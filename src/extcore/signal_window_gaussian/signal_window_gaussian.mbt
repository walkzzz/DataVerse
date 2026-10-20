///===
/// extcore/signal_window_gaussian

pub(all) struct SignalwindowgaussianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_gaussian_make_point(x : Double, y : Double) -> SignalwindowgaussianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_gaussian_make_point3(x : Double, y : Double, z : Double) -> SignalwindowgaussianPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowgaussianPoint::x(self : SignalwindowgaussianPoint) -> Double { self.x }

pub fn SignalwindowgaussianPoint::y(self : SignalwindowgaussianPoint) -> Double { self.y }

pub fn SignalwindowgaussianPoint::z(self : SignalwindowgaussianPoint) -> Double { self.z }

pub fn SignalwindowgaussianPoint::label(self : SignalwindowgaussianPoint) -> Int { self.label }

pub fn SignalwindowgaussianPoint::dist(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowgaussianPoint::add(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowgaussianPoint::sub(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowgaussianPoint::scale(self : SignalwindowgaussianPoint, s : Double) -> SignalwindowgaussianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowgaussianPoint::dot(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowgaussianPoint::cross(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowgaussianPoint::norm(self : SignalwindowgaussianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowgaussianPoint::normalize(self : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowgaussianPoint::negate(self : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowgaussianPoint::mid(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowgaussianPoint::lerp(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint, t : Double) -> SignalwindowgaussianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowgaussianPoint::to_string(self : SignalwindowgaussianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowgaussianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_gaussian_make_series(vals : Array[Double], name : String) -> SignalwindowgaussianSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowgaussianSeries::len(self : SignalwindowgaussianSeries) -> Int { self.vals.length() }

pub fn SignalwindowgaussianSeries::sum(self : SignalwindowgaussianSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowgaussianSeries::mean(self : SignalwindowgaussianSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowgaussianSeries::min(self : SignalwindowgaussianSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowgaussianSeries::max(self : SignalwindowgaussianSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowgaussianSeries::range(self : SignalwindowgaussianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowgaussianSeries::variance(self : SignalwindowgaussianSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowgaussianSeries::std(self : SignalwindowgaussianSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowgaussianSeries::median(self : SignalwindowgaussianSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowgaussianSeries::scale(self : SignalwindowgaussianSeries, f : Double) -> SignalwindowgaussianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowgaussianSeries::add(self : SignalwindowgaussianSeries, other : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowgaussianSeries::sub(self : SignalwindowgaussianSeries, other : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowgaussianSeries::normalize(self : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowgaussianSeries::cumsum(self : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowgaussianSeries::to_string(self : SignalwindowgaussianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowgaussianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_gaussian_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowgaussianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_gaussian_matrix_identity(n : Int) -> SignalwindowgaussianMatrix {
  let m = signal_window_gaussian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowgaussianMatrix::get(self : SignalwindowgaussianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowgaussianMatrix::transpose(self : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  let result = signal_window_gaussian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowgaussianMatrix::add(self : SignalwindowgaussianMatrix, other : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowgaussianMatrix::scale(self : SignalwindowgaussianMatrix, s : Double) -> SignalwindowgaussianMatrix {
  let result = signal_window_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowgaussianMatrix::multiply(self : SignalwindowgaussianMatrix, other : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  if self.cols != other.rows { return signal_window_gaussian_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_gaussian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowgaussianMatrix::trace(self : SignalwindowgaussianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowgaussianMatrix::det(self : SignalwindowgaussianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowgaussianMatrix::norm(self : SignalwindowgaussianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowgaussianMatrix::to_string(self : SignalwindowgaussianMatrix) -> String {
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

pub(all) struct SignalwindowgaussianVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_gaussian_make_vector(comps : Array[Double]) -> SignalwindowgaussianVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_gaussian_vector_zero(dim : Int) -> SignalwindowgaussianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowgaussianVector::add(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowgaussianVector::sub(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowgaussianVector::scale(self : SignalwindowgaussianVector, s : Double) -> SignalwindowgaussianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowgaussianVector::dot(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowgaussianVector::norm(self : SignalwindowgaussianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowgaussianVector::normalize(self : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowgaussianVector::dist(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowgaussianVector::to_string(self : SignalwindowgaussianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowgaussianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_frame_make(size : Int) -> SignalwindowgaussianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianFrame::len(self : SignalwindowgaussianFrame) -> Int { self.size }

pub fn SignalwindowgaussianFrame::get(self : SignalwindowgaussianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianFrame::set(self : SignalwindowgaussianFrame, i : Int, v : Double) -> SignalwindowgaussianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianFrame::sum(self : SignalwindowgaussianFrame) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianFrame::mean(self : SignalwindowgaussianFrame) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianFrame::scale(self : SignalwindowgaussianFrame, f : Double) -> SignalwindowgaussianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianFrame::add(self : SignalwindowgaussianFrame, other : SignalwindowgaussianFrame) -> SignalwindowgaussianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianFrame::copy(self : SignalwindowgaussianFrame) -> SignalwindowgaussianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianFrame::fill(self : SignalwindowgaussianFrame, v : Double) -> SignalwindowgaussianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianFrame::min(self : SignalwindowgaussianFrame) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianFrame::max(self : SignalwindowgaussianFrame) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianFrame::to_string(self : SignalwindowgaussianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_table_make(size : Int) -> SignalwindowgaussianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianTable::len(self : SignalwindowgaussianTable) -> Int { self.size }

pub fn SignalwindowgaussianTable::get(self : SignalwindowgaussianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianTable::set(self : SignalwindowgaussianTable, i : Int, v : Double) -> SignalwindowgaussianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianTable::sum(self : SignalwindowgaussianTable) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianTable::mean(self : SignalwindowgaussianTable) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianTable::scale(self : SignalwindowgaussianTable, f : Double) -> SignalwindowgaussianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianTable::add(self : SignalwindowgaussianTable, other : SignalwindowgaussianTable) -> SignalwindowgaussianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianTable::copy(self : SignalwindowgaussianTable) -> SignalwindowgaussianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianTable::fill(self : SignalwindowgaussianTable, v : Double) -> SignalwindowgaussianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianTable::min(self : SignalwindowgaussianTable) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianTable::max(self : SignalwindowgaussianTable) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianTable::to_string(self : SignalwindowgaussianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_graphn_make(size : Int) -> SignalwindowgaussianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianGraphN::len(self : SignalwindowgaussianGraphN) -> Int { self.size }

pub fn SignalwindowgaussianGraphN::get(self : SignalwindowgaussianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianGraphN::set(self : SignalwindowgaussianGraphN, i : Int, v : Double) -> SignalwindowgaussianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianGraphN::sum(self : SignalwindowgaussianGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianGraphN::mean(self : SignalwindowgaussianGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianGraphN::scale(self : SignalwindowgaussianGraphN, f : Double) -> SignalwindowgaussianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianGraphN::add(self : SignalwindowgaussianGraphN, other : SignalwindowgaussianGraphN) -> SignalwindowgaussianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianGraphN::copy(self : SignalwindowgaussianGraphN) -> SignalwindowgaussianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianGraphN::fill(self : SignalwindowgaussianGraphN, v : Double) -> SignalwindowgaussianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianGraphN::min(self : SignalwindowgaussianGraphN) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianGraphN::max(self : SignalwindowgaussianGraphN) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianGraphN::to_string(self : SignalwindowgaussianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_node_make(size : Int) -> SignalwindowgaussianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianNode::len(self : SignalwindowgaussianNode) -> Int { self.size }

pub fn SignalwindowgaussianNode::get(self : SignalwindowgaussianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianNode::set(self : SignalwindowgaussianNode, i : Int, v : Double) -> SignalwindowgaussianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianNode::sum(self : SignalwindowgaussianNode) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianNode::mean(self : SignalwindowgaussianNode) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianNode::scale(self : SignalwindowgaussianNode, f : Double) -> SignalwindowgaussianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianNode::add(self : SignalwindowgaussianNode, other : SignalwindowgaussianNode) -> SignalwindowgaussianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianNode::copy(self : SignalwindowgaussianNode) -> SignalwindowgaussianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianNode::fill(self : SignalwindowgaussianNode, v : Double) -> SignalwindowgaussianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianNode::min(self : SignalwindowgaussianNode) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianNode::max(self : SignalwindowgaussianNode) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianNode::to_string(self : SignalwindowgaussianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_edge_make(size : Int) -> SignalwindowgaussianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianEdge::len(self : SignalwindowgaussianEdge) -> Int { self.size }

pub fn SignalwindowgaussianEdge::get(self : SignalwindowgaussianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianEdge::set(self : SignalwindowgaussianEdge, i : Int, v : Double) -> SignalwindowgaussianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianEdge::sum(self : SignalwindowgaussianEdge) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianEdge::mean(self : SignalwindowgaussianEdge) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianEdge::scale(self : SignalwindowgaussianEdge, f : Double) -> SignalwindowgaussianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianEdge::add(self : SignalwindowgaussianEdge, other : SignalwindowgaussianEdge) -> SignalwindowgaussianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianEdge::copy(self : SignalwindowgaussianEdge) -> SignalwindowgaussianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianEdge::fill(self : SignalwindowgaussianEdge, v : Double) -> SignalwindowgaussianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianEdge::min(self : SignalwindowgaussianEdge) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianEdge::max(self : SignalwindowgaussianEdge) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianEdge::to_string(self : SignalwindowgaussianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_path_make(size : Int) -> SignalwindowgaussianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianPath::len(self : SignalwindowgaussianPath) -> Int { self.size }

pub fn SignalwindowgaussianPath::get(self : SignalwindowgaussianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianPath::set(self : SignalwindowgaussianPath, i : Int, v : Double) -> SignalwindowgaussianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianPath::sum(self : SignalwindowgaussianPath) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianPath::mean(self : SignalwindowgaussianPath) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianPath::scale(self : SignalwindowgaussianPath, f : Double) -> SignalwindowgaussianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianPath::add(self : SignalwindowgaussianPath, other : SignalwindowgaussianPath) -> SignalwindowgaussianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianPath::copy(self : SignalwindowgaussianPath) -> SignalwindowgaussianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianPath::fill(self : SignalwindowgaussianPath, v : Double) -> SignalwindowgaussianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianPath::min(self : SignalwindowgaussianPath) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianPath::max(self : SignalwindowgaussianPath) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianPath::to_string(self : SignalwindowgaussianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_cluster_make(size : Int) -> SignalwindowgaussianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianCluster::len(self : SignalwindowgaussianCluster) -> Int { self.size }

pub fn SignalwindowgaussianCluster::get(self : SignalwindowgaussianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianCluster::set(self : SignalwindowgaussianCluster, i : Int, v : Double) -> SignalwindowgaussianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCluster::sum(self : SignalwindowgaussianCluster) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianCluster::mean(self : SignalwindowgaussianCluster) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianCluster::scale(self : SignalwindowgaussianCluster, f : Double) -> SignalwindowgaussianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCluster::add(self : SignalwindowgaussianCluster, other : SignalwindowgaussianCluster) -> SignalwindowgaussianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianCluster::copy(self : SignalwindowgaussianCluster) -> SignalwindowgaussianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCluster::fill(self : SignalwindowgaussianCluster, v : Double) -> SignalwindowgaussianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCluster::min(self : SignalwindowgaussianCluster) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianCluster::max(self : SignalwindowgaussianCluster) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianCluster::to_string(self : SignalwindowgaussianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_model_make(size : Int) -> SignalwindowgaussianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianModel::len(self : SignalwindowgaussianModel) -> Int { self.size }

pub fn SignalwindowgaussianModel::get(self : SignalwindowgaussianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianModel::set(self : SignalwindowgaussianModel, i : Int, v : Double) -> SignalwindowgaussianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianModel::sum(self : SignalwindowgaussianModel) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianModel::mean(self : SignalwindowgaussianModel) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianModel::scale(self : SignalwindowgaussianModel, f : Double) -> SignalwindowgaussianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianModel::add(self : SignalwindowgaussianModel, other : SignalwindowgaussianModel) -> SignalwindowgaussianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianModel::copy(self : SignalwindowgaussianModel) -> SignalwindowgaussianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianModel::fill(self : SignalwindowgaussianModel, v : Double) -> SignalwindowgaussianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianModel::min(self : SignalwindowgaussianModel) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianModel::max(self : SignalwindowgaussianModel) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianModel::to_string(self : SignalwindowgaussianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_layer_make(size : Int) -> SignalwindowgaussianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianLayer::len(self : SignalwindowgaussianLayer) -> Int { self.size }

pub fn SignalwindowgaussianLayer::get(self : SignalwindowgaussianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianLayer::set(self : SignalwindowgaussianLayer, i : Int, v : Double) -> SignalwindowgaussianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianLayer::sum(self : SignalwindowgaussianLayer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianLayer::mean(self : SignalwindowgaussianLayer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianLayer::scale(self : SignalwindowgaussianLayer, f : Double) -> SignalwindowgaussianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianLayer::add(self : SignalwindowgaussianLayer, other : SignalwindowgaussianLayer) -> SignalwindowgaussianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianLayer::copy(self : SignalwindowgaussianLayer) -> SignalwindowgaussianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianLayer::fill(self : SignalwindowgaussianLayer, v : Double) -> SignalwindowgaussianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianLayer::min(self : SignalwindowgaussianLayer) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianLayer::max(self : SignalwindowgaussianLayer) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianLayer::to_string(self : SignalwindowgaussianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_buffer_make(size : Int) -> SignalwindowgaussianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianBuffer::len(self : SignalwindowgaussianBuffer) -> Int { self.size }

pub fn SignalwindowgaussianBuffer::get(self : SignalwindowgaussianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianBuffer::set(self : SignalwindowgaussianBuffer, i : Int, v : Double) -> SignalwindowgaussianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianBuffer::sum(self : SignalwindowgaussianBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianBuffer::mean(self : SignalwindowgaussianBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianBuffer::scale(self : SignalwindowgaussianBuffer, f : Double) -> SignalwindowgaussianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianBuffer::add(self : SignalwindowgaussianBuffer, other : SignalwindowgaussianBuffer) -> SignalwindowgaussianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianBuffer::copy(self : SignalwindowgaussianBuffer) -> SignalwindowgaussianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianBuffer::fill(self : SignalwindowgaussianBuffer, v : Double) -> SignalwindowgaussianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianBuffer::min(self : SignalwindowgaussianBuffer) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianBuffer::max(self : SignalwindowgaussianBuffer) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianBuffer::to_string(self : SignalwindowgaussianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_cursor_make(size : Int) -> SignalwindowgaussianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianCursor::len(self : SignalwindowgaussianCursor) -> Int { self.size }

pub fn SignalwindowgaussianCursor::get(self : SignalwindowgaussianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianCursor::set(self : SignalwindowgaussianCursor, i : Int, v : Double) -> SignalwindowgaussianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCursor::sum(self : SignalwindowgaussianCursor) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianCursor::mean(self : SignalwindowgaussianCursor) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianCursor::scale(self : SignalwindowgaussianCursor, f : Double) -> SignalwindowgaussianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCursor::add(self : SignalwindowgaussianCursor, other : SignalwindowgaussianCursor) -> SignalwindowgaussianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianCursor::copy(self : SignalwindowgaussianCursor) -> SignalwindowgaussianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCursor::fill(self : SignalwindowgaussianCursor, v : Double) -> SignalwindowgaussianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianCursor::min(self : SignalwindowgaussianCursor) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianCursor::max(self : SignalwindowgaussianCursor) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianCursor::to_string(self : SignalwindowgaussianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_view_make(size : Int) -> SignalwindowgaussianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianView::len(self : SignalwindowgaussianView) -> Int { self.size }

pub fn SignalwindowgaussianView::get(self : SignalwindowgaussianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianView::set(self : SignalwindowgaussianView, i : Int, v : Double) -> SignalwindowgaussianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianView::sum(self : SignalwindowgaussianView) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianView::mean(self : SignalwindowgaussianView) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianView::scale(self : SignalwindowgaussianView, f : Double) -> SignalwindowgaussianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianView::add(self : SignalwindowgaussianView, other : SignalwindowgaussianView) -> SignalwindowgaussianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianView::copy(self : SignalwindowgaussianView) -> SignalwindowgaussianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianView::fill(self : SignalwindowgaussianView, v : Double) -> SignalwindowgaussianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianView::min(self : SignalwindowgaussianView) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianView::max(self : SignalwindowgaussianView) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianView::to_string(self : SignalwindowgaussianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_range_make(size : Int) -> SignalwindowgaussianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianRange::len(self : SignalwindowgaussianRange) -> Int { self.size }

pub fn SignalwindowgaussianRange::get(self : SignalwindowgaussianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianRange::set(self : SignalwindowgaussianRange, i : Int, v : Double) -> SignalwindowgaussianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianRange::sum(self : SignalwindowgaussianRange) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianRange::mean(self : SignalwindowgaussianRange) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianRange::scale(self : SignalwindowgaussianRange, f : Double) -> SignalwindowgaussianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianRange::add(self : SignalwindowgaussianRange, other : SignalwindowgaussianRange) -> SignalwindowgaussianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianRange::copy(self : SignalwindowgaussianRange) -> SignalwindowgaussianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianRange::fill(self : SignalwindowgaussianRange, v : Double) -> SignalwindowgaussianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianRange::min(self : SignalwindowgaussianRange) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianRange::max(self : SignalwindowgaussianRange) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianRange::to_string(self : SignalwindowgaussianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_slice_make(size : Int) -> SignalwindowgaussianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowgaussianSlice::len(self : SignalwindowgaussianSlice) -> Int { self.size }

pub fn SignalwindowgaussianSlice::get(self : SignalwindowgaussianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowgaussianSlice::set(self : SignalwindowgaussianSlice, i : Int, v : Double) -> SignalwindowgaussianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianSlice::sum(self : SignalwindowgaussianSlice) -> Double { @_common.sum(self.data) }

pub fn SignalwindowgaussianSlice::mean(self : SignalwindowgaussianSlice) -> Double { @_common.mean(self.data) }

pub fn SignalwindowgaussianSlice::scale(self : SignalwindowgaussianSlice, f : Double) -> SignalwindowgaussianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianSlice::add(self : SignalwindowgaussianSlice, other : SignalwindowgaussianSlice) -> SignalwindowgaussianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowgaussianSlice::copy(self : SignalwindowgaussianSlice) -> SignalwindowgaussianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianSlice::fill(self : SignalwindowgaussianSlice, v : Double) -> SignalwindowgaussianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowgaussianSlice::min(self : SignalwindowgaussianSlice) -> Double { @_common.min(self.data) }

pub fn SignalwindowgaussianSlice::max(self : SignalwindowgaussianSlice) -> Double { @_common.max(self.data) }

pub fn SignalwindowgaussianSlice::to_string(self : SignalwindowgaussianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

