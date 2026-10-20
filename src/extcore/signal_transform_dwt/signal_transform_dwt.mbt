///===
/// extcore/signal_transform_dwt

pub(all) struct SignaltransformdwtPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dwt_make_point(x : Double, y : Double) -> SignaltransformdwtPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dwt_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdwtPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformdwtPoint::x(self : SignaltransformdwtPoint) -> Double { self.x }

pub fn SignaltransformdwtPoint::y(self : SignaltransformdwtPoint) -> Double { self.y }

pub fn SignaltransformdwtPoint::z(self : SignaltransformdwtPoint) -> Double { self.z }

pub fn SignaltransformdwtPoint::label(self : SignaltransformdwtPoint) -> Int { self.label }

pub fn SignaltransformdwtPoint::dist(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformdwtPoint::add(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformdwtPoint::sub(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformdwtPoint::scale(self : SignaltransformdwtPoint, s : Double) -> SignaltransformdwtPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformdwtPoint::dot(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformdwtPoint::cross(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformdwtPoint::norm(self : SignaltransformdwtPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformdwtPoint::normalize(self : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdwtPoint::negate(self : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformdwtPoint::mid(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformdwtPoint::lerp(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint, t : Double) -> SignaltransformdwtPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformdwtPoint::to_string(self : SignaltransformdwtPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformdwtSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dwt_make_series(vals : Array[Double], name : String) -> SignaltransformdwtSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformdwtSeries::len(self : SignaltransformdwtSeries) -> Int { self.vals.length() }

pub fn SignaltransformdwtSeries::sum(self : SignaltransformdwtSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformdwtSeries::mean(self : SignaltransformdwtSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformdwtSeries::min(self : SignaltransformdwtSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformdwtSeries::max(self : SignaltransformdwtSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformdwtSeries::range(self : SignaltransformdwtSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformdwtSeries::variance(self : SignaltransformdwtSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformdwtSeries::std(self : SignaltransformdwtSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformdwtSeries::median(self : SignaltransformdwtSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformdwtSeries::scale(self : SignaltransformdwtSeries, f : Double) -> SignaltransformdwtSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformdwtSeries::add(self : SignaltransformdwtSeries, other : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformdwtSeries::sub(self : SignaltransformdwtSeries, other : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformdwtSeries::normalize(self : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformdwtSeries::cumsum(self : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformdwtSeries::to_string(self : SignaltransformdwtSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdwtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dwt_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdwtMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn signal_transform_dwt_matrix_identity(n : Int) -> SignaltransformdwtMatrix {
  let m = signal_transform_dwt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformdwtMatrix::get(self : SignaltransformdwtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformdwtMatrix::transpose(self : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  let result = signal_transform_dwt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformdwtMatrix::add(self : SignaltransformdwtMatrix, other : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_dwt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformdwtMatrix::scale(self : SignaltransformdwtMatrix, s : Double) -> SignaltransformdwtMatrix {
  let result = signal_transform_dwt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformdwtMatrix::multiply(self : SignaltransformdwtMatrix, other : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  if self.cols != other.rows { return signal_transform_dwt_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_dwt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignaltransformdwtMatrix::trace(self : SignaltransformdwtMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformdwtMatrix::det(self : SignaltransformdwtMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformdwtMatrix::norm(self : SignaltransformdwtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformdwtMatrix::to_string(self : SignaltransformdwtMatrix) -> String {
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

pub(all) struct SignaltransformdwtVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dwt_make_vector(comps : Array[Double]) -> SignaltransformdwtVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dwt_vector_zero(dim : Int) -> SignaltransformdwtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformdwtVector::add(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdwtVector::sub(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdwtVector::scale(self : SignaltransformdwtVector, s : Double) -> SignaltransformdwtVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformdwtVector::dot(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformdwtVector::norm(self : SignaltransformdwtVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformdwtVector::normalize(self : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdwtVector::dist(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformdwtVector::to_string(self : SignaltransformdwtVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdwtFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_frame_make(size : Int) -> SignaltransformdwtFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtFrame::len(self : SignaltransformdwtFrame) -> Int { self.size }

pub fn SignaltransformdwtFrame::get(self : SignaltransformdwtFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtFrame::set(self : SignaltransformdwtFrame, i : Int, v : Double) -> SignaltransformdwtFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtFrame::sum(self : SignaltransformdwtFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtFrame::mean(self : SignaltransformdwtFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtFrame::scale(self : SignaltransformdwtFrame, f : Double) -> SignaltransformdwtFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtFrame::add(self : SignaltransformdwtFrame, other : SignaltransformdwtFrame) -> SignaltransformdwtFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtFrame::copy(self : SignaltransformdwtFrame) -> SignaltransformdwtFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtFrame::fill(self : SignaltransformdwtFrame, v : Double) -> SignaltransformdwtFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtFrame::min(self : SignaltransformdwtFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtFrame::max(self : SignaltransformdwtFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtFrame::to_string(self : SignaltransformdwtFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_table_make(size : Int) -> SignaltransformdwtTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtTable::len(self : SignaltransformdwtTable) -> Int { self.size }

pub fn SignaltransformdwtTable::get(self : SignaltransformdwtTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtTable::set(self : SignaltransformdwtTable, i : Int, v : Double) -> SignaltransformdwtTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtTable::sum(self : SignaltransformdwtTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtTable::mean(self : SignaltransformdwtTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtTable::scale(self : SignaltransformdwtTable, f : Double) -> SignaltransformdwtTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtTable::add(self : SignaltransformdwtTable, other : SignaltransformdwtTable) -> SignaltransformdwtTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtTable::copy(self : SignaltransformdwtTable) -> SignaltransformdwtTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtTable::fill(self : SignaltransformdwtTable, v : Double) -> SignaltransformdwtTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtTable::min(self : SignaltransformdwtTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtTable::max(self : SignaltransformdwtTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtTable::to_string(self : SignaltransformdwtTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_graphn_make(size : Int) -> SignaltransformdwtGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtGraphN::len(self : SignaltransformdwtGraphN) -> Int { self.size }

pub fn SignaltransformdwtGraphN::get(self : SignaltransformdwtGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtGraphN::set(self : SignaltransformdwtGraphN, i : Int, v : Double) -> SignaltransformdwtGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtGraphN::sum(self : SignaltransformdwtGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtGraphN::mean(self : SignaltransformdwtGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtGraphN::scale(self : SignaltransformdwtGraphN, f : Double) -> SignaltransformdwtGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtGraphN::add(self : SignaltransformdwtGraphN, other : SignaltransformdwtGraphN) -> SignaltransformdwtGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtGraphN::copy(self : SignaltransformdwtGraphN) -> SignaltransformdwtGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtGraphN::fill(self : SignaltransformdwtGraphN, v : Double) -> SignaltransformdwtGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtGraphN::min(self : SignaltransformdwtGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtGraphN::max(self : SignaltransformdwtGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtGraphN::to_string(self : SignaltransformdwtGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_node_make(size : Int) -> SignaltransformdwtNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtNode::len(self : SignaltransformdwtNode) -> Int { self.size }

pub fn SignaltransformdwtNode::get(self : SignaltransformdwtNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtNode::set(self : SignaltransformdwtNode, i : Int, v : Double) -> SignaltransformdwtNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtNode::sum(self : SignaltransformdwtNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtNode::mean(self : SignaltransformdwtNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtNode::scale(self : SignaltransformdwtNode, f : Double) -> SignaltransformdwtNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtNode::add(self : SignaltransformdwtNode, other : SignaltransformdwtNode) -> SignaltransformdwtNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtNode::copy(self : SignaltransformdwtNode) -> SignaltransformdwtNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtNode::fill(self : SignaltransformdwtNode, v : Double) -> SignaltransformdwtNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtNode::min(self : SignaltransformdwtNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtNode::max(self : SignaltransformdwtNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtNode::to_string(self : SignaltransformdwtNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_edge_make(size : Int) -> SignaltransformdwtEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtEdge::len(self : SignaltransformdwtEdge) -> Int { self.size }

pub fn SignaltransformdwtEdge::get(self : SignaltransformdwtEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtEdge::set(self : SignaltransformdwtEdge, i : Int, v : Double) -> SignaltransformdwtEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtEdge::sum(self : SignaltransformdwtEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtEdge::mean(self : SignaltransformdwtEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtEdge::scale(self : SignaltransformdwtEdge, f : Double) -> SignaltransformdwtEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtEdge::add(self : SignaltransformdwtEdge, other : SignaltransformdwtEdge) -> SignaltransformdwtEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtEdge::copy(self : SignaltransformdwtEdge) -> SignaltransformdwtEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtEdge::fill(self : SignaltransformdwtEdge, v : Double) -> SignaltransformdwtEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtEdge::min(self : SignaltransformdwtEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtEdge::max(self : SignaltransformdwtEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtEdge::to_string(self : SignaltransformdwtEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_path_make(size : Int) -> SignaltransformdwtPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtPath::len(self : SignaltransformdwtPath) -> Int { self.size }

pub fn SignaltransformdwtPath::get(self : SignaltransformdwtPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtPath::set(self : SignaltransformdwtPath, i : Int, v : Double) -> SignaltransformdwtPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtPath::sum(self : SignaltransformdwtPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtPath::mean(self : SignaltransformdwtPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtPath::scale(self : SignaltransformdwtPath, f : Double) -> SignaltransformdwtPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtPath::add(self : SignaltransformdwtPath, other : SignaltransformdwtPath) -> SignaltransformdwtPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtPath::copy(self : SignaltransformdwtPath) -> SignaltransformdwtPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtPath::fill(self : SignaltransformdwtPath, v : Double) -> SignaltransformdwtPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtPath::min(self : SignaltransformdwtPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtPath::max(self : SignaltransformdwtPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtPath::to_string(self : SignaltransformdwtPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_cluster_make(size : Int) -> SignaltransformdwtCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtCluster::len(self : SignaltransformdwtCluster) -> Int { self.size }

pub fn SignaltransformdwtCluster::get(self : SignaltransformdwtCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtCluster::set(self : SignaltransformdwtCluster, i : Int, v : Double) -> SignaltransformdwtCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCluster::sum(self : SignaltransformdwtCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtCluster::mean(self : SignaltransformdwtCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtCluster::scale(self : SignaltransformdwtCluster, f : Double) -> SignaltransformdwtCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCluster::add(self : SignaltransformdwtCluster, other : SignaltransformdwtCluster) -> SignaltransformdwtCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtCluster::copy(self : SignaltransformdwtCluster) -> SignaltransformdwtCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCluster::fill(self : SignaltransformdwtCluster, v : Double) -> SignaltransformdwtCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCluster::min(self : SignaltransformdwtCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtCluster::max(self : SignaltransformdwtCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtCluster::to_string(self : SignaltransformdwtCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_model_make(size : Int) -> SignaltransformdwtModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtModel::len(self : SignaltransformdwtModel) -> Int { self.size }

pub fn SignaltransformdwtModel::get(self : SignaltransformdwtModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtModel::set(self : SignaltransformdwtModel, i : Int, v : Double) -> SignaltransformdwtModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtModel::sum(self : SignaltransformdwtModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtModel::mean(self : SignaltransformdwtModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtModel::scale(self : SignaltransformdwtModel, f : Double) -> SignaltransformdwtModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtModel::add(self : SignaltransformdwtModel, other : SignaltransformdwtModel) -> SignaltransformdwtModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtModel::copy(self : SignaltransformdwtModel) -> SignaltransformdwtModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtModel::fill(self : SignaltransformdwtModel, v : Double) -> SignaltransformdwtModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtModel::min(self : SignaltransformdwtModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtModel::max(self : SignaltransformdwtModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtModel::to_string(self : SignaltransformdwtModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_layer_make(size : Int) -> SignaltransformdwtLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtLayer::len(self : SignaltransformdwtLayer) -> Int { self.size }

pub fn SignaltransformdwtLayer::get(self : SignaltransformdwtLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtLayer::set(self : SignaltransformdwtLayer, i : Int, v : Double) -> SignaltransformdwtLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtLayer::sum(self : SignaltransformdwtLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtLayer::mean(self : SignaltransformdwtLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtLayer::scale(self : SignaltransformdwtLayer, f : Double) -> SignaltransformdwtLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtLayer::add(self : SignaltransformdwtLayer, other : SignaltransformdwtLayer) -> SignaltransformdwtLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtLayer::copy(self : SignaltransformdwtLayer) -> SignaltransformdwtLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtLayer::fill(self : SignaltransformdwtLayer, v : Double) -> SignaltransformdwtLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtLayer::min(self : SignaltransformdwtLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtLayer::max(self : SignaltransformdwtLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtLayer::to_string(self : SignaltransformdwtLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_buffer_make(size : Int) -> SignaltransformdwtBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtBuffer::len(self : SignaltransformdwtBuffer) -> Int { self.size }

pub fn SignaltransformdwtBuffer::get(self : SignaltransformdwtBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtBuffer::set(self : SignaltransformdwtBuffer, i : Int, v : Double) -> SignaltransformdwtBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtBuffer::sum(self : SignaltransformdwtBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtBuffer::mean(self : SignaltransformdwtBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtBuffer::scale(self : SignaltransformdwtBuffer, f : Double) -> SignaltransformdwtBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtBuffer::add(self : SignaltransformdwtBuffer, other : SignaltransformdwtBuffer) -> SignaltransformdwtBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtBuffer::copy(self : SignaltransformdwtBuffer) -> SignaltransformdwtBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtBuffer::fill(self : SignaltransformdwtBuffer, v : Double) -> SignaltransformdwtBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtBuffer::min(self : SignaltransformdwtBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtBuffer::max(self : SignaltransformdwtBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtBuffer::to_string(self : SignaltransformdwtBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_cursor_make(size : Int) -> SignaltransformdwtCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtCursor::len(self : SignaltransformdwtCursor) -> Int { self.size }

pub fn SignaltransformdwtCursor::get(self : SignaltransformdwtCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtCursor::set(self : SignaltransformdwtCursor, i : Int, v : Double) -> SignaltransformdwtCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCursor::sum(self : SignaltransformdwtCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtCursor::mean(self : SignaltransformdwtCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtCursor::scale(self : SignaltransformdwtCursor, f : Double) -> SignaltransformdwtCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCursor::add(self : SignaltransformdwtCursor, other : SignaltransformdwtCursor) -> SignaltransformdwtCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtCursor::copy(self : SignaltransformdwtCursor) -> SignaltransformdwtCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCursor::fill(self : SignaltransformdwtCursor, v : Double) -> SignaltransformdwtCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtCursor::min(self : SignaltransformdwtCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtCursor::max(self : SignaltransformdwtCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtCursor::to_string(self : SignaltransformdwtCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_view_make(size : Int) -> SignaltransformdwtView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtView::len(self : SignaltransformdwtView) -> Int { self.size }

pub fn SignaltransformdwtView::get(self : SignaltransformdwtView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtView::set(self : SignaltransformdwtView, i : Int, v : Double) -> SignaltransformdwtView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtView::sum(self : SignaltransformdwtView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtView::mean(self : SignaltransformdwtView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtView::scale(self : SignaltransformdwtView, f : Double) -> SignaltransformdwtView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtView::add(self : SignaltransformdwtView, other : SignaltransformdwtView) -> SignaltransformdwtView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtView::copy(self : SignaltransformdwtView) -> SignaltransformdwtView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtView::fill(self : SignaltransformdwtView, v : Double) -> SignaltransformdwtView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtView::min(self : SignaltransformdwtView) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtView::max(self : SignaltransformdwtView) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtView::to_string(self : SignaltransformdwtView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_range_make(size : Int) -> SignaltransformdwtRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtRange::len(self : SignaltransformdwtRange) -> Int { self.size }

pub fn SignaltransformdwtRange::get(self : SignaltransformdwtRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtRange::set(self : SignaltransformdwtRange, i : Int, v : Double) -> SignaltransformdwtRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtRange::sum(self : SignaltransformdwtRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtRange::mean(self : SignaltransformdwtRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtRange::scale(self : SignaltransformdwtRange, f : Double) -> SignaltransformdwtRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtRange::add(self : SignaltransformdwtRange, other : SignaltransformdwtRange) -> SignaltransformdwtRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtRange::copy(self : SignaltransformdwtRange) -> SignaltransformdwtRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtRange::fill(self : SignaltransformdwtRange, v : Double) -> SignaltransformdwtRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtRange::min(self : SignaltransformdwtRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtRange::max(self : SignaltransformdwtRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtRange::to_string(self : SignaltransformdwtRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_slice_make(size : Int) -> SignaltransformdwtSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdwtSlice::len(self : SignaltransformdwtSlice) -> Int { self.size }

pub fn SignaltransformdwtSlice::get(self : SignaltransformdwtSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdwtSlice::set(self : SignaltransformdwtSlice, i : Int, v : Double) -> SignaltransformdwtSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtSlice::sum(self : SignaltransformdwtSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdwtSlice::mean(self : SignaltransformdwtSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdwtSlice::scale(self : SignaltransformdwtSlice, f : Double) -> SignaltransformdwtSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtSlice::add(self : SignaltransformdwtSlice, other : SignaltransformdwtSlice) -> SignaltransformdwtSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdwtSlice::copy(self : SignaltransformdwtSlice) -> SignaltransformdwtSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtSlice::fill(self : SignaltransformdwtSlice, v : Double) -> SignaltransformdwtSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdwtSlice::min(self : SignaltransformdwtSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformdwtSlice::max(self : SignaltransformdwtSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformdwtSlice::to_string(self : SignaltransformdwtSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

