///===
/// extcore/signal_spec_periodogram

pub(all) struct SignalspecperiodogramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_periodogram_make_point(x : Double, y : Double) -> SignalspecperiodogramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_periodogram_make_point3(x : Double, y : Double, z : Double) -> SignalspecperiodogramPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecperiodogramPoint::x(self : SignalspecperiodogramPoint) -> Double { self.x }

pub fn SignalspecperiodogramPoint::y(self : SignalspecperiodogramPoint) -> Double { self.y }

pub fn SignalspecperiodogramPoint::z(self : SignalspecperiodogramPoint) -> Double { self.z }

pub fn SignalspecperiodogramPoint::label(self : SignalspecperiodogramPoint) -> Int { self.label }

pub fn SignalspecperiodogramPoint::dist(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecperiodogramPoint::add(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecperiodogramPoint::sub(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecperiodogramPoint::scale(self : SignalspecperiodogramPoint, s : Double) -> SignalspecperiodogramPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecperiodogramPoint::dot(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecperiodogramPoint::cross(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecperiodogramPoint::norm(self : SignalspecperiodogramPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecperiodogramPoint::normalize(self : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecperiodogramPoint::negate(self : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecperiodogramPoint::mid(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecperiodogramPoint::lerp(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint, t : Double) -> SignalspecperiodogramPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecperiodogramPoint::to_string(self : SignalspecperiodogramPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecperiodogramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_periodogram_make_series(vals : Array[Double], name : String) -> SignalspecperiodogramSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecperiodogramSeries::len(self : SignalspecperiodogramSeries) -> Int { self.vals.length() }

pub fn SignalspecperiodogramSeries::sum(self : SignalspecperiodogramSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecperiodogramSeries::mean(self : SignalspecperiodogramSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecperiodogramSeries::min(self : SignalspecperiodogramSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecperiodogramSeries::max(self : SignalspecperiodogramSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecperiodogramSeries::range(self : SignalspecperiodogramSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecperiodogramSeries::variance(self : SignalspecperiodogramSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecperiodogramSeries::std(self : SignalspecperiodogramSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecperiodogramSeries::median(self : SignalspecperiodogramSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecperiodogramSeries::scale(self : SignalspecperiodogramSeries, f : Double) -> SignalspecperiodogramSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecperiodogramSeries::add(self : SignalspecperiodogramSeries, other : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecperiodogramSeries::sub(self : SignalspecperiodogramSeries, other : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecperiodogramSeries::normalize(self : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecperiodogramSeries::cumsum(self : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecperiodogramSeries::to_string(self : SignalspecperiodogramSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecperiodogramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_periodogram_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecperiodogramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_periodogram_matrix_identity(n : Int) -> SignalspecperiodogramMatrix {
  let m = signal_spec_periodogram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecperiodogramMatrix::get(self : SignalspecperiodogramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecperiodogramMatrix::transpose(self : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  let result = signal_spec_periodogram_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecperiodogramMatrix::add(self : SignalspecperiodogramMatrix, other : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_periodogram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecperiodogramMatrix::scale(self : SignalspecperiodogramMatrix, s : Double) -> SignalspecperiodogramMatrix {
  let result = signal_spec_periodogram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecperiodogramMatrix::multiply(self : SignalspecperiodogramMatrix, other : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  if self.cols != other.rows { return signal_spec_periodogram_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_periodogram_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalspecperiodogramMatrix::trace(self : SignalspecperiodogramMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecperiodogramMatrix::det(self : SignalspecperiodogramMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecperiodogramMatrix::norm(self : SignalspecperiodogramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecperiodogramMatrix::to_string(self : SignalspecperiodogramMatrix) -> String {
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

pub(all) struct SignalspecperiodogramVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_periodogram_make_vector(comps : Array[Double]) -> SignalspecperiodogramVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_periodogram_vector_zero(dim : Int) -> SignalspecperiodogramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecperiodogramVector::add(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecperiodogramVector::sub(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecperiodogramVector::scale(self : SignalspecperiodogramVector, s : Double) -> SignalspecperiodogramVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecperiodogramVector::dot(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecperiodogramVector::norm(self : SignalspecperiodogramVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecperiodogramVector::normalize(self : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecperiodogramVector::dist(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecperiodogramVector::to_string(self : SignalspecperiodogramVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecperiodogramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_frame_make(size : Int) -> SignalspecperiodogramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramFrame::len(self : SignalspecperiodogramFrame) -> Int { self.size }

pub fn SignalspecperiodogramFrame::get(self : SignalspecperiodogramFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramFrame::set(self : SignalspecperiodogramFrame, i : Int, v : Double) -> SignalspecperiodogramFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramFrame::sum(self : SignalspecperiodogramFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramFrame::mean(self : SignalspecperiodogramFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramFrame::scale(self : SignalspecperiodogramFrame, f : Double) -> SignalspecperiodogramFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramFrame::add(self : SignalspecperiodogramFrame, other : SignalspecperiodogramFrame) -> SignalspecperiodogramFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramFrame::copy(self : SignalspecperiodogramFrame) -> SignalspecperiodogramFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramFrame::fill(self : SignalspecperiodogramFrame, v : Double) -> SignalspecperiodogramFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramFrame::min(self : SignalspecperiodogramFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramFrame::max(self : SignalspecperiodogramFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramFrame::to_string(self : SignalspecperiodogramFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_table_make(size : Int) -> SignalspecperiodogramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramTable::len(self : SignalspecperiodogramTable) -> Int { self.size }

pub fn SignalspecperiodogramTable::get(self : SignalspecperiodogramTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramTable::set(self : SignalspecperiodogramTable, i : Int, v : Double) -> SignalspecperiodogramTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramTable::sum(self : SignalspecperiodogramTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramTable::mean(self : SignalspecperiodogramTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramTable::scale(self : SignalspecperiodogramTable, f : Double) -> SignalspecperiodogramTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramTable::add(self : SignalspecperiodogramTable, other : SignalspecperiodogramTable) -> SignalspecperiodogramTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramTable::copy(self : SignalspecperiodogramTable) -> SignalspecperiodogramTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramTable::fill(self : SignalspecperiodogramTable, v : Double) -> SignalspecperiodogramTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramTable::min(self : SignalspecperiodogramTable) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramTable::max(self : SignalspecperiodogramTable) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramTable::to_string(self : SignalspecperiodogramTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_graphn_make(size : Int) -> SignalspecperiodogramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramGraphN::len(self : SignalspecperiodogramGraphN) -> Int { self.size }

pub fn SignalspecperiodogramGraphN::get(self : SignalspecperiodogramGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramGraphN::set(self : SignalspecperiodogramGraphN, i : Int, v : Double) -> SignalspecperiodogramGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramGraphN::sum(self : SignalspecperiodogramGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramGraphN::mean(self : SignalspecperiodogramGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramGraphN::scale(self : SignalspecperiodogramGraphN, f : Double) -> SignalspecperiodogramGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramGraphN::add(self : SignalspecperiodogramGraphN, other : SignalspecperiodogramGraphN) -> SignalspecperiodogramGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramGraphN::copy(self : SignalspecperiodogramGraphN) -> SignalspecperiodogramGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramGraphN::fill(self : SignalspecperiodogramGraphN, v : Double) -> SignalspecperiodogramGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramGraphN::min(self : SignalspecperiodogramGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramGraphN::max(self : SignalspecperiodogramGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramGraphN::to_string(self : SignalspecperiodogramGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_node_make(size : Int) -> SignalspecperiodogramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramNode::len(self : SignalspecperiodogramNode) -> Int { self.size }

pub fn SignalspecperiodogramNode::get(self : SignalspecperiodogramNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramNode::set(self : SignalspecperiodogramNode, i : Int, v : Double) -> SignalspecperiodogramNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramNode::sum(self : SignalspecperiodogramNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramNode::mean(self : SignalspecperiodogramNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramNode::scale(self : SignalspecperiodogramNode, f : Double) -> SignalspecperiodogramNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramNode::add(self : SignalspecperiodogramNode, other : SignalspecperiodogramNode) -> SignalspecperiodogramNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramNode::copy(self : SignalspecperiodogramNode) -> SignalspecperiodogramNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramNode::fill(self : SignalspecperiodogramNode, v : Double) -> SignalspecperiodogramNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramNode::min(self : SignalspecperiodogramNode) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramNode::max(self : SignalspecperiodogramNode) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramNode::to_string(self : SignalspecperiodogramNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_edge_make(size : Int) -> SignalspecperiodogramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramEdge::len(self : SignalspecperiodogramEdge) -> Int { self.size }

pub fn SignalspecperiodogramEdge::get(self : SignalspecperiodogramEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramEdge::set(self : SignalspecperiodogramEdge, i : Int, v : Double) -> SignalspecperiodogramEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramEdge::sum(self : SignalspecperiodogramEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramEdge::mean(self : SignalspecperiodogramEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramEdge::scale(self : SignalspecperiodogramEdge, f : Double) -> SignalspecperiodogramEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramEdge::add(self : SignalspecperiodogramEdge, other : SignalspecperiodogramEdge) -> SignalspecperiodogramEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramEdge::copy(self : SignalspecperiodogramEdge) -> SignalspecperiodogramEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramEdge::fill(self : SignalspecperiodogramEdge, v : Double) -> SignalspecperiodogramEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramEdge::min(self : SignalspecperiodogramEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramEdge::max(self : SignalspecperiodogramEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramEdge::to_string(self : SignalspecperiodogramEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_path_make(size : Int) -> SignalspecperiodogramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramPath::len(self : SignalspecperiodogramPath) -> Int { self.size }

pub fn SignalspecperiodogramPath::get(self : SignalspecperiodogramPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramPath::set(self : SignalspecperiodogramPath, i : Int, v : Double) -> SignalspecperiodogramPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramPath::sum(self : SignalspecperiodogramPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramPath::mean(self : SignalspecperiodogramPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramPath::scale(self : SignalspecperiodogramPath, f : Double) -> SignalspecperiodogramPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramPath::add(self : SignalspecperiodogramPath, other : SignalspecperiodogramPath) -> SignalspecperiodogramPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramPath::copy(self : SignalspecperiodogramPath) -> SignalspecperiodogramPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramPath::fill(self : SignalspecperiodogramPath, v : Double) -> SignalspecperiodogramPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramPath::min(self : SignalspecperiodogramPath) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramPath::max(self : SignalspecperiodogramPath) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramPath::to_string(self : SignalspecperiodogramPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_cluster_make(size : Int) -> SignalspecperiodogramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramCluster::len(self : SignalspecperiodogramCluster) -> Int { self.size }

pub fn SignalspecperiodogramCluster::get(self : SignalspecperiodogramCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramCluster::set(self : SignalspecperiodogramCluster, i : Int, v : Double) -> SignalspecperiodogramCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCluster::sum(self : SignalspecperiodogramCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramCluster::mean(self : SignalspecperiodogramCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramCluster::scale(self : SignalspecperiodogramCluster, f : Double) -> SignalspecperiodogramCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCluster::add(self : SignalspecperiodogramCluster, other : SignalspecperiodogramCluster) -> SignalspecperiodogramCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramCluster::copy(self : SignalspecperiodogramCluster) -> SignalspecperiodogramCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCluster::fill(self : SignalspecperiodogramCluster, v : Double) -> SignalspecperiodogramCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCluster::min(self : SignalspecperiodogramCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramCluster::max(self : SignalspecperiodogramCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramCluster::to_string(self : SignalspecperiodogramCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_model_make(size : Int) -> SignalspecperiodogramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramModel::len(self : SignalspecperiodogramModel) -> Int { self.size }

pub fn SignalspecperiodogramModel::get(self : SignalspecperiodogramModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramModel::set(self : SignalspecperiodogramModel, i : Int, v : Double) -> SignalspecperiodogramModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramModel::sum(self : SignalspecperiodogramModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramModel::mean(self : SignalspecperiodogramModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramModel::scale(self : SignalspecperiodogramModel, f : Double) -> SignalspecperiodogramModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramModel::add(self : SignalspecperiodogramModel, other : SignalspecperiodogramModel) -> SignalspecperiodogramModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramModel::copy(self : SignalspecperiodogramModel) -> SignalspecperiodogramModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramModel::fill(self : SignalspecperiodogramModel, v : Double) -> SignalspecperiodogramModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramModel::min(self : SignalspecperiodogramModel) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramModel::max(self : SignalspecperiodogramModel) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramModel::to_string(self : SignalspecperiodogramModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_layer_make(size : Int) -> SignalspecperiodogramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramLayer::len(self : SignalspecperiodogramLayer) -> Int { self.size }

pub fn SignalspecperiodogramLayer::get(self : SignalspecperiodogramLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramLayer::set(self : SignalspecperiodogramLayer, i : Int, v : Double) -> SignalspecperiodogramLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramLayer::sum(self : SignalspecperiodogramLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramLayer::mean(self : SignalspecperiodogramLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramLayer::scale(self : SignalspecperiodogramLayer, f : Double) -> SignalspecperiodogramLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramLayer::add(self : SignalspecperiodogramLayer, other : SignalspecperiodogramLayer) -> SignalspecperiodogramLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramLayer::copy(self : SignalspecperiodogramLayer) -> SignalspecperiodogramLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramLayer::fill(self : SignalspecperiodogramLayer, v : Double) -> SignalspecperiodogramLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramLayer::min(self : SignalspecperiodogramLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramLayer::max(self : SignalspecperiodogramLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramLayer::to_string(self : SignalspecperiodogramLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_buffer_make(size : Int) -> SignalspecperiodogramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramBuffer::len(self : SignalspecperiodogramBuffer) -> Int { self.size }

pub fn SignalspecperiodogramBuffer::get(self : SignalspecperiodogramBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramBuffer::set(self : SignalspecperiodogramBuffer, i : Int, v : Double) -> SignalspecperiodogramBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramBuffer::sum(self : SignalspecperiodogramBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramBuffer::mean(self : SignalspecperiodogramBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramBuffer::scale(self : SignalspecperiodogramBuffer, f : Double) -> SignalspecperiodogramBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramBuffer::add(self : SignalspecperiodogramBuffer, other : SignalspecperiodogramBuffer) -> SignalspecperiodogramBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramBuffer::copy(self : SignalspecperiodogramBuffer) -> SignalspecperiodogramBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramBuffer::fill(self : SignalspecperiodogramBuffer, v : Double) -> SignalspecperiodogramBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramBuffer::min(self : SignalspecperiodogramBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramBuffer::max(self : SignalspecperiodogramBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramBuffer::to_string(self : SignalspecperiodogramBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_cursor_make(size : Int) -> SignalspecperiodogramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramCursor::len(self : SignalspecperiodogramCursor) -> Int { self.size }

pub fn SignalspecperiodogramCursor::get(self : SignalspecperiodogramCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramCursor::set(self : SignalspecperiodogramCursor, i : Int, v : Double) -> SignalspecperiodogramCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCursor::sum(self : SignalspecperiodogramCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramCursor::mean(self : SignalspecperiodogramCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramCursor::scale(self : SignalspecperiodogramCursor, f : Double) -> SignalspecperiodogramCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCursor::add(self : SignalspecperiodogramCursor, other : SignalspecperiodogramCursor) -> SignalspecperiodogramCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramCursor::copy(self : SignalspecperiodogramCursor) -> SignalspecperiodogramCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCursor::fill(self : SignalspecperiodogramCursor, v : Double) -> SignalspecperiodogramCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramCursor::min(self : SignalspecperiodogramCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramCursor::max(self : SignalspecperiodogramCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramCursor::to_string(self : SignalspecperiodogramCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_view_make(size : Int) -> SignalspecperiodogramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramView::len(self : SignalspecperiodogramView) -> Int { self.size }

pub fn SignalspecperiodogramView::get(self : SignalspecperiodogramView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramView::set(self : SignalspecperiodogramView, i : Int, v : Double) -> SignalspecperiodogramView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramView::sum(self : SignalspecperiodogramView) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramView::mean(self : SignalspecperiodogramView) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramView::scale(self : SignalspecperiodogramView, f : Double) -> SignalspecperiodogramView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramView::add(self : SignalspecperiodogramView, other : SignalspecperiodogramView) -> SignalspecperiodogramView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramView::copy(self : SignalspecperiodogramView) -> SignalspecperiodogramView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramView::fill(self : SignalspecperiodogramView, v : Double) -> SignalspecperiodogramView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramView::min(self : SignalspecperiodogramView) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramView::max(self : SignalspecperiodogramView) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramView::to_string(self : SignalspecperiodogramView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_range_make(size : Int) -> SignalspecperiodogramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramRange::len(self : SignalspecperiodogramRange) -> Int { self.size }

pub fn SignalspecperiodogramRange::get(self : SignalspecperiodogramRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramRange::set(self : SignalspecperiodogramRange, i : Int, v : Double) -> SignalspecperiodogramRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramRange::sum(self : SignalspecperiodogramRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramRange::mean(self : SignalspecperiodogramRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramRange::scale(self : SignalspecperiodogramRange, f : Double) -> SignalspecperiodogramRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramRange::add(self : SignalspecperiodogramRange, other : SignalspecperiodogramRange) -> SignalspecperiodogramRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramRange::copy(self : SignalspecperiodogramRange) -> SignalspecperiodogramRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramRange::fill(self : SignalspecperiodogramRange, v : Double) -> SignalspecperiodogramRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramRange::min(self : SignalspecperiodogramRange) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramRange::max(self : SignalspecperiodogramRange) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramRange::to_string(self : SignalspecperiodogramRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_slice_make(size : Int) -> SignalspecperiodogramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecperiodogramSlice::len(self : SignalspecperiodogramSlice) -> Int { self.size }

pub fn SignalspecperiodogramSlice::get(self : SignalspecperiodogramSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecperiodogramSlice::set(self : SignalspecperiodogramSlice, i : Int, v : Double) -> SignalspecperiodogramSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramSlice::sum(self : SignalspecperiodogramSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecperiodogramSlice::mean(self : SignalspecperiodogramSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecperiodogramSlice::scale(self : SignalspecperiodogramSlice, f : Double) -> SignalspecperiodogramSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramSlice::add(self : SignalspecperiodogramSlice, other : SignalspecperiodogramSlice) -> SignalspecperiodogramSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecperiodogramSlice::copy(self : SignalspecperiodogramSlice) -> SignalspecperiodogramSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramSlice::fill(self : SignalspecperiodogramSlice, v : Double) -> SignalspecperiodogramSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecperiodogramSlice::min(self : SignalspecperiodogramSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecperiodogramSlice::max(self : SignalspecperiodogramSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecperiodogramSlice::to_string(self : SignalspecperiodogramSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

