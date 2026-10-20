///===
/// extcore/signal_spec_welch

pub(all) struct SignalspecwelchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_welch_make_point(x : Double, y : Double) -> SignalspecwelchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_welch_make_point3(x : Double, y : Double, z : Double) -> SignalspecwelchPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecwelchPoint::x(self : SignalspecwelchPoint) -> Double { self.x }

pub fn SignalspecwelchPoint::y(self : SignalspecwelchPoint) -> Double { self.y }

pub fn SignalspecwelchPoint::z(self : SignalspecwelchPoint) -> Double { self.z }

pub fn SignalspecwelchPoint::label(self : SignalspecwelchPoint) -> Int { self.label }

pub fn SignalspecwelchPoint::dist(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecwelchPoint::add(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecwelchPoint::sub(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecwelchPoint::scale(self : SignalspecwelchPoint, s : Double) -> SignalspecwelchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecwelchPoint::dot(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecwelchPoint::cross(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecwelchPoint::norm(self : SignalspecwelchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecwelchPoint::normalize(self : SignalspecwelchPoint) -> SignalspecwelchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecwelchPoint::negate(self : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecwelchPoint::mid(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecwelchPoint::lerp(self : SignalspecwelchPoint, other : SignalspecwelchPoint, t : Double) -> SignalspecwelchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecwelchPoint::to_string(self : SignalspecwelchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecwelchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_welch_make_series(vals : Array[Double], name : String) -> SignalspecwelchSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecwelchSeries::len(self : SignalspecwelchSeries) -> Int { self.vals.length() }

pub fn SignalspecwelchSeries::sum(self : SignalspecwelchSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecwelchSeries::mean(self : SignalspecwelchSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecwelchSeries::min(self : SignalspecwelchSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecwelchSeries::max(self : SignalspecwelchSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecwelchSeries::range(self : SignalspecwelchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecwelchSeries::variance(self : SignalspecwelchSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecwelchSeries::std(self : SignalspecwelchSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecwelchSeries::median(self : SignalspecwelchSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecwelchSeries::scale(self : SignalspecwelchSeries, f : Double) -> SignalspecwelchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecwelchSeries::add(self : SignalspecwelchSeries, other : SignalspecwelchSeries) -> SignalspecwelchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecwelchSeries::sub(self : SignalspecwelchSeries, other : SignalspecwelchSeries) -> SignalspecwelchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecwelchSeries::normalize(self : SignalspecwelchSeries) -> SignalspecwelchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecwelchSeries::cumsum(self : SignalspecwelchSeries) -> SignalspecwelchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecwelchSeries::to_string(self : SignalspecwelchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecwelchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_welch_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecwelchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_welch_matrix_identity(n : Int) -> SignalspecwelchMatrix {
  let m = signal_spec_welch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecwelchMatrix::get(self : SignalspecwelchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecwelchMatrix::transpose(self : SignalspecwelchMatrix) -> SignalspecwelchMatrix {
  let result = signal_spec_welch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecwelchMatrix::add(self : SignalspecwelchMatrix, other : SignalspecwelchMatrix) -> SignalspecwelchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_welch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecwelchMatrix::scale(self : SignalspecwelchMatrix, s : Double) -> SignalspecwelchMatrix {
  let result = signal_spec_welch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecwelchMatrix::multiply(self : SignalspecwelchMatrix, other : SignalspecwelchMatrix) -> SignalspecwelchMatrix {
  if self.cols != other.rows { return signal_spec_welch_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_welch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalspecwelchMatrix::trace(self : SignalspecwelchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecwelchMatrix::det(self : SignalspecwelchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecwelchMatrix::norm(self : SignalspecwelchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecwelchMatrix::to_string(self : SignalspecwelchMatrix) -> String {
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

pub(all) struct SignalspecwelchVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_welch_make_vector(comps : Array[Double]) -> SignalspecwelchVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_welch_vector_zero(dim : Int) -> SignalspecwelchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecwelchVector::add(self : SignalspecwelchVector, other : SignalspecwelchVector) -> SignalspecwelchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecwelchVector::sub(self : SignalspecwelchVector, other : SignalspecwelchVector) -> SignalspecwelchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecwelchVector::scale(self : SignalspecwelchVector, s : Double) -> SignalspecwelchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecwelchVector::dot(self : SignalspecwelchVector, other : SignalspecwelchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecwelchVector::norm(self : SignalspecwelchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecwelchVector::normalize(self : SignalspecwelchVector) -> SignalspecwelchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecwelchVector::dist(self : SignalspecwelchVector, other : SignalspecwelchVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecwelchVector::to_string(self : SignalspecwelchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecwelchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_frame_make(size : Int) -> SignalspecwelchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchFrame::len(self : SignalspecwelchFrame) -> Int { self.size }

pub fn SignalspecwelchFrame::get(self : SignalspecwelchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchFrame::set(self : SignalspecwelchFrame, i : Int, v : Double) -> SignalspecwelchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchFrame::sum(self : SignalspecwelchFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchFrame::mean(self : SignalspecwelchFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchFrame::scale(self : SignalspecwelchFrame, f : Double) -> SignalspecwelchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchFrame::add(self : SignalspecwelchFrame, other : SignalspecwelchFrame) -> SignalspecwelchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchFrame::copy(self : SignalspecwelchFrame) -> SignalspecwelchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchFrame::fill(self : SignalspecwelchFrame, v : Double) -> SignalspecwelchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchFrame::min(self : SignalspecwelchFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchFrame::max(self : SignalspecwelchFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchFrame::to_string(self : SignalspecwelchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_table_make(size : Int) -> SignalspecwelchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchTable::len(self : SignalspecwelchTable) -> Int { self.size }

pub fn SignalspecwelchTable::get(self : SignalspecwelchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchTable::set(self : SignalspecwelchTable, i : Int, v : Double) -> SignalspecwelchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchTable::sum(self : SignalspecwelchTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchTable::mean(self : SignalspecwelchTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchTable::scale(self : SignalspecwelchTable, f : Double) -> SignalspecwelchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchTable::add(self : SignalspecwelchTable, other : SignalspecwelchTable) -> SignalspecwelchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchTable::copy(self : SignalspecwelchTable) -> SignalspecwelchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchTable::fill(self : SignalspecwelchTable, v : Double) -> SignalspecwelchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchTable::min(self : SignalspecwelchTable) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchTable::max(self : SignalspecwelchTable) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchTable::to_string(self : SignalspecwelchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_graphn_make(size : Int) -> SignalspecwelchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchGraphN::len(self : SignalspecwelchGraphN) -> Int { self.size }

pub fn SignalspecwelchGraphN::get(self : SignalspecwelchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchGraphN::set(self : SignalspecwelchGraphN, i : Int, v : Double) -> SignalspecwelchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchGraphN::sum(self : SignalspecwelchGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchGraphN::mean(self : SignalspecwelchGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchGraphN::scale(self : SignalspecwelchGraphN, f : Double) -> SignalspecwelchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchGraphN::add(self : SignalspecwelchGraphN, other : SignalspecwelchGraphN) -> SignalspecwelchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchGraphN::copy(self : SignalspecwelchGraphN) -> SignalspecwelchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchGraphN::fill(self : SignalspecwelchGraphN, v : Double) -> SignalspecwelchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchGraphN::min(self : SignalspecwelchGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchGraphN::max(self : SignalspecwelchGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchGraphN::to_string(self : SignalspecwelchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_node_make(size : Int) -> SignalspecwelchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchNode::len(self : SignalspecwelchNode) -> Int { self.size }

pub fn SignalspecwelchNode::get(self : SignalspecwelchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchNode::set(self : SignalspecwelchNode, i : Int, v : Double) -> SignalspecwelchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchNode::sum(self : SignalspecwelchNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchNode::mean(self : SignalspecwelchNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchNode::scale(self : SignalspecwelchNode, f : Double) -> SignalspecwelchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchNode::add(self : SignalspecwelchNode, other : SignalspecwelchNode) -> SignalspecwelchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchNode::copy(self : SignalspecwelchNode) -> SignalspecwelchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchNode::fill(self : SignalspecwelchNode, v : Double) -> SignalspecwelchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchNode::min(self : SignalspecwelchNode) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchNode::max(self : SignalspecwelchNode) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchNode::to_string(self : SignalspecwelchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_edge_make(size : Int) -> SignalspecwelchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchEdge::len(self : SignalspecwelchEdge) -> Int { self.size }

pub fn SignalspecwelchEdge::get(self : SignalspecwelchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchEdge::set(self : SignalspecwelchEdge, i : Int, v : Double) -> SignalspecwelchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchEdge::sum(self : SignalspecwelchEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchEdge::mean(self : SignalspecwelchEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchEdge::scale(self : SignalspecwelchEdge, f : Double) -> SignalspecwelchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchEdge::add(self : SignalspecwelchEdge, other : SignalspecwelchEdge) -> SignalspecwelchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchEdge::copy(self : SignalspecwelchEdge) -> SignalspecwelchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchEdge::fill(self : SignalspecwelchEdge, v : Double) -> SignalspecwelchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchEdge::min(self : SignalspecwelchEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchEdge::max(self : SignalspecwelchEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchEdge::to_string(self : SignalspecwelchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_path_make(size : Int) -> SignalspecwelchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchPath::len(self : SignalspecwelchPath) -> Int { self.size }

pub fn SignalspecwelchPath::get(self : SignalspecwelchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchPath::set(self : SignalspecwelchPath, i : Int, v : Double) -> SignalspecwelchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchPath::sum(self : SignalspecwelchPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchPath::mean(self : SignalspecwelchPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchPath::scale(self : SignalspecwelchPath, f : Double) -> SignalspecwelchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchPath::add(self : SignalspecwelchPath, other : SignalspecwelchPath) -> SignalspecwelchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchPath::copy(self : SignalspecwelchPath) -> SignalspecwelchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchPath::fill(self : SignalspecwelchPath, v : Double) -> SignalspecwelchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchPath::min(self : SignalspecwelchPath) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchPath::max(self : SignalspecwelchPath) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchPath::to_string(self : SignalspecwelchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_cluster_make(size : Int) -> SignalspecwelchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchCluster::len(self : SignalspecwelchCluster) -> Int { self.size }

pub fn SignalspecwelchCluster::get(self : SignalspecwelchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchCluster::set(self : SignalspecwelchCluster, i : Int, v : Double) -> SignalspecwelchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCluster::sum(self : SignalspecwelchCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchCluster::mean(self : SignalspecwelchCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchCluster::scale(self : SignalspecwelchCluster, f : Double) -> SignalspecwelchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCluster::add(self : SignalspecwelchCluster, other : SignalspecwelchCluster) -> SignalspecwelchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchCluster::copy(self : SignalspecwelchCluster) -> SignalspecwelchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCluster::fill(self : SignalspecwelchCluster, v : Double) -> SignalspecwelchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCluster::min(self : SignalspecwelchCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchCluster::max(self : SignalspecwelchCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchCluster::to_string(self : SignalspecwelchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_model_make(size : Int) -> SignalspecwelchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchModel::len(self : SignalspecwelchModel) -> Int { self.size }

pub fn SignalspecwelchModel::get(self : SignalspecwelchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchModel::set(self : SignalspecwelchModel, i : Int, v : Double) -> SignalspecwelchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchModel::sum(self : SignalspecwelchModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchModel::mean(self : SignalspecwelchModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchModel::scale(self : SignalspecwelchModel, f : Double) -> SignalspecwelchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchModel::add(self : SignalspecwelchModel, other : SignalspecwelchModel) -> SignalspecwelchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchModel::copy(self : SignalspecwelchModel) -> SignalspecwelchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchModel::fill(self : SignalspecwelchModel, v : Double) -> SignalspecwelchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchModel::min(self : SignalspecwelchModel) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchModel::max(self : SignalspecwelchModel) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchModel::to_string(self : SignalspecwelchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_layer_make(size : Int) -> SignalspecwelchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchLayer::len(self : SignalspecwelchLayer) -> Int { self.size }

pub fn SignalspecwelchLayer::get(self : SignalspecwelchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchLayer::set(self : SignalspecwelchLayer, i : Int, v : Double) -> SignalspecwelchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchLayer::sum(self : SignalspecwelchLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchLayer::mean(self : SignalspecwelchLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchLayer::scale(self : SignalspecwelchLayer, f : Double) -> SignalspecwelchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchLayer::add(self : SignalspecwelchLayer, other : SignalspecwelchLayer) -> SignalspecwelchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchLayer::copy(self : SignalspecwelchLayer) -> SignalspecwelchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchLayer::fill(self : SignalspecwelchLayer, v : Double) -> SignalspecwelchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchLayer::min(self : SignalspecwelchLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchLayer::max(self : SignalspecwelchLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchLayer::to_string(self : SignalspecwelchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_buffer_make(size : Int) -> SignalspecwelchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchBuffer::len(self : SignalspecwelchBuffer) -> Int { self.size }

pub fn SignalspecwelchBuffer::get(self : SignalspecwelchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchBuffer::set(self : SignalspecwelchBuffer, i : Int, v : Double) -> SignalspecwelchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchBuffer::sum(self : SignalspecwelchBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchBuffer::mean(self : SignalspecwelchBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchBuffer::scale(self : SignalspecwelchBuffer, f : Double) -> SignalspecwelchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchBuffer::add(self : SignalspecwelchBuffer, other : SignalspecwelchBuffer) -> SignalspecwelchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchBuffer::copy(self : SignalspecwelchBuffer) -> SignalspecwelchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchBuffer::fill(self : SignalspecwelchBuffer, v : Double) -> SignalspecwelchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchBuffer::min(self : SignalspecwelchBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchBuffer::max(self : SignalspecwelchBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchBuffer::to_string(self : SignalspecwelchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_cursor_make(size : Int) -> SignalspecwelchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchCursor::len(self : SignalspecwelchCursor) -> Int { self.size }

pub fn SignalspecwelchCursor::get(self : SignalspecwelchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchCursor::set(self : SignalspecwelchCursor, i : Int, v : Double) -> SignalspecwelchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCursor::sum(self : SignalspecwelchCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchCursor::mean(self : SignalspecwelchCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchCursor::scale(self : SignalspecwelchCursor, f : Double) -> SignalspecwelchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCursor::add(self : SignalspecwelchCursor, other : SignalspecwelchCursor) -> SignalspecwelchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchCursor::copy(self : SignalspecwelchCursor) -> SignalspecwelchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCursor::fill(self : SignalspecwelchCursor, v : Double) -> SignalspecwelchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchCursor::min(self : SignalspecwelchCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchCursor::max(self : SignalspecwelchCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchCursor::to_string(self : SignalspecwelchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_view_make(size : Int) -> SignalspecwelchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchView::len(self : SignalspecwelchView) -> Int { self.size }

pub fn SignalspecwelchView::get(self : SignalspecwelchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchView::set(self : SignalspecwelchView, i : Int, v : Double) -> SignalspecwelchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchView::sum(self : SignalspecwelchView) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchView::mean(self : SignalspecwelchView) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchView::scale(self : SignalspecwelchView, f : Double) -> SignalspecwelchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchView::add(self : SignalspecwelchView, other : SignalspecwelchView) -> SignalspecwelchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchView::copy(self : SignalspecwelchView) -> SignalspecwelchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchView::fill(self : SignalspecwelchView, v : Double) -> SignalspecwelchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchView::min(self : SignalspecwelchView) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchView::max(self : SignalspecwelchView) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchView::to_string(self : SignalspecwelchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_range_make(size : Int) -> SignalspecwelchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchRange::len(self : SignalspecwelchRange) -> Int { self.size }

pub fn SignalspecwelchRange::get(self : SignalspecwelchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchRange::set(self : SignalspecwelchRange, i : Int, v : Double) -> SignalspecwelchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchRange::sum(self : SignalspecwelchRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchRange::mean(self : SignalspecwelchRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchRange::scale(self : SignalspecwelchRange, f : Double) -> SignalspecwelchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchRange::add(self : SignalspecwelchRange, other : SignalspecwelchRange) -> SignalspecwelchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchRange::copy(self : SignalspecwelchRange) -> SignalspecwelchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchRange::fill(self : SignalspecwelchRange, v : Double) -> SignalspecwelchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchRange::min(self : SignalspecwelchRange) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchRange::max(self : SignalspecwelchRange) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchRange::to_string(self : SignalspecwelchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_slice_make(size : Int) -> SignalspecwelchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecwelchSlice::len(self : SignalspecwelchSlice) -> Int { self.size }

pub fn SignalspecwelchSlice::get(self : SignalspecwelchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecwelchSlice::set(self : SignalspecwelchSlice, i : Int, v : Double) -> SignalspecwelchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecwelchSlice::sum(self : SignalspecwelchSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecwelchSlice::mean(self : SignalspecwelchSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecwelchSlice::scale(self : SignalspecwelchSlice, f : Double) -> SignalspecwelchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchSlice::add(self : SignalspecwelchSlice, other : SignalspecwelchSlice) -> SignalspecwelchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecwelchSlice::copy(self : SignalspecwelchSlice) -> SignalspecwelchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchSlice::fill(self : SignalspecwelchSlice, v : Double) -> SignalspecwelchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecwelchSlice::min(self : SignalspecwelchSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecwelchSlice::max(self : SignalspecwelchSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecwelchSlice::to_string(self : SignalspecwelchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

