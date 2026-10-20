///===
/// extcore/signal_spec_yule_walker

pub(all) struct SignalspecyulewalkerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_yule_walker_make_point(x : Double, y : Double) -> SignalspecyulewalkerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_yule_walker_make_point3(x : Double, y : Double, z : Double) -> SignalspecyulewalkerPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecyulewalkerPoint::x(self : SignalspecyulewalkerPoint) -> Double { self.x }

pub fn SignalspecyulewalkerPoint::y(self : SignalspecyulewalkerPoint) -> Double { self.y }

pub fn SignalspecyulewalkerPoint::z(self : SignalspecyulewalkerPoint) -> Double { self.z }

pub fn SignalspecyulewalkerPoint::label(self : SignalspecyulewalkerPoint) -> Int { self.label }

pub fn SignalspecyulewalkerPoint::dist(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecyulewalkerPoint::add(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecyulewalkerPoint::sub(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecyulewalkerPoint::scale(self : SignalspecyulewalkerPoint, s : Double) -> SignalspecyulewalkerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecyulewalkerPoint::dot(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecyulewalkerPoint::cross(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecyulewalkerPoint::norm(self : SignalspecyulewalkerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecyulewalkerPoint::normalize(self : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecyulewalkerPoint::negate(self : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecyulewalkerPoint::mid(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecyulewalkerPoint::lerp(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint, t : Double) -> SignalspecyulewalkerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecyulewalkerPoint::to_string(self : SignalspecyulewalkerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_yule_walker_make_series(vals : Array[Double], name : String) -> SignalspecyulewalkerSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecyulewalkerSeries::len(self : SignalspecyulewalkerSeries) -> Int { self.vals.length() }

pub fn SignalspecyulewalkerSeries::sum(self : SignalspecyulewalkerSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecyulewalkerSeries::mean(self : SignalspecyulewalkerSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecyulewalkerSeries::min(self : SignalspecyulewalkerSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecyulewalkerSeries::max(self : SignalspecyulewalkerSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecyulewalkerSeries::range(self : SignalspecyulewalkerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecyulewalkerSeries::variance(self : SignalspecyulewalkerSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecyulewalkerSeries::std(self : SignalspecyulewalkerSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecyulewalkerSeries::median(self : SignalspecyulewalkerSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecyulewalkerSeries::scale(self : SignalspecyulewalkerSeries, f : Double) -> SignalspecyulewalkerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::add(self : SignalspecyulewalkerSeries, other : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::sub(self : SignalspecyulewalkerSeries, other : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::normalize(self : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecyulewalkerSeries::cumsum(self : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::to_string(self : SignalspecyulewalkerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecyulewalkerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_yule_walker_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecyulewalkerMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_spec_yule_walker_matrix_identity(n : Int) -> SignalspecyulewalkerMatrix {
  let m = signal_spec_yule_walker_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecyulewalkerMatrix::get(self : SignalspecyulewalkerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecyulewalkerMatrix::transpose(self : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  let result = signal_spec_yule_walker_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecyulewalkerMatrix::add(self : SignalspecyulewalkerMatrix, other : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_yule_walker_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecyulewalkerMatrix::scale(self : SignalspecyulewalkerMatrix, s : Double) -> SignalspecyulewalkerMatrix {
  let result = signal_spec_yule_walker_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecyulewalkerMatrix::multiply(self : SignalspecyulewalkerMatrix, other : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  if self.cols != other.rows { return signal_spec_yule_walker_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_yule_walker_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalspecyulewalkerMatrix::trace(self : SignalspecyulewalkerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecyulewalkerMatrix::det(self : SignalspecyulewalkerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecyulewalkerMatrix::norm(self : SignalspecyulewalkerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecyulewalkerMatrix::to_string(self : SignalspecyulewalkerMatrix) -> String {
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

pub(all) struct SignalspecyulewalkerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_yule_walker_make_vector(comps : Array[Double]) -> SignalspecyulewalkerVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_yule_walker_vector_zero(dim : Int) -> SignalspecyulewalkerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecyulewalkerVector::add(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecyulewalkerVector::sub(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecyulewalkerVector::scale(self : SignalspecyulewalkerVector, s : Double) -> SignalspecyulewalkerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecyulewalkerVector::dot(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecyulewalkerVector::norm(self : SignalspecyulewalkerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecyulewalkerVector::normalize(self : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecyulewalkerVector::dist(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecyulewalkerVector::to_string(self : SignalspecyulewalkerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecyulewalkerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_frame_make(size : Int) -> SignalspecyulewalkerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerFrame::len(self : SignalspecyulewalkerFrame) -> Int { self.size }

pub fn SignalspecyulewalkerFrame::get(self : SignalspecyulewalkerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerFrame::set(self : SignalspecyulewalkerFrame, i : Int, v : Double) -> SignalspecyulewalkerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerFrame::sum(self : SignalspecyulewalkerFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerFrame::mean(self : SignalspecyulewalkerFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerFrame::scale(self : SignalspecyulewalkerFrame, f : Double) -> SignalspecyulewalkerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerFrame::add(self : SignalspecyulewalkerFrame, other : SignalspecyulewalkerFrame) -> SignalspecyulewalkerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerFrame::copy(self : SignalspecyulewalkerFrame) -> SignalspecyulewalkerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerFrame::fill(self : SignalspecyulewalkerFrame, v : Double) -> SignalspecyulewalkerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerFrame::min(self : SignalspecyulewalkerFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerFrame::max(self : SignalspecyulewalkerFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerFrame::to_string(self : SignalspecyulewalkerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_table_make(size : Int) -> SignalspecyulewalkerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerTable::len(self : SignalspecyulewalkerTable) -> Int { self.size }

pub fn SignalspecyulewalkerTable::get(self : SignalspecyulewalkerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerTable::set(self : SignalspecyulewalkerTable, i : Int, v : Double) -> SignalspecyulewalkerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerTable::sum(self : SignalspecyulewalkerTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerTable::mean(self : SignalspecyulewalkerTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerTable::scale(self : SignalspecyulewalkerTable, f : Double) -> SignalspecyulewalkerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerTable::add(self : SignalspecyulewalkerTable, other : SignalspecyulewalkerTable) -> SignalspecyulewalkerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerTable::copy(self : SignalspecyulewalkerTable) -> SignalspecyulewalkerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerTable::fill(self : SignalspecyulewalkerTable, v : Double) -> SignalspecyulewalkerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerTable::min(self : SignalspecyulewalkerTable) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerTable::max(self : SignalspecyulewalkerTable) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerTable::to_string(self : SignalspecyulewalkerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_graphn_make(size : Int) -> SignalspecyulewalkerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerGraphN::len(self : SignalspecyulewalkerGraphN) -> Int { self.size }

pub fn SignalspecyulewalkerGraphN::get(self : SignalspecyulewalkerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerGraphN::set(self : SignalspecyulewalkerGraphN, i : Int, v : Double) -> SignalspecyulewalkerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerGraphN::sum(self : SignalspecyulewalkerGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerGraphN::mean(self : SignalspecyulewalkerGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerGraphN::scale(self : SignalspecyulewalkerGraphN, f : Double) -> SignalspecyulewalkerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerGraphN::add(self : SignalspecyulewalkerGraphN, other : SignalspecyulewalkerGraphN) -> SignalspecyulewalkerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerGraphN::copy(self : SignalspecyulewalkerGraphN) -> SignalspecyulewalkerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerGraphN::fill(self : SignalspecyulewalkerGraphN, v : Double) -> SignalspecyulewalkerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerGraphN::min(self : SignalspecyulewalkerGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerGraphN::max(self : SignalspecyulewalkerGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerGraphN::to_string(self : SignalspecyulewalkerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_node_make(size : Int) -> SignalspecyulewalkerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerNode::len(self : SignalspecyulewalkerNode) -> Int { self.size }

pub fn SignalspecyulewalkerNode::get(self : SignalspecyulewalkerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerNode::set(self : SignalspecyulewalkerNode, i : Int, v : Double) -> SignalspecyulewalkerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerNode::sum(self : SignalspecyulewalkerNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerNode::mean(self : SignalspecyulewalkerNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerNode::scale(self : SignalspecyulewalkerNode, f : Double) -> SignalspecyulewalkerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerNode::add(self : SignalspecyulewalkerNode, other : SignalspecyulewalkerNode) -> SignalspecyulewalkerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerNode::copy(self : SignalspecyulewalkerNode) -> SignalspecyulewalkerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerNode::fill(self : SignalspecyulewalkerNode, v : Double) -> SignalspecyulewalkerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerNode::min(self : SignalspecyulewalkerNode) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerNode::max(self : SignalspecyulewalkerNode) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerNode::to_string(self : SignalspecyulewalkerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_edge_make(size : Int) -> SignalspecyulewalkerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerEdge::len(self : SignalspecyulewalkerEdge) -> Int { self.size }

pub fn SignalspecyulewalkerEdge::get(self : SignalspecyulewalkerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerEdge::set(self : SignalspecyulewalkerEdge, i : Int, v : Double) -> SignalspecyulewalkerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerEdge::sum(self : SignalspecyulewalkerEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerEdge::mean(self : SignalspecyulewalkerEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerEdge::scale(self : SignalspecyulewalkerEdge, f : Double) -> SignalspecyulewalkerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerEdge::add(self : SignalspecyulewalkerEdge, other : SignalspecyulewalkerEdge) -> SignalspecyulewalkerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerEdge::copy(self : SignalspecyulewalkerEdge) -> SignalspecyulewalkerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerEdge::fill(self : SignalspecyulewalkerEdge, v : Double) -> SignalspecyulewalkerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerEdge::min(self : SignalspecyulewalkerEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerEdge::max(self : SignalspecyulewalkerEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerEdge::to_string(self : SignalspecyulewalkerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_path_make(size : Int) -> SignalspecyulewalkerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerPath::len(self : SignalspecyulewalkerPath) -> Int { self.size }

pub fn SignalspecyulewalkerPath::get(self : SignalspecyulewalkerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerPath::set(self : SignalspecyulewalkerPath, i : Int, v : Double) -> SignalspecyulewalkerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerPath::sum(self : SignalspecyulewalkerPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerPath::mean(self : SignalspecyulewalkerPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerPath::scale(self : SignalspecyulewalkerPath, f : Double) -> SignalspecyulewalkerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerPath::add(self : SignalspecyulewalkerPath, other : SignalspecyulewalkerPath) -> SignalspecyulewalkerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerPath::copy(self : SignalspecyulewalkerPath) -> SignalspecyulewalkerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerPath::fill(self : SignalspecyulewalkerPath, v : Double) -> SignalspecyulewalkerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerPath::min(self : SignalspecyulewalkerPath) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerPath::max(self : SignalspecyulewalkerPath) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerPath::to_string(self : SignalspecyulewalkerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_cluster_make(size : Int) -> SignalspecyulewalkerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerCluster::len(self : SignalspecyulewalkerCluster) -> Int { self.size }

pub fn SignalspecyulewalkerCluster::get(self : SignalspecyulewalkerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerCluster::set(self : SignalspecyulewalkerCluster, i : Int, v : Double) -> SignalspecyulewalkerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCluster::sum(self : SignalspecyulewalkerCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerCluster::mean(self : SignalspecyulewalkerCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerCluster::scale(self : SignalspecyulewalkerCluster, f : Double) -> SignalspecyulewalkerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCluster::add(self : SignalspecyulewalkerCluster, other : SignalspecyulewalkerCluster) -> SignalspecyulewalkerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerCluster::copy(self : SignalspecyulewalkerCluster) -> SignalspecyulewalkerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCluster::fill(self : SignalspecyulewalkerCluster, v : Double) -> SignalspecyulewalkerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCluster::min(self : SignalspecyulewalkerCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerCluster::max(self : SignalspecyulewalkerCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerCluster::to_string(self : SignalspecyulewalkerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_model_make(size : Int) -> SignalspecyulewalkerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerModel::len(self : SignalspecyulewalkerModel) -> Int { self.size }

pub fn SignalspecyulewalkerModel::get(self : SignalspecyulewalkerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerModel::set(self : SignalspecyulewalkerModel, i : Int, v : Double) -> SignalspecyulewalkerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerModel::sum(self : SignalspecyulewalkerModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerModel::mean(self : SignalspecyulewalkerModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerModel::scale(self : SignalspecyulewalkerModel, f : Double) -> SignalspecyulewalkerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerModel::add(self : SignalspecyulewalkerModel, other : SignalspecyulewalkerModel) -> SignalspecyulewalkerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerModel::copy(self : SignalspecyulewalkerModel) -> SignalspecyulewalkerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerModel::fill(self : SignalspecyulewalkerModel, v : Double) -> SignalspecyulewalkerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerModel::min(self : SignalspecyulewalkerModel) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerModel::max(self : SignalspecyulewalkerModel) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerModel::to_string(self : SignalspecyulewalkerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_layer_make(size : Int) -> SignalspecyulewalkerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerLayer::len(self : SignalspecyulewalkerLayer) -> Int { self.size }

pub fn SignalspecyulewalkerLayer::get(self : SignalspecyulewalkerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerLayer::set(self : SignalspecyulewalkerLayer, i : Int, v : Double) -> SignalspecyulewalkerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerLayer::sum(self : SignalspecyulewalkerLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerLayer::mean(self : SignalspecyulewalkerLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerLayer::scale(self : SignalspecyulewalkerLayer, f : Double) -> SignalspecyulewalkerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerLayer::add(self : SignalspecyulewalkerLayer, other : SignalspecyulewalkerLayer) -> SignalspecyulewalkerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerLayer::copy(self : SignalspecyulewalkerLayer) -> SignalspecyulewalkerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerLayer::fill(self : SignalspecyulewalkerLayer, v : Double) -> SignalspecyulewalkerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerLayer::min(self : SignalspecyulewalkerLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerLayer::max(self : SignalspecyulewalkerLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerLayer::to_string(self : SignalspecyulewalkerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_buffer_make(size : Int) -> SignalspecyulewalkerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerBuffer::len(self : SignalspecyulewalkerBuffer) -> Int { self.size }

pub fn SignalspecyulewalkerBuffer::get(self : SignalspecyulewalkerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerBuffer::set(self : SignalspecyulewalkerBuffer, i : Int, v : Double) -> SignalspecyulewalkerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerBuffer::sum(self : SignalspecyulewalkerBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerBuffer::mean(self : SignalspecyulewalkerBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerBuffer::scale(self : SignalspecyulewalkerBuffer, f : Double) -> SignalspecyulewalkerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerBuffer::add(self : SignalspecyulewalkerBuffer, other : SignalspecyulewalkerBuffer) -> SignalspecyulewalkerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerBuffer::copy(self : SignalspecyulewalkerBuffer) -> SignalspecyulewalkerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerBuffer::fill(self : SignalspecyulewalkerBuffer, v : Double) -> SignalspecyulewalkerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerBuffer::min(self : SignalspecyulewalkerBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerBuffer::max(self : SignalspecyulewalkerBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerBuffer::to_string(self : SignalspecyulewalkerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_cursor_make(size : Int) -> SignalspecyulewalkerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerCursor::len(self : SignalspecyulewalkerCursor) -> Int { self.size }

pub fn SignalspecyulewalkerCursor::get(self : SignalspecyulewalkerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerCursor::set(self : SignalspecyulewalkerCursor, i : Int, v : Double) -> SignalspecyulewalkerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCursor::sum(self : SignalspecyulewalkerCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerCursor::mean(self : SignalspecyulewalkerCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerCursor::scale(self : SignalspecyulewalkerCursor, f : Double) -> SignalspecyulewalkerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCursor::add(self : SignalspecyulewalkerCursor, other : SignalspecyulewalkerCursor) -> SignalspecyulewalkerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerCursor::copy(self : SignalspecyulewalkerCursor) -> SignalspecyulewalkerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCursor::fill(self : SignalspecyulewalkerCursor, v : Double) -> SignalspecyulewalkerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerCursor::min(self : SignalspecyulewalkerCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerCursor::max(self : SignalspecyulewalkerCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerCursor::to_string(self : SignalspecyulewalkerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_view_make(size : Int) -> SignalspecyulewalkerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerView::len(self : SignalspecyulewalkerView) -> Int { self.size }

pub fn SignalspecyulewalkerView::get(self : SignalspecyulewalkerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerView::set(self : SignalspecyulewalkerView, i : Int, v : Double) -> SignalspecyulewalkerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerView::sum(self : SignalspecyulewalkerView) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerView::mean(self : SignalspecyulewalkerView) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerView::scale(self : SignalspecyulewalkerView, f : Double) -> SignalspecyulewalkerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerView::add(self : SignalspecyulewalkerView, other : SignalspecyulewalkerView) -> SignalspecyulewalkerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerView::copy(self : SignalspecyulewalkerView) -> SignalspecyulewalkerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerView::fill(self : SignalspecyulewalkerView, v : Double) -> SignalspecyulewalkerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerView::min(self : SignalspecyulewalkerView) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerView::max(self : SignalspecyulewalkerView) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerView::to_string(self : SignalspecyulewalkerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_range_make(size : Int) -> SignalspecyulewalkerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerRange::len(self : SignalspecyulewalkerRange) -> Int { self.size }

pub fn SignalspecyulewalkerRange::get(self : SignalspecyulewalkerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerRange::set(self : SignalspecyulewalkerRange, i : Int, v : Double) -> SignalspecyulewalkerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerRange::sum(self : SignalspecyulewalkerRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerRange::mean(self : SignalspecyulewalkerRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerRange::scale(self : SignalspecyulewalkerRange, f : Double) -> SignalspecyulewalkerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerRange::add(self : SignalspecyulewalkerRange, other : SignalspecyulewalkerRange) -> SignalspecyulewalkerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerRange::copy(self : SignalspecyulewalkerRange) -> SignalspecyulewalkerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerRange::fill(self : SignalspecyulewalkerRange, v : Double) -> SignalspecyulewalkerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerRange::min(self : SignalspecyulewalkerRange) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerRange::max(self : SignalspecyulewalkerRange) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerRange::to_string(self : SignalspecyulewalkerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_slice_make(size : Int) -> SignalspecyulewalkerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecyulewalkerSlice::len(self : SignalspecyulewalkerSlice) -> Int { self.size }

pub fn SignalspecyulewalkerSlice::get(self : SignalspecyulewalkerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecyulewalkerSlice::set(self : SignalspecyulewalkerSlice, i : Int, v : Double) -> SignalspecyulewalkerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerSlice::sum(self : SignalspecyulewalkerSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecyulewalkerSlice::mean(self : SignalspecyulewalkerSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecyulewalkerSlice::scale(self : SignalspecyulewalkerSlice, f : Double) -> SignalspecyulewalkerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerSlice::add(self : SignalspecyulewalkerSlice, other : SignalspecyulewalkerSlice) -> SignalspecyulewalkerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecyulewalkerSlice::copy(self : SignalspecyulewalkerSlice) -> SignalspecyulewalkerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerSlice::fill(self : SignalspecyulewalkerSlice, v : Double) -> SignalspecyulewalkerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecyulewalkerSlice::min(self : SignalspecyulewalkerSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecyulewalkerSlice::max(self : SignalspecyulewalkerSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecyulewalkerSlice::to_string(self : SignalspecyulewalkerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

