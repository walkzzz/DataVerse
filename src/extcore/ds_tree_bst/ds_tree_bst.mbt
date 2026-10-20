///===
/// extcore/ds_tree_bst

pub(all) struct DstreebstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_bst_make_point(x : Double, y : Double) -> DstreebstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_bst_make_point3(x : Double, y : Double, z : Double) -> DstreebstPoint {
  { x, y, z, label: 0 }
}

pub fn DstreebstPoint::x(self : DstreebstPoint) -> Double { self.x }

pub fn DstreebstPoint::y(self : DstreebstPoint) -> Double { self.y }

pub fn DstreebstPoint::z(self : DstreebstPoint) -> Double { self.z }

pub fn DstreebstPoint::label(self : DstreebstPoint) -> Int { self.label }

pub fn DstreebstPoint::dist(self : DstreebstPoint, other : DstreebstPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreebstPoint::add(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreebstPoint::sub(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreebstPoint::scale(self : DstreebstPoint, s : Double) -> DstreebstPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreebstPoint::dot(self : DstreebstPoint, other : DstreebstPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreebstPoint::cross(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreebstPoint::norm(self : DstreebstPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreebstPoint::normalize(self : DstreebstPoint) -> DstreebstPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebstPoint::negate(self : DstreebstPoint) -> DstreebstPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreebstPoint::mid(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreebstPoint::lerp(self : DstreebstPoint, other : DstreebstPoint, t : Double) -> DstreebstPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreebstPoint::to_string(self : DstreebstPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreebstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_bst_make_series(vals : Array[Double], name : String) -> DstreebstSeries {
  { vals, name, meta: 0 }
}

pub fn DstreebstSeries::len(self : DstreebstSeries) -> Int { self.vals.length() }

pub fn DstreebstSeries::sum(self : DstreebstSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreebstSeries::mean(self : DstreebstSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreebstSeries::min(self : DstreebstSeries) -> Double { @_common.min(self.vals) }

pub fn DstreebstSeries::max(self : DstreebstSeries) -> Double { @_common.max(self.vals) }

pub fn DstreebstSeries::range(self : DstreebstSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreebstSeries::variance(self : DstreebstSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreebstSeries::std(self : DstreebstSeries) -> Double { @_common.std(self.vals) }

pub fn DstreebstSeries::median(self : DstreebstSeries) -> Double { @_common.median(self.vals) }

pub fn DstreebstSeries::scale(self : DstreebstSeries, f : Double) -> DstreebstSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreebstSeries::add(self : DstreebstSeries, other : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreebstSeries::sub(self : DstreebstSeries, other : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreebstSeries::normalize(self : DstreebstSeries) -> DstreebstSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreebstSeries::cumsum(self : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreebstSeries::to_string(self : DstreebstSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_bst_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_bst_matrix_identity(n : Int) -> DstreebstMatrix {
  let m = ds_tree_bst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreebstMatrix::get(self : DstreebstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreebstMatrix::transpose(self : DstreebstMatrix) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreebstMatrix::add(self : DstreebstMatrix, other : DstreebstMatrix) -> DstreebstMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_bst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreebstMatrix::scale(self : DstreebstMatrix, s : Double) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreebstMatrix::multiply(self : DstreebstMatrix, other : DstreebstMatrix) -> DstreebstMatrix {
  if self.cols != other.rows { return ds_tree_bst_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_bst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DstreebstMatrix::trace(self : DstreebstMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreebstMatrix::det(self : DstreebstMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreebstMatrix::norm(self : DstreebstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreebstMatrix::to_string(self : DstreebstMatrix) -> String {
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

pub(all) struct DstreebstVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_bst_make_vector(comps : Array[Double]) -> DstreebstVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_bst_vector_zero(dim : Int) -> DstreebstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreebstVector::add(self : DstreebstVector, other : DstreebstVector) -> DstreebstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebstVector::sub(self : DstreebstVector, other : DstreebstVector) -> DstreebstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebstVector::scale(self : DstreebstVector, s : Double) -> DstreebstVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreebstVector::dot(self : DstreebstVector, other : DstreebstVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreebstVector::norm(self : DstreebstVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreebstVector::normalize(self : DstreebstVector) -> DstreebstVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebstVector::dist(self : DstreebstVector, other : DstreebstVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreebstVector::to_string(self : DstreebstVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_frame_make(size : Int) -> DstreebstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstFrame::len(self : DstreebstFrame) -> Int { self.size }

pub fn DstreebstFrame::get(self : DstreebstFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstFrame::set(self : DstreebstFrame, i : Int, v : Double) -> DstreebstFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstFrame::sum(self : DstreebstFrame) -> Double { @_common.sum(self.data) }

pub fn DstreebstFrame::mean(self : DstreebstFrame) -> Double { @_common.mean(self.data) }

pub fn DstreebstFrame::scale(self : DstreebstFrame, f : Double) -> DstreebstFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstFrame::add(self : DstreebstFrame, other : DstreebstFrame) -> DstreebstFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstFrame::copy(self : DstreebstFrame) -> DstreebstFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstFrame::fill(self : DstreebstFrame, v : Double) -> DstreebstFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstFrame::min(self : DstreebstFrame) -> Double { @_common.min(self.data) }

pub fn DstreebstFrame::max(self : DstreebstFrame) -> Double { @_common.max(self.data) }

pub fn DstreebstFrame::to_string(self : DstreebstFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_table_make(size : Int) -> DstreebstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstTable::len(self : DstreebstTable) -> Int { self.size }

pub fn DstreebstTable::get(self : DstreebstTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstTable::set(self : DstreebstTable, i : Int, v : Double) -> DstreebstTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstTable::sum(self : DstreebstTable) -> Double { @_common.sum(self.data) }

pub fn DstreebstTable::mean(self : DstreebstTable) -> Double { @_common.mean(self.data) }

pub fn DstreebstTable::scale(self : DstreebstTable, f : Double) -> DstreebstTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstTable::add(self : DstreebstTable, other : DstreebstTable) -> DstreebstTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstTable::copy(self : DstreebstTable) -> DstreebstTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstTable::fill(self : DstreebstTable, v : Double) -> DstreebstTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstTable::min(self : DstreebstTable) -> Double { @_common.min(self.data) }

pub fn DstreebstTable::max(self : DstreebstTable) -> Double { @_common.max(self.data) }

pub fn DstreebstTable::to_string(self : DstreebstTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_graphn_make(size : Int) -> DstreebstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstGraphN::len(self : DstreebstGraphN) -> Int { self.size }

pub fn DstreebstGraphN::get(self : DstreebstGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstGraphN::set(self : DstreebstGraphN, i : Int, v : Double) -> DstreebstGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstGraphN::sum(self : DstreebstGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreebstGraphN::mean(self : DstreebstGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreebstGraphN::scale(self : DstreebstGraphN, f : Double) -> DstreebstGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstGraphN::add(self : DstreebstGraphN, other : DstreebstGraphN) -> DstreebstGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstGraphN::copy(self : DstreebstGraphN) -> DstreebstGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstGraphN::fill(self : DstreebstGraphN, v : Double) -> DstreebstGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstGraphN::min(self : DstreebstGraphN) -> Double { @_common.min(self.data) }

pub fn DstreebstGraphN::max(self : DstreebstGraphN) -> Double { @_common.max(self.data) }

pub fn DstreebstGraphN::to_string(self : DstreebstGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_node_make(size : Int) -> DstreebstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstNode::len(self : DstreebstNode) -> Int { self.size }

pub fn DstreebstNode::get(self : DstreebstNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstNode::set(self : DstreebstNode, i : Int, v : Double) -> DstreebstNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstNode::sum(self : DstreebstNode) -> Double { @_common.sum(self.data) }

pub fn DstreebstNode::mean(self : DstreebstNode) -> Double { @_common.mean(self.data) }

pub fn DstreebstNode::scale(self : DstreebstNode, f : Double) -> DstreebstNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstNode::add(self : DstreebstNode, other : DstreebstNode) -> DstreebstNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstNode::copy(self : DstreebstNode) -> DstreebstNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstNode::fill(self : DstreebstNode, v : Double) -> DstreebstNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstNode::min(self : DstreebstNode) -> Double { @_common.min(self.data) }

pub fn DstreebstNode::max(self : DstreebstNode) -> Double { @_common.max(self.data) }

pub fn DstreebstNode::to_string(self : DstreebstNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_edge_make(size : Int) -> DstreebstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstEdge::len(self : DstreebstEdge) -> Int { self.size }

pub fn DstreebstEdge::get(self : DstreebstEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstEdge::set(self : DstreebstEdge, i : Int, v : Double) -> DstreebstEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstEdge::sum(self : DstreebstEdge) -> Double { @_common.sum(self.data) }

pub fn DstreebstEdge::mean(self : DstreebstEdge) -> Double { @_common.mean(self.data) }

pub fn DstreebstEdge::scale(self : DstreebstEdge, f : Double) -> DstreebstEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstEdge::add(self : DstreebstEdge, other : DstreebstEdge) -> DstreebstEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstEdge::copy(self : DstreebstEdge) -> DstreebstEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstEdge::fill(self : DstreebstEdge, v : Double) -> DstreebstEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstEdge::min(self : DstreebstEdge) -> Double { @_common.min(self.data) }

pub fn DstreebstEdge::max(self : DstreebstEdge) -> Double { @_common.max(self.data) }

pub fn DstreebstEdge::to_string(self : DstreebstEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_path_make(size : Int) -> DstreebstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstPath::len(self : DstreebstPath) -> Int { self.size }

pub fn DstreebstPath::get(self : DstreebstPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstPath::set(self : DstreebstPath, i : Int, v : Double) -> DstreebstPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstPath::sum(self : DstreebstPath) -> Double { @_common.sum(self.data) }

pub fn DstreebstPath::mean(self : DstreebstPath) -> Double { @_common.mean(self.data) }

pub fn DstreebstPath::scale(self : DstreebstPath, f : Double) -> DstreebstPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstPath::add(self : DstreebstPath, other : DstreebstPath) -> DstreebstPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstPath::copy(self : DstreebstPath) -> DstreebstPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstPath::fill(self : DstreebstPath, v : Double) -> DstreebstPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstPath::min(self : DstreebstPath) -> Double { @_common.min(self.data) }

pub fn DstreebstPath::max(self : DstreebstPath) -> Double { @_common.max(self.data) }

pub fn DstreebstPath::to_string(self : DstreebstPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cluster_make(size : Int) -> DstreebstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstCluster::len(self : DstreebstCluster) -> Int { self.size }

pub fn DstreebstCluster::get(self : DstreebstCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstCluster::set(self : DstreebstCluster, i : Int, v : Double) -> DstreebstCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstCluster::sum(self : DstreebstCluster) -> Double { @_common.sum(self.data) }

pub fn DstreebstCluster::mean(self : DstreebstCluster) -> Double { @_common.mean(self.data) }

pub fn DstreebstCluster::scale(self : DstreebstCluster, f : Double) -> DstreebstCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstCluster::add(self : DstreebstCluster, other : DstreebstCluster) -> DstreebstCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstCluster::copy(self : DstreebstCluster) -> DstreebstCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstCluster::fill(self : DstreebstCluster, v : Double) -> DstreebstCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstCluster::min(self : DstreebstCluster) -> Double { @_common.min(self.data) }

pub fn DstreebstCluster::max(self : DstreebstCluster) -> Double { @_common.max(self.data) }

pub fn DstreebstCluster::to_string(self : DstreebstCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_model_make(size : Int) -> DstreebstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstModel::len(self : DstreebstModel) -> Int { self.size }

pub fn DstreebstModel::get(self : DstreebstModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstModel::set(self : DstreebstModel, i : Int, v : Double) -> DstreebstModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstModel::sum(self : DstreebstModel) -> Double { @_common.sum(self.data) }

pub fn DstreebstModel::mean(self : DstreebstModel) -> Double { @_common.mean(self.data) }

pub fn DstreebstModel::scale(self : DstreebstModel, f : Double) -> DstreebstModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstModel::add(self : DstreebstModel, other : DstreebstModel) -> DstreebstModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstModel::copy(self : DstreebstModel) -> DstreebstModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstModel::fill(self : DstreebstModel, v : Double) -> DstreebstModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstModel::min(self : DstreebstModel) -> Double { @_common.min(self.data) }

pub fn DstreebstModel::max(self : DstreebstModel) -> Double { @_common.max(self.data) }

pub fn DstreebstModel::to_string(self : DstreebstModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_layer_make(size : Int) -> DstreebstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstLayer::len(self : DstreebstLayer) -> Int { self.size }

pub fn DstreebstLayer::get(self : DstreebstLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstLayer::set(self : DstreebstLayer, i : Int, v : Double) -> DstreebstLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstLayer::sum(self : DstreebstLayer) -> Double { @_common.sum(self.data) }

pub fn DstreebstLayer::mean(self : DstreebstLayer) -> Double { @_common.mean(self.data) }

pub fn DstreebstLayer::scale(self : DstreebstLayer, f : Double) -> DstreebstLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstLayer::add(self : DstreebstLayer, other : DstreebstLayer) -> DstreebstLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstLayer::copy(self : DstreebstLayer) -> DstreebstLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstLayer::fill(self : DstreebstLayer, v : Double) -> DstreebstLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstLayer::min(self : DstreebstLayer) -> Double { @_common.min(self.data) }

pub fn DstreebstLayer::max(self : DstreebstLayer) -> Double { @_common.max(self.data) }

pub fn DstreebstLayer::to_string(self : DstreebstLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_buffer_make(size : Int) -> DstreebstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstBuffer::len(self : DstreebstBuffer) -> Int { self.size }

pub fn DstreebstBuffer::get(self : DstreebstBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstBuffer::set(self : DstreebstBuffer, i : Int, v : Double) -> DstreebstBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstBuffer::sum(self : DstreebstBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreebstBuffer::mean(self : DstreebstBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreebstBuffer::scale(self : DstreebstBuffer, f : Double) -> DstreebstBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstBuffer::add(self : DstreebstBuffer, other : DstreebstBuffer) -> DstreebstBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstBuffer::copy(self : DstreebstBuffer) -> DstreebstBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstBuffer::fill(self : DstreebstBuffer, v : Double) -> DstreebstBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstBuffer::min(self : DstreebstBuffer) -> Double { @_common.min(self.data) }

pub fn DstreebstBuffer::max(self : DstreebstBuffer) -> Double { @_common.max(self.data) }

pub fn DstreebstBuffer::to_string(self : DstreebstBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cursor_make(size : Int) -> DstreebstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstCursor::len(self : DstreebstCursor) -> Int { self.size }

pub fn DstreebstCursor::get(self : DstreebstCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstCursor::set(self : DstreebstCursor, i : Int, v : Double) -> DstreebstCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstCursor::sum(self : DstreebstCursor) -> Double { @_common.sum(self.data) }

pub fn DstreebstCursor::mean(self : DstreebstCursor) -> Double { @_common.mean(self.data) }

pub fn DstreebstCursor::scale(self : DstreebstCursor, f : Double) -> DstreebstCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstCursor::add(self : DstreebstCursor, other : DstreebstCursor) -> DstreebstCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstCursor::copy(self : DstreebstCursor) -> DstreebstCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstCursor::fill(self : DstreebstCursor, v : Double) -> DstreebstCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstCursor::min(self : DstreebstCursor) -> Double { @_common.min(self.data) }

pub fn DstreebstCursor::max(self : DstreebstCursor) -> Double { @_common.max(self.data) }

pub fn DstreebstCursor::to_string(self : DstreebstCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_view_make(size : Int) -> DstreebstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstView::len(self : DstreebstView) -> Int { self.size }

pub fn DstreebstView::get(self : DstreebstView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstView::set(self : DstreebstView, i : Int, v : Double) -> DstreebstView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstView::sum(self : DstreebstView) -> Double { @_common.sum(self.data) }

pub fn DstreebstView::mean(self : DstreebstView) -> Double { @_common.mean(self.data) }

pub fn DstreebstView::scale(self : DstreebstView, f : Double) -> DstreebstView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstView::add(self : DstreebstView, other : DstreebstView) -> DstreebstView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstView::copy(self : DstreebstView) -> DstreebstView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstView::fill(self : DstreebstView, v : Double) -> DstreebstView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstView::min(self : DstreebstView) -> Double { @_common.min(self.data) }

pub fn DstreebstView::max(self : DstreebstView) -> Double { @_common.max(self.data) }

pub fn DstreebstView::to_string(self : DstreebstView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_range_make(size : Int) -> DstreebstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstRange::len(self : DstreebstRange) -> Int { self.size }

pub fn DstreebstRange::get(self : DstreebstRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstRange::set(self : DstreebstRange, i : Int, v : Double) -> DstreebstRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstRange::sum(self : DstreebstRange) -> Double { @_common.sum(self.data) }

pub fn DstreebstRange::mean(self : DstreebstRange) -> Double { @_common.mean(self.data) }

pub fn DstreebstRange::scale(self : DstreebstRange, f : Double) -> DstreebstRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstRange::add(self : DstreebstRange, other : DstreebstRange) -> DstreebstRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstRange::copy(self : DstreebstRange) -> DstreebstRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstRange::fill(self : DstreebstRange, v : Double) -> DstreebstRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstRange::min(self : DstreebstRange) -> Double { @_common.min(self.data) }

pub fn DstreebstRange::max(self : DstreebstRange) -> Double { @_common.max(self.data) }

pub fn DstreebstRange::to_string(self : DstreebstRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_slice_make(size : Int) -> DstreebstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebstSlice::len(self : DstreebstSlice) -> Int { self.size }

pub fn DstreebstSlice::get(self : DstreebstSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebstSlice::set(self : DstreebstSlice, i : Int, v : Double) -> DstreebstSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebstSlice::sum(self : DstreebstSlice) -> Double { @_common.sum(self.data) }

pub fn DstreebstSlice::mean(self : DstreebstSlice) -> Double { @_common.mean(self.data) }

pub fn DstreebstSlice::scale(self : DstreebstSlice, f : Double) -> DstreebstSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebstSlice::add(self : DstreebstSlice, other : DstreebstSlice) -> DstreebstSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebstSlice::copy(self : DstreebstSlice) -> DstreebstSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebstSlice::fill(self : DstreebstSlice, v : Double) -> DstreebstSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebstSlice::min(self : DstreebstSlice) -> Double { @_common.min(self.data) }

pub fn DstreebstSlice::max(self : DstreebstSlice) -> Double { @_common.max(self.data) }

pub fn DstreebstSlice::to_string(self : DstreebstSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

