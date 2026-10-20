///===
/// extcore/signal_spec_burg

pub(all) struct SignalspecburgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_burg_make_point(x : Double, y : Double) -> SignalspecburgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_burg_make_point3(x : Double, y : Double, z : Double) -> SignalspecburgPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecburgPoint::x(self : SignalspecburgPoint) -> Double { self.x }

pub fn SignalspecburgPoint::y(self : SignalspecburgPoint) -> Double { self.y }

pub fn SignalspecburgPoint::z(self : SignalspecburgPoint) -> Double { self.z }

pub fn SignalspecburgPoint::label(self : SignalspecburgPoint) -> Int { self.label }

pub fn SignalspecburgPoint::dist(self : SignalspecburgPoint, other : SignalspecburgPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecburgPoint::add(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecburgPoint::sub(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecburgPoint::scale(self : SignalspecburgPoint, s : Double) -> SignalspecburgPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecburgPoint::dot(self : SignalspecburgPoint, other : SignalspecburgPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecburgPoint::cross(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecburgPoint::norm(self : SignalspecburgPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecburgPoint::normalize(self : SignalspecburgPoint) -> SignalspecburgPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecburgPoint::negate(self : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecburgPoint::mid(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecburgPoint::lerp(self : SignalspecburgPoint, other : SignalspecburgPoint, t : Double) -> SignalspecburgPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecburgPoint::to_string(self : SignalspecburgPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecburgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_burg_make_series(vals : Array[Double], name : String) -> SignalspecburgSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecburgSeries::len(self : SignalspecburgSeries) -> Int { self.vals.length() }

pub fn SignalspecburgSeries::sum(self : SignalspecburgSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecburgSeries::mean(self : SignalspecburgSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecburgSeries::min(self : SignalspecburgSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecburgSeries::max(self : SignalspecburgSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecburgSeries::range(self : SignalspecburgSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecburgSeries::variance(self : SignalspecburgSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecburgSeries::std(self : SignalspecburgSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecburgSeries::median(self : SignalspecburgSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecburgSeries::scale(self : SignalspecburgSeries, f : Double) -> SignalspecburgSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecburgSeries::add(self : SignalspecburgSeries, other : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecburgSeries::sub(self : SignalspecburgSeries, other : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecburgSeries::normalize(self : SignalspecburgSeries) -> SignalspecburgSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecburgSeries::cumsum(self : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecburgSeries::to_string(self : SignalspecburgSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecburgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_burg_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecburgMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_spec_burg_matrix_identity(n : Int) -> SignalspecburgMatrix {
  let m = signal_spec_burg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecburgMatrix::get(self : SignalspecburgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecburgMatrix::transpose(self : SignalspecburgMatrix) -> SignalspecburgMatrix {
  let result = signal_spec_burg_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecburgMatrix::add(self : SignalspecburgMatrix, other : SignalspecburgMatrix) -> SignalspecburgMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_burg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecburgMatrix::scale(self : SignalspecburgMatrix, s : Double) -> SignalspecburgMatrix {
  let result = signal_spec_burg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecburgMatrix::multiply(self : SignalspecburgMatrix, other : SignalspecburgMatrix) -> SignalspecburgMatrix {
  if self.cols != other.rows { return signal_spec_burg_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_burg_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalspecburgMatrix::trace(self : SignalspecburgMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecburgMatrix::det(self : SignalspecburgMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecburgMatrix::norm(self : SignalspecburgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecburgMatrix::to_string(self : SignalspecburgMatrix) -> String {
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

pub(all) struct SignalspecburgVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_burg_make_vector(comps : Array[Double]) -> SignalspecburgVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_burg_vector_zero(dim : Int) -> SignalspecburgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecburgVector::add(self : SignalspecburgVector, other : SignalspecburgVector) -> SignalspecburgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecburgVector::sub(self : SignalspecburgVector, other : SignalspecburgVector) -> SignalspecburgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecburgVector::scale(self : SignalspecburgVector, s : Double) -> SignalspecburgVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecburgVector::dot(self : SignalspecburgVector, other : SignalspecburgVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecburgVector::norm(self : SignalspecburgVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecburgVector::normalize(self : SignalspecburgVector) -> SignalspecburgVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecburgVector::dist(self : SignalspecburgVector, other : SignalspecburgVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecburgVector::to_string(self : SignalspecburgVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecburgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_frame_make(size : Int) -> SignalspecburgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgFrame::len(self : SignalspecburgFrame) -> Int { self.size }

pub fn SignalspecburgFrame::get(self : SignalspecburgFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgFrame::set(self : SignalspecburgFrame, i : Int, v : Double) -> SignalspecburgFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgFrame::sum(self : SignalspecburgFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgFrame::mean(self : SignalspecburgFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgFrame::scale(self : SignalspecburgFrame, f : Double) -> SignalspecburgFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgFrame::add(self : SignalspecburgFrame, other : SignalspecburgFrame) -> SignalspecburgFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgFrame::copy(self : SignalspecburgFrame) -> SignalspecburgFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgFrame::fill(self : SignalspecburgFrame, v : Double) -> SignalspecburgFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgFrame::min(self : SignalspecburgFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecburgFrame::max(self : SignalspecburgFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecburgFrame::to_string(self : SignalspecburgFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_table_make(size : Int) -> SignalspecburgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgTable::len(self : SignalspecburgTable) -> Int { self.size }

pub fn SignalspecburgTable::get(self : SignalspecburgTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgTable::set(self : SignalspecburgTable, i : Int, v : Double) -> SignalspecburgTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgTable::sum(self : SignalspecburgTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgTable::mean(self : SignalspecburgTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgTable::scale(self : SignalspecburgTable, f : Double) -> SignalspecburgTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgTable::add(self : SignalspecburgTable, other : SignalspecburgTable) -> SignalspecburgTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgTable::copy(self : SignalspecburgTable) -> SignalspecburgTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgTable::fill(self : SignalspecburgTable, v : Double) -> SignalspecburgTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgTable::min(self : SignalspecburgTable) -> Double { @_common.min(self.data) }

pub fn SignalspecburgTable::max(self : SignalspecburgTable) -> Double { @_common.max(self.data) }

pub fn SignalspecburgTable::to_string(self : SignalspecburgTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_graphn_make(size : Int) -> SignalspecburgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgGraphN::len(self : SignalspecburgGraphN) -> Int { self.size }

pub fn SignalspecburgGraphN::get(self : SignalspecburgGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgGraphN::set(self : SignalspecburgGraphN, i : Int, v : Double) -> SignalspecburgGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgGraphN::sum(self : SignalspecburgGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgGraphN::mean(self : SignalspecburgGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgGraphN::scale(self : SignalspecburgGraphN, f : Double) -> SignalspecburgGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgGraphN::add(self : SignalspecburgGraphN, other : SignalspecburgGraphN) -> SignalspecburgGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgGraphN::copy(self : SignalspecburgGraphN) -> SignalspecburgGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgGraphN::fill(self : SignalspecburgGraphN, v : Double) -> SignalspecburgGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgGraphN::min(self : SignalspecburgGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecburgGraphN::max(self : SignalspecburgGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecburgGraphN::to_string(self : SignalspecburgGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_node_make(size : Int) -> SignalspecburgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgNode::len(self : SignalspecburgNode) -> Int { self.size }

pub fn SignalspecburgNode::get(self : SignalspecburgNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgNode::set(self : SignalspecburgNode, i : Int, v : Double) -> SignalspecburgNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgNode::sum(self : SignalspecburgNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgNode::mean(self : SignalspecburgNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgNode::scale(self : SignalspecburgNode, f : Double) -> SignalspecburgNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgNode::add(self : SignalspecburgNode, other : SignalspecburgNode) -> SignalspecburgNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgNode::copy(self : SignalspecburgNode) -> SignalspecburgNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgNode::fill(self : SignalspecburgNode, v : Double) -> SignalspecburgNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgNode::min(self : SignalspecburgNode) -> Double { @_common.min(self.data) }

pub fn SignalspecburgNode::max(self : SignalspecburgNode) -> Double { @_common.max(self.data) }

pub fn SignalspecburgNode::to_string(self : SignalspecburgNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_edge_make(size : Int) -> SignalspecburgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgEdge::len(self : SignalspecburgEdge) -> Int { self.size }

pub fn SignalspecburgEdge::get(self : SignalspecburgEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgEdge::set(self : SignalspecburgEdge, i : Int, v : Double) -> SignalspecburgEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgEdge::sum(self : SignalspecburgEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgEdge::mean(self : SignalspecburgEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgEdge::scale(self : SignalspecburgEdge, f : Double) -> SignalspecburgEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgEdge::add(self : SignalspecburgEdge, other : SignalspecburgEdge) -> SignalspecburgEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgEdge::copy(self : SignalspecburgEdge) -> SignalspecburgEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgEdge::fill(self : SignalspecburgEdge, v : Double) -> SignalspecburgEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgEdge::min(self : SignalspecburgEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecburgEdge::max(self : SignalspecburgEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecburgEdge::to_string(self : SignalspecburgEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_path_make(size : Int) -> SignalspecburgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgPath::len(self : SignalspecburgPath) -> Int { self.size }

pub fn SignalspecburgPath::get(self : SignalspecburgPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgPath::set(self : SignalspecburgPath, i : Int, v : Double) -> SignalspecburgPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgPath::sum(self : SignalspecburgPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgPath::mean(self : SignalspecburgPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgPath::scale(self : SignalspecburgPath, f : Double) -> SignalspecburgPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgPath::add(self : SignalspecburgPath, other : SignalspecburgPath) -> SignalspecburgPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgPath::copy(self : SignalspecburgPath) -> SignalspecburgPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgPath::fill(self : SignalspecburgPath, v : Double) -> SignalspecburgPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgPath::min(self : SignalspecburgPath) -> Double { @_common.min(self.data) }

pub fn SignalspecburgPath::max(self : SignalspecburgPath) -> Double { @_common.max(self.data) }

pub fn SignalspecburgPath::to_string(self : SignalspecburgPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_cluster_make(size : Int) -> SignalspecburgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgCluster::len(self : SignalspecburgCluster) -> Int { self.size }

pub fn SignalspecburgCluster::get(self : SignalspecburgCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgCluster::set(self : SignalspecburgCluster, i : Int, v : Double) -> SignalspecburgCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgCluster::sum(self : SignalspecburgCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgCluster::mean(self : SignalspecburgCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgCluster::scale(self : SignalspecburgCluster, f : Double) -> SignalspecburgCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgCluster::add(self : SignalspecburgCluster, other : SignalspecburgCluster) -> SignalspecburgCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgCluster::copy(self : SignalspecburgCluster) -> SignalspecburgCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgCluster::fill(self : SignalspecburgCluster, v : Double) -> SignalspecburgCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgCluster::min(self : SignalspecburgCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecburgCluster::max(self : SignalspecburgCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecburgCluster::to_string(self : SignalspecburgCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_model_make(size : Int) -> SignalspecburgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgModel::len(self : SignalspecburgModel) -> Int { self.size }

pub fn SignalspecburgModel::get(self : SignalspecburgModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgModel::set(self : SignalspecburgModel, i : Int, v : Double) -> SignalspecburgModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgModel::sum(self : SignalspecburgModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgModel::mean(self : SignalspecburgModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgModel::scale(self : SignalspecburgModel, f : Double) -> SignalspecburgModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgModel::add(self : SignalspecburgModel, other : SignalspecburgModel) -> SignalspecburgModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgModel::copy(self : SignalspecburgModel) -> SignalspecburgModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgModel::fill(self : SignalspecburgModel, v : Double) -> SignalspecburgModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgModel::min(self : SignalspecburgModel) -> Double { @_common.min(self.data) }

pub fn SignalspecburgModel::max(self : SignalspecburgModel) -> Double { @_common.max(self.data) }

pub fn SignalspecburgModel::to_string(self : SignalspecburgModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_layer_make(size : Int) -> SignalspecburgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgLayer::len(self : SignalspecburgLayer) -> Int { self.size }

pub fn SignalspecburgLayer::get(self : SignalspecburgLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgLayer::set(self : SignalspecburgLayer, i : Int, v : Double) -> SignalspecburgLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgLayer::sum(self : SignalspecburgLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgLayer::mean(self : SignalspecburgLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgLayer::scale(self : SignalspecburgLayer, f : Double) -> SignalspecburgLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgLayer::add(self : SignalspecburgLayer, other : SignalspecburgLayer) -> SignalspecburgLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgLayer::copy(self : SignalspecburgLayer) -> SignalspecburgLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgLayer::fill(self : SignalspecburgLayer, v : Double) -> SignalspecburgLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgLayer::min(self : SignalspecburgLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecburgLayer::max(self : SignalspecburgLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecburgLayer::to_string(self : SignalspecburgLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_buffer_make(size : Int) -> SignalspecburgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgBuffer::len(self : SignalspecburgBuffer) -> Int { self.size }

pub fn SignalspecburgBuffer::get(self : SignalspecburgBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgBuffer::set(self : SignalspecburgBuffer, i : Int, v : Double) -> SignalspecburgBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgBuffer::sum(self : SignalspecburgBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgBuffer::mean(self : SignalspecburgBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgBuffer::scale(self : SignalspecburgBuffer, f : Double) -> SignalspecburgBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgBuffer::add(self : SignalspecburgBuffer, other : SignalspecburgBuffer) -> SignalspecburgBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgBuffer::copy(self : SignalspecburgBuffer) -> SignalspecburgBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgBuffer::fill(self : SignalspecburgBuffer, v : Double) -> SignalspecburgBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgBuffer::min(self : SignalspecburgBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecburgBuffer::max(self : SignalspecburgBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecburgBuffer::to_string(self : SignalspecburgBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_cursor_make(size : Int) -> SignalspecburgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgCursor::len(self : SignalspecburgCursor) -> Int { self.size }

pub fn SignalspecburgCursor::get(self : SignalspecburgCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgCursor::set(self : SignalspecburgCursor, i : Int, v : Double) -> SignalspecburgCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgCursor::sum(self : SignalspecburgCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgCursor::mean(self : SignalspecburgCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgCursor::scale(self : SignalspecburgCursor, f : Double) -> SignalspecburgCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgCursor::add(self : SignalspecburgCursor, other : SignalspecburgCursor) -> SignalspecburgCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgCursor::copy(self : SignalspecburgCursor) -> SignalspecburgCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgCursor::fill(self : SignalspecburgCursor, v : Double) -> SignalspecburgCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgCursor::min(self : SignalspecburgCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecburgCursor::max(self : SignalspecburgCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecburgCursor::to_string(self : SignalspecburgCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_view_make(size : Int) -> SignalspecburgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgView::len(self : SignalspecburgView) -> Int { self.size }

pub fn SignalspecburgView::get(self : SignalspecburgView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgView::set(self : SignalspecburgView, i : Int, v : Double) -> SignalspecburgView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgView::sum(self : SignalspecburgView) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgView::mean(self : SignalspecburgView) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgView::scale(self : SignalspecburgView, f : Double) -> SignalspecburgView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgView::add(self : SignalspecburgView, other : SignalspecburgView) -> SignalspecburgView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgView::copy(self : SignalspecburgView) -> SignalspecburgView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgView::fill(self : SignalspecburgView, v : Double) -> SignalspecburgView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgView::min(self : SignalspecburgView) -> Double { @_common.min(self.data) }

pub fn SignalspecburgView::max(self : SignalspecburgView) -> Double { @_common.max(self.data) }

pub fn SignalspecburgView::to_string(self : SignalspecburgView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_range_make(size : Int) -> SignalspecburgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgRange::len(self : SignalspecburgRange) -> Int { self.size }

pub fn SignalspecburgRange::get(self : SignalspecburgRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgRange::set(self : SignalspecburgRange, i : Int, v : Double) -> SignalspecburgRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgRange::sum(self : SignalspecburgRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgRange::mean(self : SignalspecburgRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgRange::scale(self : SignalspecburgRange, f : Double) -> SignalspecburgRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgRange::add(self : SignalspecburgRange, other : SignalspecburgRange) -> SignalspecburgRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgRange::copy(self : SignalspecburgRange) -> SignalspecburgRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgRange::fill(self : SignalspecburgRange, v : Double) -> SignalspecburgRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgRange::min(self : SignalspecburgRange) -> Double { @_common.min(self.data) }

pub fn SignalspecburgRange::max(self : SignalspecburgRange) -> Double { @_common.max(self.data) }

pub fn SignalspecburgRange::to_string(self : SignalspecburgRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecburgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_slice_make(size : Int) -> SignalspecburgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecburgSlice::len(self : SignalspecburgSlice) -> Int { self.size }

pub fn SignalspecburgSlice::get(self : SignalspecburgSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecburgSlice::set(self : SignalspecburgSlice, i : Int, v : Double) -> SignalspecburgSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecburgSlice::sum(self : SignalspecburgSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecburgSlice::mean(self : SignalspecburgSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecburgSlice::scale(self : SignalspecburgSlice, f : Double) -> SignalspecburgSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecburgSlice::add(self : SignalspecburgSlice, other : SignalspecburgSlice) -> SignalspecburgSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecburgSlice::copy(self : SignalspecburgSlice) -> SignalspecburgSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecburgSlice::fill(self : SignalspecburgSlice, v : Double) -> SignalspecburgSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecburgSlice::min(self : SignalspecburgSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecburgSlice::max(self : SignalspecburgSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecburgSlice::to_string(self : SignalspecburgSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

