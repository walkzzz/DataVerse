///===
/// extcore/signal_window_planck

pub(all) struct SignalwindowplanckPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_planck_make_point(x : Double, y : Double) -> SignalwindowplanckPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_planck_make_point3(x : Double, y : Double, z : Double) -> SignalwindowplanckPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowplanckPoint::x(self : SignalwindowplanckPoint) -> Double { self.x }

pub fn SignalwindowplanckPoint::y(self : SignalwindowplanckPoint) -> Double { self.y }

pub fn SignalwindowplanckPoint::z(self : SignalwindowplanckPoint) -> Double { self.z }

pub fn SignalwindowplanckPoint::label(self : SignalwindowplanckPoint) -> Int { self.label }

pub fn SignalwindowplanckPoint::dist(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowplanckPoint::add(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowplanckPoint::sub(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowplanckPoint::scale(self : SignalwindowplanckPoint, s : Double) -> SignalwindowplanckPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowplanckPoint::dot(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowplanckPoint::cross(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowplanckPoint::norm(self : SignalwindowplanckPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowplanckPoint::normalize(self : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowplanckPoint::negate(self : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowplanckPoint::mid(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowplanckPoint::lerp(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint, t : Double) -> SignalwindowplanckPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowplanckPoint::to_string(self : SignalwindowplanckPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowplanckSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_planck_make_series(vals : Array[Double], name : String) -> SignalwindowplanckSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowplanckSeries::len(self : SignalwindowplanckSeries) -> Int { self.vals.length() }

pub fn SignalwindowplanckSeries::sum(self : SignalwindowplanckSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowplanckSeries::mean(self : SignalwindowplanckSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowplanckSeries::min(self : SignalwindowplanckSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowplanckSeries::max(self : SignalwindowplanckSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowplanckSeries::range(self : SignalwindowplanckSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowplanckSeries::variance(self : SignalwindowplanckSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowplanckSeries::std(self : SignalwindowplanckSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowplanckSeries::median(self : SignalwindowplanckSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowplanckSeries::scale(self : SignalwindowplanckSeries, f : Double) -> SignalwindowplanckSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowplanckSeries::add(self : SignalwindowplanckSeries, other : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowplanckSeries::sub(self : SignalwindowplanckSeries, other : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowplanckSeries::normalize(self : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowplanckSeries::cumsum(self : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowplanckSeries::to_string(self : SignalwindowplanckSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowplanckMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_planck_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowplanckMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_window_planck_matrix_identity(n : Int) -> SignalwindowplanckMatrix {
  let m = signal_window_planck_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowplanckMatrix::get(self : SignalwindowplanckMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowplanckMatrix::transpose(self : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  let result = signal_window_planck_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowplanckMatrix::add(self : SignalwindowplanckMatrix, other : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_planck_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowplanckMatrix::scale(self : SignalwindowplanckMatrix, s : Double) -> SignalwindowplanckMatrix {
  let result = signal_window_planck_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowplanckMatrix::multiply(self : SignalwindowplanckMatrix, other : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  if self.cols != other.rows { return signal_window_planck_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_planck_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalwindowplanckMatrix::trace(self : SignalwindowplanckMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowplanckMatrix::det(self : SignalwindowplanckMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowplanckMatrix::norm(self : SignalwindowplanckMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowplanckMatrix::to_string(self : SignalwindowplanckMatrix) -> String {
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

pub(all) struct SignalwindowplanckVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_planck_make_vector(comps : Array[Double]) -> SignalwindowplanckVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_planck_vector_zero(dim : Int) -> SignalwindowplanckVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowplanckVector::add(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowplanckVector::sub(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowplanckVector::scale(self : SignalwindowplanckVector, s : Double) -> SignalwindowplanckVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowplanckVector::dot(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowplanckVector::norm(self : SignalwindowplanckVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowplanckVector::normalize(self : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowplanckVector::dist(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowplanckVector::to_string(self : SignalwindowplanckVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowplanckFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_frame_make(size : Int) -> SignalwindowplanckFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckFrame::len(self : SignalwindowplanckFrame) -> Int { self.size }

pub fn SignalwindowplanckFrame::get(self : SignalwindowplanckFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckFrame::set(self : SignalwindowplanckFrame, i : Int, v : Double) -> SignalwindowplanckFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckFrame::sum(self : SignalwindowplanckFrame) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckFrame::mean(self : SignalwindowplanckFrame) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckFrame::scale(self : SignalwindowplanckFrame, f : Double) -> SignalwindowplanckFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckFrame::add(self : SignalwindowplanckFrame, other : SignalwindowplanckFrame) -> SignalwindowplanckFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckFrame::copy(self : SignalwindowplanckFrame) -> SignalwindowplanckFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckFrame::fill(self : SignalwindowplanckFrame, v : Double) -> SignalwindowplanckFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckFrame::min(self : SignalwindowplanckFrame) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckFrame::max(self : SignalwindowplanckFrame) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckFrame::to_string(self : SignalwindowplanckFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_table_make(size : Int) -> SignalwindowplanckTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckTable::len(self : SignalwindowplanckTable) -> Int { self.size }

pub fn SignalwindowplanckTable::get(self : SignalwindowplanckTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckTable::set(self : SignalwindowplanckTable, i : Int, v : Double) -> SignalwindowplanckTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckTable::sum(self : SignalwindowplanckTable) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckTable::mean(self : SignalwindowplanckTable) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckTable::scale(self : SignalwindowplanckTable, f : Double) -> SignalwindowplanckTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckTable::add(self : SignalwindowplanckTable, other : SignalwindowplanckTable) -> SignalwindowplanckTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckTable::copy(self : SignalwindowplanckTable) -> SignalwindowplanckTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckTable::fill(self : SignalwindowplanckTable, v : Double) -> SignalwindowplanckTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckTable::min(self : SignalwindowplanckTable) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckTable::max(self : SignalwindowplanckTable) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckTable::to_string(self : SignalwindowplanckTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_graphn_make(size : Int) -> SignalwindowplanckGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckGraphN::len(self : SignalwindowplanckGraphN) -> Int { self.size }

pub fn SignalwindowplanckGraphN::get(self : SignalwindowplanckGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckGraphN::set(self : SignalwindowplanckGraphN, i : Int, v : Double) -> SignalwindowplanckGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckGraphN::sum(self : SignalwindowplanckGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckGraphN::mean(self : SignalwindowplanckGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckGraphN::scale(self : SignalwindowplanckGraphN, f : Double) -> SignalwindowplanckGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckGraphN::add(self : SignalwindowplanckGraphN, other : SignalwindowplanckGraphN) -> SignalwindowplanckGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckGraphN::copy(self : SignalwindowplanckGraphN) -> SignalwindowplanckGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckGraphN::fill(self : SignalwindowplanckGraphN, v : Double) -> SignalwindowplanckGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckGraphN::min(self : SignalwindowplanckGraphN) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckGraphN::max(self : SignalwindowplanckGraphN) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckGraphN::to_string(self : SignalwindowplanckGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_node_make(size : Int) -> SignalwindowplanckNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckNode::len(self : SignalwindowplanckNode) -> Int { self.size }

pub fn SignalwindowplanckNode::get(self : SignalwindowplanckNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckNode::set(self : SignalwindowplanckNode, i : Int, v : Double) -> SignalwindowplanckNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckNode::sum(self : SignalwindowplanckNode) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckNode::mean(self : SignalwindowplanckNode) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckNode::scale(self : SignalwindowplanckNode, f : Double) -> SignalwindowplanckNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckNode::add(self : SignalwindowplanckNode, other : SignalwindowplanckNode) -> SignalwindowplanckNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckNode::copy(self : SignalwindowplanckNode) -> SignalwindowplanckNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckNode::fill(self : SignalwindowplanckNode, v : Double) -> SignalwindowplanckNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckNode::min(self : SignalwindowplanckNode) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckNode::max(self : SignalwindowplanckNode) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckNode::to_string(self : SignalwindowplanckNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_edge_make(size : Int) -> SignalwindowplanckEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckEdge::len(self : SignalwindowplanckEdge) -> Int { self.size }

pub fn SignalwindowplanckEdge::get(self : SignalwindowplanckEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckEdge::set(self : SignalwindowplanckEdge, i : Int, v : Double) -> SignalwindowplanckEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckEdge::sum(self : SignalwindowplanckEdge) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckEdge::mean(self : SignalwindowplanckEdge) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckEdge::scale(self : SignalwindowplanckEdge, f : Double) -> SignalwindowplanckEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckEdge::add(self : SignalwindowplanckEdge, other : SignalwindowplanckEdge) -> SignalwindowplanckEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckEdge::copy(self : SignalwindowplanckEdge) -> SignalwindowplanckEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckEdge::fill(self : SignalwindowplanckEdge, v : Double) -> SignalwindowplanckEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckEdge::min(self : SignalwindowplanckEdge) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckEdge::max(self : SignalwindowplanckEdge) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckEdge::to_string(self : SignalwindowplanckEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_path_make(size : Int) -> SignalwindowplanckPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckPath::len(self : SignalwindowplanckPath) -> Int { self.size }

pub fn SignalwindowplanckPath::get(self : SignalwindowplanckPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckPath::set(self : SignalwindowplanckPath, i : Int, v : Double) -> SignalwindowplanckPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckPath::sum(self : SignalwindowplanckPath) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckPath::mean(self : SignalwindowplanckPath) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckPath::scale(self : SignalwindowplanckPath, f : Double) -> SignalwindowplanckPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckPath::add(self : SignalwindowplanckPath, other : SignalwindowplanckPath) -> SignalwindowplanckPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckPath::copy(self : SignalwindowplanckPath) -> SignalwindowplanckPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckPath::fill(self : SignalwindowplanckPath, v : Double) -> SignalwindowplanckPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckPath::min(self : SignalwindowplanckPath) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckPath::max(self : SignalwindowplanckPath) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckPath::to_string(self : SignalwindowplanckPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_cluster_make(size : Int) -> SignalwindowplanckCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckCluster::len(self : SignalwindowplanckCluster) -> Int { self.size }

pub fn SignalwindowplanckCluster::get(self : SignalwindowplanckCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckCluster::set(self : SignalwindowplanckCluster, i : Int, v : Double) -> SignalwindowplanckCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCluster::sum(self : SignalwindowplanckCluster) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckCluster::mean(self : SignalwindowplanckCluster) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckCluster::scale(self : SignalwindowplanckCluster, f : Double) -> SignalwindowplanckCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCluster::add(self : SignalwindowplanckCluster, other : SignalwindowplanckCluster) -> SignalwindowplanckCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckCluster::copy(self : SignalwindowplanckCluster) -> SignalwindowplanckCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCluster::fill(self : SignalwindowplanckCluster, v : Double) -> SignalwindowplanckCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCluster::min(self : SignalwindowplanckCluster) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckCluster::max(self : SignalwindowplanckCluster) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckCluster::to_string(self : SignalwindowplanckCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_model_make(size : Int) -> SignalwindowplanckModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckModel::len(self : SignalwindowplanckModel) -> Int { self.size }

pub fn SignalwindowplanckModel::get(self : SignalwindowplanckModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckModel::set(self : SignalwindowplanckModel, i : Int, v : Double) -> SignalwindowplanckModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckModel::sum(self : SignalwindowplanckModel) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckModel::mean(self : SignalwindowplanckModel) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckModel::scale(self : SignalwindowplanckModel, f : Double) -> SignalwindowplanckModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckModel::add(self : SignalwindowplanckModel, other : SignalwindowplanckModel) -> SignalwindowplanckModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckModel::copy(self : SignalwindowplanckModel) -> SignalwindowplanckModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckModel::fill(self : SignalwindowplanckModel, v : Double) -> SignalwindowplanckModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckModel::min(self : SignalwindowplanckModel) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckModel::max(self : SignalwindowplanckModel) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckModel::to_string(self : SignalwindowplanckModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_layer_make(size : Int) -> SignalwindowplanckLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckLayer::len(self : SignalwindowplanckLayer) -> Int { self.size }

pub fn SignalwindowplanckLayer::get(self : SignalwindowplanckLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckLayer::set(self : SignalwindowplanckLayer, i : Int, v : Double) -> SignalwindowplanckLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckLayer::sum(self : SignalwindowplanckLayer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckLayer::mean(self : SignalwindowplanckLayer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckLayer::scale(self : SignalwindowplanckLayer, f : Double) -> SignalwindowplanckLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckLayer::add(self : SignalwindowplanckLayer, other : SignalwindowplanckLayer) -> SignalwindowplanckLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckLayer::copy(self : SignalwindowplanckLayer) -> SignalwindowplanckLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckLayer::fill(self : SignalwindowplanckLayer, v : Double) -> SignalwindowplanckLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckLayer::min(self : SignalwindowplanckLayer) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckLayer::max(self : SignalwindowplanckLayer) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckLayer::to_string(self : SignalwindowplanckLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_buffer_make(size : Int) -> SignalwindowplanckBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckBuffer::len(self : SignalwindowplanckBuffer) -> Int { self.size }

pub fn SignalwindowplanckBuffer::get(self : SignalwindowplanckBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckBuffer::set(self : SignalwindowplanckBuffer, i : Int, v : Double) -> SignalwindowplanckBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckBuffer::sum(self : SignalwindowplanckBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckBuffer::mean(self : SignalwindowplanckBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckBuffer::scale(self : SignalwindowplanckBuffer, f : Double) -> SignalwindowplanckBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckBuffer::add(self : SignalwindowplanckBuffer, other : SignalwindowplanckBuffer) -> SignalwindowplanckBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckBuffer::copy(self : SignalwindowplanckBuffer) -> SignalwindowplanckBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckBuffer::fill(self : SignalwindowplanckBuffer, v : Double) -> SignalwindowplanckBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckBuffer::min(self : SignalwindowplanckBuffer) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckBuffer::max(self : SignalwindowplanckBuffer) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckBuffer::to_string(self : SignalwindowplanckBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_cursor_make(size : Int) -> SignalwindowplanckCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckCursor::len(self : SignalwindowplanckCursor) -> Int { self.size }

pub fn SignalwindowplanckCursor::get(self : SignalwindowplanckCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckCursor::set(self : SignalwindowplanckCursor, i : Int, v : Double) -> SignalwindowplanckCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCursor::sum(self : SignalwindowplanckCursor) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckCursor::mean(self : SignalwindowplanckCursor) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckCursor::scale(self : SignalwindowplanckCursor, f : Double) -> SignalwindowplanckCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCursor::add(self : SignalwindowplanckCursor, other : SignalwindowplanckCursor) -> SignalwindowplanckCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckCursor::copy(self : SignalwindowplanckCursor) -> SignalwindowplanckCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCursor::fill(self : SignalwindowplanckCursor, v : Double) -> SignalwindowplanckCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckCursor::min(self : SignalwindowplanckCursor) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckCursor::max(self : SignalwindowplanckCursor) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckCursor::to_string(self : SignalwindowplanckCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_view_make(size : Int) -> SignalwindowplanckView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckView::len(self : SignalwindowplanckView) -> Int { self.size }

pub fn SignalwindowplanckView::get(self : SignalwindowplanckView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckView::set(self : SignalwindowplanckView, i : Int, v : Double) -> SignalwindowplanckView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckView::sum(self : SignalwindowplanckView) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckView::mean(self : SignalwindowplanckView) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckView::scale(self : SignalwindowplanckView, f : Double) -> SignalwindowplanckView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckView::add(self : SignalwindowplanckView, other : SignalwindowplanckView) -> SignalwindowplanckView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckView::copy(self : SignalwindowplanckView) -> SignalwindowplanckView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckView::fill(self : SignalwindowplanckView, v : Double) -> SignalwindowplanckView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckView::min(self : SignalwindowplanckView) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckView::max(self : SignalwindowplanckView) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckView::to_string(self : SignalwindowplanckView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_range_make(size : Int) -> SignalwindowplanckRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckRange::len(self : SignalwindowplanckRange) -> Int { self.size }

pub fn SignalwindowplanckRange::get(self : SignalwindowplanckRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckRange::set(self : SignalwindowplanckRange, i : Int, v : Double) -> SignalwindowplanckRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckRange::sum(self : SignalwindowplanckRange) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckRange::mean(self : SignalwindowplanckRange) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckRange::scale(self : SignalwindowplanckRange, f : Double) -> SignalwindowplanckRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckRange::add(self : SignalwindowplanckRange, other : SignalwindowplanckRange) -> SignalwindowplanckRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckRange::copy(self : SignalwindowplanckRange) -> SignalwindowplanckRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckRange::fill(self : SignalwindowplanckRange, v : Double) -> SignalwindowplanckRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckRange::min(self : SignalwindowplanckRange) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckRange::max(self : SignalwindowplanckRange) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckRange::to_string(self : SignalwindowplanckRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_slice_make(size : Int) -> SignalwindowplanckSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowplanckSlice::len(self : SignalwindowplanckSlice) -> Int { self.size }

pub fn SignalwindowplanckSlice::get(self : SignalwindowplanckSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowplanckSlice::set(self : SignalwindowplanckSlice, i : Int, v : Double) -> SignalwindowplanckSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckSlice::sum(self : SignalwindowplanckSlice) -> Double { @_common.sum(self.data) }

pub fn SignalwindowplanckSlice::mean(self : SignalwindowplanckSlice) -> Double { @_common.mean(self.data) }

pub fn SignalwindowplanckSlice::scale(self : SignalwindowplanckSlice, f : Double) -> SignalwindowplanckSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckSlice::add(self : SignalwindowplanckSlice, other : SignalwindowplanckSlice) -> SignalwindowplanckSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowplanckSlice::copy(self : SignalwindowplanckSlice) -> SignalwindowplanckSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckSlice::fill(self : SignalwindowplanckSlice, v : Double) -> SignalwindowplanckSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowplanckSlice::min(self : SignalwindowplanckSlice) -> Double { @_common.min(self.data) }

pub fn SignalwindowplanckSlice::max(self : SignalwindowplanckSlice) -> Double { @_common.max(self.data) }

pub fn SignalwindowplanckSlice::to_string(self : SignalwindowplanckSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

