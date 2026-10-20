///===
/// extcore/sort_compare_bubble

pub(all) struct SortcomparebubblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_bubble_make_point(x : Double, y : Double) -> SortcomparebubblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_bubble_make_point3(x : Double, y : Double, z : Double) -> SortcomparebubblePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparebubblePoint::x(self : SortcomparebubblePoint) -> Double { self.x }

pub fn SortcomparebubblePoint::y(self : SortcomparebubblePoint) -> Double { self.y }

pub fn SortcomparebubblePoint::z(self : SortcomparebubblePoint) -> Double { self.z }

pub fn SortcomparebubblePoint::label(self : SortcomparebubblePoint) -> Int { self.label }

pub fn SortcomparebubblePoint::dist(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparebubblePoint::add(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparebubblePoint::sub(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparebubblePoint::scale(self : SortcomparebubblePoint, s : Double) -> SortcomparebubblePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparebubblePoint::dot(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparebubblePoint::cross(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparebubblePoint::norm(self : SortcomparebubblePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparebubblePoint::normalize(self : SortcomparebubblePoint) -> SortcomparebubblePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparebubblePoint::negate(self : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparebubblePoint::mid(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparebubblePoint::lerp(self : SortcomparebubblePoint, other : SortcomparebubblePoint, t : Double) -> SortcomparebubblePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparebubblePoint::to_string(self : SortcomparebubblePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparebubbleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_bubble_make_series(vals : Array[Double], name : String) -> SortcomparebubbleSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparebubbleSeries::len(self : SortcomparebubbleSeries) -> Int { self.vals.length() }

pub fn SortcomparebubbleSeries::sum(self : SortcomparebubbleSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparebubbleSeries::mean(self : SortcomparebubbleSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparebubbleSeries::min(self : SortcomparebubbleSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparebubbleSeries::max(self : SortcomparebubbleSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparebubbleSeries::range(self : SortcomparebubbleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparebubbleSeries::variance(self : SortcomparebubbleSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparebubbleSeries::std(self : SortcomparebubbleSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparebubbleSeries::median(self : SortcomparebubbleSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparebubbleSeries::scale(self : SortcomparebubbleSeries, f : Double) -> SortcomparebubbleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparebubbleSeries::add(self : SortcomparebubbleSeries, other : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparebubbleSeries::sub(self : SortcomparebubbleSeries, other : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparebubbleSeries::normalize(self : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparebubbleSeries::cumsum(self : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparebubbleSeries::to_string(self : SortcomparebubbleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparebubbleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_bubble_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparebubbleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_bubble_matrix_identity(n : Int) -> SortcomparebubbleMatrix {
  let m = sort_compare_bubble_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparebubbleMatrix::get(self : SortcomparebubbleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparebubbleMatrix::transpose(self : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  let result = sort_compare_bubble_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparebubbleMatrix::add(self : SortcomparebubbleMatrix, other : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_bubble_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparebubbleMatrix::scale(self : SortcomparebubbleMatrix, s : Double) -> SortcomparebubbleMatrix {
  let result = sort_compare_bubble_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparebubbleMatrix::multiply(self : SortcomparebubbleMatrix, other : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  if self.cols != other.rows { return sort_compare_bubble_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_bubble_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparebubbleMatrix::trace(self : SortcomparebubbleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparebubbleMatrix::det(self : SortcomparebubbleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparebubbleMatrix::norm(self : SortcomparebubbleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparebubbleMatrix::to_string(self : SortcomparebubbleMatrix) -> String {
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

pub(all) struct SortcomparebubbleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_bubble_make_vector(comps : Array[Double]) -> SortcomparebubbleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_bubble_vector_zero(dim : Int) -> SortcomparebubbleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparebubbleVector::add(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparebubbleVector::sub(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparebubbleVector::scale(self : SortcomparebubbleVector, s : Double) -> SortcomparebubbleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparebubbleVector::dot(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparebubbleVector::norm(self : SortcomparebubbleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparebubbleVector::normalize(self : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparebubbleVector::dist(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparebubbleVector::to_string(self : SortcomparebubbleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparebubbleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_frame_make(size : Int) -> SortcomparebubbleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleFrame::len(self : SortcomparebubbleFrame) -> Int { self.size }

pub fn SortcomparebubbleFrame::get(self : SortcomparebubbleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleFrame::set(self : SortcomparebubbleFrame, i : Int, v : Double) -> SortcomparebubbleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleFrame::sum(self : SortcomparebubbleFrame) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleFrame::mean(self : SortcomparebubbleFrame) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleFrame::scale(self : SortcomparebubbleFrame, f : Double) -> SortcomparebubbleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleFrame::add(self : SortcomparebubbleFrame, other : SortcomparebubbleFrame) -> SortcomparebubbleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleFrame::copy(self : SortcomparebubbleFrame) -> SortcomparebubbleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleFrame::fill(self : SortcomparebubbleFrame, v : Double) -> SortcomparebubbleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleFrame::min(self : SortcomparebubbleFrame) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleFrame::max(self : SortcomparebubbleFrame) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleFrame::to_string(self : SortcomparebubbleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_table_make(size : Int) -> SortcomparebubbleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleTable::len(self : SortcomparebubbleTable) -> Int { self.size }

pub fn SortcomparebubbleTable::get(self : SortcomparebubbleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleTable::set(self : SortcomparebubbleTable, i : Int, v : Double) -> SortcomparebubbleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleTable::sum(self : SortcomparebubbleTable) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleTable::mean(self : SortcomparebubbleTable) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleTable::scale(self : SortcomparebubbleTable, f : Double) -> SortcomparebubbleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleTable::add(self : SortcomparebubbleTable, other : SortcomparebubbleTable) -> SortcomparebubbleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleTable::copy(self : SortcomparebubbleTable) -> SortcomparebubbleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleTable::fill(self : SortcomparebubbleTable, v : Double) -> SortcomparebubbleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleTable::min(self : SortcomparebubbleTable) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleTable::max(self : SortcomparebubbleTable) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleTable::to_string(self : SortcomparebubbleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_graphn_make(size : Int) -> SortcomparebubbleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleGraphN::len(self : SortcomparebubbleGraphN) -> Int { self.size }

pub fn SortcomparebubbleGraphN::get(self : SortcomparebubbleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleGraphN::set(self : SortcomparebubbleGraphN, i : Int, v : Double) -> SortcomparebubbleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleGraphN::sum(self : SortcomparebubbleGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleGraphN::mean(self : SortcomparebubbleGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleGraphN::scale(self : SortcomparebubbleGraphN, f : Double) -> SortcomparebubbleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleGraphN::add(self : SortcomparebubbleGraphN, other : SortcomparebubbleGraphN) -> SortcomparebubbleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleGraphN::copy(self : SortcomparebubbleGraphN) -> SortcomparebubbleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleGraphN::fill(self : SortcomparebubbleGraphN, v : Double) -> SortcomparebubbleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleGraphN::min(self : SortcomparebubbleGraphN) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleGraphN::max(self : SortcomparebubbleGraphN) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleGraphN::to_string(self : SortcomparebubbleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_node_make(size : Int) -> SortcomparebubbleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleNode::len(self : SortcomparebubbleNode) -> Int { self.size }

pub fn SortcomparebubbleNode::get(self : SortcomparebubbleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleNode::set(self : SortcomparebubbleNode, i : Int, v : Double) -> SortcomparebubbleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleNode::sum(self : SortcomparebubbleNode) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleNode::mean(self : SortcomparebubbleNode) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleNode::scale(self : SortcomparebubbleNode, f : Double) -> SortcomparebubbleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleNode::add(self : SortcomparebubbleNode, other : SortcomparebubbleNode) -> SortcomparebubbleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleNode::copy(self : SortcomparebubbleNode) -> SortcomparebubbleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleNode::fill(self : SortcomparebubbleNode, v : Double) -> SortcomparebubbleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleNode::min(self : SortcomparebubbleNode) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleNode::max(self : SortcomparebubbleNode) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleNode::to_string(self : SortcomparebubbleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_edge_make(size : Int) -> SortcomparebubbleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleEdge::len(self : SortcomparebubbleEdge) -> Int { self.size }

pub fn SortcomparebubbleEdge::get(self : SortcomparebubbleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleEdge::set(self : SortcomparebubbleEdge, i : Int, v : Double) -> SortcomparebubbleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleEdge::sum(self : SortcomparebubbleEdge) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleEdge::mean(self : SortcomparebubbleEdge) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleEdge::scale(self : SortcomparebubbleEdge, f : Double) -> SortcomparebubbleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleEdge::add(self : SortcomparebubbleEdge, other : SortcomparebubbleEdge) -> SortcomparebubbleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleEdge::copy(self : SortcomparebubbleEdge) -> SortcomparebubbleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleEdge::fill(self : SortcomparebubbleEdge, v : Double) -> SortcomparebubbleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleEdge::min(self : SortcomparebubbleEdge) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleEdge::max(self : SortcomparebubbleEdge) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleEdge::to_string(self : SortcomparebubbleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_path_make(size : Int) -> SortcomparebubblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubblePath::len(self : SortcomparebubblePath) -> Int { self.size }

pub fn SortcomparebubblePath::get(self : SortcomparebubblePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubblePath::set(self : SortcomparebubblePath, i : Int, v : Double) -> SortcomparebubblePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubblePath::sum(self : SortcomparebubblePath) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubblePath::mean(self : SortcomparebubblePath) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubblePath::scale(self : SortcomparebubblePath, f : Double) -> SortcomparebubblePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubblePath::add(self : SortcomparebubblePath, other : SortcomparebubblePath) -> SortcomparebubblePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubblePath::copy(self : SortcomparebubblePath) -> SortcomparebubblePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubblePath::fill(self : SortcomparebubblePath, v : Double) -> SortcomparebubblePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubblePath::min(self : SortcomparebubblePath) -> Double { @_common.min(self.data) }

pub fn SortcomparebubblePath::max(self : SortcomparebubblePath) -> Double { @_common.max(self.data) }

pub fn SortcomparebubblePath::to_string(self : SortcomparebubblePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_cluster_make(size : Int) -> SortcomparebubbleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleCluster::len(self : SortcomparebubbleCluster) -> Int { self.size }

pub fn SortcomparebubbleCluster::get(self : SortcomparebubbleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleCluster::set(self : SortcomparebubbleCluster, i : Int, v : Double) -> SortcomparebubbleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCluster::sum(self : SortcomparebubbleCluster) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleCluster::mean(self : SortcomparebubbleCluster) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleCluster::scale(self : SortcomparebubbleCluster, f : Double) -> SortcomparebubbleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCluster::add(self : SortcomparebubbleCluster, other : SortcomparebubbleCluster) -> SortcomparebubbleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleCluster::copy(self : SortcomparebubbleCluster) -> SortcomparebubbleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCluster::fill(self : SortcomparebubbleCluster, v : Double) -> SortcomparebubbleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCluster::min(self : SortcomparebubbleCluster) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleCluster::max(self : SortcomparebubbleCluster) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleCluster::to_string(self : SortcomparebubbleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_model_make(size : Int) -> SortcomparebubbleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleModel::len(self : SortcomparebubbleModel) -> Int { self.size }

pub fn SortcomparebubbleModel::get(self : SortcomparebubbleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleModel::set(self : SortcomparebubbleModel, i : Int, v : Double) -> SortcomparebubbleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleModel::sum(self : SortcomparebubbleModel) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleModel::mean(self : SortcomparebubbleModel) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleModel::scale(self : SortcomparebubbleModel, f : Double) -> SortcomparebubbleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleModel::add(self : SortcomparebubbleModel, other : SortcomparebubbleModel) -> SortcomparebubbleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleModel::copy(self : SortcomparebubbleModel) -> SortcomparebubbleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleModel::fill(self : SortcomparebubbleModel, v : Double) -> SortcomparebubbleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleModel::min(self : SortcomparebubbleModel) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleModel::max(self : SortcomparebubbleModel) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleModel::to_string(self : SortcomparebubbleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_layer_make(size : Int) -> SortcomparebubbleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleLayer::len(self : SortcomparebubbleLayer) -> Int { self.size }

pub fn SortcomparebubbleLayer::get(self : SortcomparebubbleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleLayer::set(self : SortcomparebubbleLayer, i : Int, v : Double) -> SortcomparebubbleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleLayer::sum(self : SortcomparebubbleLayer) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleLayer::mean(self : SortcomparebubbleLayer) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleLayer::scale(self : SortcomparebubbleLayer, f : Double) -> SortcomparebubbleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleLayer::add(self : SortcomparebubbleLayer, other : SortcomparebubbleLayer) -> SortcomparebubbleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleLayer::copy(self : SortcomparebubbleLayer) -> SortcomparebubbleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleLayer::fill(self : SortcomparebubbleLayer, v : Double) -> SortcomparebubbleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleLayer::min(self : SortcomparebubbleLayer) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleLayer::max(self : SortcomparebubbleLayer) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleLayer::to_string(self : SortcomparebubbleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_buffer_make(size : Int) -> SortcomparebubbleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleBuffer::len(self : SortcomparebubbleBuffer) -> Int { self.size }

pub fn SortcomparebubbleBuffer::get(self : SortcomparebubbleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleBuffer::set(self : SortcomparebubbleBuffer, i : Int, v : Double) -> SortcomparebubbleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleBuffer::sum(self : SortcomparebubbleBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleBuffer::mean(self : SortcomparebubbleBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleBuffer::scale(self : SortcomparebubbleBuffer, f : Double) -> SortcomparebubbleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleBuffer::add(self : SortcomparebubbleBuffer, other : SortcomparebubbleBuffer) -> SortcomparebubbleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleBuffer::copy(self : SortcomparebubbleBuffer) -> SortcomparebubbleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleBuffer::fill(self : SortcomparebubbleBuffer, v : Double) -> SortcomparebubbleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleBuffer::min(self : SortcomparebubbleBuffer) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleBuffer::max(self : SortcomparebubbleBuffer) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleBuffer::to_string(self : SortcomparebubbleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_cursor_make(size : Int) -> SortcomparebubbleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleCursor::len(self : SortcomparebubbleCursor) -> Int { self.size }

pub fn SortcomparebubbleCursor::get(self : SortcomparebubbleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleCursor::set(self : SortcomparebubbleCursor, i : Int, v : Double) -> SortcomparebubbleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCursor::sum(self : SortcomparebubbleCursor) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleCursor::mean(self : SortcomparebubbleCursor) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleCursor::scale(self : SortcomparebubbleCursor, f : Double) -> SortcomparebubbleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCursor::add(self : SortcomparebubbleCursor, other : SortcomparebubbleCursor) -> SortcomparebubbleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleCursor::copy(self : SortcomparebubbleCursor) -> SortcomparebubbleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCursor::fill(self : SortcomparebubbleCursor, v : Double) -> SortcomparebubbleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleCursor::min(self : SortcomparebubbleCursor) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleCursor::max(self : SortcomparebubbleCursor) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleCursor::to_string(self : SortcomparebubbleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_view_make(size : Int) -> SortcomparebubbleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleView::len(self : SortcomparebubbleView) -> Int { self.size }

pub fn SortcomparebubbleView::get(self : SortcomparebubbleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleView::set(self : SortcomparebubbleView, i : Int, v : Double) -> SortcomparebubbleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleView::sum(self : SortcomparebubbleView) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleView::mean(self : SortcomparebubbleView) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleView::scale(self : SortcomparebubbleView, f : Double) -> SortcomparebubbleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleView::add(self : SortcomparebubbleView, other : SortcomparebubbleView) -> SortcomparebubbleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleView::copy(self : SortcomparebubbleView) -> SortcomparebubbleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleView::fill(self : SortcomparebubbleView, v : Double) -> SortcomparebubbleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleView::min(self : SortcomparebubbleView) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleView::max(self : SortcomparebubbleView) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleView::to_string(self : SortcomparebubbleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_range_make(size : Int) -> SortcomparebubbleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleRange::len(self : SortcomparebubbleRange) -> Int { self.size }

pub fn SortcomparebubbleRange::get(self : SortcomparebubbleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleRange::set(self : SortcomparebubbleRange, i : Int, v : Double) -> SortcomparebubbleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleRange::sum(self : SortcomparebubbleRange) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleRange::mean(self : SortcomparebubbleRange) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleRange::scale(self : SortcomparebubbleRange, f : Double) -> SortcomparebubbleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleRange::add(self : SortcomparebubbleRange, other : SortcomparebubbleRange) -> SortcomparebubbleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleRange::copy(self : SortcomparebubbleRange) -> SortcomparebubbleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleRange::fill(self : SortcomparebubbleRange, v : Double) -> SortcomparebubbleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleRange::min(self : SortcomparebubbleRange) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleRange::max(self : SortcomparebubbleRange) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleRange::to_string(self : SortcomparebubbleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_slice_make(size : Int) -> SortcomparebubbleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparebubbleSlice::len(self : SortcomparebubbleSlice) -> Int { self.size }

pub fn SortcomparebubbleSlice::get(self : SortcomparebubbleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparebubbleSlice::set(self : SortcomparebubbleSlice, i : Int, v : Double) -> SortcomparebubbleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleSlice::sum(self : SortcomparebubbleSlice) -> Double { @_common.sum(self.data) }

pub fn SortcomparebubbleSlice::mean(self : SortcomparebubbleSlice) -> Double { @_common.mean(self.data) }

pub fn SortcomparebubbleSlice::scale(self : SortcomparebubbleSlice, f : Double) -> SortcomparebubbleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleSlice::add(self : SortcomparebubbleSlice, other : SortcomparebubbleSlice) -> SortcomparebubbleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparebubbleSlice::copy(self : SortcomparebubbleSlice) -> SortcomparebubbleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleSlice::fill(self : SortcomparebubbleSlice, v : Double) -> SortcomparebubbleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparebubbleSlice::min(self : SortcomparebubbleSlice) -> Double { @_common.min(self.data) }

pub fn SortcomparebubbleSlice::max(self : SortcomparebubbleSlice) -> Double { @_common.max(self.data) }

pub fn SortcomparebubbleSlice::to_string(self : SortcomparebubbleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

