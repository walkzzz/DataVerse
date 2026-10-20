///===
/// extcore/signal_window_kaiser

pub(all) struct SignalwindowkaiserPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_kaiser_make_point(x : Double, y : Double) -> SignalwindowkaiserPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_kaiser_make_point3(x : Double, y : Double, z : Double) -> SignalwindowkaiserPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowkaiserPoint::x(self : SignalwindowkaiserPoint) -> Double { self.x }

pub fn SignalwindowkaiserPoint::y(self : SignalwindowkaiserPoint) -> Double { self.y }

pub fn SignalwindowkaiserPoint::z(self : SignalwindowkaiserPoint) -> Double { self.z }

pub fn SignalwindowkaiserPoint::label(self : SignalwindowkaiserPoint) -> Int { self.label }

pub fn SignalwindowkaiserPoint::dist(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowkaiserPoint::add(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowkaiserPoint::sub(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowkaiserPoint::scale(self : SignalwindowkaiserPoint, s : Double) -> SignalwindowkaiserPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowkaiserPoint::dot(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowkaiserPoint::cross(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowkaiserPoint::norm(self : SignalwindowkaiserPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowkaiserPoint::normalize(self : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowkaiserPoint::negate(self : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowkaiserPoint::mid(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowkaiserPoint::lerp(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint, t : Double) -> SignalwindowkaiserPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowkaiserPoint::to_string(self : SignalwindowkaiserPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowkaiserSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_kaiser_make_series(vals : Array[Double], name : String) -> SignalwindowkaiserSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowkaiserSeries::len(self : SignalwindowkaiserSeries) -> Int { self.vals.length() }

pub fn SignalwindowkaiserSeries::sum(self : SignalwindowkaiserSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowkaiserSeries::mean(self : SignalwindowkaiserSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowkaiserSeries::min(self : SignalwindowkaiserSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowkaiserSeries::max(self : SignalwindowkaiserSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowkaiserSeries::range(self : SignalwindowkaiserSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowkaiserSeries::variance(self : SignalwindowkaiserSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowkaiserSeries::std(self : SignalwindowkaiserSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowkaiserSeries::median(self : SignalwindowkaiserSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowkaiserSeries::scale(self : SignalwindowkaiserSeries, f : Double) -> SignalwindowkaiserSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowkaiserSeries::add(self : SignalwindowkaiserSeries, other : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowkaiserSeries::sub(self : SignalwindowkaiserSeries, other : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowkaiserSeries::normalize(self : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowkaiserSeries::cumsum(self : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowkaiserSeries::to_string(self : SignalwindowkaiserSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowkaiserMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_kaiser_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowkaiserMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_window_kaiser_matrix_identity(n : Int) -> SignalwindowkaiserMatrix {
  let m = signal_window_kaiser_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowkaiserMatrix::get(self : SignalwindowkaiserMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowkaiserMatrix::transpose(self : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  let result = signal_window_kaiser_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowkaiserMatrix::add(self : SignalwindowkaiserMatrix, other : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_kaiser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowkaiserMatrix::scale(self : SignalwindowkaiserMatrix, s : Double) -> SignalwindowkaiserMatrix {
  let result = signal_window_kaiser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowkaiserMatrix::multiply(self : SignalwindowkaiserMatrix, other : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  if self.cols != other.rows { return signal_window_kaiser_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_kaiser_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalwindowkaiserMatrix::trace(self : SignalwindowkaiserMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowkaiserMatrix::det(self : SignalwindowkaiserMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowkaiserMatrix::norm(self : SignalwindowkaiserMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowkaiserMatrix::to_string(self : SignalwindowkaiserMatrix) -> String {
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

pub(all) struct SignalwindowkaiserVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_kaiser_make_vector(comps : Array[Double]) -> SignalwindowkaiserVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_kaiser_vector_zero(dim : Int) -> SignalwindowkaiserVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowkaiserVector::add(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowkaiserVector::sub(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowkaiserVector::scale(self : SignalwindowkaiserVector, s : Double) -> SignalwindowkaiserVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowkaiserVector::dot(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowkaiserVector::norm(self : SignalwindowkaiserVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowkaiserVector::normalize(self : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowkaiserVector::dist(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowkaiserVector::to_string(self : SignalwindowkaiserVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowkaiserFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_frame_make(size : Int) -> SignalwindowkaiserFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserFrame::len(self : SignalwindowkaiserFrame) -> Int { self.size }

pub fn SignalwindowkaiserFrame::get(self : SignalwindowkaiserFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserFrame::set(self : SignalwindowkaiserFrame, i : Int, v : Double) -> SignalwindowkaiserFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserFrame::sum(self : SignalwindowkaiserFrame) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserFrame::mean(self : SignalwindowkaiserFrame) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserFrame::scale(self : SignalwindowkaiserFrame, f : Double) -> SignalwindowkaiserFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserFrame::add(self : SignalwindowkaiserFrame, other : SignalwindowkaiserFrame) -> SignalwindowkaiserFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserFrame::copy(self : SignalwindowkaiserFrame) -> SignalwindowkaiserFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserFrame::fill(self : SignalwindowkaiserFrame, v : Double) -> SignalwindowkaiserFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserFrame::min(self : SignalwindowkaiserFrame) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserFrame::max(self : SignalwindowkaiserFrame) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserFrame::to_string(self : SignalwindowkaiserFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_table_make(size : Int) -> SignalwindowkaiserTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserTable::len(self : SignalwindowkaiserTable) -> Int { self.size }

pub fn SignalwindowkaiserTable::get(self : SignalwindowkaiserTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserTable::set(self : SignalwindowkaiserTable, i : Int, v : Double) -> SignalwindowkaiserTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserTable::sum(self : SignalwindowkaiserTable) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserTable::mean(self : SignalwindowkaiserTable) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserTable::scale(self : SignalwindowkaiserTable, f : Double) -> SignalwindowkaiserTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserTable::add(self : SignalwindowkaiserTable, other : SignalwindowkaiserTable) -> SignalwindowkaiserTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserTable::copy(self : SignalwindowkaiserTable) -> SignalwindowkaiserTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserTable::fill(self : SignalwindowkaiserTable, v : Double) -> SignalwindowkaiserTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserTable::min(self : SignalwindowkaiserTable) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserTable::max(self : SignalwindowkaiserTable) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserTable::to_string(self : SignalwindowkaiserTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_graphn_make(size : Int) -> SignalwindowkaiserGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserGraphN::len(self : SignalwindowkaiserGraphN) -> Int { self.size }

pub fn SignalwindowkaiserGraphN::get(self : SignalwindowkaiserGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserGraphN::set(self : SignalwindowkaiserGraphN, i : Int, v : Double) -> SignalwindowkaiserGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserGraphN::sum(self : SignalwindowkaiserGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserGraphN::mean(self : SignalwindowkaiserGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserGraphN::scale(self : SignalwindowkaiserGraphN, f : Double) -> SignalwindowkaiserGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserGraphN::add(self : SignalwindowkaiserGraphN, other : SignalwindowkaiserGraphN) -> SignalwindowkaiserGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserGraphN::copy(self : SignalwindowkaiserGraphN) -> SignalwindowkaiserGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserGraphN::fill(self : SignalwindowkaiserGraphN, v : Double) -> SignalwindowkaiserGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserGraphN::min(self : SignalwindowkaiserGraphN) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserGraphN::max(self : SignalwindowkaiserGraphN) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserGraphN::to_string(self : SignalwindowkaiserGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_node_make(size : Int) -> SignalwindowkaiserNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserNode::len(self : SignalwindowkaiserNode) -> Int { self.size }

pub fn SignalwindowkaiserNode::get(self : SignalwindowkaiserNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserNode::set(self : SignalwindowkaiserNode, i : Int, v : Double) -> SignalwindowkaiserNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserNode::sum(self : SignalwindowkaiserNode) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserNode::mean(self : SignalwindowkaiserNode) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserNode::scale(self : SignalwindowkaiserNode, f : Double) -> SignalwindowkaiserNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserNode::add(self : SignalwindowkaiserNode, other : SignalwindowkaiserNode) -> SignalwindowkaiserNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserNode::copy(self : SignalwindowkaiserNode) -> SignalwindowkaiserNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserNode::fill(self : SignalwindowkaiserNode, v : Double) -> SignalwindowkaiserNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserNode::min(self : SignalwindowkaiserNode) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserNode::max(self : SignalwindowkaiserNode) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserNode::to_string(self : SignalwindowkaiserNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_edge_make(size : Int) -> SignalwindowkaiserEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserEdge::len(self : SignalwindowkaiserEdge) -> Int { self.size }

pub fn SignalwindowkaiserEdge::get(self : SignalwindowkaiserEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserEdge::set(self : SignalwindowkaiserEdge, i : Int, v : Double) -> SignalwindowkaiserEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserEdge::sum(self : SignalwindowkaiserEdge) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserEdge::mean(self : SignalwindowkaiserEdge) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserEdge::scale(self : SignalwindowkaiserEdge, f : Double) -> SignalwindowkaiserEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserEdge::add(self : SignalwindowkaiserEdge, other : SignalwindowkaiserEdge) -> SignalwindowkaiserEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserEdge::copy(self : SignalwindowkaiserEdge) -> SignalwindowkaiserEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserEdge::fill(self : SignalwindowkaiserEdge, v : Double) -> SignalwindowkaiserEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserEdge::min(self : SignalwindowkaiserEdge) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserEdge::max(self : SignalwindowkaiserEdge) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserEdge::to_string(self : SignalwindowkaiserEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_path_make(size : Int) -> SignalwindowkaiserPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserPath::len(self : SignalwindowkaiserPath) -> Int { self.size }

pub fn SignalwindowkaiserPath::get(self : SignalwindowkaiserPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserPath::set(self : SignalwindowkaiserPath, i : Int, v : Double) -> SignalwindowkaiserPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserPath::sum(self : SignalwindowkaiserPath) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserPath::mean(self : SignalwindowkaiserPath) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserPath::scale(self : SignalwindowkaiserPath, f : Double) -> SignalwindowkaiserPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserPath::add(self : SignalwindowkaiserPath, other : SignalwindowkaiserPath) -> SignalwindowkaiserPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserPath::copy(self : SignalwindowkaiserPath) -> SignalwindowkaiserPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserPath::fill(self : SignalwindowkaiserPath, v : Double) -> SignalwindowkaiserPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserPath::min(self : SignalwindowkaiserPath) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserPath::max(self : SignalwindowkaiserPath) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserPath::to_string(self : SignalwindowkaiserPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_cluster_make(size : Int) -> SignalwindowkaiserCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserCluster::len(self : SignalwindowkaiserCluster) -> Int { self.size }

pub fn SignalwindowkaiserCluster::get(self : SignalwindowkaiserCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserCluster::set(self : SignalwindowkaiserCluster, i : Int, v : Double) -> SignalwindowkaiserCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCluster::sum(self : SignalwindowkaiserCluster) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserCluster::mean(self : SignalwindowkaiserCluster) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserCluster::scale(self : SignalwindowkaiserCluster, f : Double) -> SignalwindowkaiserCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCluster::add(self : SignalwindowkaiserCluster, other : SignalwindowkaiserCluster) -> SignalwindowkaiserCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserCluster::copy(self : SignalwindowkaiserCluster) -> SignalwindowkaiserCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCluster::fill(self : SignalwindowkaiserCluster, v : Double) -> SignalwindowkaiserCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCluster::min(self : SignalwindowkaiserCluster) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserCluster::max(self : SignalwindowkaiserCluster) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserCluster::to_string(self : SignalwindowkaiserCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_model_make(size : Int) -> SignalwindowkaiserModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserModel::len(self : SignalwindowkaiserModel) -> Int { self.size }

pub fn SignalwindowkaiserModel::get(self : SignalwindowkaiserModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserModel::set(self : SignalwindowkaiserModel, i : Int, v : Double) -> SignalwindowkaiserModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserModel::sum(self : SignalwindowkaiserModel) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserModel::mean(self : SignalwindowkaiserModel) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserModel::scale(self : SignalwindowkaiserModel, f : Double) -> SignalwindowkaiserModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserModel::add(self : SignalwindowkaiserModel, other : SignalwindowkaiserModel) -> SignalwindowkaiserModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserModel::copy(self : SignalwindowkaiserModel) -> SignalwindowkaiserModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserModel::fill(self : SignalwindowkaiserModel, v : Double) -> SignalwindowkaiserModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserModel::min(self : SignalwindowkaiserModel) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserModel::max(self : SignalwindowkaiserModel) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserModel::to_string(self : SignalwindowkaiserModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_layer_make(size : Int) -> SignalwindowkaiserLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserLayer::len(self : SignalwindowkaiserLayer) -> Int { self.size }

pub fn SignalwindowkaiserLayer::get(self : SignalwindowkaiserLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserLayer::set(self : SignalwindowkaiserLayer, i : Int, v : Double) -> SignalwindowkaiserLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserLayer::sum(self : SignalwindowkaiserLayer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserLayer::mean(self : SignalwindowkaiserLayer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserLayer::scale(self : SignalwindowkaiserLayer, f : Double) -> SignalwindowkaiserLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserLayer::add(self : SignalwindowkaiserLayer, other : SignalwindowkaiserLayer) -> SignalwindowkaiserLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserLayer::copy(self : SignalwindowkaiserLayer) -> SignalwindowkaiserLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserLayer::fill(self : SignalwindowkaiserLayer, v : Double) -> SignalwindowkaiserLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserLayer::min(self : SignalwindowkaiserLayer) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserLayer::max(self : SignalwindowkaiserLayer) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserLayer::to_string(self : SignalwindowkaiserLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_buffer_make(size : Int) -> SignalwindowkaiserBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserBuffer::len(self : SignalwindowkaiserBuffer) -> Int { self.size }

pub fn SignalwindowkaiserBuffer::get(self : SignalwindowkaiserBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserBuffer::set(self : SignalwindowkaiserBuffer, i : Int, v : Double) -> SignalwindowkaiserBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserBuffer::sum(self : SignalwindowkaiserBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserBuffer::mean(self : SignalwindowkaiserBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserBuffer::scale(self : SignalwindowkaiserBuffer, f : Double) -> SignalwindowkaiserBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserBuffer::add(self : SignalwindowkaiserBuffer, other : SignalwindowkaiserBuffer) -> SignalwindowkaiserBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserBuffer::copy(self : SignalwindowkaiserBuffer) -> SignalwindowkaiserBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserBuffer::fill(self : SignalwindowkaiserBuffer, v : Double) -> SignalwindowkaiserBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserBuffer::min(self : SignalwindowkaiserBuffer) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserBuffer::max(self : SignalwindowkaiserBuffer) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserBuffer::to_string(self : SignalwindowkaiserBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_cursor_make(size : Int) -> SignalwindowkaiserCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserCursor::len(self : SignalwindowkaiserCursor) -> Int { self.size }

pub fn SignalwindowkaiserCursor::get(self : SignalwindowkaiserCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserCursor::set(self : SignalwindowkaiserCursor, i : Int, v : Double) -> SignalwindowkaiserCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCursor::sum(self : SignalwindowkaiserCursor) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserCursor::mean(self : SignalwindowkaiserCursor) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserCursor::scale(self : SignalwindowkaiserCursor, f : Double) -> SignalwindowkaiserCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCursor::add(self : SignalwindowkaiserCursor, other : SignalwindowkaiserCursor) -> SignalwindowkaiserCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserCursor::copy(self : SignalwindowkaiserCursor) -> SignalwindowkaiserCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCursor::fill(self : SignalwindowkaiserCursor, v : Double) -> SignalwindowkaiserCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserCursor::min(self : SignalwindowkaiserCursor) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserCursor::max(self : SignalwindowkaiserCursor) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserCursor::to_string(self : SignalwindowkaiserCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_view_make(size : Int) -> SignalwindowkaiserView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserView::len(self : SignalwindowkaiserView) -> Int { self.size }

pub fn SignalwindowkaiserView::get(self : SignalwindowkaiserView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserView::set(self : SignalwindowkaiserView, i : Int, v : Double) -> SignalwindowkaiserView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserView::sum(self : SignalwindowkaiserView) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserView::mean(self : SignalwindowkaiserView) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserView::scale(self : SignalwindowkaiserView, f : Double) -> SignalwindowkaiserView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserView::add(self : SignalwindowkaiserView, other : SignalwindowkaiserView) -> SignalwindowkaiserView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserView::copy(self : SignalwindowkaiserView) -> SignalwindowkaiserView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserView::fill(self : SignalwindowkaiserView, v : Double) -> SignalwindowkaiserView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserView::min(self : SignalwindowkaiserView) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserView::max(self : SignalwindowkaiserView) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserView::to_string(self : SignalwindowkaiserView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_range_make(size : Int) -> SignalwindowkaiserRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserRange::len(self : SignalwindowkaiserRange) -> Int { self.size }

pub fn SignalwindowkaiserRange::get(self : SignalwindowkaiserRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserRange::set(self : SignalwindowkaiserRange, i : Int, v : Double) -> SignalwindowkaiserRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserRange::sum(self : SignalwindowkaiserRange) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserRange::mean(self : SignalwindowkaiserRange) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserRange::scale(self : SignalwindowkaiserRange, f : Double) -> SignalwindowkaiserRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserRange::add(self : SignalwindowkaiserRange, other : SignalwindowkaiserRange) -> SignalwindowkaiserRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserRange::copy(self : SignalwindowkaiserRange) -> SignalwindowkaiserRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserRange::fill(self : SignalwindowkaiserRange, v : Double) -> SignalwindowkaiserRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserRange::min(self : SignalwindowkaiserRange) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserRange::max(self : SignalwindowkaiserRange) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserRange::to_string(self : SignalwindowkaiserRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_slice_make(size : Int) -> SignalwindowkaiserSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowkaiserSlice::len(self : SignalwindowkaiserSlice) -> Int { self.size }

pub fn SignalwindowkaiserSlice::get(self : SignalwindowkaiserSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowkaiserSlice::set(self : SignalwindowkaiserSlice, i : Int, v : Double) -> SignalwindowkaiserSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserSlice::sum(self : SignalwindowkaiserSlice) -> Double { @_common.sum(self.data) }

pub fn SignalwindowkaiserSlice::mean(self : SignalwindowkaiserSlice) -> Double { @_common.mean(self.data) }

pub fn SignalwindowkaiserSlice::scale(self : SignalwindowkaiserSlice, f : Double) -> SignalwindowkaiserSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserSlice::add(self : SignalwindowkaiserSlice, other : SignalwindowkaiserSlice) -> SignalwindowkaiserSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowkaiserSlice::copy(self : SignalwindowkaiserSlice) -> SignalwindowkaiserSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserSlice::fill(self : SignalwindowkaiserSlice, v : Double) -> SignalwindowkaiserSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowkaiserSlice::min(self : SignalwindowkaiserSlice) -> Double { @_common.min(self.data) }

pub fn SignalwindowkaiserSlice::max(self : SignalwindowkaiserSlice) -> Double { @_common.max(self.data) }

pub fn SignalwindowkaiserSlice::to_string(self : SignalwindowkaiserSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

