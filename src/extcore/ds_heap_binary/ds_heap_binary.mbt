///===
/// extcore/ds_heap_binary

pub(all) struct DsheapbinaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_binary_make_point(x : Double, y : Double) -> DsheapbinaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_binary_make_point3(x : Double, y : Double, z : Double) -> DsheapbinaryPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapbinaryPoint::x(self : DsheapbinaryPoint) -> Double { self.x }

pub fn DsheapbinaryPoint::y(self : DsheapbinaryPoint) -> Double { self.y }

pub fn DsheapbinaryPoint::z(self : DsheapbinaryPoint) -> Double { self.z }

pub fn DsheapbinaryPoint::label(self : DsheapbinaryPoint) -> Int { self.label }

pub fn DsheapbinaryPoint::dist(self : DsheapbinaryPoint, other : DsheapbinaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapbinaryPoint::add(self : DsheapbinaryPoint, other : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapbinaryPoint::sub(self : DsheapbinaryPoint, other : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapbinaryPoint::scale(self : DsheapbinaryPoint, s : Double) -> DsheapbinaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapbinaryPoint::dot(self : DsheapbinaryPoint, other : DsheapbinaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapbinaryPoint::cross(self : DsheapbinaryPoint, other : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapbinaryPoint::norm(self : DsheapbinaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapbinaryPoint::normalize(self : DsheapbinaryPoint) -> DsheapbinaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapbinaryPoint::negate(self : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapbinaryPoint::mid(self : DsheapbinaryPoint, other : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapbinaryPoint::lerp(self : DsheapbinaryPoint, other : DsheapbinaryPoint, t : Double) -> DsheapbinaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapbinaryPoint::to_string(self : DsheapbinaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapbinarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_binary_make_series(vals : Array[Double], name : String) -> DsheapbinarySeries {
  { vals, name, meta: 0 }
}

pub fn DsheapbinarySeries::len(self : DsheapbinarySeries) -> Int { self.vals.length() }

pub fn DsheapbinarySeries::sum(self : DsheapbinarySeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapbinarySeries::mean(self : DsheapbinarySeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapbinarySeries::min(self : DsheapbinarySeries) -> Double { @_common.min(self.vals) }

pub fn DsheapbinarySeries::max(self : DsheapbinarySeries) -> Double { @_common.max(self.vals) }

pub fn DsheapbinarySeries::range(self : DsheapbinarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapbinarySeries::variance(self : DsheapbinarySeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapbinarySeries::std(self : DsheapbinarySeries) -> Double { @_common.std(self.vals) }

pub fn DsheapbinarySeries::median(self : DsheapbinarySeries) -> Double { @_common.median(self.vals) }

pub fn DsheapbinarySeries::scale(self : DsheapbinarySeries, f : Double) -> DsheapbinarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapbinarySeries::add(self : DsheapbinarySeries, other : DsheapbinarySeries) -> DsheapbinarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapbinarySeries::sub(self : DsheapbinarySeries, other : DsheapbinarySeries) -> DsheapbinarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapbinarySeries::normalize(self : DsheapbinarySeries) -> DsheapbinarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapbinarySeries::cumsum(self : DsheapbinarySeries) -> DsheapbinarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapbinarySeries::to_string(self : DsheapbinarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapbinaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_binary_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapbinaryMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_heap_binary_matrix_identity(n : Int) -> DsheapbinaryMatrix {
  let m = ds_heap_binary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapbinaryMatrix::get(self : DsheapbinaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapbinaryMatrix::transpose(self : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  let result = ds_heap_binary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapbinaryMatrix::add(self : DsheapbinaryMatrix, other : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_binary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapbinaryMatrix::scale(self : DsheapbinaryMatrix, s : Double) -> DsheapbinaryMatrix {
  let result = ds_heap_binary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapbinaryMatrix::multiply(self : DsheapbinaryMatrix, other : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  if self.cols != other.rows { return ds_heap_binary_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_binary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsheapbinaryMatrix::trace(self : DsheapbinaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapbinaryMatrix::det(self : DsheapbinaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapbinaryMatrix::norm(self : DsheapbinaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapbinaryMatrix::to_string(self : DsheapbinaryMatrix) -> String {
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

pub(all) struct DsheapbinaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_binary_make_vector(comps : Array[Double]) -> DsheapbinaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_binary_vector_zero(dim : Int) -> DsheapbinaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapbinaryVector::add(self : DsheapbinaryVector, other : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapbinaryVector::sub(self : DsheapbinaryVector, other : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapbinaryVector::scale(self : DsheapbinaryVector, s : Double) -> DsheapbinaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapbinaryVector::dot(self : DsheapbinaryVector, other : DsheapbinaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapbinaryVector::norm(self : DsheapbinaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapbinaryVector::normalize(self : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapbinaryVector::dist(self : DsheapbinaryVector, other : DsheapbinaryVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapbinaryVector::to_string(self : DsheapbinaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapbinaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_frame_make(size : Int) -> DsheapbinaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryFrame::len(self : DsheapbinaryFrame) -> Int { self.size }

pub fn DsheapbinaryFrame::get(self : DsheapbinaryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryFrame::set(self : DsheapbinaryFrame, i : Int, v : Double) -> DsheapbinaryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryFrame::sum(self : DsheapbinaryFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryFrame::mean(self : DsheapbinaryFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryFrame::scale(self : DsheapbinaryFrame, f : Double) -> DsheapbinaryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryFrame::add(self : DsheapbinaryFrame, other : DsheapbinaryFrame) -> DsheapbinaryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryFrame::copy(self : DsheapbinaryFrame) -> DsheapbinaryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryFrame::fill(self : DsheapbinaryFrame, v : Double) -> DsheapbinaryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryFrame::min(self : DsheapbinaryFrame) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryFrame::max(self : DsheapbinaryFrame) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryFrame::to_string(self : DsheapbinaryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_table_make(size : Int) -> DsheapbinaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryTable::len(self : DsheapbinaryTable) -> Int { self.size }

pub fn DsheapbinaryTable::get(self : DsheapbinaryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryTable::set(self : DsheapbinaryTable, i : Int, v : Double) -> DsheapbinaryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryTable::sum(self : DsheapbinaryTable) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryTable::mean(self : DsheapbinaryTable) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryTable::scale(self : DsheapbinaryTable, f : Double) -> DsheapbinaryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryTable::add(self : DsheapbinaryTable, other : DsheapbinaryTable) -> DsheapbinaryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryTable::copy(self : DsheapbinaryTable) -> DsheapbinaryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryTable::fill(self : DsheapbinaryTable, v : Double) -> DsheapbinaryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryTable::min(self : DsheapbinaryTable) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryTable::max(self : DsheapbinaryTable) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryTable::to_string(self : DsheapbinaryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_graphn_make(size : Int) -> DsheapbinaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryGraphN::len(self : DsheapbinaryGraphN) -> Int { self.size }

pub fn DsheapbinaryGraphN::get(self : DsheapbinaryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryGraphN::set(self : DsheapbinaryGraphN, i : Int, v : Double) -> DsheapbinaryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryGraphN::sum(self : DsheapbinaryGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryGraphN::mean(self : DsheapbinaryGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryGraphN::scale(self : DsheapbinaryGraphN, f : Double) -> DsheapbinaryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryGraphN::add(self : DsheapbinaryGraphN, other : DsheapbinaryGraphN) -> DsheapbinaryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryGraphN::copy(self : DsheapbinaryGraphN) -> DsheapbinaryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryGraphN::fill(self : DsheapbinaryGraphN, v : Double) -> DsheapbinaryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryGraphN::min(self : DsheapbinaryGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryGraphN::max(self : DsheapbinaryGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryGraphN::to_string(self : DsheapbinaryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_node_make(size : Int) -> DsheapbinaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryNode::len(self : DsheapbinaryNode) -> Int { self.size }

pub fn DsheapbinaryNode::get(self : DsheapbinaryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryNode::set(self : DsheapbinaryNode, i : Int, v : Double) -> DsheapbinaryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryNode::sum(self : DsheapbinaryNode) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryNode::mean(self : DsheapbinaryNode) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryNode::scale(self : DsheapbinaryNode, f : Double) -> DsheapbinaryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryNode::add(self : DsheapbinaryNode, other : DsheapbinaryNode) -> DsheapbinaryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryNode::copy(self : DsheapbinaryNode) -> DsheapbinaryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryNode::fill(self : DsheapbinaryNode, v : Double) -> DsheapbinaryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryNode::min(self : DsheapbinaryNode) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryNode::max(self : DsheapbinaryNode) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryNode::to_string(self : DsheapbinaryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_edge_make(size : Int) -> DsheapbinaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryEdge::len(self : DsheapbinaryEdge) -> Int { self.size }

pub fn DsheapbinaryEdge::get(self : DsheapbinaryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryEdge::set(self : DsheapbinaryEdge, i : Int, v : Double) -> DsheapbinaryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryEdge::sum(self : DsheapbinaryEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryEdge::mean(self : DsheapbinaryEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryEdge::scale(self : DsheapbinaryEdge, f : Double) -> DsheapbinaryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryEdge::add(self : DsheapbinaryEdge, other : DsheapbinaryEdge) -> DsheapbinaryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryEdge::copy(self : DsheapbinaryEdge) -> DsheapbinaryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryEdge::fill(self : DsheapbinaryEdge, v : Double) -> DsheapbinaryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryEdge::min(self : DsheapbinaryEdge) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryEdge::max(self : DsheapbinaryEdge) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryEdge::to_string(self : DsheapbinaryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_path_make(size : Int) -> DsheapbinaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryPath::len(self : DsheapbinaryPath) -> Int { self.size }

pub fn DsheapbinaryPath::get(self : DsheapbinaryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryPath::set(self : DsheapbinaryPath, i : Int, v : Double) -> DsheapbinaryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryPath::sum(self : DsheapbinaryPath) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryPath::mean(self : DsheapbinaryPath) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryPath::scale(self : DsheapbinaryPath, f : Double) -> DsheapbinaryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryPath::add(self : DsheapbinaryPath, other : DsheapbinaryPath) -> DsheapbinaryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryPath::copy(self : DsheapbinaryPath) -> DsheapbinaryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryPath::fill(self : DsheapbinaryPath, v : Double) -> DsheapbinaryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryPath::min(self : DsheapbinaryPath) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryPath::max(self : DsheapbinaryPath) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryPath::to_string(self : DsheapbinaryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_cluster_make(size : Int) -> DsheapbinaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryCluster::len(self : DsheapbinaryCluster) -> Int { self.size }

pub fn DsheapbinaryCluster::get(self : DsheapbinaryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryCluster::set(self : DsheapbinaryCluster, i : Int, v : Double) -> DsheapbinaryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCluster::sum(self : DsheapbinaryCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryCluster::mean(self : DsheapbinaryCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryCluster::scale(self : DsheapbinaryCluster, f : Double) -> DsheapbinaryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCluster::add(self : DsheapbinaryCluster, other : DsheapbinaryCluster) -> DsheapbinaryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryCluster::copy(self : DsheapbinaryCluster) -> DsheapbinaryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCluster::fill(self : DsheapbinaryCluster, v : Double) -> DsheapbinaryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCluster::min(self : DsheapbinaryCluster) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryCluster::max(self : DsheapbinaryCluster) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryCluster::to_string(self : DsheapbinaryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_model_make(size : Int) -> DsheapbinaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryModel::len(self : DsheapbinaryModel) -> Int { self.size }

pub fn DsheapbinaryModel::get(self : DsheapbinaryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryModel::set(self : DsheapbinaryModel, i : Int, v : Double) -> DsheapbinaryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryModel::sum(self : DsheapbinaryModel) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryModel::mean(self : DsheapbinaryModel) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryModel::scale(self : DsheapbinaryModel, f : Double) -> DsheapbinaryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryModel::add(self : DsheapbinaryModel, other : DsheapbinaryModel) -> DsheapbinaryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryModel::copy(self : DsheapbinaryModel) -> DsheapbinaryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryModel::fill(self : DsheapbinaryModel, v : Double) -> DsheapbinaryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryModel::min(self : DsheapbinaryModel) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryModel::max(self : DsheapbinaryModel) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryModel::to_string(self : DsheapbinaryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_layer_make(size : Int) -> DsheapbinaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryLayer::len(self : DsheapbinaryLayer) -> Int { self.size }

pub fn DsheapbinaryLayer::get(self : DsheapbinaryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryLayer::set(self : DsheapbinaryLayer, i : Int, v : Double) -> DsheapbinaryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryLayer::sum(self : DsheapbinaryLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryLayer::mean(self : DsheapbinaryLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryLayer::scale(self : DsheapbinaryLayer, f : Double) -> DsheapbinaryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryLayer::add(self : DsheapbinaryLayer, other : DsheapbinaryLayer) -> DsheapbinaryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryLayer::copy(self : DsheapbinaryLayer) -> DsheapbinaryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryLayer::fill(self : DsheapbinaryLayer, v : Double) -> DsheapbinaryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryLayer::min(self : DsheapbinaryLayer) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryLayer::max(self : DsheapbinaryLayer) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryLayer::to_string(self : DsheapbinaryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_buffer_make(size : Int) -> DsheapbinaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryBuffer::len(self : DsheapbinaryBuffer) -> Int { self.size }

pub fn DsheapbinaryBuffer::get(self : DsheapbinaryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryBuffer::set(self : DsheapbinaryBuffer, i : Int, v : Double) -> DsheapbinaryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryBuffer::sum(self : DsheapbinaryBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryBuffer::mean(self : DsheapbinaryBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryBuffer::scale(self : DsheapbinaryBuffer, f : Double) -> DsheapbinaryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryBuffer::add(self : DsheapbinaryBuffer, other : DsheapbinaryBuffer) -> DsheapbinaryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryBuffer::copy(self : DsheapbinaryBuffer) -> DsheapbinaryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryBuffer::fill(self : DsheapbinaryBuffer, v : Double) -> DsheapbinaryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryBuffer::min(self : DsheapbinaryBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryBuffer::max(self : DsheapbinaryBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryBuffer::to_string(self : DsheapbinaryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_cursor_make(size : Int) -> DsheapbinaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryCursor::len(self : DsheapbinaryCursor) -> Int { self.size }

pub fn DsheapbinaryCursor::get(self : DsheapbinaryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryCursor::set(self : DsheapbinaryCursor, i : Int, v : Double) -> DsheapbinaryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCursor::sum(self : DsheapbinaryCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryCursor::mean(self : DsheapbinaryCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryCursor::scale(self : DsheapbinaryCursor, f : Double) -> DsheapbinaryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCursor::add(self : DsheapbinaryCursor, other : DsheapbinaryCursor) -> DsheapbinaryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryCursor::copy(self : DsheapbinaryCursor) -> DsheapbinaryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCursor::fill(self : DsheapbinaryCursor, v : Double) -> DsheapbinaryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryCursor::min(self : DsheapbinaryCursor) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryCursor::max(self : DsheapbinaryCursor) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryCursor::to_string(self : DsheapbinaryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_view_make(size : Int) -> DsheapbinaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryView::len(self : DsheapbinaryView) -> Int { self.size }

pub fn DsheapbinaryView::get(self : DsheapbinaryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryView::set(self : DsheapbinaryView, i : Int, v : Double) -> DsheapbinaryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryView::sum(self : DsheapbinaryView) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryView::mean(self : DsheapbinaryView) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryView::scale(self : DsheapbinaryView, f : Double) -> DsheapbinaryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryView::add(self : DsheapbinaryView, other : DsheapbinaryView) -> DsheapbinaryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryView::copy(self : DsheapbinaryView) -> DsheapbinaryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryView::fill(self : DsheapbinaryView, v : Double) -> DsheapbinaryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryView::min(self : DsheapbinaryView) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryView::max(self : DsheapbinaryView) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryView::to_string(self : DsheapbinaryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_range_make(size : Int) -> DsheapbinaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinaryRange::len(self : DsheapbinaryRange) -> Int { self.size }

pub fn DsheapbinaryRange::get(self : DsheapbinaryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinaryRange::set(self : DsheapbinaryRange, i : Int, v : Double) -> DsheapbinaryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinaryRange::sum(self : DsheapbinaryRange) -> Double { @_common.sum(self.data) }

pub fn DsheapbinaryRange::mean(self : DsheapbinaryRange) -> Double { @_common.mean(self.data) }

pub fn DsheapbinaryRange::scale(self : DsheapbinaryRange, f : Double) -> DsheapbinaryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryRange::add(self : DsheapbinaryRange, other : DsheapbinaryRange) -> DsheapbinaryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinaryRange::copy(self : DsheapbinaryRange) -> DsheapbinaryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryRange::fill(self : DsheapbinaryRange, v : Double) -> DsheapbinaryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinaryRange::min(self : DsheapbinaryRange) -> Double { @_common.min(self.data) }

pub fn DsheapbinaryRange::max(self : DsheapbinaryRange) -> Double { @_common.max(self.data) }

pub fn DsheapbinaryRange::to_string(self : DsheapbinaryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapbinarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_slice_make(size : Int) -> DsheapbinarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapbinarySlice::len(self : DsheapbinarySlice) -> Int { self.size }

pub fn DsheapbinarySlice::get(self : DsheapbinarySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapbinarySlice::set(self : DsheapbinarySlice, i : Int, v : Double) -> DsheapbinarySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapbinarySlice::sum(self : DsheapbinarySlice) -> Double { @_common.sum(self.data) }

pub fn DsheapbinarySlice::mean(self : DsheapbinarySlice) -> Double { @_common.mean(self.data) }

pub fn DsheapbinarySlice::scale(self : DsheapbinarySlice, f : Double) -> DsheapbinarySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapbinarySlice::add(self : DsheapbinarySlice, other : DsheapbinarySlice) -> DsheapbinarySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapbinarySlice::copy(self : DsheapbinarySlice) -> DsheapbinarySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapbinarySlice::fill(self : DsheapbinarySlice, v : Double) -> DsheapbinarySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapbinarySlice::min(self : DsheapbinarySlice) -> Double { @_common.min(self.data) }

pub fn DsheapbinarySlice::max(self : DsheapbinarySlice) -> Double { @_common.max(self.data) }

pub fn DsheapbinarySlice::to_string(self : DsheapbinarySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

