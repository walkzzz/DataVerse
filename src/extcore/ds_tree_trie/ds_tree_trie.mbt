///===
/// extcore/ds_tree_trie

pub(all) struct DstreetriePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_trie_make_point(x : Double, y : Double) -> DstreetriePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_trie_make_point3(x : Double, y : Double, z : Double) -> DstreetriePoint {
  { x, y, z, label: 0 }
}

pub fn DstreetriePoint::x(self : DstreetriePoint) -> Double { self.x }

pub fn DstreetriePoint::y(self : DstreetriePoint) -> Double { self.y }

pub fn DstreetriePoint::z(self : DstreetriePoint) -> Double { self.z }

pub fn DstreetriePoint::label(self : DstreetriePoint) -> Int { self.label }

pub fn DstreetriePoint::dist(self : DstreetriePoint, other : DstreetriePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreetriePoint::add(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreetriePoint::sub(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreetriePoint::scale(self : DstreetriePoint, s : Double) -> DstreetriePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreetriePoint::dot(self : DstreetriePoint, other : DstreetriePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreetriePoint::cross(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreetriePoint::norm(self : DstreetriePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreetriePoint::normalize(self : DstreetriePoint) -> DstreetriePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreetriePoint::negate(self : DstreetriePoint) -> DstreetriePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreetriePoint::mid(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreetriePoint::lerp(self : DstreetriePoint, other : DstreetriePoint, t : Double) -> DstreetriePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreetriePoint::to_string(self : DstreetriePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreetrieSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_trie_make_series(vals : Array[Double], name : String) -> DstreetrieSeries {
  { vals, name, meta: 0 }
}

pub fn DstreetrieSeries::len(self : DstreetrieSeries) -> Int { self.vals.length() }

pub fn DstreetrieSeries::sum(self : DstreetrieSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreetrieSeries::mean(self : DstreetrieSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreetrieSeries::min(self : DstreetrieSeries) -> Double { @_common.min(self.vals) }

pub fn DstreetrieSeries::max(self : DstreetrieSeries) -> Double { @_common.max(self.vals) }

pub fn DstreetrieSeries::range(self : DstreetrieSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreetrieSeries::variance(self : DstreetrieSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreetrieSeries::std(self : DstreetrieSeries) -> Double { @_common.std(self.vals) }

pub fn DstreetrieSeries::median(self : DstreetrieSeries) -> Double { @_common.median(self.vals) }

pub fn DstreetrieSeries::scale(self : DstreetrieSeries, f : Double) -> DstreetrieSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreetrieSeries::add(self : DstreetrieSeries, other : DstreetrieSeries) -> DstreetrieSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreetrieSeries::sub(self : DstreetrieSeries, other : DstreetrieSeries) -> DstreetrieSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreetrieSeries::normalize(self : DstreetrieSeries) -> DstreetrieSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreetrieSeries::cumsum(self : DstreetrieSeries) -> DstreetrieSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreetrieSeries::to_string(self : DstreetrieSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreetrieMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_trie_make_matrix(rows : Int, cols : Int, val : Double) -> DstreetrieMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_trie_matrix_identity(n : Int) -> DstreetrieMatrix {
  let m = ds_tree_trie_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreetrieMatrix::get(self : DstreetrieMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreetrieMatrix::transpose(self : DstreetrieMatrix) -> DstreetrieMatrix {
  let result = ds_tree_trie_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreetrieMatrix::add(self : DstreetrieMatrix, other : DstreetrieMatrix) -> DstreetrieMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_trie_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreetrieMatrix::scale(self : DstreetrieMatrix, s : Double) -> DstreetrieMatrix {
  let result = ds_tree_trie_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreetrieMatrix::multiply(self : DstreetrieMatrix, other : DstreetrieMatrix) -> DstreetrieMatrix {
  if self.cols != other.rows { return ds_tree_trie_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_trie_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreetrieMatrix::trace(self : DstreetrieMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreetrieMatrix::det(self : DstreetrieMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreetrieMatrix::norm(self : DstreetrieMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreetrieMatrix::to_string(self : DstreetrieMatrix) -> String {
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

pub(all) struct DstreetrieVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_trie_make_vector(comps : Array[Double]) -> DstreetrieVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_trie_vector_zero(dim : Int) -> DstreetrieVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreetrieVector::add(self : DstreetrieVector, other : DstreetrieVector) -> DstreetrieVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreetrieVector::sub(self : DstreetrieVector, other : DstreetrieVector) -> DstreetrieVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreetrieVector::scale(self : DstreetrieVector, s : Double) -> DstreetrieVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreetrieVector::dot(self : DstreetrieVector, other : DstreetrieVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreetrieVector::norm(self : DstreetrieVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreetrieVector::normalize(self : DstreetrieVector) -> DstreetrieVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreetrieVector::dist(self : DstreetrieVector, other : DstreetrieVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreetrieVector::to_string(self : DstreetrieVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreetrieFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_frame_make(size : Int) -> DstreetrieFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieFrame::len(self : DstreetrieFrame) -> Int { self.size }

pub fn DstreetrieFrame::get(self : DstreetrieFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieFrame::set(self : DstreetrieFrame, i : Int, v : Double) -> DstreetrieFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieFrame::sum(self : DstreetrieFrame) -> Double { @_common.sum(self.data) }

pub fn DstreetrieFrame::mean(self : DstreetrieFrame) -> Double { @_common.mean(self.data) }

pub fn DstreetrieFrame::scale(self : DstreetrieFrame, f : Double) -> DstreetrieFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieFrame::add(self : DstreetrieFrame, other : DstreetrieFrame) -> DstreetrieFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieFrame::copy(self : DstreetrieFrame) -> DstreetrieFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieFrame::fill(self : DstreetrieFrame, v : Double) -> DstreetrieFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieFrame::min(self : DstreetrieFrame) -> Double { @_common.min(self.data) }

pub fn DstreetrieFrame::max(self : DstreetrieFrame) -> Double { @_common.max(self.data) }

pub fn DstreetrieFrame::to_string(self : DstreetrieFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_table_make(size : Int) -> DstreetrieTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieTable::len(self : DstreetrieTable) -> Int { self.size }

pub fn DstreetrieTable::get(self : DstreetrieTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieTable::set(self : DstreetrieTable, i : Int, v : Double) -> DstreetrieTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieTable::sum(self : DstreetrieTable) -> Double { @_common.sum(self.data) }

pub fn DstreetrieTable::mean(self : DstreetrieTable) -> Double { @_common.mean(self.data) }

pub fn DstreetrieTable::scale(self : DstreetrieTable, f : Double) -> DstreetrieTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieTable::add(self : DstreetrieTable, other : DstreetrieTable) -> DstreetrieTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieTable::copy(self : DstreetrieTable) -> DstreetrieTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieTable::fill(self : DstreetrieTable, v : Double) -> DstreetrieTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieTable::min(self : DstreetrieTable) -> Double { @_common.min(self.data) }

pub fn DstreetrieTable::max(self : DstreetrieTable) -> Double { @_common.max(self.data) }

pub fn DstreetrieTable::to_string(self : DstreetrieTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_graphn_make(size : Int) -> DstreetrieGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieGraphN::len(self : DstreetrieGraphN) -> Int { self.size }

pub fn DstreetrieGraphN::get(self : DstreetrieGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieGraphN::set(self : DstreetrieGraphN, i : Int, v : Double) -> DstreetrieGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieGraphN::sum(self : DstreetrieGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreetrieGraphN::mean(self : DstreetrieGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreetrieGraphN::scale(self : DstreetrieGraphN, f : Double) -> DstreetrieGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieGraphN::add(self : DstreetrieGraphN, other : DstreetrieGraphN) -> DstreetrieGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieGraphN::copy(self : DstreetrieGraphN) -> DstreetrieGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieGraphN::fill(self : DstreetrieGraphN, v : Double) -> DstreetrieGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieGraphN::min(self : DstreetrieGraphN) -> Double { @_common.min(self.data) }

pub fn DstreetrieGraphN::max(self : DstreetrieGraphN) -> Double { @_common.max(self.data) }

pub fn DstreetrieGraphN::to_string(self : DstreetrieGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_node_make(size : Int) -> DstreetrieNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieNode::len(self : DstreetrieNode) -> Int { self.size }

pub fn DstreetrieNode::get(self : DstreetrieNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieNode::set(self : DstreetrieNode, i : Int, v : Double) -> DstreetrieNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieNode::sum(self : DstreetrieNode) -> Double { @_common.sum(self.data) }

pub fn DstreetrieNode::mean(self : DstreetrieNode) -> Double { @_common.mean(self.data) }

pub fn DstreetrieNode::scale(self : DstreetrieNode, f : Double) -> DstreetrieNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieNode::add(self : DstreetrieNode, other : DstreetrieNode) -> DstreetrieNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieNode::copy(self : DstreetrieNode) -> DstreetrieNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieNode::fill(self : DstreetrieNode, v : Double) -> DstreetrieNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieNode::min(self : DstreetrieNode) -> Double { @_common.min(self.data) }

pub fn DstreetrieNode::max(self : DstreetrieNode) -> Double { @_common.max(self.data) }

pub fn DstreetrieNode::to_string(self : DstreetrieNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_edge_make(size : Int) -> DstreetrieEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieEdge::len(self : DstreetrieEdge) -> Int { self.size }

pub fn DstreetrieEdge::get(self : DstreetrieEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieEdge::set(self : DstreetrieEdge, i : Int, v : Double) -> DstreetrieEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieEdge::sum(self : DstreetrieEdge) -> Double { @_common.sum(self.data) }

pub fn DstreetrieEdge::mean(self : DstreetrieEdge) -> Double { @_common.mean(self.data) }

pub fn DstreetrieEdge::scale(self : DstreetrieEdge, f : Double) -> DstreetrieEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieEdge::add(self : DstreetrieEdge, other : DstreetrieEdge) -> DstreetrieEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieEdge::copy(self : DstreetrieEdge) -> DstreetrieEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieEdge::fill(self : DstreetrieEdge, v : Double) -> DstreetrieEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieEdge::min(self : DstreetrieEdge) -> Double { @_common.min(self.data) }

pub fn DstreetrieEdge::max(self : DstreetrieEdge) -> Double { @_common.max(self.data) }

pub fn DstreetrieEdge::to_string(self : DstreetrieEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetriePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_path_make(size : Int) -> DstreetriePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetriePath::len(self : DstreetriePath) -> Int { self.size }

pub fn DstreetriePath::get(self : DstreetriePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetriePath::set(self : DstreetriePath, i : Int, v : Double) -> DstreetriePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetriePath::sum(self : DstreetriePath) -> Double { @_common.sum(self.data) }

pub fn DstreetriePath::mean(self : DstreetriePath) -> Double { @_common.mean(self.data) }

pub fn DstreetriePath::scale(self : DstreetriePath, f : Double) -> DstreetriePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetriePath::add(self : DstreetriePath, other : DstreetriePath) -> DstreetriePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetriePath::copy(self : DstreetriePath) -> DstreetriePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetriePath::fill(self : DstreetriePath, v : Double) -> DstreetriePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetriePath::min(self : DstreetriePath) -> Double { @_common.min(self.data) }

pub fn DstreetriePath::max(self : DstreetriePath) -> Double { @_common.max(self.data) }

pub fn DstreetriePath::to_string(self : DstreetriePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_cluster_make(size : Int) -> DstreetrieCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieCluster::len(self : DstreetrieCluster) -> Int { self.size }

pub fn DstreetrieCluster::get(self : DstreetrieCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieCluster::set(self : DstreetrieCluster, i : Int, v : Double) -> DstreetrieCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieCluster::sum(self : DstreetrieCluster) -> Double { @_common.sum(self.data) }

pub fn DstreetrieCluster::mean(self : DstreetrieCluster) -> Double { @_common.mean(self.data) }

pub fn DstreetrieCluster::scale(self : DstreetrieCluster, f : Double) -> DstreetrieCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieCluster::add(self : DstreetrieCluster, other : DstreetrieCluster) -> DstreetrieCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieCluster::copy(self : DstreetrieCluster) -> DstreetrieCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieCluster::fill(self : DstreetrieCluster, v : Double) -> DstreetrieCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieCluster::min(self : DstreetrieCluster) -> Double { @_common.min(self.data) }

pub fn DstreetrieCluster::max(self : DstreetrieCluster) -> Double { @_common.max(self.data) }

pub fn DstreetrieCluster::to_string(self : DstreetrieCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_model_make(size : Int) -> DstreetrieModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieModel::len(self : DstreetrieModel) -> Int { self.size }

pub fn DstreetrieModel::get(self : DstreetrieModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieModel::set(self : DstreetrieModel, i : Int, v : Double) -> DstreetrieModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieModel::sum(self : DstreetrieModel) -> Double { @_common.sum(self.data) }

pub fn DstreetrieModel::mean(self : DstreetrieModel) -> Double { @_common.mean(self.data) }

pub fn DstreetrieModel::scale(self : DstreetrieModel, f : Double) -> DstreetrieModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieModel::add(self : DstreetrieModel, other : DstreetrieModel) -> DstreetrieModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieModel::copy(self : DstreetrieModel) -> DstreetrieModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieModel::fill(self : DstreetrieModel, v : Double) -> DstreetrieModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieModel::min(self : DstreetrieModel) -> Double { @_common.min(self.data) }

pub fn DstreetrieModel::max(self : DstreetrieModel) -> Double { @_common.max(self.data) }

pub fn DstreetrieModel::to_string(self : DstreetrieModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_layer_make(size : Int) -> DstreetrieLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieLayer::len(self : DstreetrieLayer) -> Int { self.size }

pub fn DstreetrieLayer::get(self : DstreetrieLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieLayer::set(self : DstreetrieLayer, i : Int, v : Double) -> DstreetrieLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieLayer::sum(self : DstreetrieLayer) -> Double { @_common.sum(self.data) }

pub fn DstreetrieLayer::mean(self : DstreetrieLayer) -> Double { @_common.mean(self.data) }

pub fn DstreetrieLayer::scale(self : DstreetrieLayer, f : Double) -> DstreetrieLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieLayer::add(self : DstreetrieLayer, other : DstreetrieLayer) -> DstreetrieLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieLayer::copy(self : DstreetrieLayer) -> DstreetrieLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieLayer::fill(self : DstreetrieLayer, v : Double) -> DstreetrieLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieLayer::min(self : DstreetrieLayer) -> Double { @_common.min(self.data) }

pub fn DstreetrieLayer::max(self : DstreetrieLayer) -> Double { @_common.max(self.data) }

pub fn DstreetrieLayer::to_string(self : DstreetrieLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_buffer_make(size : Int) -> DstreetrieBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieBuffer::len(self : DstreetrieBuffer) -> Int { self.size }

pub fn DstreetrieBuffer::get(self : DstreetrieBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieBuffer::set(self : DstreetrieBuffer, i : Int, v : Double) -> DstreetrieBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieBuffer::sum(self : DstreetrieBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreetrieBuffer::mean(self : DstreetrieBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreetrieBuffer::scale(self : DstreetrieBuffer, f : Double) -> DstreetrieBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieBuffer::add(self : DstreetrieBuffer, other : DstreetrieBuffer) -> DstreetrieBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieBuffer::copy(self : DstreetrieBuffer) -> DstreetrieBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieBuffer::fill(self : DstreetrieBuffer, v : Double) -> DstreetrieBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieBuffer::min(self : DstreetrieBuffer) -> Double { @_common.min(self.data) }

pub fn DstreetrieBuffer::max(self : DstreetrieBuffer) -> Double { @_common.max(self.data) }

pub fn DstreetrieBuffer::to_string(self : DstreetrieBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_cursor_make(size : Int) -> DstreetrieCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieCursor::len(self : DstreetrieCursor) -> Int { self.size }

pub fn DstreetrieCursor::get(self : DstreetrieCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieCursor::set(self : DstreetrieCursor, i : Int, v : Double) -> DstreetrieCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieCursor::sum(self : DstreetrieCursor) -> Double { @_common.sum(self.data) }

pub fn DstreetrieCursor::mean(self : DstreetrieCursor) -> Double { @_common.mean(self.data) }

pub fn DstreetrieCursor::scale(self : DstreetrieCursor, f : Double) -> DstreetrieCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieCursor::add(self : DstreetrieCursor, other : DstreetrieCursor) -> DstreetrieCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieCursor::copy(self : DstreetrieCursor) -> DstreetrieCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieCursor::fill(self : DstreetrieCursor, v : Double) -> DstreetrieCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieCursor::min(self : DstreetrieCursor) -> Double { @_common.min(self.data) }

pub fn DstreetrieCursor::max(self : DstreetrieCursor) -> Double { @_common.max(self.data) }

pub fn DstreetrieCursor::to_string(self : DstreetrieCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_view_make(size : Int) -> DstreetrieView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieView::len(self : DstreetrieView) -> Int { self.size }

pub fn DstreetrieView::get(self : DstreetrieView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieView::set(self : DstreetrieView, i : Int, v : Double) -> DstreetrieView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieView::sum(self : DstreetrieView) -> Double { @_common.sum(self.data) }

pub fn DstreetrieView::mean(self : DstreetrieView) -> Double { @_common.mean(self.data) }

pub fn DstreetrieView::scale(self : DstreetrieView, f : Double) -> DstreetrieView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieView::add(self : DstreetrieView, other : DstreetrieView) -> DstreetrieView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieView::copy(self : DstreetrieView) -> DstreetrieView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieView::fill(self : DstreetrieView, v : Double) -> DstreetrieView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieView::min(self : DstreetrieView) -> Double { @_common.min(self.data) }

pub fn DstreetrieView::max(self : DstreetrieView) -> Double { @_common.max(self.data) }

pub fn DstreetrieView::to_string(self : DstreetrieView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_range_make(size : Int) -> DstreetrieRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieRange::len(self : DstreetrieRange) -> Int { self.size }

pub fn DstreetrieRange::get(self : DstreetrieRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieRange::set(self : DstreetrieRange, i : Int, v : Double) -> DstreetrieRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieRange::sum(self : DstreetrieRange) -> Double { @_common.sum(self.data) }

pub fn DstreetrieRange::mean(self : DstreetrieRange) -> Double { @_common.mean(self.data) }

pub fn DstreetrieRange::scale(self : DstreetrieRange, f : Double) -> DstreetrieRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieRange::add(self : DstreetrieRange, other : DstreetrieRange) -> DstreetrieRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieRange::copy(self : DstreetrieRange) -> DstreetrieRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieRange::fill(self : DstreetrieRange, v : Double) -> DstreetrieRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieRange::min(self : DstreetrieRange) -> Double { @_common.min(self.data) }

pub fn DstreetrieRange::max(self : DstreetrieRange) -> Double { @_common.max(self.data) }

pub fn DstreetrieRange::to_string(self : DstreetrieRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreetrieSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_slice_make(size : Int) -> DstreetrieSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreetrieSlice::len(self : DstreetrieSlice) -> Int { self.size }

pub fn DstreetrieSlice::get(self : DstreetrieSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreetrieSlice::set(self : DstreetrieSlice, i : Int, v : Double) -> DstreetrieSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreetrieSlice::sum(self : DstreetrieSlice) -> Double { @_common.sum(self.data) }

pub fn DstreetrieSlice::mean(self : DstreetrieSlice) -> Double { @_common.mean(self.data) }

pub fn DstreetrieSlice::scale(self : DstreetrieSlice, f : Double) -> DstreetrieSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreetrieSlice::add(self : DstreetrieSlice, other : DstreetrieSlice) -> DstreetrieSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreetrieSlice::copy(self : DstreetrieSlice) -> DstreetrieSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreetrieSlice::fill(self : DstreetrieSlice, v : Double) -> DstreetrieSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreetrieSlice::min(self : DstreetrieSlice) -> Double { @_common.min(self.data) }

pub fn DstreetrieSlice::max(self : DstreetrieSlice) -> Double { @_common.max(self.data) }

pub fn DstreetrieSlice::to_string(self : DstreetrieSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

