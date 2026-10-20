///===
/// extcore/sort_compare_heap

pub(all) struct SortcompareheapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_heap_make_point(x : Double, y : Double) -> SortcompareheapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_heap_make_point3(x : Double, y : Double, z : Double) -> SortcompareheapPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareheapPoint::x(self : SortcompareheapPoint) -> Double { self.x }

pub fn SortcompareheapPoint::y(self : SortcompareheapPoint) -> Double { self.y }

pub fn SortcompareheapPoint::z(self : SortcompareheapPoint) -> Double { self.z }

pub fn SortcompareheapPoint::label(self : SortcompareheapPoint) -> Int { self.label }

pub fn SortcompareheapPoint::dist(self : SortcompareheapPoint, other : SortcompareheapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareheapPoint::add(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareheapPoint::sub(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareheapPoint::scale(self : SortcompareheapPoint, s : Double) -> SortcompareheapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareheapPoint::dot(self : SortcompareheapPoint, other : SortcompareheapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareheapPoint::cross(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareheapPoint::norm(self : SortcompareheapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareheapPoint::normalize(self : SortcompareheapPoint) -> SortcompareheapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareheapPoint::negate(self : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareheapPoint::mid(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareheapPoint::lerp(self : SortcompareheapPoint, other : SortcompareheapPoint, t : Double) -> SortcompareheapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareheapPoint::to_string(self : SortcompareheapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareheapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_heap_make_series(vals : Array[Double], name : String) -> SortcompareheapSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareheapSeries::len(self : SortcompareheapSeries) -> Int { self.vals.length() }

pub fn SortcompareheapSeries::sum(self : SortcompareheapSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareheapSeries::mean(self : SortcompareheapSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareheapSeries::min(self : SortcompareheapSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareheapSeries::max(self : SortcompareheapSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareheapSeries::range(self : SortcompareheapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareheapSeries::variance(self : SortcompareheapSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareheapSeries::std(self : SortcompareheapSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareheapSeries::median(self : SortcompareheapSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareheapSeries::scale(self : SortcompareheapSeries, f : Double) -> SortcompareheapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareheapSeries::add(self : SortcompareheapSeries, other : SortcompareheapSeries) -> SortcompareheapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareheapSeries::sub(self : SortcompareheapSeries, other : SortcompareheapSeries) -> SortcompareheapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareheapSeries::normalize(self : SortcompareheapSeries) -> SortcompareheapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareheapSeries::cumsum(self : SortcompareheapSeries) -> SortcompareheapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareheapSeries::to_string(self : SortcompareheapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareheapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_heap_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareheapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_heap_matrix_identity(n : Int) -> SortcompareheapMatrix {
  let m = sort_compare_heap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareheapMatrix::get(self : SortcompareheapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareheapMatrix::transpose(self : SortcompareheapMatrix) -> SortcompareheapMatrix {
  let result = sort_compare_heap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareheapMatrix::add(self : SortcompareheapMatrix, other : SortcompareheapMatrix) -> SortcompareheapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_heap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareheapMatrix::scale(self : SortcompareheapMatrix, s : Double) -> SortcompareheapMatrix {
  let result = sort_compare_heap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareheapMatrix::multiply(self : SortcompareheapMatrix, other : SortcompareheapMatrix) -> SortcompareheapMatrix {
  if self.cols != other.rows { return sort_compare_heap_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_heap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcompareheapMatrix::trace(self : SortcompareheapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareheapMatrix::det(self : SortcompareheapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareheapMatrix::norm(self : SortcompareheapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareheapMatrix::to_string(self : SortcompareheapMatrix) -> String {
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

pub(all) struct SortcompareheapVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_heap_make_vector(comps : Array[Double]) -> SortcompareheapVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_heap_vector_zero(dim : Int) -> SortcompareheapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareheapVector::add(self : SortcompareheapVector, other : SortcompareheapVector) -> SortcompareheapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareheapVector::sub(self : SortcompareheapVector, other : SortcompareheapVector) -> SortcompareheapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareheapVector::scale(self : SortcompareheapVector, s : Double) -> SortcompareheapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareheapVector::dot(self : SortcompareheapVector, other : SortcompareheapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareheapVector::norm(self : SortcompareheapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareheapVector::normalize(self : SortcompareheapVector) -> SortcompareheapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareheapVector::dist(self : SortcompareheapVector, other : SortcompareheapVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareheapVector::to_string(self : SortcompareheapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareheapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_frame_make(size : Int) -> SortcompareheapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapFrame::len(self : SortcompareheapFrame) -> Int { self.size }

pub fn SortcompareheapFrame::get(self : SortcompareheapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapFrame::set(self : SortcompareheapFrame, i : Int, v : Double) -> SortcompareheapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapFrame::sum(self : SortcompareheapFrame) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapFrame::mean(self : SortcompareheapFrame) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapFrame::scale(self : SortcompareheapFrame, f : Double) -> SortcompareheapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapFrame::add(self : SortcompareheapFrame, other : SortcompareheapFrame) -> SortcompareheapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapFrame::copy(self : SortcompareheapFrame) -> SortcompareheapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapFrame::fill(self : SortcompareheapFrame, v : Double) -> SortcompareheapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapFrame::min(self : SortcompareheapFrame) -> Double { @_common.min(self.data) }

pub fn SortcompareheapFrame::max(self : SortcompareheapFrame) -> Double { @_common.max(self.data) }

pub fn SortcompareheapFrame::to_string(self : SortcompareheapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_table_make(size : Int) -> SortcompareheapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapTable::len(self : SortcompareheapTable) -> Int { self.size }

pub fn SortcompareheapTable::get(self : SortcompareheapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapTable::set(self : SortcompareheapTable, i : Int, v : Double) -> SortcompareheapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapTable::sum(self : SortcompareheapTable) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapTable::mean(self : SortcompareheapTable) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapTable::scale(self : SortcompareheapTable, f : Double) -> SortcompareheapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapTable::add(self : SortcompareheapTable, other : SortcompareheapTable) -> SortcompareheapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapTable::copy(self : SortcompareheapTable) -> SortcompareheapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapTable::fill(self : SortcompareheapTable, v : Double) -> SortcompareheapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapTable::min(self : SortcompareheapTable) -> Double { @_common.min(self.data) }

pub fn SortcompareheapTable::max(self : SortcompareheapTable) -> Double { @_common.max(self.data) }

pub fn SortcompareheapTable::to_string(self : SortcompareheapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_graphn_make(size : Int) -> SortcompareheapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapGraphN::len(self : SortcompareheapGraphN) -> Int { self.size }

pub fn SortcompareheapGraphN::get(self : SortcompareheapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapGraphN::set(self : SortcompareheapGraphN, i : Int, v : Double) -> SortcompareheapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapGraphN::sum(self : SortcompareheapGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapGraphN::mean(self : SortcompareheapGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapGraphN::scale(self : SortcompareheapGraphN, f : Double) -> SortcompareheapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapGraphN::add(self : SortcompareheapGraphN, other : SortcompareheapGraphN) -> SortcompareheapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapGraphN::copy(self : SortcompareheapGraphN) -> SortcompareheapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapGraphN::fill(self : SortcompareheapGraphN, v : Double) -> SortcompareheapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapGraphN::min(self : SortcompareheapGraphN) -> Double { @_common.min(self.data) }

pub fn SortcompareheapGraphN::max(self : SortcompareheapGraphN) -> Double { @_common.max(self.data) }

pub fn SortcompareheapGraphN::to_string(self : SortcompareheapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_node_make(size : Int) -> SortcompareheapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapNode::len(self : SortcompareheapNode) -> Int { self.size }

pub fn SortcompareheapNode::get(self : SortcompareheapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapNode::set(self : SortcompareheapNode, i : Int, v : Double) -> SortcompareheapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapNode::sum(self : SortcompareheapNode) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapNode::mean(self : SortcompareheapNode) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapNode::scale(self : SortcompareheapNode, f : Double) -> SortcompareheapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapNode::add(self : SortcompareheapNode, other : SortcompareheapNode) -> SortcompareheapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapNode::copy(self : SortcompareheapNode) -> SortcompareheapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapNode::fill(self : SortcompareheapNode, v : Double) -> SortcompareheapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapNode::min(self : SortcompareheapNode) -> Double { @_common.min(self.data) }

pub fn SortcompareheapNode::max(self : SortcompareheapNode) -> Double { @_common.max(self.data) }

pub fn SortcompareheapNode::to_string(self : SortcompareheapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_edge_make(size : Int) -> SortcompareheapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapEdge::len(self : SortcompareheapEdge) -> Int { self.size }

pub fn SortcompareheapEdge::get(self : SortcompareheapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapEdge::set(self : SortcompareheapEdge, i : Int, v : Double) -> SortcompareheapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapEdge::sum(self : SortcompareheapEdge) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapEdge::mean(self : SortcompareheapEdge) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapEdge::scale(self : SortcompareheapEdge, f : Double) -> SortcompareheapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapEdge::add(self : SortcompareheapEdge, other : SortcompareheapEdge) -> SortcompareheapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapEdge::copy(self : SortcompareheapEdge) -> SortcompareheapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapEdge::fill(self : SortcompareheapEdge, v : Double) -> SortcompareheapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapEdge::min(self : SortcompareheapEdge) -> Double { @_common.min(self.data) }

pub fn SortcompareheapEdge::max(self : SortcompareheapEdge) -> Double { @_common.max(self.data) }

pub fn SortcompareheapEdge::to_string(self : SortcompareheapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_path_make(size : Int) -> SortcompareheapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapPath::len(self : SortcompareheapPath) -> Int { self.size }

pub fn SortcompareheapPath::get(self : SortcompareheapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapPath::set(self : SortcompareheapPath, i : Int, v : Double) -> SortcompareheapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapPath::sum(self : SortcompareheapPath) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapPath::mean(self : SortcompareheapPath) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapPath::scale(self : SortcompareheapPath, f : Double) -> SortcompareheapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapPath::add(self : SortcompareheapPath, other : SortcompareheapPath) -> SortcompareheapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapPath::copy(self : SortcompareheapPath) -> SortcompareheapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapPath::fill(self : SortcompareheapPath, v : Double) -> SortcompareheapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapPath::min(self : SortcompareheapPath) -> Double { @_common.min(self.data) }

pub fn SortcompareheapPath::max(self : SortcompareheapPath) -> Double { @_common.max(self.data) }

pub fn SortcompareheapPath::to_string(self : SortcompareheapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_cluster_make(size : Int) -> SortcompareheapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapCluster::len(self : SortcompareheapCluster) -> Int { self.size }

pub fn SortcompareheapCluster::get(self : SortcompareheapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapCluster::set(self : SortcompareheapCluster, i : Int, v : Double) -> SortcompareheapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapCluster::sum(self : SortcompareheapCluster) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapCluster::mean(self : SortcompareheapCluster) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapCluster::scale(self : SortcompareheapCluster, f : Double) -> SortcompareheapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapCluster::add(self : SortcompareheapCluster, other : SortcompareheapCluster) -> SortcompareheapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapCluster::copy(self : SortcompareheapCluster) -> SortcompareheapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapCluster::fill(self : SortcompareheapCluster, v : Double) -> SortcompareheapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapCluster::min(self : SortcompareheapCluster) -> Double { @_common.min(self.data) }

pub fn SortcompareheapCluster::max(self : SortcompareheapCluster) -> Double { @_common.max(self.data) }

pub fn SortcompareheapCluster::to_string(self : SortcompareheapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_model_make(size : Int) -> SortcompareheapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapModel::len(self : SortcompareheapModel) -> Int { self.size }

pub fn SortcompareheapModel::get(self : SortcompareheapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapModel::set(self : SortcompareheapModel, i : Int, v : Double) -> SortcompareheapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapModel::sum(self : SortcompareheapModel) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapModel::mean(self : SortcompareheapModel) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapModel::scale(self : SortcompareheapModel, f : Double) -> SortcompareheapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapModel::add(self : SortcompareheapModel, other : SortcompareheapModel) -> SortcompareheapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapModel::copy(self : SortcompareheapModel) -> SortcompareheapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapModel::fill(self : SortcompareheapModel, v : Double) -> SortcompareheapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapModel::min(self : SortcompareheapModel) -> Double { @_common.min(self.data) }

pub fn SortcompareheapModel::max(self : SortcompareheapModel) -> Double { @_common.max(self.data) }

pub fn SortcompareheapModel::to_string(self : SortcompareheapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_layer_make(size : Int) -> SortcompareheapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapLayer::len(self : SortcompareheapLayer) -> Int { self.size }

pub fn SortcompareheapLayer::get(self : SortcompareheapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapLayer::set(self : SortcompareheapLayer, i : Int, v : Double) -> SortcompareheapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapLayer::sum(self : SortcompareheapLayer) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapLayer::mean(self : SortcompareheapLayer) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapLayer::scale(self : SortcompareheapLayer, f : Double) -> SortcompareheapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapLayer::add(self : SortcompareheapLayer, other : SortcompareheapLayer) -> SortcompareheapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapLayer::copy(self : SortcompareheapLayer) -> SortcompareheapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapLayer::fill(self : SortcompareheapLayer, v : Double) -> SortcompareheapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapLayer::min(self : SortcompareheapLayer) -> Double { @_common.min(self.data) }

pub fn SortcompareheapLayer::max(self : SortcompareheapLayer) -> Double { @_common.max(self.data) }

pub fn SortcompareheapLayer::to_string(self : SortcompareheapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_buffer_make(size : Int) -> SortcompareheapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapBuffer::len(self : SortcompareheapBuffer) -> Int { self.size }

pub fn SortcompareheapBuffer::get(self : SortcompareheapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapBuffer::set(self : SortcompareheapBuffer, i : Int, v : Double) -> SortcompareheapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapBuffer::sum(self : SortcompareheapBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapBuffer::mean(self : SortcompareheapBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapBuffer::scale(self : SortcompareheapBuffer, f : Double) -> SortcompareheapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapBuffer::add(self : SortcompareheapBuffer, other : SortcompareheapBuffer) -> SortcompareheapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapBuffer::copy(self : SortcompareheapBuffer) -> SortcompareheapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapBuffer::fill(self : SortcompareheapBuffer, v : Double) -> SortcompareheapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapBuffer::min(self : SortcompareheapBuffer) -> Double { @_common.min(self.data) }

pub fn SortcompareheapBuffer::max(self : SortcompareheapBuffer) -> Double { @_common.max(self.data) }

pub fn SortcompareheapBuffer::to_string(self : SortcompareheapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_cursor_make(size : Int) -> SortcompareheapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapCursor::len(self : SortcompareheapCursor) -> Int { self.size }

pub fn SortcompareheapCursor::get(self : SortcompareheapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapCursor::set(self : SortcompareheapCursor, i : Int, v : Double) -> SortcompareheapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapCursor::sum(self : SortcompareheapCursor) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapCursor::mean(self : SortcompareheapCursor) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapCursor::scale(self : SortcompareheapCursor, f : Double) -> SortcompareheapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapCursor::add(self : SortcompareheapCursor, other : SortcompareheapCursor) -> SortcompareheapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapCursor::copy(self : SortcompareheapCursor) -> SortcompareheapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapCursor::fill(self : SortcompareheapCursor, v : Double) -> SortcompareheapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapCursor::min(self : SortcompareheapCursor) -> Double { @_common.min(self.data) }

pub fn SortcompareheapCursor::max(self : SortcompareheapCursor) -> Double { @_common.max(self.data) }

pub fn SortcompareheapCursor::to_string(self : SortcompareheapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_view_make(size : Int) -> SortcompareheapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapView::len(self : SortcompareheapView) -> Int { self.size }

pub fn SortcompareheapView::get(self : SortcompareheapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapView::set(self : SortcompareheapView, i : Int, v : Double) -> SortcompareheapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapView::sum(self : SortcompareheapView) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapView::mean(self : SortcompareheapView) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapView::scale(self : SortcompareheapView, f : Double) -> SortcompareheapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapView::add(self : SortcompareheapView, other : SortcompareheapView) -> SortcompareheapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapView::copy(self : SortcompareheapView) -> SortcompareheapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapView::fill(self : SortcompareheapView, v : Double) -> SortcompareheapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapView::min(self : SortcompareheapView) -> Double { @_common.min(self.data) }

pub fn SortcompareheapView::max(self : SortcompareheapView) -> Double { @_common.max(self.data) }

pub fn SortcompareheapView::to_string(self : SortcompareheapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_range_make(size : Int) -> SortcompareheapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapRange::len(self : SortcompareheapRange) -> Int { self.size }

pub fn SortcompareheapRange::get(self : SortcompareheapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapRange::set(self : SortcompareheapRange, i : Int, v : Double) -> SortcompareheapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapRange::sum(self : SortcompareheapRange) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapRange::mean(self : SortcompareheapRange) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapRange::scale(self : SortcompareheapRange, f : Double) -> SortcompareheapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapRange::add(self : SortcompareheapRange, other : SortcompareheapRange) -> SortcompareheapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapRange::copy(self : SortcompareheapRange) -> SortcompareheapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapRange::fill(self : SortcompareheapRange, v : Double) -> SortcompareheapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapRange::min(self : SortcompareheapRange) -> Double { @_common.min(self.data) }

pub fn SortcompareheapRange::max(self : SortcompareheapRange) -> Double { @_common.max(self.data) }

pub fn SortcompareheapRange::to_string(self : SortcompareheapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareheapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_slice_make(size : Int) -> SortcompareheapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareheapSlice::len(self : SortcompareheapSlice) -> Int { self.size }

pub fn SortcompareheapSlice::get(self : SortcompareheapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareheapSlice::set(self : SortcompareheapSlice, i : Int, v : Double) -> SortcompareheapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareheapSlice::sum(self : SortcompareheapSlice) -> Double { @_common.sum(self.data) }

pub fn SortcompareheapSlice::mean(self : SortcompareheapSlice) -> Double { @_common.mean(self.data) }

pub fn SortcompareheapSlice::scale(self : SortcompareheapSlice, f : Double) -> SortcompareheapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareheapSlice::add(self : SortcompareheapSlice, other : SortcompareheapSlice) -> SortcompareheapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareheapSlice::copy(self : SortcompareheapSlice) -> SortcompareheapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareheapSlice::fill(self : SortcompareheapSlice, v : Double) -> SortcompareheapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareheapSlice::min(self : SortcompareheapSlice) -> Double { @_common.min(self.data) }

pub fn SortcompareheapSlice::max(self : SortcompareheapSlice) -> Double { @_common.max(self.data) }

pub fn SortcompareheapSlice::to_string(self : SortcompareheapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

