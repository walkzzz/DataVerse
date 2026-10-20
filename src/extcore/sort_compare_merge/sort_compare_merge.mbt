///===
/// extcore/sort_compare_merge

pub(all) struct SortcomparemergePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_merge_make_point(x : Double, y : Double) -> SortcomparemergePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_merge_make_point3(x : Double, y : Double, z : Double) -> SortcomparemergePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparemergePoint::x(self : SortcomparemergePoint) -> Double { self.x }

pub fn SortcomparemergePoint::y(self : SortcomparemergePoint) -> Double { self.y }

pub fn SortcomparemergePoint::z(self : SortcomparemergePoint) -> Double { self.z }

pub fn SortcomparemergePoint::label(self : SortcomparemergePoint) -> Int { self.label }

pub fn SortcomparemergePoint::dist(self : SortcomparemergePoint, other : SortcomparemergePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparemergePoint::add(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparemergePoint::sub(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparemergePoint::scale(self : SortcomparemergePoint, s : Double) -> SortcomparemergePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparemergePoint::dot(self : SortcomparemergePoint, other : SortcomparemergePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparemergePoint::cross(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparemergePoint::norm(self : SortcomparemergePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparemergePoint::normalize(self : SortcomparemergePoint) -> SortcomparemergePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparemergePoint::negate(self : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparemergePoint::mid(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparemergePoint::lerp(self : SortcomparemergePoint, other : SortcomparemergePoint, t : Double) -> SortcomparemergePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparemergePoint::to_string(self : SortcomparemergePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparemergeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_merge_make_series(vals : Array[Double], name : String) -> SortcomparemergeSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparemergeSeries::len(self : SortcomparemergeSeries) -> Int { self.vals.length() }

pub fn SortcomparemergeSeries::sum(self : SortcomparemergeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparemergeSeries::mean(self : SortcomparemergeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparemergeSeries::min(self : SortcomparemergeSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparemergeSeries::max(self : SortcomparemergeSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparemergeSeries::range(self : SortcomparemergeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparemergeSeries::variance(self : SortcomparemergeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparemergeSeries::std(self : SortcomparemergeSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparemergeSeries::median(self : SortcomparemergeSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparemergeSeries::scale(self : SortcomparemergeSeries, f : Double) -> SortcomparemergeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparemergeSeries::add(self : SortcomparemergeSeries, other : SortcomparemergeSeries) -> SortcomparemergeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparemergeSeries::sub(self : SortcomparemergeSeries, other : SortcomparemergeSeries) -> SortcomparemergeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparemergeSeries::normalize(self : SortcomparemergeSeries) -> SortcomparemergeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparemergeSeries::cumsum(self : SortcomparemergeSeries) -> SortcomparemergeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparemergeSeries::to_string(self : SortcomparemergeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparemergeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_merge_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparemergeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_merge_matrix_identity(n : Int) -> SortcomparemergeMatrix {
  let m = sort_compare_merge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparemergeMatrix::get(self : SortcomparemergeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparemergeMatrix::transpose(self : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  let result = sort_compare_merge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparemergeMatrix::add(self : SortcomparemergeMatrix, other : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_merge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparemergeMatrix::scale(self : SortcomparemergeMatrix, s : Double) -> SortcomparemergeMatrix {
  let result = sort_compare_merge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparemergeMatrix::multiply(self : SortcomparemergeMatrix, other : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  if self.cols != other.rows { return sort_compare_merge_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_merge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SortcomparemergeMatrix::trace(self : SortcomparemergeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparemergeMatrix::det(self : SortcomparemergeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparemergeMatrix::norm(self : SortcomparemergeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparemergeMatrix::to_string(self : SortcomparemergeMatrix) -> String {
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

pub(all) struct SortcomparemergeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_merge_make_vector(comps : Array[Double]) -> SortcomparemergeVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_merge_vector_zero(dim : Int) -> SortcomparemergeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparemergeVector::add(self : SortcomparemergeVector, other : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparemergeVector::sub(self : SortcomparemergeVector, other : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparemergeVector::scale(self : SortcomparemergeVector, s : Double) -> SortcomparemergeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparemergeVector::dot(self : SortcomparemergeVector, other : SortcomparemergeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparemergeVector::norm(self : SortcomparemergeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparemergeVector::normalize(self : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparemergeVector::dist(self : SortcomparemergeVector, other : SortcomparemergeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparemergeVector::to_string(self : SortcomparemergeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparemergeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_frame_make(size : Int) -> SortcomparemergeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeFrame::len(self : SortcomparemergeFrame) -> Int { self.size }

pub fn SortcomparemergeFrame::get(self : SortcomparemergeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeFrame::set(self : SortcomparemergeFrame, i : Int, v : Double) -> SortcomparemergeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeFrame::sum(self : SortcomparemergeFrame) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeFrame::mean(self : SortcomparemergeFrame) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeFrame::scale(self : SortcomparemergeFrame, f : Double) -> SortcomparemergeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeFrame::add(self : SortcomparemergeFrame, other : SortcomparemergeFrame) -> SortcomparemergeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeFrame::copy(self : SortcomparemergeFrame) -> SortcomparemergeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeFrame::fill(self : SortcomparemergeFrame, v : Double) -> SortcomparemergeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeFrame::min(self : SortcomparemergeFrame) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeFrame::max(self : SortcomparemergeFrame) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeFrame::to_string(self : SortcomparemergeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_table_make(size : Int) -> SortcomparemergeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeTable::len(self : SortcomparemergeTable) -> Int { self.size }

pub fn SortcomparemergeTable::get(self : SortcomparemergeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeTable::set(self : SortcomparemergeTable, i : Int, v : Double) -> SortcomparemergeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeTable::sum(self : SortcomparemergeTable) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeTable::mean(self : SortcomparemergeTable) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeTable::scale(self : SortcomparemergeTable, f : Double) -> SortcomparemergeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeTable::add(self : SortcomparemergeTable, other : SortcomparemergeTable) -> SortcomparemergeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeTable::copy(self : SortcomparemergeTable) -> SortcomparemergeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeTable::fill(self : SortcomparemergeTable, v : Double) -> SortcomparemergeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeTable::min(self : SortcomparemergeTable) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeTable::max(self : SortcomparemergeTable) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeTable::to_string(self : SortcomparemergeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_graphn_make(size : Int) -> SortcomparemergeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeGraphN::len(self : SortcomparemergeGraphN) -> Int { self.size }

pub fn SortcomparemergeGraphN::get(self : SortcomparemergeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeGraphN::set(self : SortcomparemergeGraphN, i : Int, v : Double) -> SortcomparemergeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeGraphN::sum(self : SortcomparemergeGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeGraphN::mean(self : SortcomparemergeGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeGraphN::scale(self : SortcomparemergeGraphN, f : Double) -> SortcomparemergeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeGraphN::add(self : SortcomparemergeGraphN, other : SortcomparemergeGraphN) -> SortcomparemergeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeGraphN::copy(self : SortcomparemergeGraphN) -> SortcomparemergeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeGraphN::fill(self : SortcomparemergeGraphN, v : Double) -> SortcomparemergeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeGraphN::min(self : SortcomparemergeGraphN) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeGraphN::max(self : SortcomparemergeGraphN) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeGraphN::to_string(self : SortcomparemergeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_node_make(size : Int) -> SortcomparemergeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeNode::len(self : SortcomparemergeNode) -> Int { self.size }

pub fn SortcomparemergeNode::get(self : SortcomparemergeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeNode::set(self : SortcomparemergeNode, i : Int, v : Double) -> SortcomparemergeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeNode::sum(self : SortcomparemergeNode) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeNode::mean(self : SortcomparemergeNode) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeNode::scale(self : SortcomparemergeNode, f : Double) -> SortcomparemergeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeNode::add(self : SortcomparemergeNode, other : SortcomparemergeNode) -> SortcomparemergeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeNode::copy(self : SortcomparemergeNode) -> SortcomparemergeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeNode::fill(self : SortcomparemergeNode, v : Double) -> SortcomparemergeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeNode::min(self : SortcomparemergeNode) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeNode::max(self : SortcomparemergeNode) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeNode::to_string(self : SortcomparemergeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_edge_make(size : Int) -> SortcomparemergeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeEdge::len(self : SortcomparemergeEdge) -> Int { self.size }

pub fn SortcomparemergeEdge::get(self : SortcomparemergeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeEdge::set(self : SortcomparemergeEdge, i : Int, v : Double) -> SortcomparemergeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeEdge::sum(self : SortcomparemergeEdge) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeEdge::mean(self : SortcomparemergeEdge) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeEdge::scale(self : SortcomparemergeEdge, f : Double) -> SortcomparemergeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeEdge::add(self : SortcomparemergeEdge, other : SortcomparemergeEdge) -> SortcomparemergeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeEdge::copy(self : SortcomparemergeEdge) -> SortcomparemergeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeEdge::fill(self : SortcomparemergeEdge, v : Double) -> SortcomparemergeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeEdge::min(self : SortcomparemergeEdge) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeEdge::max(self : SortcomparemergeEdge) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeEdge::to_string(self : SortcomparemergeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_path_make(size : Int) -> SortcomparemergePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergePath::len(self : SortcomparemergePath) -> Int { self.size }

pub fn SortcomparemergePath::get(self : SortcomparemergePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergePath::set(self : SortcomparemergePath, i : Int, v : Double) -> SortcomparemergePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergePath::sum(self : SortcomparemergePath) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergePath::mean(self : SortcomparemergePath) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergePath::scale(self : SortcomparemergePath, f : Double) -> SortcomparemergePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergePath::add(self : SortcomparemergePath, other : SortcomparemergePath) -> SortcomparemergePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergePath::copy(self : SortcomparemergePath) -> SortcomparemergePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergePath::fill(self : SortcomparemergePath, v : Double) -> SortcomparemergePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergePath::min(self : SortcomparemergePath) -> Double { @_common.min(self.data) }

pub fn SortcomparemergePath::max(self : SortcomparemergePath) -> Double { @_common.max(self.data) }

pub fn SortcomparemergePath::to_string(self : SortcomparemergePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_cluster_make(size : Int) -> SortcomparemergeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeCluster::len(self : SortcomparemergeCluster) -> Int { self.size }

pub fn SortcomparemergeCluster::get(self : SortcomparemergeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeCluster::set(self : SortcomparemergeCluster, i : Int, v : Double) -> SortcomparemergeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCluster::sum(self : SortcomparemergeCluster) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeCluster::mean(self : SortcomparemergeCluster) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeCluster::scale(self : SortcomparemergeCluster, f : Double) -> SortcomparemergeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCluster::add(self : SortcomparemergeCluster, other : SortcomparemergeCluster) -> SortcomparemergeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeCluster::copy(self : SortcomparemergeCluster) -> SortcomparemergeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCluster::fill(self : SortcomparemergeCluster, v : Double) -> SortcomparemergeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCluster::min(self : SortcomparemergeCluster) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeCluster::max(self : SortcomparemergeCluster) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeCluster::to_string(self : SortcomparemergeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_model_make(size : Int) -> SortcomparemergeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeModel::len(self : SortcomparemergeModel) -> Int { self.size }

pub fn SortcomparemergeModel::get(self : SortcomparemergeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeModel::set(self : SortcomparemergeModel, i : Int, v : Double) -> SortcomparemergeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeModel::sum(self : SortcomparemergeModel) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeModel::mean(self : SortcomparemergeModel) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeModel::scale(self : SortcomparemergeModel, f : Double) -> SortcomparemergeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeModel::add(self : SortcomparemergeModel, other : SortcomparemergeModel) -> SortcomparemergeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeModel::copy(self : SortcomparemergeModel) -> SortcomparemergeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeModel::fill(self : SortcomparemergeModel, v : Double) -> SortcomparemergeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeModel::min(self : SortcomparemergeModel) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeModel::max(self : SortcomparemergeModel) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeModel::to_string(self : SortcomparemergeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_layer_make(size : Int) -> SortcomparemergeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeLayer::len(self : SortcomparemergeLayer) -> Int { self.size }

pub fn SortcomparemergeLayer::get(self : SortcomparemergeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeLayer::set(self : SortcomparemergeLayer, i : Int, v : Double) -> SortcomparemergeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeLayer::sum(self : SortcomparemergeLayer) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeLayer::mean(self : SortcomparemergeLayer) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeLayer::scale(self : SortcomparemergeLayer, f : Double) -> SortcomparemergeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeLayer::add(self : SortcomparemergeLayer, other : SortcomparemergeLayer) -> SortcomparemergeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeLayer::copy(self : SortcomparemergeLayer) -> SortcomparemergeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeLayer::fill(self : SortcomparemergeLayer, v : Double) -> SortcomparemergeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeLayer::min(self : SortcomparemergeLayer) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeLayer::max(self : SortcomparemergeLayer) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeLayer::to_string(self : SortcomparemergeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_buffer_make(size : Int) -> SortcomparemergeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeBuffer::len(self : SortcomparemergeBuffer) -> Int { self.size }

pub fn SortcomparemergeBuffer::get(self : SortcomparemergeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeBuffer::set(self : SortcomparemergeBuffer, i : Int, v : Double) -> SortcomparemergeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeBuffer::sum(self : SortcomparemergeBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeBuffer::mean(self : SortcomparemergeBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeBuffer::scale(self : SortcomparemergeBuffer, f : Double) -> SortcomparemergeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeBuffer::add(self : SortcomparemergeBuffer, other : SortcomparemergeBuffer) -> SortcomparemergeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeBuffer::copy(self : SortcomparemergeBuffer) -> SortcomparemergeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeBuffer::fill(self : SortcomparemergeBuffer, v : Double) -> SortcomparemergeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeBuffer::min(self : SortcomparemergeBuffer) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeBuffer::max(self : SortcomparemergeBuffer) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeBuffer::to_string(self : SortcomparemergeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_cursor_make(size : Int) -> SortcomparemergeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeCursor::len(self : SortcomparemergeCursor) -> Int { self.size }

pub fn SortcomparemergeCursor::get(self : SortcomparemergeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeCursor::set(self : SortcomparemergeCursor, i : Int, v : Double) -> SortcomparemergeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCursor::sum(self : SortcomparemergeCursor) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeCursor::mean(self : SortcomparemergeCursor) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeCursor::scale(self : SortcomparemergeCursor, f : Double) -> SortcomparemergeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCursor::add(self : SortcomparemergeCursor, other : SortcomparemergeCursor) -> SortcomparemergeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeCursor::copy(self : SortcomparemergeCursor) -> SortcomparemergeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCursor::fill(self : SortcomparemergeCursor, v : Double) -> SortcomparemergeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeCursor::min(self : SortcomparemergeCursor) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeCursor::max(self : SortcomparemergeCursor) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeCursor::to_string(self : SortcomparemergeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_view_make(size : Int) -> SortcomparemergeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeView::len(self : SortcomparemergeView) -> Int { self.size }

pub fn SortcomparemergeView::get(self : SortcomparemergeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeView::set(self : SortcomparemergeView, i : Int, v : Double) -> SortcomparemergeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeView::sum(self : SortcomparemergeView) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeView::mean(self : SortcomparemergeView) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeView::scale(self : SortcomparemergeView, f : Double) -> SortcomparemergeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeView::add(self : SortcomparemergeView, other : SortcomparemergeView) -> SortcomparemergeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeView::copy(self : SortcomparemergeView) -> SortcomparemergeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeView::fill(self : SortcomparemergeView, v : Double) -> SortcomparemergeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeView::min(self : SortcomparemergeView) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeView::max(self : SortcomparemergeView) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeView::to_string(self : SortcomparemergeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_range_make(size : Int) -> SortcomparemergeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeRange::len(self : SortcomparemergeRange) -> Int { self.size }

pub fn SortcomparemergeRange::get(self : SortcomparemergeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeRange::set(self : SortcomparemergeRange, i : Int, v : Double) -> SortcomparemergeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeRange::sum(self : SortcomparemergeRange) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeRange::mean(self : SortcomparemergeRange) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeRange::scale(self : SortcomparemergeRange, f : Double) -> SortcomparemergeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeRange::add(self : SortcomparemergeRange, other : SortcomparemergeRange) -> SortcomparemergeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeRange::copy(self : SortcomparemergeRange) -> SortcomparemergeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeRange::fill(self : SortcomparemergeRange, v : Double) -> SortcomparemergeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeRange::min(self : SortcomparemergeRange) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeRange::max(self : SortcomparemergeRange) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeRange::to_string(self : SortcomparemergeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_slice_make(size : Int) -> SortcomparemergeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparemergeSlice::len(self : SortcomparemergeSlice) -> Int { self.size }

pub fn SortcomparemergeSlice::get(self : SortcomparemergeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparemergeSlice::set(self : SortcomparemergeSlice, i : Int, v : Double) -> SortcomparemergeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparemergeSlice::sum(self : SortcomparemergeSlice) -> Double { @_common.sum(self.data) }

pub fn SortcomparemergeSlice::mean(self : SortcomparemergeSlice) -> Double { @_common.mean(self.data) }

pub fn SortcomparemergeSlice::scale(self : SortcomparemergeSlice, f : Double) -> SortcomparemergeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeSlice::add(self : SortcomparemergeSlice, other : SortcomparemergeSlice) -> SortcomparemergeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparemergeSlice::copy(self : SortcomparemergeSlice) -> SortcomparemergeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeSlice::fill(self : SortcomparemergeSlice, v : Double) -> SortcomparemergeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparemergeSlice::min(self : SortcomparemergeSlice) -> Double { @_common.min(self.data) }

pub fn SortcomparemergeSlice::max(self : SortcomparemergeSlice) -> Double { @_common.max(self.data) }

pub fn SortcomparemergeSlice::to_string(self : SortcomparemergeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

