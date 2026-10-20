///===
/// extcore/signal_filter_wiener

pub(all) struct SignalfilterwienerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_wiener_make_point(x : Double, y : Double) -> SignalfilterwienerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_wiener_make_point3(x : Double, y : Double, z : Double) -> SignalfilterwienerPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterwienerPoint::x(self : SignalfilterwienerPoint) -> Double { self.x }

pub fn SignalfilterwienerPoint::y(self : SignalfilterwienerPoint) -> Double { self.y }

pub fn SignalfilterwienerPoint::z(self : SignalfilterwienerPoint) -> Double { self.z }

pub fn SignalfilterwienerPoint::label(self : SignalfilterwienerPoint) -> Int { self.label }

pub fn SignalfilterwienerPoint::dist(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterwienerPoint::add(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterwienerPoint::sub(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterwienerPoint::scale(self : SignalfilterwienerPoint, s : Double) -> SignalfilterwienerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterwienerPoint::dot(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterwienerPoint::cross(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterwienerPoint::norm(self : SignalfilterwienerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterwienerPoint::normalize(self : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterwienerPoint::negate(self : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterwienerPoint::mid(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterwienerPoint::lerp(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint, t : Double) -> SignalfilterwienerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterwienerPoint::to_string(self : SignalfilterwienerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterwienerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_wiener_make_series(vals : Array[Double], name : String) -> SignalfilterwienerSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterwienerSeries::len(self : SignalfilterwienerSeries) -> Int { self.vals.length() }

pub fn SignalfilterwienerSeries::sum(self : SignalfilterwienerSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterwienerSeries::mean(self : SignalfilterwienerSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterwienerSeries::min(self : SignalfilterwienerSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterwienerSeries::max(self : SignalfilterwienerSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterwienerSeries::range(self : SignalfilterwienerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterwienerSeries::variance(self : SignalfilterwienerSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterwienerSeries::std(self : SignalfilterwienerSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterwienerSeries::median(self : SignalfilterwienerSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterwienerSeries::scale(self : SignalfilterwienerSeries, f : Double) -> SignalfilterwienerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterwienerSeries::add(self : SignalfilterwienerSeries, other : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterwienerSeries::sub(self : SignalfilterwienerSeries, other : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterwienerSeries::normalize(self : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterwienerSeries::cumsum(self : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterwienerSeries::to_string(self : SignalfilterwienerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterwienerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_wiener_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterwienerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_wiener_matrix_identity(n : Int) -> SignalfilterwienerMatrix {
  let m = signal_filter_wiener_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterwienerMatrix::get(self : SignalfilterwienerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterwienerMatrix::transpose(self : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  let result = signal_filter_wiener_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterwienerMatrix::add(self : SignalfilterwienerMatrix, other : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_wiener_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterwienerMatrix::scale(self : SignalfilterwienerMatrix, s : Double) -> SignalfilterwienerMatrix {
  let result = signal_filter_wiener_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterwienerMatrix::multiply(self : SignalfilterwienerMatrix, other : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  if self.cols != other.rows { return signal_filter_wiener_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_wiener_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalfilterwienerMatrix::trace(self : SignalfilterwienerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterwienerMatrix::det(self : SignalfilterwienerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterwienerMatrix::norm(self : SignalfilterwienerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterwienerMatrix::to_string(self : SignalfilterwienerMatrix) -> String {
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

pub(all) struct SignalfilterwienerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_wiener_make_vector(comps : Array[Double]) -> SignalfilterwienerVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_wiener_vector_zero(dim : Int) -> SignalfilterwienerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterwienerVector::add(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterwienerVector::sub(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterwienerVector::scale(self : SignalfilterwienerVector, s : Double) -> SignalfilterwienerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterwienerVector::dot(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterwienerVector::norm(self : SignalfilterwienerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterwienerVector::normalize(self : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterwienerVector::dist(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterwienerVector::to_string(self : SignalfilterwienerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterwienerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_frame_make(size : Int) -> SignalfilterwienerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerFrame::len(self : SignalfilterwienerFrame) -> Int { self.size }

pub fn SignalfilterwienerFrame::get(self : SignalfilterwienerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerFrame::set(self : SignalfilterwienerFrame, i : Int, v : Double) -> SignalfilterwienerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerFrame::sum(self : SignalfilterwienerFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerFrame::mean(self : SignalfilterwienerFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerFrame::scale(self : SignalfilterwienerFrame, f : Double) -> SignalfilterwienerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerFrame::add(self : SignalfilterwienerFrame, other : SignalfilterwienerFrame) -> SignalfilterwienerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerFrame::copy(self : SignalfilterwienerFrame) -> SignalfilterwienerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerFrame::fill(self : SignalfilterwienerFrame, v : Double) -> SignalfilterwienerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerFrame::min(self : SignalfilterwienerFrame) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerFrame::max(self : SignalfilterwienerFrame) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerFrame::to_string(self : SignalfilterwienerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_table_make(size : Int) -> SignalfilterwienerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerTable::len(self : SignalfilterwienerTable) -> Int { self.size }

pub fn SignalfilterwienerTable::get(self : SignalfilterwienerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerTable::set(self : SignalfilterwienerTable, i : Int, v : Double) -> SignalfilterwienerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerTable::sum(self : SignalfilterwienerTable) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerTable::mean(self : SignalfilterwienerTable) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerTable::scale(self : SignalfilterwienerTable, f : Double) -> SignalfilterwienerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerTable::add(self : SignalfilterwienerTable, other : SignalfilterwienerTable) -> SignalfilterwienerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerTable::copy(self : SignalfilterwienerTable) -> SignalfilterwienerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerTable::fill(self : SignalfilterwienerTable, v : Double) -> SignalfilterwienerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerTable::min(self : SignalfilterwienerTable) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerTable::max(self : SignalfilterwienerTable) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerTable::to_string(self : SignalfilterwienerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_graphn_make(size : Int) -> SignalfilterwienerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerGraphN::len(self : SignalfilterwienerGraphN) -> Int { self.size }

pub fn SignalfilterwienerGraphN::get(self : SignalfilterwienerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerGraphN::set(self : SignalfilterwienerGraphN, i : Int, v : Double) -> SignalfilterwienerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerGraphN::sum(self : SignalfilterwienerGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerGraphN::mean(self : SignalfilterwienerGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerGraphN::scale(self : SignalfilterwienerGraphN, f : Double) -> SignalfilterwienerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerGraphN::add(self : SignalfilterwienerGraphN, other : SignalfilterwienerGraphN) -> SignalfilterwienerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerGraphN::copy(self : SignalfilterwienerGraphN) -> SignalfilterwienerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerGraphN::fill(self : SignalfilterwienerGraphN, v : Double) -> SignalfilterwienerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerGraphN::min(self : SignalfilterwienerGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerGraphN::max(self : SignalfilterwienerGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerGraphN::to_string(self : SignalfilterwienerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_node_make(size : Int) -> SignalfilterwienerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerNode::len(self : SignalfilterwienerNode) -> Int { self.size }

pub fn SignalfilterwienerNode::get(self : SignalfilterwienerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerNode::set(self : SignalfilterwienerNode, i : Int, v : Double) -> SignalfilterwienerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerNode::sum(self : SignalfilterwienerNode) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerNode::mean(self : SignalfilterwienerNode) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerNode::scale(self : SignalfilterwienerNode, f : Double) -> SignalfilterwienerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerNode::add(self : SignalfilterwienerNode, other : SignalfilterwienerNode) -> SignalfilterwienerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerNode::copy(self : SignalfilterwienerNode) -> SignalfilterwienerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerNode::fill(self : SignalfilterwienerNode, v : Double) -> SignalfilterwienerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerNode::min(self : SignalfilterwienerNode) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerNode::max(self : SignalfilterwienerNode) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerNode::to_string(self : SignalfilterwienerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_edge_make(size : Int) -> SignalfilterwienerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerEdge::len(self : SignalfilterwienerEdge) -> Int { self.size }

pub fn SignalfilterwienerEdge::get(self : SignalfilterwienerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerEdge::set(self : SignalfilterwienerEdge, i : Int, v : Double) -> SignalfilterwienerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerEdge::sum(self : SignalfilterwienerEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerEdge::mean(self : SignalfilterwienerEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerEdge::scale(self : SignalfilterwienerEdge, f : Double) -> SignalfilterwienerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerEdge::add(self : SignalfilterwienerEdge, other : SignalfilterwienerEdge) -> SignalfilterwienerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerEdge::copy(self : SignalfilterwienerEdge) -> SignalfilterwienerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerEdge::fill(self : SignalfilterwienerEdge, v : Double) -> SignalfilterwienerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerEdge::min(self : SignalfilterwienerEdge) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerEdge::max(self : SignalfilterwienerEdge) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerEdge::to_string(self : SignalfilterwienerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_path_make(size : Int) -> SignalfilterwienerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerPath::len(self : SignalfilterwienerPath) -> Int { self.size }

pub fn SignalfilterwienerPath::get(self : SignalfilterwienerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerPath::set(self : SignalfilterwienerPath, i : Int, v : Double) -> SignalfilterwienerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerPath::sum(self : SignalfilterwienerPath) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerPath::mean(self : SignalfilterwienerPath) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerPath::scale(self : SignalfilterwienerPath, f : Double) -> SignalfilterwienerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerPath::add(self : SignalfilterwienerPath, other : SignalfilterwienerPath) -> SignalfilterwienerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerPath::copy(self : SignalfilterwienerPath) -> SignalfilterwienerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerPath::fill(self : SignalfilterwienerPath, v : Double) -> SignalfilterwienerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerPath::min(self : SignalfilterwienerPath) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerPath::max(self : SignalfilterwienerPath) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerPath::to_string(self : SignalfilterwienerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_cluster_make(size : Int) -> SignalfilterwienerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerCluster::len(self : SignalfilterwienerCluster) -> Int { self.size }

pub fn SignalfilterwienerCluster::get(self : SignalfilterwienerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerCluster::set(self : SignalfilterwienerCluster, i : Int, v : Double) -> SignalfilterwienerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCluster::sum(self : SignalfilterwienerCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerCluster::mean(self : SignalfilterwienerCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerCluster::scale(self : SignalfilterwienerCluster, f : Double) -> SignalfilterwienerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCluster::add(self : SignalfilterwienerCluster, other : SignalfilterwienerCluster) -> SignalfilterwienerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerCluster::copy(self : SignalfilterwienerCluster) -> SignalfilterwienerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCluster::fill(self : SignalfilterwienerCluster, v : Double) -> SignalfilterwienerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCluster::min(self : SignalfilterwienerCluster) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerCluster::max(self : SignalfilterwienerCluster) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerCluster::to_string(self : SignalfilterwienerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_model_make(size : Int) -> SignalfilterwienerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerModel::len(self : SignalfilterwienerModel) -> Int { self.size }

pub fn SignalfilterwienerModel::get(self : SignalfilterwienerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerModel::set(self : SignalfilterwienerModel, i : Int, v : Double) -> SignalfilterwienerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerModel::sum(self : SignalfilterwienerModel) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerModel::mean(self : SignalfilterwienerModel) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerModel::scale(self : SignalfilterwienerModel, f : Double) -> SignalfilterwienerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerModel::add(self : SignalfilterwienerModel, other : SignalfilterwienerModel) -> SignalfilterwienerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerModel::copy(self : SignalfilterwienerModel) -> SignalfilterwienerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerModel::fill(self : SignalfilterwienerModel, v : Double) -> SignalfilterwienerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerModel::min(self : SignalfilterwienerModel) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerModel::max(self : SignalfilterwienerModel) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerModel::to_string(self : SignalfilterwienerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_layer_make(size : Int) -> SignalfilterwienerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerLayer::len(self : SignalfilterwienerLayer) -> Int { self.size }

pub fn SignalfilterwienerLayer::get(self : SignalfilterwienerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerLayer::set(self : SignalfilterwienerLayer, i : Int, v : Double) -> SignalfilterwienerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerLayer::sum(self : SignalfilterwienerLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerLayer::mean(self : SignalfilterwienerLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerLayer::scale(self : SignalfilterwienerLayer, f : Double) -> SignalfilterwienerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerLayer::add(self : SignalfilterwienerLayer, other : SignalfilterwienerLayer) -> SignalfilterwienerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerLayer::copy(self : SignalfilterwienerLayer) -> SignalfilterwienerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerLayer::fill(self : SignalfilterwienerLayer, v : Double) -> SignalfilterwienerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerLayer::min(self : SignalfilterwienerLayer) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerLayer::max(self : SignalfilterwienerLayer) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerLayer::to_string(self : SignalfilterwienerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_buffer_make(size : Int) -> SignalfilterwienerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerBuffer::len(self : SignalfilterwienerBuffer) -> Int { self.size }

pub fn SignalfilterwienerBuffer::get(self : SignalfilterwienerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerBuffer::set(self : SignalfilterwienerBuffer, i : Int, v : Double) -> SignalfilterwienerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerBuffer::sum(self : SignalfilterwienerBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerBuffer::mean(self : SignalfilterwienerBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerBuffer::scale(self : SignalfilterwienerBuffer, f : Double) -> SignalfilterwienerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerBuffer::add(self : SignalfilterwienerBuffer, other : SignalfilterwienerBuffer) -> SignalfilterwienerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerBuffer::copy(self : SignalfilterwienerBuffer) -> SignalfilterwienerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerBuffer::fill(self : SignalfilterwienerBuffer, v : Double) -> SignalfilterwienerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerBuffer::min(self : SignalfilterwienerBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerBuffer::max(self : SignalfilterwienerBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerBuffer::to_string(self : SignalfilterwienerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_cursor_make(size : Int) -> SignalfilterwienerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerCursor::len(self : SignalfilterwienerCursor) -> Int { self.size }

pub fn SignalfilterwienerCursor::get(self : SignalfilterwienerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerCursor::set(self : SignalfilterwienerCursor, i : Int, v : Double) -> SignalfilterwienerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCursor::sum(self : SignalfilterwienerCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerCursor::mean(self : SignalfilterwienerCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerCursor::scale(self : SignalfilterwienerCursor, f : Double) -> SignalfilterwienerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCursor::add(self : SignalfilterwienerCursor, other : SignalfilterwienerCursor) -> SignalfilterwienerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerCursor::copy(self : SignalfilterwienerCursor) -> SignalfilterwienerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCursor::fill(self : SignalfilterwienerCursor, v : Double) -> SignalfilterwienerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerCursor::min(self : SignalfilterwienerCursor) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerCursor::max(self : SignalfilterwienerCursor) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerCursor::to_string(self : SignalfilterwienerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_view_make(size : Int) -> SignalfilterwienerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerView::len(self : SignalfilterwienerView) -> Int { self.size }

pub fn SignalfilterwienerView::get(self : SignalfilterwienerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerView::set(self : SignalfilterwienerView, i : Int, v : Double) -> SignalfilterwienerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerView::sum(self : SignalfilterwienerView) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerView::mean(self : SignalfilterwienerView) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerView::scale(self : SignalfilterwienerView, f : Double) -> SignalfilterwienerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerView::add(self : SignalfilterwienerView, other : SignalfilterwienerView) -> SignalfilterwienerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerView::copy(self : SignalfilterwienerView) -> SignalfilterwienerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerView::fill(self : SignalfilterwienerView, v : Double) -> SignalfilterwienerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerView::min(self : SignalfilterwienerView) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerView::max(self : SignalfilterwienerView) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerView::to_string(self : SignalfilterwienerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_range_make(size : Int) -> SignalfilterwienerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerRange::len(self : SignalfilterwienerRange) -> Int { self.size }

pub fn SignalfilterwienerRange::get(self : SignalfilterwienerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerRange::set(self : SignalfilterwienerRange, i : Int, v : Double) -> SignalfilterwienerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerRange::sum(self : SignalfilterwienerRange) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerRange::mean(self : SignalfilterwienerRange) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerRange::scale(self : SignalfilterwienerRange, f : Double) -> SignalfilterwienerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerRange::add(self : SignalfilterwienerRange, other : SignalfilterwienerRange) -> SignalfilterwienerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerRange::copy(self : SignalfilterwienerRange) -> SignalfilterwienerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerRange::fill(self : SignalfilterwienerRange, v : Double) -> SignalfilterwienerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerRange::min(self : SignalfilterwienerRange) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerRange::max(self : SignalfilterwienerRange) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerRange::to_string(self : SignalfilterwienerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_slice_make(size : Int) -> SignalfilterwienerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterwienerSlice::len(self : SignalfilterwienerSlice) -> Int { self.size }

pub fn SignalfilterwienerSlice::get(self : SignalfilterwienerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterwienerSlice::set(self : SignalfilterwienerSlice, i : Int, v : Double) -> SignalfilterwienerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerSlice::sum(self : SignalfilterwienerSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfilterwienerSlice::mean(self : SignalfilterwienerSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfilterwienerSlice::scale(self : SignalfilterwienerSlice, f : Double) -> SignalfilterwienerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerSlice::add(self : SignalfilterwienerSlice, other : SignalfilterwienerSlice) -> SignalfilterwienerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterwienerSlice::copy(self : SignalfilterwienerSlice) -> SignalfilterwienerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerSlice::fill(self : SignalfilterwienerSlice, v : Double) -> SignalfilterwienerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterwienerSlice::min(self : SignalfilterwienerSlice) -> Double { @_common.min(self.data) }

pub fn SignalfilterwienerSlice::max(self : SignalfilterwienerSlice) -> Double { @_common.max(self.data) }

pub fn SignalfilterwienerSlice::to_string(self : SignalfilterwienerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

