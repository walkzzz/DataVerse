///===
/// extcore/signal_spec_daniell

pub(all) struct SignalspecdaniellPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_daniell_make_point(x : Double, y : Double) -> SignalspecdaniellPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_daniell_make_point3(x : Double, y : Double, z : Double) -> SignalspecdaniellPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecdaniellPoint::x(self : SignalspecdaniellPoint) -> Double { self.x }

pub fn SignalspecdaniellPoint::y(self : SignalspecdaniellPoint) -> Double { self.y }

pub fn SignalspecdaniellPoint::z(self : SignalspecdaniellPoint) -> Double { self.z }

pub fn SignalspecdaniellPoint::label(self : SignalspecdaniellPoint) -> Int { self.label }

pub fn SignalspecdaniellPoint::dist(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecdaniellPoint::add(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecdaniellPoint::sub(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecdaniellPoint::scale(self : SignalspecdaniellPoint, s : Double) -> SignalspecdaniellPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecdaniellPoint::dot(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecdaniellPoint::cross(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecdaniellPoint::norm(self : SignalspecdaniellPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecdaniellPoint::normalize(self : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecdaniellPoint::negate(self : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecdaniellPoint::mid(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecdaniellPoint::lerp(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint, t : Double) -> SignalspecdaniellPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecdaniellPoint::to_string(self : SignalspecdaniellPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecdaniellSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_daniell_make_series(vals : Array[Double], name : String) -> SignalspecdaniellSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecdaniellSeries::len(self : SignalspecdaniellSeries) -> Int { self.vals.length() }

pub fn SignalspecdaniellSeries::sum(self : SignalspecdaniellSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecdaniellSeries::mean(self : SignalspecdaniellSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecdaniellSeries::min(self : SignalspecdaniellSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecdaniellSeries::max(self : SignalspecdaniellSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecdaniellSeries::range(self : SignalspecdaniellSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecdaniellSeries::variance(self : SignalspecdaniellSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecdaniellSeries::std(self : SignalspecdaniellSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecdaniellSeries::median(self : SignalspecdaniellSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecdaniellSeries::scale(self : SignalspecdaniellSeries, f : Double) -> SignalspecdaniellSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecdaniellSeries::add(self : SignalspecdaniellSeries, other : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecdaniellSeries::sub(self : SignalspecdaniellSeries, other : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecdaniellSeries::normalize(self : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecdaniellSeries::cumsum(self : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecdaniellSeries::to_string(self : SignalspecdaniellSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecdaniellMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_daniell_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecdaniellMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_daniell_matrix_identity(n : Int) -> SignalspecdaniellMatrix {
  let m = signal_spec_daniell_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecdaniellMatrix::get(self : SignalspecdaniellMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecdaniellMatrix::transpose(self : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecdaniellMatrix::add(self : SignalspecdaniellMatrix, other : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_daniell_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecdaniellMatrix::scale(self : SignalspecdaniellMatrix, s : Double) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecdaniellMatrix::multiply(self : SignalspecdaniellMatrix, other : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if self.cols != other.rows { return signal_spec_daniell_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_daniell_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalspecdaniellMatrix::trace(self : SignalspecdaniellMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecdaniellMatrix::det(self : SignalspecdaniellMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecdaniellMatrix::norm(self : SignalspecdaniellMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecdaniellMatrix::to_string(self : SignalspecdaniellMatrix) -> String {
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

pub(all) struct SignalspecdaniellVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_daniell_make_vector(comps : Array[Double]) -> SignalspecdaniellVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_daniell_vector_zero(dim : Int) -> SignalspecdaniellVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecdaniellVector::add(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecdaniellVector::sub(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecdaniellVector::scale(self : SignalspecdaniellVector, s : Double) -> SignalspecdaniellVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecdaniellVector::dot(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecdaniellVector::norm(self : SignalspecdaniellVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecdaniellVector::normalize(self : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecdaniellVector::dist(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecdaniellVector::to_string(self : SignalspecdaniellVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecdaniellFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_frame_make(size : Int) -> SignalspecdaniellFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellFrame::len(self : SignalspecdaniellFrame) -> Int { self.size }

pub fn SignalspecdaniellFrame::get(self : SignalspecdaniellFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellFrame::set(self : SignalspecdaniellFrame, i : Int, v : Double) -> SignalspecdaniellFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellFrame::sum(self : SignalspecdaniellFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellFrame::mean(self : SignalspecdaniellFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellFrame::scale(self : SignalspecdaniellFrame, f : Double) -> SignalspecdaniellFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellFrame::add(self : SignalspecdaniellFrame, other : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellFrame::copy(self : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellFrame::fill(self : SignalspecdaniellFrame, v : Double) -> SignalspecdaniellFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellFrame::min(self : SignalspecdaniellFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellFrame::max(self : SignalspecdaniellFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellFrame::to_string(self : SignalspecdaniellFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_table_make(size : Int) -> SignalspecdaniellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellTable::len(self : SignalspecdaniellTable) -> Int { self.size }

pub fn SignalspecdaniellTable::get(self : SignalspecdaniellTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellTable::set(self : SignalspecdaniellTable, i : Int, v : Double) -> SignalspecdaniellTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellTable::sum(self : SignalspecdaniellTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellTable::mean(self : SignalspecdaniellTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellTable::scale(self : SignalspecdaniellTable, f : Double) -> SignalspecdaniellTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellTable::add(self : SignalspecdaniellTable, other : SignalspecdaniellTable) -> SignalspecdaniellTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellTable::copy(self : SignalspecdaniellTable) -> SignalspecdaniellTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellTable::fill(self : SignalspecdaniellTable, v : Double) -> SignalspecdaniellTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellTable::min(self : SignalspecdaniellTable) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellTable::max(self : SignalspecdaniellTable) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellTable::to_string(self : SignalspecdaniellTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_graphn_make(size : Int) -> SignalspecdaniellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellGraphN::len(self : SignalspecdaniellGraphN) -> Int { self.size }

pub fn SignalspecdaniellGraphN::get(self : SignalspecdaniellGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellGraphN::set(self : SignalspecdaniellGraphN, i : Int, v : Double) -> SignalspecdaniellGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellGraphN::sum(self : SignalspecdaniellGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellGraphN::mean(self : SignalspecdaniellGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellGraphN::scale(self : SignalspecdaniellGraphN, f : Double) -> SignalspecdaniellGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellGraphN::add(self : SignalspecdaniellGraphN, other : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellGraphN::copy(self : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellGraphN::fill(self : SignalspecdaniellGraphN, v : Double) -> SignalspecdaniellGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellGraphN::min(self : SignalspecdaniellGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellGraphN::max(self : SignalspecdaniellGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellGraphN::to_string(self : SignalspecdaniellGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_node_make(size : Int) -> SignalspecdaniellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellNode::len(self : SignalspecdaniellNode) -> Int { self.size }

pub fn SignalspecdaniellNode::get(self : SignalspecdaniellNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellNode::set(self : SignalspecdaniellNode, i : Int, v : Double) -> SignalspecdaniellNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellNode::sum(self : SignalspecdaniellNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellNode::mean(self : SignalspecdaniellNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellNode::scale(self : SignalspecdaniellNode, f : Double) -> SignalspecdaniellNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellNode::add(self : SignalspecdaniellNode, other : SignalspecdaniellNode) -> SignalspecdaniellNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellNode::copy(self : SignalspecdaniellNode) -> SignalspecdaniellNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellNode::fill(self : SignalspecdaniellNode, v : Double) -> SignalspecdaniellNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellNode::min(self : SignalspecdaniellNode) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellNode::max(self : SignalspecdaniellNode) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellNode::to_string(self : SignalspecdaniellNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_edge_make(size : Int) -> SignalspecdaniellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellEdge::len(self : SignalspecdaniellEdge) -> Int { self.size }

pub fn SignalspecdaniellEdge::get(self : SignalspecdaniellEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellEdge::set(self : SignalspecdaniellEdge, i : Int, v : Double) -> SignalspecdaniellEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellEdge::sum(self : SignalspecdaniellEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellEdge::mean(self : SignalspecdaniellEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellEdge::scale(self : SignalspecdaniellEdge, f : Double) -> SignalspecdaniellEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellEdge::add(self : SignalspecdaniellEdge, other : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellEdge::copy(self : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellEdge::fill(self : SignalspecdaniellEdge, v : Double) -> SignalspecdaniellEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellEdge::min(self : SignalspecdaniellEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellEdge::max(self : SignalspecdaniellEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellEdge::to_string(self : SignalspecdaniellEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_path_make(size : Int) -> SignalspecdaniellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellPath::len(self : SignalspecdaniellPath) -> Int { self.size }

pub fn SignalspecdaniellPath::get(self : SignalspecdaniellPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellPath::set(self : SignalspecdaniellPath, i : Int, v : Double) -> SignalspecdaniellPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellPath::sum(self : SignalspecdaniellPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellPath::mean(self : SignalspecdaniellPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellPath::scale(self : SignalspecdaniellPath, f : Double) -> SignalspecdaniellPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellPath::add(self : SignalspecdaniellPath, other : SignalspecdaniellPath) -> SignalspecdaniellPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellPath::copy(self : SignalspecdaniellPath) -> SignalspecdaniellPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellPath::fill(self : SignalspecdaniellPath, v : Double) -> SignalspecdaniellPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellPath::min(self : SignalspecdaniellPath) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellPath::max(self : SignalspecdaniellPath) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellPath::to_string(self : SignalspecdaniellPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cluster_make(size : Int) -> SignalspecdaniellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellCluster::len(self : SignalspecdaniellCluster) -> Int { self.size }

pub fn SignalspecdaniellCluster::get(self : SignalspecdaniellCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellCluster::set(self : SignalspecdaniellCluster, i : Int, v : Double) -> SignalspecdaniellCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCluster::sum(self : SignalspecdaniellCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellCluster::mean(self : SignalspecdaniellCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellCluster::scale(self : SignalspecdaniellCluster, f : Double) -> SignalspecdaniellCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCluster::add(self : SignalspecdaniellCluster, other : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellCluster::copy(self : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCluster::fill(self : SignalspecdaniellCluster, v : Double) -> SignalspecdaniellCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCluster::min(self : SignalspecdaniellCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellCluster::max(self : SignalspecdaniellCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellCluster::to_string(self : SignalspecdaniellCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_model_make(size : Int) -> SignalspecdaniellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellModel::len(self : SignalspecdaniellModel) -> Int { self.size }

pub fn SignalspecdaniellModel::get(self : SignalspecdaniellModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellModel::set(self : SignalspecdaniellModel, i : Int, v : Double) -> SignalspecdaniellModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellModel::sum(self : SignalspecdaniellModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellModel::mean(self : SignalspecdaniellModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellModel::scale(self : SignalspecdaniellModel, f : Double) -> SignalspecdaniellModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellModel::add(self : SignalspecdaniellModel, other : SignalspecdaniellModel) -> SignalspecdaniellModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellModel::copy(self : SignalspecdaniellModel) -> SignalspecdaniellModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellModel::fill(self : SignalspecdaniellModel, v : Double) -> SignalspecdaniellModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellModel::min(self : SignalspecdaniellModel) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellModel::max(self : SignalspecdaniellModel) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellModel::to_string(self : SignalspecdaniellModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_layer_make(size : Int) -> SignalspecdaniellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellLayer::len(self : SignalspecdaniellLayer) -> Int { self.size }

pub fn SignalspecdaniellLayer::get(self : SignalspecdaniellLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellLayer::set(self : SignalspecdaniellLayer, i : Int, v : Double) -> SignalspecdaniellLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellLayer::sum(self : SignalspecdaniellLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellLayer::mean(self : SignalspecdaniellLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellLayer::scale(self : SignalspecdaniellLayer, f : Double) -> SignalspecdaniellLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellLayer::add(self : SignalspecdaniellLayer, other : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellLayer::copy(self : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellLayer::fill(self : SignalspecdaniellLayer, v : Double) -> SignalspecdaniellLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellLayer::min(self : SignalspecdaniellLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellLayer::max(self : SignalspecdaniellLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellLayer::to_string(self : SignalspecdaniellLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_buffer_make(size : Int) -> SignalspecdaniellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellBuffer::len(self : SignalspecdaniellBuffer) -> Int { self.size }

pub fn SignalspecdaniellBuffer::get(self : SignalspecdaniellBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellBuffer::set(self : SignalspecdaniellBuffer, i : Int, v : Double) -> SignalspecdaniellBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellBuffer::sum(self : SignalspecdaniellBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellBuffer::mean(self : SignalspecdaniellBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellBuffer::scale(self : SignalspecdaniellBuffer, f : Double) -> SignalspecdaniellBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellBuffer::add(self : SignalspecdaniellBuffer, other : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellBuffer::copy(self : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellBuffer::fill(self : SignalspecdaniellBuffer, v : Double) -> SignalspecdaniellBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellBuffer::min(self : SignalspecdaniellBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellBuffer::max(self : SignalspecdaniellBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellBuffer::to_string(self : SignalspecdaniellBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cursor_make(size : Int) -> SignalspecdaniellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellCursor::len(self : SignalspecdaniellCursor) -> Int { self.size }

pub fn SignalspecdaniellCursor::get(self : SignalspecdaniellCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellCursor::set(self : SignalspecdaniellCursor, i : Int, v : Double) -> SignalspecdaniellCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCursor::sum(self : SignalspecdaniellCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellCursor::mean(self : SignalspecdaniellCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellCursor::scale(self : SignalspecdaniellCursor, f : Double) -> SignalspecdaniellCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCursor::add(self : SignalspecdaniellCursor, other : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellCursor::copy(self : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCursor::fill(self : SignalspecdaniellCursor, v : Double) -> SignalspecdaniellCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellCursor::min(self : SignalspecdaniellCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellCursor::max(self : SignalspecdaniellCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellCursor::to_string(self : SignalspecdaniellCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_view_make(size : Int) -> SignalspecdaniellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellView::len(self : SignalspecdaniellView) -> Int { self.size }

pub fn SignalspecdaniellView::get(self : SignalspecdaniellView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellView::set(self : SignalspecdaniellView, i : Int, v : Double) -> SignalspecdaniellView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellView::sum(self : SignalspecdaniellView) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellView::mean(self : SignalspecdaniellView) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellView::scale(self : SignalspecdaniellView, f : Double) -> SignalspecdaniellView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellView::add(self : SignalspecdaniellView, other : SignalspecdaniellView) -> SignalspecdaniellView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellView::copy(self : SignalspecdaniellView) -> SignalspecdaniellView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellView::fill(self : SignalspecdaniellView, v : Double) -> SignalspecdaniellView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellView::min(self : SignalspecdaniellView) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellView::max(self : SignalspecdaniellView) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellView::to_string(self : SignalspecdaniellView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_range_make(size : Int) -> SignalspecdaniellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellRange::len(self : SignalspecdaniellRange) -> Int { self.size }

pub fn SignalspecdaniellRange::get(self : SignalspecdaniellRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellRange::set(self : SignalspecdaniellRange, i : Int, v : Double) -> SignalspecdaniellRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellRange::sum(self : SignalspecdaniellRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellRange::mean(self : SignalspecdaniellRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellRange::scale(self : SignalspecdaniellRange, f : Double) -> SignalspecdaniellRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellRange::add(self : SignalspecdaniellRange, other : SignalspecdaniellRange) -> SignalspecdaniellRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellRange::copy(self : SignalspecdaniellRange) -> SignalspecdaniellRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellRange::fill(self : SignalspecdaniellRange, v : Double) -> SignalspecdaniellRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellRange::min(self : SignalspecdaniellRange) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellRange::max(self : SignalspecdaniellRange) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellRange::to_string(self : SignalspecdaniellRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_slice_make(size : Int) -> SignalspecdaniellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecdaniellSlice::len(self : SignalspecdaniellSlice) -> Int { self.size }

pub fn SignalspecdaniellSlice::get(self : SignalspecdaniellSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecdaniellSlice::set(self : SignalspecdaniellSlice, i : Int, v : Double) -> SignalspecdaniellSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellSlice::sum(self : SignalspecdaniellSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecdaniellSlice::mean(self : SignalspecdaniellSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecdaniellSlice::scale(self : SignalspecdaniellSlice, f : Double) -> SignalspecdaniellSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellSlice::add(self : SignalspecdaniellSlice, other : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecdaniellSlice::copy(self : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellSlice::fill(self : SignalspecdaniellSlice, v : Double) -> SignalspecdaniellSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecdaniellSlice::min(self : SignalspecdaniellSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecdaniellSlice::max(self : SignalspecdaniellSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecdaniellSlice::to_string(self : SignalspecdaniellSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

