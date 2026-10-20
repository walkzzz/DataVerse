///===
/// extcore/sort_dist_radix

pub(all) struct SortdistradixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_radix_make_point(x : Double, y : Double) -> SortdistradixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_radix_make_point3(x : Double, y : Double, z : Double) -> SortdistradixPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistradixPoint::x(self : SortdistradixPoint) -> Double { self.x }

pub fn SortdistradixPoint::y(self : SortdistradixPoint) -> Double { self.y }

pub fn SortdistradixPoint::z(self : SortdistradixPoint) -> Double { self.z }

pub fn SortdistradixPoint::label(self : SortdistradixPoint) -> Int { self.label }

pub fn SortdistradixPoint::dist(self : SortdistradixPoint, other : SortdistradixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistradixPoint::add(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistradixPoint::sub(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistradixPoint::scale(self : SortdistradixPoint, s : Double) -> SortdistradixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistradixPoint::dot(self : SortdistradixPoint, other : SortdistradixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistradixPoint::cross(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistradixPoint::norm(self : SortdistradixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistradixPoint::normalize(self : SortdistradixPoint) -> SortdistradixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistradixPoint::negate(self : SortdistradixPoint) -> SortdistradixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistradixPoint::mid(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistradixPoint::lerp(self : SortdistradixPoint, other : SortdistradixPoint, t : Double) -> SortdistradixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistradixPoint::to_string(self : SortdistradixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistradixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_radix_make_series(vals : Array[Double], name : String) -> SortdistradixSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistradixSeries::len(self : SortdistradixSeries) -> Int { self.vals.length() }

pub fn SortdistradixSeries::sum(self : SortdistradixSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistradixSeries::mean(self : SortdistradixSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistradixSeries::min(self : SortdistradixSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistradixSeries::max(self : SortdistradixSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistradixSeries::range(self : SortdistradixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistradixSeries::variance(self : SortdistradixSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistradixSeries::std(self : SortdistradixSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistradixSeries::median(self : SortdistradixSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistradixSeries::scale(self : SortdistradixSeries, f : Double) -> SortdistradixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistradixSeries::add(self : SortdistradixSeries, other : SortdistradixSeries) -> SortdistradixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistradixSeries::sub(self : SortdistradixSeries, other : SortdistradixSeries) -> SortdistradixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistradixSeries::normalize(self : SortdistradixSeries) -> SortdistradixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistradixSeries::cumsum(self : SortdistradixSeries) -> SortdistradixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistradixSeries::to_string(self : SortdistradixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistradixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_radix_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistradixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_radix_matrix_identity(n : Int) -> SortdistradixMatrix {
  let m = sort_dist_radix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistradixMatrix::get(self : SortdistradixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistradixMatrix::transpose(self : SortdistradixMatrix) -> SortdistradixMatrix {
  let result = sort_dist_radix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistradixMatrix::add(self : SortdistradixMatrix, other : SortdistradixMatrix) -> SortdistradixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_radix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistradixMatrix::scale(self : SortdistradixMatrix, s : Double) -> SortdistradixMatrix {
  let result = sort_dist_radix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistradixMatrix::multiply(self : SortdistradixMatrix, other : SortdistradixMatrix) -> SortdistradixMatrix {
  if self.cols != other.rows { return sort_dist_radix_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_radix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistradixMatrix::trace(self : SortdistradixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistradixMatrix::det(self : SortdistradixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistradixMatrix::norm(self : SortdistradixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistradixMatrix::to_string(self : SortdistradixMatrix) -> String {
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

pub(all) struct SortdistradixVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_radix_make_vector(comps : Array[Double]) -> SortdistradixVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_radix_vector_zero(dim : Int) -> SortdistradixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistradixVector::add(self : SortdistradixVector, other : SortdistradixVector) -> SortdistradixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistradixVector::sub(self : SortdistradixVector, other : SortdistradixVector) -> SortdistradixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistradixVector::scale(self : SortdistradixVector, s : Double) -> SortdistradixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistradixVector::dot(self : SortdistradixVector, other : SortdistradixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistradixVector::norm(self : SortdistradixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistradixVector::normalize(self : SortdistradixVector) -> SortdistradixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistradixVector::dist(self : SortdistradixVector, other : SortdistradixVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistradixVector::to_string(self : SortdistradixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistradixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_frame_make(size : Int) -> SortdistradixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixFrame::len(self : SortdistradixFrame) -> Int { self.size }

pub fn SortdistradixFrame::get(self : SortdistradixFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixFrame::set(self : SortdistradixFrame, i : Int, v : Double) -> SortdistradixFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixFrame::sum(self : SortdistradixFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistradixFrame::mean(self : SortdistradixFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistradixFrame::scale(self : SortdistradixFrame, f : Double) -> SortdistradixFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixFrame::add(self : SortdistradixFrame, other : SortdistradixFrame) -> SortdistradixFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixFrame::copy(self : SortdistradixFrame) -> SortdistradixFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixFrame::fill(self : SortdistradixFrame, v : Double) -> SortdistradixFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixFrame::min(self : SortdistradixFrame) -> Double { @_common.min(self.data) }

pub fn SortdistradixFrame::max(self : SortdistradixFrame) -> Double { @_common.max(self.data) }

pub fn SortdistradixFrame::to_string(self : SortdistradixFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_table_make(size : Int) -> SortdistradixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixTable::len(self : SortdistradixTable) -> Int { self.size }

pub fn SortdistradixTable::get(self : SortdistradixTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixTable::set(self : SortdistradixTable, i : Int, v : Double) -> SortdistradixTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixTable::sum(self : SortdistradixTable) -> Double { @_common.sum(self.data) }

pub fn SortdistradixTable::mean(self : SortdistradixTable) -> Double { @_common.mean(self.data) }

pub fn SortdistradixTable::scale(self : SortdistradixTable, f : Double) -> SortdistradixTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixTable::add(self : SortdistradixTable, other : SortdistradixTable) -> SortdistradixTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixTable::copy(self : SortdistradixTable) -> SortdistradixTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixTable::fill(self : SortdistradixTable, v : Double) -> SortdistradixTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixTable::min(self : SortdistradixTable) -> Double { @_common.min(self.data) }

pub fn SortdistradixTable::max(self : SortdistradixTable) -> Double { @_common.max(self.data) }

pub fn SortdistradixTable::to_string(self : SortdistradixTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_graphn_make(size : Int) -> SortdistradixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixGraphN::len(self : SortdistradixGraphN) -> Int { self.size }

pub fn SortdistradixGraphN::get(self : SortdistradixGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixGraphN::set(self : SortdistradixGraphN, i : Int, v : Double) -> SortdistradixGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixGraphN::sum(self : SortdistradixGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistradixGraphN::mean(self : SortdistradixGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistradixGraphN::scale(self : SortdistradixGraphN, f : Double) -> SortdistradixGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixGraphN::add(self : SortdistradixGraphN, other : SortdistradixGraphN) -> SortdistradixGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixGraphN::copy(self : SortdistradixGraphN) -> SortdistradixGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixGraphN::fill(self : SortdistradixGraphN, v : Double) -> SortdistradixGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixGraphN::min(self : SortdistradixGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistradixGraphN::max(self : SortdistradixGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistradixGraphN::to_string(self : SortdistradixGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_node_make(size : Int) -> SortdistradixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixNode::len(self : SortdistradixNode) -> Int { self.size }

pub fn SortdistradixNode::get(self : SortdistradixNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixNode::set(self : SortdistradixNode, i : Int, v : Double) -> SortdistradixNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixNode::sum(self : SortdistradixNode) -> Double { @_common.sum(self.data) }

pub fn SortdistradixNode::mean(self : SortdistradixNode) -> Double { @_common.mean(self.data) }

pub fn SortdistradixNode::scale(self : SortdistradixNode, f : Double) -> SortdistradixNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixNode::add(self : SortdistradixNode, other : SortdistradixNode) -> SortdistradixNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixNode::copy(self : SortdistradixNode) -> SortdistradixNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixNode::fill(self : SortdistradixNode, v : Double) -> SortdistradixNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixNode::min(self : SortdistradixNode) -> Double { @_common.min(self.data) }

pub fn SortdistradixNode::max(self : SortdistradixNode) -> Double { @_common.max(self.data) }

pub fn SortdistradixNode::to_string(self : SortdistradixNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_edge_make(size : Int) -> SortdistradixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixEdge::len(self : SortdistradixEdge) -> Int { self.size }

pub fn SortdistradixEdge::get(self : SortdistradixEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixEdge::set(self : SortdistradixEdge, i : Int, v : Double) -> SortdistradixEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixEdge::sum(self : SortdistradixEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistradixEdge::mean(self : SortdistradixEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistradixEdge::scale(self : SortdistradixEdge, f : Double) -> SortdistradixEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixEdge::add(self : SortdistradixEdge, other : SortdistradixEdge) -> SortdistradixEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixEdge::copy(self : SortdistradixEdge) -> SortdistradixEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixEdge::fill(self : SortdistradixEdge, v : Double) -> SortdistradixEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixEdge::min(self : SortdistradixEdge) -> Double { @_common.min(self.data) }

pub fn SortdistradixEdge::max(self : SortdistradixEdge) -> Double { @_common.max(self.data) }

pub fn SortdistradixEdge::to_string(self : SortdistradixEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_path_make(size : Int) -> SortdistradixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixPath::len(self : SortdistradixPath) -> Int { self.size }

pub fn SortdistradixPath::get(self : SortdistradixPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixPath::set(self : SortdistradixPath, i : Int, v : Double) -> SortdistradixPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixPath::sum(self : SortdistradixPath) -> Double { @_common.sum(self.data) }

pub fn SortdistradixPath::mean(self : SortdistradixPath) -> Double { @_common.mean(self.data) }

pub fn SortdistradixPath::scale(self : SortdistradixPath, f : Double) -> SortdistradixPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixPath::add(self : SortdistradixPath, other : SortdistradixPath) -> SortdistradixPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixPath::copy(self : SortdistradixPath) -> SortdistradixPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixPath::fill(self : SortdistradixPath, v : Double) -> SortdistradixPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixPath::min(self : SortdistradixPath) -> Double { @_common.min(self.data) }

pub fn SortdistradixPath::max(self : SortdistradixPath) -> Double { @_common.max(self.data) }

pub fn SortdistradixPath::to_string(self : SortdistradixPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_cluster_make(size : Int) -> SortdistradixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixCluster::len(self : SortdistradixCluster) -> Int { self.size }

pub fn SortdistradixCluster::get(self : SortdistradixCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixCluster::set(self : SortdistradixCluster, i : Int, v : Double) -> SortdistradixCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixCluster::sum(self : SortdistradixCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistradixCluster::mean(self : SortdistradixCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistradixCluster::scale(self : SortdistradixCluster, f : Double) -> SortdistradixCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixCluster::add(self : SortdistradixCluster, other : SortdistradixCluster) -> SortdistradixCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixCluster::copy(self : SortdistradixCluster) -> SortdistradixCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixCluster::fill(self : SortdistradixCluster, v : Double) -> SortdistradixCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixCluster::min(self : SortdistradixCluster) -> Double { @_common.min(self.data) }

pub fn SortdistradixCluster::max(self : SortdistradixCluster) -> Double { @_common.max(self.data) }

pub fn SortdistradixCluster::to_string(self : SortdistradixCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_model_make(size : Int) -> SortdistradixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixModel::len(self : SortdistradixModel) -> Int { self.size }

pub fn SortdistradixModel::get(self : SortdistradixModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixModel::set(self : SortdistradixModel, i : Int, v : Double) -> SortdistradixModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixModel::sum(self : SortdistradixModel) -> Double { @_common.sum(self.data) }

pub fn SortdistradixModel::mean(self : SortdistradixModel) -> Double { @_common.mean(self.data) }

pub fn SortdistradixModel::scale(self : SortdistradixModel, f : Double) -> SortdistradixModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixModel::add(self : SortdistradixModel, other : SortdistradixModel) -> SortdistradixModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixModel::copy(self : SortdistradixModel) -> SortdistradixModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixModel::fill(self : SortdistradixModel, v : Double) -> SortdistradixModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixModel::min(self : SortdistradixModel) -> Double { @_common.min(self.data) }

pub fn SortdistradixModel::max(self : SortdistradixModel) -> Double { @_common.max(self.data) }

pub fn SortdistradixModel::to_string(self : SortdistradixModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_layer_make(size : Int) -> SortdistradixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixLayer::len(self : SortdistradixLayer) -> Int { self.size }

pub fn SortdistradixLayer::get(self : SortdistradixLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixLayer::set(self : SortdistradixLayer, i : Int, v : Double) -> SortdistradixLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixLayer::sum(self : SortdistradixLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistradixLayer::mean(self : SortdistradixLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistradixLayer::scale(self : SortdistradixLayer, f : Double) -> SortdistradixLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixLayer::add(self : SortdistradixLayer, other : SortdistradixLayer) -> SortdistradixLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixLayer::copy(self : SortdistradixLayer) -> SortdistradixLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixLayer::fill(self : SortdistradixLayer, v : Double) -> SortdistradixLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixLayer::min(self : SortdistradixLayer) -> Double { @_common.min(self.data) }

pub fn SortdistradixLayer::max(self : SortdistradixLayer) -> Double { @_common.max(self.data) }

pub fn SortdistradixLayer::to_string(self : SortdistradixLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_buffer_make(size : Int) -> SortdistradixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixBuffer::len(self : SortdistradixBuffer) -> Int { self.size }

pub fn SortdistradixBuffer::get(self : SortdistradixBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixBuffer::set(self : SortdistradixBuffer, i : Int, v : Double) -> SortdistradixBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixBuffer::sum(self : SortdistradixBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistradixBuffer::mean(self : SortdistradixBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistradixBuffer::scale(self : SortdistradixBuffer, f : Double) -> SortdistradixBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixBuffer::add(self : SortdistradixBuffer, other : SortdistradixBuffer) -> SortdistradixBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixBuffer::copy(self : SortdistradixBuffer) -> SortdistradixBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixBuffer::fill(self : SortdistradixBuffer, v : Double) -> SortdistradixBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixBuffer::min(self : SortdistradixBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistradixBuffer::max(self : SortdistradixBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistradixBuffer::to_string(self : SortdistradixBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_cursor_make(size : Int) -> SortdistradixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixCursor::len(self : SortdistradixCursor) -> Int { self.size }

pub fn SortdistradixCursor::get(self : SortdistradixCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixCursor::set(self : SortdistradixCursor, i : Int, v : Double) -> SortdistradixCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixCursor::sum(self : SortdistradixCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistradixCursor::mean(self : SortdistradixCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistradixCursor::scale(self : SortdistradixCursor, f : Double) -> SortdistradixCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixCursor::add(self : SortdistradixCursor, other : SortdistradixCursor) -> SortdistradixCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixCursor::copy(self : SortdistradixCursor) -> SortdistradixCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixCursor::fill(self : SortdistradixCursor, v : Double) -> SortdistradixCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixCursor::min(self : SortdistradixCursor) -> Double { @_common.min(self.data) }

pub fn SortdistradixCursor::max(self : SortdistradixCursor) -> Double { @_common.max(self.data) }

pub fn SortdistradixCursor::to_string(self : SortdistradixCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_view_make(size : Int) -> SortdistradixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixView::len(self : SortdistradixView) -> Int { self.size }

pub fn SortdistradixView::get(self : SortdistradixView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixView::set(self : SortdistradixView, i : Int, v : Double) -> SortdistradixView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixView::sum(self : SortdistradixView) -> Double { @_common.sum(self.data) }

pub fn SortdistradixView::mean(self : SortdistradixView) -> Double { @_common.mean(self.data) }

pub fn SortdistradixView::scale(self : SortdistradixView, f : Double) -> SortdistradixView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixView::add(self : SortdistradixView, other : SortdistradixView) -> SortdistradixView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixView::copy(self : SortdistradixView) -> SortdistradixView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixView::fill(self : SortdistradixView, v : Double) -> SortdistradixView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixView::min(self : SortdistradixView) -> Double { @_common.min(self.data) }

pub fn SortdistradixView::max(self : SortdistradixView) -> Double { @_common.max(self.data) }

pub fn SortdistradixView::to_string(self : SortdistradixView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_range_make(size : Int) -> SortdistradixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixRange::len(self : SortdistradixRange) -> Int { self.size }

pub fn SortdistradixRange::get(self : SortdistradixRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixRange::set(self : SortdistradixRange, i : Int, v : Double) -> SortdistradixRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixRange::sum(self : SortdistradixRange) -> Double { @_common.sum(self.data) }

pub fn SortdistradixRange::mean(self : SortdistradixRange) -> Double { @_common.mean(self.data) }

pub fn SortdistradixRange::scale(self : SortdistradixRange, f : Double) -> SortdistradixRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixRange::add(self : SortdistradixRange, other : SortdistradixRange) -> SortdistradixRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixRange::copy(self : SortdistradixRange) -> SortdistradixRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixRange::fill(self : SortdistradixRange, v : Double) -> SortdistradixRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixRange::min(self : SortdistradixRange) -> Double { @_common.min(self.data) }

pub fn SortdistradixRange::max(self : SortdistradixRange) -> Double { @_common.max(self.data) }

pub fn SortdistradixRange::to_string(self : SortdistradixRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistradixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_slice_make(size : Int) -> SortdistradixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistradixSlice::len(self : SortdistradixSlice) -> Int { self.size }

pub fn SortdistradixSlice::get(self : SortdistradixSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistradixSlice::set(self : SortdistradixSlice, i : Int, v : Double) -> SortdistradixSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistradixSlice::sum(self : SortdistradixSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistradixSlice::mean(self : SortdistradixSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistradixSlice::scale(self : SortdistradixSlice, f : Double) -> SortdistradixSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistradixSlice::add(self : SortdistradixSlice, other : SortdistradixSlice) -> SortdistradixSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistradixSlice::copy(self : SortdistradixSlice) -> SortdistradixSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistradixSlice::fill(self : SortdistradixSlice, v : Double) -> SortdistradixSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistradixSlice::min(self : SortdistradixSlice) -> Double { @_common.min(self.data) }

pub fn SortdistradixSlice::max(self : SortdistradixSlice) -> Double { @_common.max(self.data) }

pub fn SortdistradixSlice::to_string(self : SortdistradixSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

