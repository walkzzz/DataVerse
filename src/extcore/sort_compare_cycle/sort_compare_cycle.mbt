///===
/// extcore/sort_compare_cycle

pub(all) struct SortcomparecyclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_cycle_make_point(x : Double, y : Double) -> SortcomparecyclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_cycle_make_point3(x : Double, y : Double, z : Double) -> SortcomparecyclePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparecyclePoint::x(self : SortcomparecyclePoint) -> Double { self.x }

pub fn SortcomparecyclePoint::y(self : SortcomparecyclePoint) -> Double { self.y }

pub fn SortcomparecyclePoint::z(self : SortcomparecyclePoint) -> Double { self.z }

pub fn SortcomparecyclePoint::label(self : SortcomparecyclePoint) -> Int { self.label }

pub fn SortcomparecyclePoint::dist(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparecyclePoint::add(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparecyclePoint::sub(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparecyclePoint::scale(self : SortcomparecyclePoint, s : Double) -> SortcomparecyclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparecyclePoint::dot(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparecyclePoint::cross(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparecyclePoint::norm(self : SortcomparecyclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparecyclePoint::normalize(self : SortcomparecyclePoint) -> SortcomparecyclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparecyclePoint::negate(self : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparecyclePoint::mid(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparecyclePoint::lerp(self : SortcomparecyclePoint, other : SortcomparecyclePoint, t : Double) -> SortcomparecyclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparecyclePoint::to_string(self : SortcomparecyclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparecycleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_cycle_make_series(vals : Array[Double], name : String) -> SortcomparecycleSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparecycleSeries::len(self : SortcomparecycleSeries) -> Int { self.vals.length() }

pub fn SortcomparecycleSeries::sum(self : SortcomparecycleSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparecycleSeries::mean(self : SortcomparecycleSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparecycleSeries::min(self : SortcomparecycleSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparecycleSeries::max(self : SortcomparecycleSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparecycleSeries::range(self : SortcomparecycleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparecycleSeries::variance(self : SortcomparecycleSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparecycleSeries::std(self : SortcomparecycleSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparecycleSeries::median(self : SortcomparecycleSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparecycleSeries::scale(self : SortcomparecycleSeries, f : Double) -> SortcomparecycleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparecycleSeries::add(self : SortcomparecycleSeries, other : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparecycleSeries::sub(self : SortcomparecycleSeries, other : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparecycleSeries::normalize(self : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparecycleSeries::cumsum(self : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparecycleSeries::to_string(self : SortcomparecycleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparecycleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_cycle_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparecycleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_cycle_matrix_identity(n : Int) -> SortcomparecycleMatrix {
  let m = sort_compare_cycle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparecycleMatrix::get(self : SortcomparecycleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparecycleMatrix::transpose(self : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparecycleMatrix::add(self : SortcomparecycleMatrix, other : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_cycle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparecycleMatrix::scale(self : SortcomparecycleMatrix, s : Double) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparecycleMatrix::multiply(self : SortcomparecycleMatrix, other : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if self.cols != other.rows { return sort_compare_cycle_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_cycle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparecycleMatrix::trace(self : SortcomparecycleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparecycleMatrix::det(self : SortcomparecycleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparecycleMatrix::norm(self : SortcomparecycleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparecycleMatrix::to_string(self : SortcomparecycleMatrix) -> String {
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

pub(all) struct SortcomparecycleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_cycle_make_vector(comps : Array[Double]) -> SortcomparecycleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_cycle_vector_zero(dim : Int) -> SortcomparecycleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparecycleVector::add(self : SortcomparecycleVector, other : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparecycleVector::sub(self : SortcomparecycleVector, other : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparecycleVector::scale(self : SortcomparecycleVector, s : Double) -> SortcomparecycleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparecycleVector::dot(self : SortcomparecycleVector, other : SortcomparecycleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparecycleVector::norm(self : SortcomparecycleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparecycleVector::normalize(self : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparecycleVector::dist(self : SortcomparecycleVector, other : SortcomparecycleVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparecycleVector::to_string(self : SortcomparecycleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparecycleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_frame_make(size : Int) -> SortcomparecycleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleFrame::len(self : SortcomparecycleFrame) -> Int { self.size }

pub fn SortcomparecycleFrame::get(self : SortcomparecycleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleFrame::set(self : SortcomparecycleFrame, i : Int, v : Double) -> SortcomparecycleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleFrame::sum(self : SortcomparecycleFrame) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleFrame::mean(self : SortcomparecycleFrame) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleFrame::scale(self : SortcomparecycleFrame, f : Double) -> SortcomparecycleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleFrame::add(self : SortcomparecycleFrame, other : SortcomparecycleFrame) -> SortcomparecycleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleFrame::copy(self : SortcomparecycleFrame) -> SortcomparecycleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleFrame::fill(self : SortcomparecycleFrame, v : Double) -> SortcomparecycleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleFrame::min(self : SortcomparecycleFrame) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleFrame::max(self : SortcomparecycleFrame) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleFrame::to_string(self : SortcomparecycleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_table_make(size : Int) -> SortcomparecycleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleTable::len(self : SortcomparecycleTable) -> Int { self.size }

pub fn SortcomparecycleTable::get(self : SortcomparecycleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleTable::set(self : SortcomparecycleTable, i : Int, v : Double) -> SortcomparecycleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleTable::sum(self : SortcomparecycleTable) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleTable::mean(self : SortcomparecycleTable) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleTable::scale(self : SortcomparecycleTable, f : Double) -> SortcomparecycleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleTable::add(self : SortcomparecycleTable, other : SortcomparecycleTable) -> SortcomparecycleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleTable::copy(self : SortcomparecycleTable) -> SortcomparecycleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleTable::fill(self : SortcomparecycleTable, v : Double) -> SortcomparecycleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleTable::min(self : SortcomparecycleTable) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleTable::max(self : SortcomparecycleTable) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleTable::to_string(self : SortcomparecycleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_graphn_make(size : Int) -> SortcomparecycleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleGraphN::len(self : SortcomparecycleGraphN) -> Int { self.size }

pub fn SortcomparecycleGraphN::get(self : SortcomparecycleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleGraphN::set(self : SortcomparecycleGraphN, i : Int, v : Double) -> SortcomparecycleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleGraphN::sum(self : SortcomparecycleGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleGraphN::mean(self : SortcomparecycleGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleGraphN::scale(self : SortcomparecycleGraphN, f : Double) -> SortcomparecycleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleGraphN::add(self : SortcomparecycleGraphN, other : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleGraphN::copy(self : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleGraphN::fill(self : SortcomparecycleGraphN, v : Double) -> SortcomparecycleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleGraphN::min(self : SortcomparecycleGraphN) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleGraphN::max(self : SortcomparecycleGraphN) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleGraphN::to_string(self : SortcomparecycleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_node_make(size : Int) -> SortcomparecycleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleNode::len(self : SortcomparecycleNode) -> Int { self.size }

pub fn SortcomparecycleNode::get(self : SortcomparecycleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleNode::set(self : SortcomparecycleNode, i : Int, v : Double) -> SortcomparecycleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleNode::sum(self : SortcomparecycleNode) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleNode::mean(self : SortcomparecycleNode) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleNode::scale(self : SortcomparecycleNode, f : Double) -> SortcomparecycleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleNode::add(self : SortcomparecycleNode, other : SortcomparecycleNode) -> SortcomparecycleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleNode::copy(self : SortcomparecycleNode) -> SortcomparecycleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleNode::fill(self : SortcomparecycleNode, v : Double) -> SortcomparecycleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleNode::min(self : SortcomparecycleNode) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleNode::max(self : SortcomparecycleNode) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleNode::to_string(self : SortcomparecycleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_edge_make(size : Int) -> SortcomparecycleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleEdge::len(self : SortcomparecycleEdge) -> Int { self.size }

pub fn SortcomparecycleEdge::get(self : SortcomparecycleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleEdge::set(self : SortcomparecycleEdge, i : Int, v : Double) -> SortcomparecycleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleEdge::sum(self : SortcomparecycleEdge) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleEdge::mean(self : SortcomparecycleEdge) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleEdge::scale(self : SortcomparecycleEdge, f : Double) -> SortcomparecycleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleEdge::add(self : SortcomparecycleEdge, other : SortcomparecycleEdge) -> SortcomparecycleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleEdge::copy(self : SortcomparecycleEdge) -> SortcomparecycleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleEdge::fill(self : SortcomparecycleEdge, v : Double) -> SortcomparecycleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleEdge::min(self : SortcomparecycleEdge) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleEdge::max(self : SortcomparecycleEdge) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleEdge::to_string(self : SortcomparecycleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecyclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_path_make(size : Int) -> SortcomparecyclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecyclePath::len(self : SortcomparecyclePath) -> Int { self.size }

pub fn SortcomparecyclePath::get(self : SortcomparecyclePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecyclePath::set(self : SortcomparecyclePath, i : Int, v : Double) -> SortcomparecyclePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecyclePath::sum(self : SortcomparecyclePath) -> Double { @_common.sum(self.data) }

pub fn SortcomparecyclePath::mean(self : SortcomparecyclePath) -> Double { @_common.mean(self.data) }

pub fn SortcomparecyclePath::scale(self : SortcomparecyclePath, f : Double) -> SortcomparecyclePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecyclePath::add(self : SortcomparecyclePath, other : SortcomparecyclePath) -> SortcomparecyclePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecyclePath::copy(self : SortcomparecyclePath) -> SortcomparecyclePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecyclePath::fill(self : SortcomparecyclePath, v : Double) -> SortcomparecyclePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecyclePath::min(self : SortcomparecyclePath) -> Double { @_common.min(self.data) }

pub fn SortcomparecyclePath::max(self : SortcomparecyclePath) -> Double { @_common.max(self.data) }

pub fn SortcomparecyclePath::to_string(self : SortcomparecyclePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cluster_make(size : Int) -> SortcomparecycleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleCluster::len(self : SortcomparecycleCluster) -> Int { self.size }

pub fn SortcomparecycleCluster::get(self : SortcomparecycleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleCluster::set(self : SortcomparecycleCluster, i : Int, v : Double) -> SortcomparecycleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCluster::sum(self : SortcomparecycleCluster) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleCluster::mean(self : SortcomparecycleCluster) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleCluster::scale(self : SortcomparecycleCluster, f : Double) -> SortcomparecycleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCluster::add(self : SortcomparecycleCluster, other : SortcomparecycleCluster) -> SortcomparecycleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleCluster::copy(self : SortcomparecycleCluster) -> SortcomparecycleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCluster::fill(self : SortcomparecycleCluster, v : Double) -> SortcomparecycleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCluster::min(self : SortcomparecycleCluster) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleCluster::max(self : SortcomparecycleCluster) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleCluster::to_string(self : SortcomparecycleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_model_make(size : Int) -> SortcomparecycleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleModel::len(self : SortcomparecycleModel) -> Int { self.size }

pub fn SortcomparecycleModel::get(self : SortcomparecycleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleModel::set(self : SortcomparecycleModel, i : Int, v : Double) -> SortcomparecycleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleModel::sum(self : SortcomparecycleModel) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleModel::mean(self : SortcomparecycleModel) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleModel::scale(self : SortcomparecycleModel, f : Double) -> SortcomparecycleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleModel::add(self : SortcomparecycleModel, other : SortcomparecycleModel) -> SortcomparecycleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleModel::copy(self : SortcomparecycleModel) -> SortcomparecycleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleModel::fill(self : SortcomparecycleModel, v : Double) -> SortcomparecycleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleModel::min(self : SortcomparecycleModel) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleModel::max(self : SortcomparecycleModel) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleModel::to_string(self : SortcomparecycleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_layer_make(size : Int) -> SortcomparecycleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleLayer::len(self : SortcomparecycleLayer) -> Int { self.size }

pub fn SortcomparecycleLayer::get(self : SortcomparecycleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleLayer::set(self : SortcomparecycleLayer, i : Int, v : Double) -> SortcomparecycleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleLayer::sum(self : SortcomparecycleLayer) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleLayer::mean(self : SortcomparecycleLayer) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleLayer::scale(self : SortcomparecycleLayer, f : Double) -> SortcomparecycleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleLayer::add(self : SortcomparecycleLayer, other : SortcomparecycleLayer) -> SortcomparecycleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleLayer::copy(self : SortcomparecycleLayer) -> SortcomparecycleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleLayer::fill(self : SortcomparecycleLayer, v : Double) -> SortcomparecycleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleLayer::min(self : SortcomparecycleLayer) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleLayer::max(self : SortcomparecycleLayer) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleLayer::to_string(self : SortcomparecycleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_buffer_make(size : Int) -> SortcomparecycleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleBuffer::len(self : SortcomparecycleBuffer) -> Int { self.size }

pub fn SortcomparecycleBuffer::get(self : SortcomparecycleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleBuffer::set(self : SortcomparecycleBuffer, i : Int, v : Double) -> SortcomparecycleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleBuffer::sum(self : SortcomparecycleBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleBuffer::mean(self : SortcomparecycleBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleBuffer::scale(self : SortcomparecycleBuffer, f : Double) -> SortcomparecycleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleBuffer::add(self : SortcomparecycleBuffer, other : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleBuffer::copy(self : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleBuffer::fill(self : SortcomparecycleBuffer, v : Double) -> SortcomparecycleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleBuffer::min(self : SortcomparecycleBuffer) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleBuffer::max(self : SortcomparecycleBuffer) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleBuffer::to_string(self : SortcomparecycleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cursor_make(size : Int) -> SortcomparecycleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleCursor::len(self : SortcomparecycleCursor) -> Int { self.size }

pub fn SortcomparecycleCursor::get(self : SortcomparecycleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleCursor::set(self : SortcomparecycleCursor, i : Int, v : Double) -> SortcomparecycleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCursor::sum(self : SortcomparecycleCursor) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleCursor::mean(self : SortcomparecycleCursor) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleCursor::scale(self : SortcomparecycleCursor, f : Double) -> SortcomparecycleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCursor::add(self : SortcomparecycleCursor, other : SortcomparecycleCursor) -> SortcomparecycleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleCursor::copy(self : SortcomparecycleCursor) -> SortcomparecycleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCursor::fill(self : SortcomparecycleCursor, v : Double) -> SortcomparecycleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleCursor::min(self : SortcomparecycleCursor) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleCursor::max(self : SortcomparecycleCursor) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleCursor::to_string(self : SortcomparecycleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_view_make(size : Int) -> SortcomparecycleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleView::len(self : SortcomparecycleView) -> Int { self.size }

pub fn SortcomparecycleView::get(self : SortcomparecycleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleView::set(self : SortcomparecycleView, i : Int, v : Double) -> SortcomparecycleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleView::sum(self : SortcomparecycleView) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleView::mean(self : SortcomparecycleView) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleView::scale(self : SortcomparecycleView, f : Double) -> SortcomparecycleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleView::add(self : SortcomparecycleView, other : SortcomparecycleView) -> SortcomparecycleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleView::copy(self : SortcomparecycleView) -> SortcomparecycleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleView::fill(self : SortcomparecycleView, v : Double) -> SortcomparecycleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleView::min(self : SortcomparecycleView) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleView::max(self : SortcomparecycleView) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleView::to_string(self : SortcomparecycleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_range_make(size : Int) -> SortcomparecycleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleRange::len(self : SortcomparecycleRange) -> Int { self.size }

pub fn SortcomparecycleRange::get(self : SortcomparecycleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleRange::set(self : SortcomparecycleRange, i : Int, v : Double) -> SortcomparecycleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleRange::sum(self : SortcomparecycleRange) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleRange::mean(self : SortcomparecycleRange) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleRange::scale(self : SortcomparecycleRange, f : Double) -> SortcomparecycleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleRange::add(self : SortcomparecycleRange, other : SortcomparecycleRange) -> SortcomparecycleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleRange::copy(self : SortcomparecycleRange) -> SortcomparecycleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleRange::fill(self : SortcomparecycleRange, v : Double) -> SortcomparecycleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleRange::min(self : SortcomparecycleRange) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleRange::max(self : SortcomparecycleRange) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleRange::to_string(self : SortcomparecycleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_slice_make(size : Int) -> SortcomparecycleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparecycleSlice::len(self : SortcomparecycleSlice) -> Int { self.size }

pub fn SortcomparecycleSlice::get(self : SortcomparecycleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparecycleSlice::set(self : SortcomparecycleSlice, i : Int, v : Double) -> SortcomparecycleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparecycleSlice::sum(self : SortcomparecycleSlice) -> Double { @_common.sum(self.data) }

pub fn SortcomparecycleSlice::mean(self : SortcomparecycleSlice) -> Double { @_common.mean(self.data) }

pub fn SortcomparecycleSlice::scale(self : SortcomparecycleSlice, f : Double) -> SortcomparecycleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleSlice::add(self : SortcomparecycleSlice, other : SortcomparecycleSlice) -> SortcomparecycleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparecycleSlice::copy(self : SortcomparecycleSlice) -> SortcomparecycleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleSlice::fill(self : SortcomparecycleSlice, v : Double) -> SortcomparecycleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparecycleSlice::min(self : SortcomparecycleSlice) -> Double { @_common.min(self.data) }

pub fn SortcomparecycleSlice::max(self : SortcomparecycleSlice) -> Double { @_common.max(self.data) }

pub fn SortcomparecycleSlice::to_string(self : SortcomparecycleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

