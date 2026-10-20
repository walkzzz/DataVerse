///===
/// extcore/sort_compare_quick

pub(all) struct SortcomparequickPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_quick_make_point(x : Double, y : Double) -> SortcomparequickPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_quick_make_point3(x : Double, y : Double, z : Double) -> SortcomparequickPoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparequickPoint::x(self : SortcomparequickPoint) -> Double { self.x }

pub fn SortcomparequickPoint::y(self : SortcomparequickPoint) -> Double { self.y }

pub fn SortcomparequickPoint::z(self : SortcomparequickPoint) -> Double { self.z }

pub fn SortcomparequickPoint::label(self : SortcomparequickPoint) -> Int { self.label }

pub fn SortcomparequickPoint::dist(self : SortcomparequickPoint, other : SortcomparequickPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparequickPoint::add(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparequickPoint::sub(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparequickPoint::scale(self : SortcomparequickPoint, s : Double) -> SortcomparequickPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparequickPoint::dot(self : SortcomparequickPoint, other : SortcomparequickPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparequickPoint::cross(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparequickPoint::norm(self : SortcomparequickPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparequickPoint::normalize(self : SortcomparequickPoint) -> SortcomparequickPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparequickPoint::negate(self : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparequickPoint::mid(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparequickPoint::lerp(self : SortcomparequickPoint, other : SortcomparequickPoint, t : Double) -> SortcomparequickPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparequickPoint::to_string(self : SortcomparequickPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparequickSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_quick_make_series(vals : Array[Double], name : String) -> SortcomparequickSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparequickSeries::len(self : SortcomparequickSeries) -> Int { self.vals.length() }

pub fn SortcomparequickSeries::sum(self : SortcomparequickSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparequickSeries::mean(self : SortcomparequickSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparequickSeries::min(self : SortcomparequickSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparequickSeries::max(self : SortcomparequickSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparequickSeries::range(self : SortcomparequickSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparequickSeries::variance(self : SortcomparequickSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparequickSeries::std(self : SortcomparequickSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparequickSeries::median(self : SortcomparequickSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparequickSeries::scale(self : SortcomparequickSeries, f : Double) -> SortcomparequickSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparequickSeries::add(self : SortcomparequickSeries, other : SortcomparequickSeries) -> SortcomparequickSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparequickSeries::sub(self : SortcomparequickSeries, other : SortcomparequickSeries) -> SortcomparequickSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparequickSeries::normalize(self : SortcomparequickSeries) -> SortcomparequickSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparequickSeries::cumsum(self : SortcomparequickSeries) -> SortcomparequickSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparequickSeries::to_string(self : SortcomparequickSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparequickMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_quick_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparequickMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn sort_compare_quick_matrix_identity(n : Int) -> SortcomparequickMatrix {
  let m = sort_compare_quick_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparequickMatrix::get(self : SortcomparequickMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparequickMatrix::transpose(self : SortcomparequickMatrix) -> SortcomparequickMatrix {
  let result = sort_compare_quick_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparequickMatrix::add(self : SortcomparequickMatrix, other : SortcomparequickMatrix) -> SortcomparequickMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_quick_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparequickMatrix::scale(self : SortcomparequickMatrix, s : Double) -> SortcomparequickMatrix {
  let result = sort_compare_quick_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparequickMatrix::multiply(self : SortcomparequickMatrix, other : SortcomparequickMatrix) -> SortcomparequickMatrix {
  if self.cols != other.rows { return sort_compare_quick_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_quick_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SortcomparequickMatrix::trace(self : SortcomparequickMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparequickMatrix::det(self : SortcomparequickMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparequickMatrix::norm(self : SortcomparequickMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparequickMatrix::to_string(self : SortcomparequickMatrix) -> String {
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

pub(all) struct SortcomparequickVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_quick_make_vector(comps : Array[Double]) -> SortcomparequickVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_quick_vector_zero(dim : Int) -> SortcomparequickVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparequickVector::add(self : SortcomparequickVector, other : SortcomparequickVector) -> SortcomparequickVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparequickVector::sub(self : SortcomparequickVector, other : SortcomparequickVector) -> SortcomparequickVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparequickVector::scale(self : SortcomparequickVector, s : Double) -> SortcomparequickVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparequickVector::dot(self : SortcomparequickVector, other : SortcomparequickVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparequickVector::norm(self : SortcomparequickVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparequickVector::normalize(self : SortcomparequickVector) -> SortcomparequickVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparequickVector::dist(self : SortcomparequickVector, other : SortcomparequickVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparequickVector::to_string(self : SortcomparequickVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparequickFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_frame_make(size : Int) -> SortcomparequickFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickFrame::len(self : SortcomparequickFrame) -> Int { self.size }

pub fn SortcomparequickFrame::get(self : SortcomparequickFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickFrame::set(self : SortcomparequickFrame, i : Int, v : Double) -> SortcomparequickFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickFrame::sum(self : SortcomparequickFrame) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickFrame::mean(self : SortcomparequickFrame) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickFrame::scale(self : SortcomparequickFrame, f : Double) -> SortcomparequickFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickFrame::add(self : SortcomparequickFrame, other : SortcomparequickFrame) -> SortcomparequickFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickFrame::copy(self : SortcomparequickFrame) -> SortcomparequickFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickFrame::fill(self : SortcomparequickFrame, v : Double) -> SortcomparequickFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickFrame::min(self : SortcomparequickFrame) -> Double { @_common.min(self.data) }

pub fn SortcomparequickFrame::max(self : SortcomparequickFrame) -> Double { @_common.max(self.data) }

pub fn SortcomparequickFrame::to_string(self : SortcomparequickFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_table_make(size : Int) -> SortcomparequickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickTable::len(self : SortcomparequickTable) -> Int { self.size }

pub fn SortcomparequickTable::get(self : SortcomparequickTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickTable::set(self : SortcomparequickTable, i : Int, v : Double) -> SortcomparequickTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickTable::sum(self : SortcomparequickTable) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickTable::mean(self : SortcomparequickTable) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickTable::scale(self : SortcomparequickTable, f : Double) -> SortcomparequickTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickTable::add(self : SortcomparequickTable, other : SortcomparequickTable) -> SortcomparequickTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickTable::copy(self : SortcomparequickTable) -> SortcomparequickTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickTable::fill(self : SortcomparequickTable, v : Double) -> SortcomparequickTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickTable::min(self : SortcomparequickTable) -> Double { @_common.min(self.data) }

pub fn SortcomparequickTable::max(self : SortcomparequickTable) -> Double { @_common.max(self.data) }

pub fn SortcomparequickTable::to_string(self : SortcomparequickTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_graphn_make(size : Int) -> SortcomparequickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickGraphN::len(self : SortcomparequickGraphN) -> Int { self.size }

pub fn SortcomparequickGraphN::get(self : SortcomparequickGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickGraphN::set(self : SortcomparequickGraphN, i : Int, v : Double) -> SortcomparequickGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickGraphN::sum(self : SortcomparequickGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickGraphN::mean(self : SortcomparequickGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickGraphN::scale(self : SortcomparequickGraphN, f : Double) -> SortcomparequickGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickGraphN::add(self : SortcomparequickGraphN, other : SortcomparequickGraphN) -> SortcomparequickGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickGraphN::copy(self : SortcomparequickGraphN) -> SortcomparequickGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickGraphN::fill(self : SortcomparequickGraphN, v : Double) -> SortcomparequickGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickGraphN::min(self : SortcomparequickGraphN) -> Double { @_common.min(self.data) }

pub fn SortcomparequickGraphN::max(self : SortcomparequickGraphN) -> Double { @_common.max(self.data) }

pub fn SortcomparequickGraphN::to_string(self : SortcomparequickGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_node_make(size : Int) -> SortcomparequickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickNode::len(self : SortcomparequickNode) -> Int { self.size }

pub fn SortcomparequickNode::get(self : SortcomparequickNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickNode::set(self : SortcomparequickNode, i : Int, v : Double) -> SortcomparequickNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickNode::sum(self : SortcomparequickNode) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickNode::mean(self : SortcomparequickNode) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickNode::scale(self : SortcomparequickNode, f : Double) -> SortcomparequickNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickNode::add(self : SortcomparequickNode, other : SortcomparequickNode) -> SortcomparequickNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickNode::copy(self : SortcomparequickNode) -> SortcomparequickNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickNode::fill(self : SortcomparequickNode, v : Double) -> SortcomparequickNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickNode::min(self : SortcomparequickNode) -> Double { @_common.min(self.data) }

pub fn SortcomparequickNode::max(self : SortcomparequickNode) -> Double { @_common.max(self.data) }

pub fn SortcomparequickNode::to_string(self : SortcomparequickNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_edge_make(size : Int) -> SortcomparequickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickEdge::len(self : SortcomparequickEdge) -> Int { self.size }

pub fn SortcomparequickEdge::get(self : SortcomparequickEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickEdge::set(self : SortcomparequickEdge, i : Int, v : Double) -> SortcomparequickEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickEdge::sum(self : SortcomparequickEdge) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickEdge::mean(self : SortcomparequickEdge) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickEdge::scale(self : SortcomparequickEdge, f : Double) -> SortcomparequickEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickEdge::add(self : SortcomparequickEdge, other : SortcomparequickEdge) -> SortcomparequickEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickEdge::copy(self : SortcomparequickEdge) -> SortcomparequickEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickEdge::fill(self : SortcomparequickEdge, v : Double) -> SortcomparequickEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickEdge::min(self : SortcomparequickEdge) -> Double { @_common.min(self.data) }

pub fn SortcomparequickEdge::max(self : SortcomparequickEdge) -> Double { @_common.max(self.data) }

pub fn SortcomparequickEdge::to_string(self : SortcomparequickEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_path_make(size : Int) -> SortcomparequickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickPath::len(self : SortcomparequickPath) -> Int { self.size }

pub fn SortcomparequickPath::get(self : SortcomparequickPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickPath::set(self : SortcomparequickPath, i : Int, v : Double) -> SortcomparequickPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickPath::sum(self : SortcomparequickPath) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickPath::mean(self : SortcomparequickPath) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickPath::scale(self : SortcomparequickPath, f : Double) -> SortcomparequickPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickPath::add(self : SortcomparequickPath, other : SortcomparequickPath) -> SortcomparequickPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickPath::copy(self : SortcomparequickPath) -> SortcomparequickPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickPath::fill(self : SortcomparequickPath, v : Double) -> SortcomparequickPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickPath::min(self : SortcomparequickPath) -> Double { @_common.min(self.data) }

pub fn SortcomparequickPath::max(self : SortcomparequickPath) -> Double { @_common.max(self.data) }

pub fn SortcomparequickPath::to_string(self : SortcomparequickPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_cluster_make(size : Int) -> SortcomparequickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickCluster::len(self : SortcomparequickCluster) -> Int { self.size }

pub fn SortcomparequickCluster::get(self : SortcomparequickCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickCluster::set(self : SortcomparequickCluster, i : Int, v : Double) -> SortcomparequickCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickCluster::sum(self : SortcomparequickCluster) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickCluster::mean(self : SortcomparequickCluster) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickCluster::scale(self : SortcomparequickCluster, f : Double) -> SortcomparequickCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickCluster::add(self : SortcomparequickCluster, other : SortcomparequickCluster) -> SortcomparequickCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickCluster::copy(self : SortcomparequickCluster) -> SortcomparequickCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickCluster::fill(self : SortcomparequickCluster, v : Double) -> SortcomparequickCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickCluster::min(self : SortcomparequickCluster) -> Double { @_common.min(self.data) }

pub fn SortcomparequickCluster::max(self : SortcomparequickCluster) -> Double { @_common.max(self.data) }

pub fn SortcomparequickCluster::to_string(self : SortcomparequickCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_model_make(size : Int) -> SortcomparequickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickModel::len(self : SortcomparequickModel) -> Int { self.size }

pub fn SortcomparequickModel::get(self : SortcomparequickModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickModel::set(self : SortcomparequickModel, i : Int, v : Double) -> SortcomparequickModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickModel::sum(self : SortcomparequickModel) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickModel::mean(self : SortcomparequickModel) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickModel::scale(self : SortcomparequickModel, f : Double) -> SortcomparequickModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickModel::add(self : SortcomparequickModel, other : SortcomparequickModel) -> SortcomparequickModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickModel::copy(self : SortcomparequickModel) -> SortcomparequickModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickModel::fill(self : SortcomparequickModel, v : Double) -> SortcomparequickModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickModel::min(self : SortcomparequickModel) -> Double { @_common.min(self.data) }

pub fn SortcomparequickModel::max(self : SortcomparequickModel) -> Double { @_common.max(self.data) }

pub fn SortcomparequickModel::to_string(self : SortcomparequickModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_layer_make(size : Int) -> SortcomparequickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickLayer::len(self : SortcomparequickLayer) -> Int { self.size }

pub fn SortcomparequickLayer::get(self : SortcomparequickLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickLayer::set(self : SortcomparequickLayer, i : Int, v : Double) -> SortcomparequickLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickLayer::sum(self : SortcomparequickLayer) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickLayer::mean(self : SortcomparequickLayer) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickLayer::scale(self : SortcomparequickLayer, f : Double) -> SortcomparequickLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickLayer::add(self : SortcomparequickLayer, other : SortcomparequickLayer) -> SortcomparequickLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickLayer::copy(self : SortcomparequickLayer) -> SortcomparequickLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickLayer::fill(self : SortcomparequickLayer, v : Double) -> SortcomparequickLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickLayer::min(self : SortcomparequickLayer) -> Double { @_common.min(self.data) }

pub fn SortcomparequickLayer::max(self : SortcomparequickLayer) -> Double { @_common.max(self.data) }

pub fn SortcomparequickLayer::to_string(self : SortcomparequickLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_buffer_make(size : Int) -> SortcomparequickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickBuffer::len(self : SortcomparequickBuffer) -> Int { self.size }

pub fn SortcomparequickBuffer::get(self : SortcomparequickBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickBuffer::set(self : SortcomparequickBuffer, i : Int, v : Double) -> SortcomparequickBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickBuffer::sum(self : SortcomparequickBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickBuffer::mean(self : SortcomparequickBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickBuffer::scale(self : SortcomparequickBuffer, f : Double) -> SortcomparequickBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickBuffer::add(self : SortcomparequickBuffer, other : SortcomparequickBuffer) -> SortcomparequickBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickBuffer::copy(self : SortcomparequickBuffer) -> SortcomparequickBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickBuffer::fill(self : SortcomparequickBuffer, v : Double) -> SortcomparequickBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickBuffer::min(self : SortcomparequickBuffer) -> Double { @_common.min(self.data) }

pub fn SortcomparequickBuffer::max(self : SortcomparequickBuffer) -> Double { @_common.max(self.data) }

pub fn SortcomparequickBuffer::to_string(self : SortcomparequickBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_cursor_make(size : Int) -> SortcomparequickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickCursor::len(self : SortcomparequickCursor) -> Int { self.size }

pub fn SortcomparequickCursor::get(self : SortcomparequickCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickCursor::set(self : SortcomparequickCursor, i : Int, v : Double) -> SortcomparequickCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickCursor::sum(self : SortcomparequickCursor) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickCursor::mean(self : SortcomparequickCursor) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickCursor::scale(self : SortcomparequickCursor, f : Double) -> SortcomparequickCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickCursor::add(self : SortcomparequickCursor, other : SortcomparequickCursor) -> SortcomparequickCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickCursor::copy(self : SortcomparequickCursor) -> SortcomparequickCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickCursor::fill(self : SortcomparequickCursor, v : Double) -> SortcomparequickCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickCursor::min(self : SortcomparequickCursor) -> Double { @_common.min(self.data) }

pub fn SortcomparequickCursor::max(self : SortcomparequickCursor) -> Double { @_common.max(self.data) }

pub fn SortcomparequickCursor::to_string(self : SortcomparequickCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_view_make(size : Int) -> SortcomparequickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickView::len(self : SortcomparequickView) -> Int { self.size }

pub fn SortcomparequickView::get(self : SortcomparequickView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickView::set(self : SortcomparequickView, i : Int, v : Double) -> SortcomparequickView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickView::sum(self : SortcomparequickView) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickView::mean(self : SortcomparequickView) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickView::scale(self : SortcomparequickView, f : Double) -> SortcomparequickView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickView::add(self : SortcomparequickView, other : SortcomparequickView) -> SortcomparequickView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickView::copy(self : SortcomparequickView) -> SortcomparequickView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickView::fill(self : SortcomparequickView, v : Double) -> SortcomparequickView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickView::min(self : SortcomparequickView) -> Double { @_common.min(self.data) }

pub fn SortcomparequickView::max(self : SortcomparequickView) -> Double { @_common.max(self.data) }

pub fn SortcomparequickView::to_string(self : SortcomparequickView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_range_make(size : Int) -> SortcomparequickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickRange::len(self : SortcomparequickRange) -> Int { self.size }

pub fn SortcomparequickRange::get(self : SortcomparequickRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickRange::set(self : SortcomparequickRange, i : Int, v : Double) -> SortcomparequickRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickRange::sum(self : SortcomparequickRange) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickRange::mean(self : SortcomparequickRange) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickRange::scale(self : SortcomparequickRange, f : Double) -> SortcomparequickRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickRange::add(self : SortcomparequickRange, other : SortcomparequickRange) -> SortcomparequickRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickRange::copy(self : SortcomparequickRange) -> SortcomparequickRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickRange::fill(self : SortcomparequickRange, v : Double) -> SortcomparequickRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickRange::min(self : SortcomparequickRange) -> Double { @_common.min(self.data) }

pub fn SortcomparequickRange::max(self : SortcomparequickRange) -> Double { @_common.max(self.data) }

pub fn SortcomparequickRange::to_string(self : SortcomparequickRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparequickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_slice_make(size : Int) -> SortcomparequickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparequickSlice::len(self : SortcomparequickSlice) -> Int { self.size }

pub fn SortcomparequickSlice::get(self : SortcomparequickSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparequickSlice::set(self : SortcomparequickSlice, i : Int, v : Double) -> SortcomparequickSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparequickSlice::sum(self : SortcomparequickSlice) -> Double { @_common.sum(self.data) }

pub fn SortcomparequickSlice::mean(self : SortcomparequickSlice) -> Double { @_common.mean(self.data) }

pub fn SortcomparequickSlice::scale(self : SortcomparequickSlice, f : Double) -> SortcomparequickSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparequickSlice::add(self : SortcomparequickSlice, other : SortcomparequickSlice) -> SortcomparequickSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparequickSlice::copy(self : SortcomparequickSlice) -> SortcomparequickSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparequickSlice::fill(self : SortcomparequickSlice, v : Double) -> SortcomparequickSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparequickSlice::min(self : SortcomparequickSlice) -> Double { @_common.min(self.data) }

pub fn SortcomparequickSlice::max(self : SortcomparequickSlice) -> Double { @_common.max(self.data) }

pub fn SortcomparequickSlice::to_string(self : SortcomparequickSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

