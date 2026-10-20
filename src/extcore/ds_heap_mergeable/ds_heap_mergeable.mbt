///===
/// extcore/ds_heap_mergeable

pub(all) struct DsheapmergeablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_mergeable_make_point(x : Double, y : Double) -> DsheapmergeablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_mergeable_make_point3(x : Double, y : Double, z : Double) -> DsheapmergeablePoint {
  { x, y, z, label: 0 }
}

pub fn DsheapmergeablePoint::x(self : DsheapmergeablePoint) -> Double { self.x }

pub fn DsheapmergeablePoint::y(self : DsheapmergeablePoint) -> Double { self.y }

pub fn DsheapmergeablePoint::z(self : DsheapmergeablePoint) -> Double { self.z }

pub fn DsheapmergeablePoint::label(self : DsheapmergeablePoint) -> Int { self.label }

pub fn DsheapmergeablePoint::dist(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapmergeablePoint::add(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapmergeablePoint::sub(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapmergeablePoint::scale(self : DsheapmergeablePoint, s : Double) -> DsheapmergeablePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapmergeablePoint::dot(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapmergeablePoint::cross(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapmergeablePoint::norm(self : DsheapmergeablePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapmergeablePoint::normalize(self : DsheapmergeablePoint) -> DsheapmergeablePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapmergeablePoint::negate(self : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapmergeablePoint::mid(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapmergeablePoint::lerp(self : DsheapmergeablePoint, other : DsheapmergeablePoint, t : Double) -> DsheapmergeablePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapmergeablePoint::to_string(self : DsheapmergeablePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapmergeableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_mergeable_make_series(vals : Array[Double], name : String) -> DsheapmergeableSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapmergeableSeries::len(self : DsheapmergeableSeries) -> Int { self.vals.length() }

pub fn DsheapmergeableSeries::sum(self : DsheapmergeableSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapmergeableSeries::mean(self : DsheapmergeableSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapmergeableSeries::min(self : DsheapmergeableSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapmergeableSeries::max(self : DsheapmergeableSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapmergeableSeries::range(self : DsheapmergeableSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapmergeableSeries::variance(self : DsheapmergeableSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapmergeableSeries::std(self : DsheapmergeableSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapmergeableSeries::median(self : DsheapmergeableSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapmergeableSeries::scale(self : DsheapmergeableSeries, f : Double) -> DsheapmergeableSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapmergeableSeries::add(self : DsheapmergeableSeries, other : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapmergeableSeries::sub(self : DsheapmergeableSeries, other : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapmergeableSeries::normalize(self : DsheapmergeableSeries) -> DsheapmergeableSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapmergeableSeries::cumsum(self : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapmergeableSeries::to_string(self : DsheapmergeableSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapmergeableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_mergeable_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapmergeableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_mergeable_matrix_identity(n : Int) -> DsheapmergeableMatrix {
  let m = ds_heap_mergeable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapmergeableMatrix::get(self : DsheapmergeableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapmergeableMatrix::transpose(self : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  let result = ds_heap_mergeable_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapmergeableMatrix::add(self : DsheapmergeableMatrix, other : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_mergeable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapmergeableMatrix::scale(self : DsheapmergeableMatrix, s : Double) -> DsheapmergeableMatrix {
  let result = ds_heap_mergeable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapmergeableMatrix::multiply(self : DsheapmergeableMatrix, other : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  if self.cols != other.rows { return ds_heap_mergeable_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_mergeable_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapmergeableMatrix::trace(self : DsheapmergeableMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapmergeableMatrix::det(self : DsheapmergeableMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapmergeableMatrix::norm(self : DsheapmergeableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapmergeableMatrix::to_string(self : DsheapmergeableMatrix) -> String {
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

pub(all) struct DsheapmergeableVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_mergeable_make_vector(comps : Array[Double]) -> DsheapmergeableVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_mergeable_vector_zero(dim : Int) -> DsheapmergeableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapmergeableVector::add(self : DsheapmergeableVector, other : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapmergeableVector::sub(self : DsheapmergeableVector, other : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapmergeableVector::scale(self : DsheapmergeableVector, s : Double) -> DsheapmergeableVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapmergeableVector::dot(self : DsheapmergeableVector, other : DsheapmergeableVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapmergeableVector::norm(self : DsheapmergeableVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapmergeableVector::normalize(self : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapmergeableVector::dist(self : DsheapmergeableVector, other : DsheapmergeableVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapmergeableVector::to_string(self : DsheapmergeableVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapmergeableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_frame_make(size : Int) -> DsheapmergeableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableFrame::len(self : DsheapmergeableFrame) -> Int { self.size }

pub fn DsheapmergeableFrame::get(self : DsheapmergeableFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableFrame::set(self : DsheapmergeableFrame, i : Int, v : Double) -> DsheapmergeableFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableFrame::sum(self : DsheapmergeableFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableFrame::mean(self : DsheapmergeableFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableFrame::scale(self : DsheapmergeableFrame, f : Double) -> DsheapmergeableFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableFrame::add(self : DsheapmergeableFrame, other : DsheapmergeableFrame) -> DsheapmergeableFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableFrame::copy(self : DsheapmergeableFrame) -> DsheapmergeableFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableFrame::fill(self : DsheapmergeableFrame, v : Double) -> DsheapmergeableFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableFrame::min(self : DsheapmergeableFrame) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableFrame::max(self : DsheapmergeableFrame) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableFrame::to_string(self : DsheapmergeableFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_table_make(size : Int) -> DsheapmergeableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableTable::len(self : DsheapmergeableTable) -> Int { self.size }

pub fn DsheapmergeableTable::get(self : DsheapmergeableTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableTable::set(self : DsheapmergeableTable, i : Int, v : Double) -> DsheapmergeableTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableTable::sum(self : DsheapmergeableTable) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableTable::mean(self : DsheapmergeableTable) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableTable::scale(self : DsheapmergeableTable, f : Double) -> DsheapmergeableTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableTable::add(self : DsheapmergeableTable, other : DsheapmergeableTable) -> DsheapmergeableTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableTable::copy(self : DsheapmergeableTable) -> DsheapmergeableTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableTable::fill(self : DsheapmergeableTable, v : Double) -> DsheapmergeableTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableTable::min(self : DsheapmergeableTable) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableTable::max(self : DsheapmergeableTable) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableTable::to_string(self : DsheapmergeableTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_graphn_make(size : Int) -> DsheapmergeableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableGraphN::len(self : DsheapmergeableGraphN) -> Int { self.size }

pub fn DsheapmergeableGraphN::get(self : DsheapmergeableGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableGraphN::set(self : DsheapmergeableGraphN, i : Int, v : Double) -> DsheapmergeableGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableGraphN::sum(self : DsheapmergeableGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableGraphN::mean(self : DsheapmergeableGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableGraphN::scale(self : DsheapmergeableGraphN, f : Double) -> DsheapmergeableGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableGraphN::add(self : DsheapmergeableGraphN, other : DsheapmergeableGraphN) -> DsheapmergeableGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableGraphN::copy(self : DsheapmergeableGraphN) -> DsheapmergeableGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableGraphN::fill(self : DsheapmergeableGraphN, v : Double) -> DsheapmergeableGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableGraphN::min(self : DsheapmergeableGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableGraphN::max(self : DsheapmergeableGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableGraphN::to_string(self : DsheapmergeableGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_node_make(size : Int) -> DsheapmergeableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableNode::len(self : DsheapmergeableNode) -> Int { self.size }

pub fn DsheapmergeableNode::get(self : DsheapmergeableNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableNode::set(self : DsheapmergeableNode, i : Int, v : Double) -> DsheapmergeableNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableNode::sum(self : DsheapmergeableNode) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableNode::mean(self : DsheapmergeableNode) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableNode::scale(self : DsheapmergeableNode, f : Double) -> DsheapmergeableNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableNode::add(self : DsheapmergeableNode, other : DsheapmergeableNode) -> DsheapmergeableNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableNode::copy(self : DsheapmergeableNode) -> DsheapmergeableNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableNode::fill(self : DsheapmergeableNode, v : Double) -> DsheapmergeableNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableNode::min(self : DsheapmergeableNode) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableNode::max(self : DsheapmergeableNode) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableNode::to_string(self : DsheapmergeableNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_edge_make(size : Int) -> DsheapmergeableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableEdge::len(self : DsheapmergeableEdge) -> Int { self.size }

pub fn DsheapmergeableEdge::get(self : DsheapmergeableEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableEdge::set(self : DsheapmergeableEdge, i : Int, v : Double) -> DsheapmergeableEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableEdge::sum(self : DsheapmergeableEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableEdge::mean(self : DsheapmergeableEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableEdge::scale(self : DsheapmergeableEdge, f : Double) -> DsheapmergeableEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableEdge::add(self : DsheapmergeableEdge, other : DsheapmergeableEdge) -> DsheapmergeableEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableEdge::copy(self : DsheapmergeableEdge) -> DsheapmergeableEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableEdge::fill(self : DsheapmergeableEdge, v : Double) -> DsheapmergeableEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableEdge::min(self : DsheapmergeableEdge) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableEdge::max(self : DsheapmergeableEdge) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableEdge::to_string(self : DsheapmergeableEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_path_make(size : Int) -> DsheapmergeablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeablePath::len(self : DsheapmergeablePath) -> Int { self.size }

pub fn DsheapmergeablePath::get(self : DsheapmergeablePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeablePath::set(self : DsheapmergeablePath, i : Int, v : Double) -> DsheapmergeablePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeablePath::sum(self : DsheapmergeablePath) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeablePath::mean(self : DsheapmergeablePath) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeablePath::scale(self : DsheapmergeablePath, f : Double) -> DsheapmergeablePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeablePath::add(self : DsheapmergeablePath, other : DsheapmergeablePath) -> DsheapmergeablePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeablePath::copy(self : DsheapmergeablePath) -> DsheapmergeablePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeablePath::fill(self : DsheapmergeablePath, v : Double) -> DsheapmergeablePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeablePath::min(self : DsheapmergeablePath) -> Double { @_common.min(self.data) }

pub fn DsheapmergeablePath::max(self : DsheapmergeablePath) -> Double { @_common.max(self.data) }

pub fn DsheapmergeablePath::to_string(self : DsheapmergeablePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_cluster_make(size : Int) -> DsheapmergeableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableCluster::len(self : DsheapmergeableCluster) -> Int { self.size }

pub fn DsheapmergeableCluster::get(self : DsheapmergeableCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableCluster::set(self : DsheapmergeableCluster, i : Int, v : Double) -> DsheapmergeableCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCluster::sum(self : DsheapmergeableCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableCluster::mean(self : DsheapmergeableCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableCluster::scale(self : DsheapmergeableCluster, f : Double) -> DsheapmergeableCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCluster::add(self : DsheapmergeableCluster, other : DsheapmergeableCluster) -> DsheapmergeableCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableCluster::copy(self : DsheapmergeableCluster) -> DsheapmergeableCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCluster::fill(self : DsheapmergeableCluster, v : Double) -> DsheapmergeableCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCluster::min(self : DsheapmergeableCluster) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableCluster::max(self : DsheapmergeableCluster) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableCluster::to_string(self : DsheapmergeableCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_model_make(size : Int) -> DsheapmergeableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableModel::len(self : DsheapmergeableModel) -> Int { self.size }

pub fn DsheapmergeableModel::get(self : DsheapmergeableModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableModel::set(self : DsheapmergeableModel, i : Int, v : Double) -> DsheapmergeableModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableModel::sum(self : DsheapmergeableModel) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableModel::mean(self : DsheapmergeableModel) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableModel::scale(self : DsheapmergeableModel, f : Double) -> DsheapmergeableModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableModel::add(self : DsheapmergeableModel, other : DsheapmergeableModel) -> DsheapmergeableModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableModel::copy(self : DsheapmergeableModel) -> DsheapmergeableModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableModel::fill(self : DsheapmergeableModel, v : Double) -> DsheapmergeableModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableModel::min(self : DsheapmergeableModel) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableModel::max(self : DsheapmergeableModel) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableModel::to_string(self : DsheapmergeableModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_layer_make(size : Int) -> DsheapmergeableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableLayer::len(self : DsheapmergeableLayer) -> Int { self.size }

pub fn DsheapmergeableLayer::get(self : DsheapmergeableLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableLayer::set(self : DsheapmergeableLayer, i : Int, v : Double) -> DsheapmergeableLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableLayer::sum(self : DsheapmergeableLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableLayer::mean(self : DsheapmergeableLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableLayer::scale(self : DsheapmergeableLayer, f : Double) -> DsheapmergeableLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableLayer::add(self : DsheapmergeableLayer, other : DsheapmergeableLayer) -> DsheapmergeableLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableLayer::copy(self : DsheapmergeableLayer) -> DsheapmergeableLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableLayer::fill(self : DsheapmergeableLayer, v : Double) -> DsheapmergeableLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableLayer::min(self : DsheapmergeableLayer) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableLayer::max(self : DsheapmergeableLayer) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableLayer::to_string(self : DsheapmergeableLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_buffer_make(size : Int) -> DsheapmergeableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableBuffer::len(self : DsheapmergeableBuffer) -> Int { self.size }

pub fn DsheapmergeableBuffer::get(self : DsheapmergeableBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableBuffer::set(self : DsheapmergeableBuffer, i : Int, v : Double) -> DsheapmergeableBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableBuffer::sum(self : DsheapmergeableBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableBuffer::mean(self : DsheapmergeableBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableBuffer::scale(self : DsheapmergeableBuffer, f : Double) -> DsheapmergeableBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableBuffer::add(self : DsheapmergeableBuffer, other : DsheapmergeableBuffer) -> DsheapmergeableBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableBuffer::copy(self : DsheapmergeableBuffer) -> DsheapmergeableBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableBuffer::fill(self : DsheapmergeableBuffer, v : Double) -> DsheapmergeableBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableBuffer::min(self : DsheapmergeableBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableBuffer::max(self : DsheapmergeableBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableBuffer::to_string(self : DsheapmergeableBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_cursor_make(size : Int) -> DsheapmergeableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableCursor::len(self : DsheapmergeableCursor) -> Int { self.size }

pub fn DsheapmergeableCursor::get(self : DsheapmergeableCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableCursor::set(self : DsheapmergeableCursor, i : Int, v : Double) -> DsheapmergeableCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCursor::sum(self : DsheapmergeableCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableCursor::mean(self : DsheapmergeableCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableCursor::scale(self : DsheapmergeableCursor, f : Double) -> DsheapmergeableCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCursor::add(self : DsheapmergeableCursor, other : DsheapmergeableCursor) -> DsheapmergeableCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableCursor::copy(self : DsheapmergeableCursor) -> DsheapmergeableCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCursor::fill(self : DsheapmergeableCursor, v : Double) -> DsheapmergeableCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableCursor::min(self : DsheapmergeableCursor) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableCursor::max(self : DsheapmergeableCursor) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableCursor::to_string(self : DsheapmergeableCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_view_make(size : Int) -> DsheapmergeableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableView::len(self : DsheapmergeableView) -> Int { self.size }

pub fn DsheapmergeableView::get(self : DsheapmergeableView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableView::set(self : DsheapmergeableView, i : Int, v : Double) -> DsheapmergeableView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableView::sum(self : DsheapmergeableView) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableView::mean(self : DsheapmergeableView) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableView::scale(self : DsheapmergeableView, f : Double) -> DsheapmergeableView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableView::add(self : DsheapmergeableView, other : DsheapmergeableView) -> DsheapmergeableView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableView::copy(self : DsheapmergeableView) -> DsheapmergeableView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableView::fill(self : DsheapmergeableView, v : Double) -> DsheapmergeableView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableView::min(self : DsheapmergeableView) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableView::max(self : DsheapmergeableView) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableView::to_string(self : DsheapmergeableView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_range_make(size : Int) -> DsheapmergeableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableRange::len(self : DsheapmergeableRange) -> Int { self.size }

pub fn DsheapmergeableRange::get(self : DsheapmergeableRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableRange::set(self : DsheapmergeableRange, i : Int, v : Double) -> DsheapmergeableRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableRange::sum(self : DsheapmergeableRange) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableRange::mean(self : DsheapmergeableRange) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableRange::scale(self : DsheapmergeableRange, f : Double) -> DsheapmergeableRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableRange::add(self : DsheapmergeableRange, other : DsheapmergeableRange) -> DsheapmergeableRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableRange::copy(self : DsheapmergeableRange) -> DsheapmergeableRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableRange::fill(self : DsheapmergeableRange, v : Double) -> DsheapmergeableRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableRange::min(self : DsheapmergeableRange) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableRange::max(self : DsheapmergeableRange) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableRange::to_string(self : DsheapmergeableRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_slice_make(size : Int) -> DsheapmergeableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapmergeableSlice::len(self : DsheapmergeableSlice) -> Int { self.size }

pub fn DsheapmergeableSlice::get(self : DsheapmergeableSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapmergeableSlice::set(self : DsheapmergeableSlice, i : Int, v : Double) -> DsheapmergeableSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapmergeableSlice::sum(self : DsheapmergeableSlice) -> Double { @_common.sum(self.data) }

pub fn DsheapmergeableSlice::mean(self : DsheapmergeableSlice) -> Double { @_common.mean(self.data) }

pub fn DsheapmergeableSlice::scale(self : DsheapmergeableSlice, f : Double) -> DsheapmergeableSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableSlice::add(self : DsheapmergeableSlice, other : DsheapmergeableSlice) -> DsheapmergeableSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapmergeableSlice::copy(self : DsheapmergeableSlice) -> DsheapmergeableSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableSlice::fill(self : DsheapmergeableSlice, v : Double) -> DsheapmergeableSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapmergeableSlice::min(self : DsheapmergeableSlice) -> Double { @_common.min(self.data) }

pub fn DsheapmergeableSlice::max(self : DsheapmergeableSlice) -> Double { @_common.max(self.data) }

pub fn DsheapmergeableSlice::to_string(self : DsheapmergeableSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

