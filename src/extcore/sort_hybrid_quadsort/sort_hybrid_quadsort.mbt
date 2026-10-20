///===
/// extcore/sort_hybrid_quadsort

pub(all) struct SorthybridquadsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_quadsort_make_point(x : Double, y : Double) -> SorthybridquadsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_quadsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridquadsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridquadsortPoint::x(self : SorthybridquadsortPoint) -> Double { self.x }

pub fn SorthybridquadsortPoint::y(self : SorthybridquadsortPoint) -> Double { self.y }

pub fn SorthybridquadsortPoint::z(self : SorthybridquadsortPoint) -> Double { self.z }

pub fn SorthybridquadsortPoint::label(self : SorthybridquadsortPoint) -> Int { self.label }

pub fn SorthybridquadsortPoint::dist(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridquadsortPoint::add(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridquadsortPoint::sub(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridquadsortPoint::scale(self : SorthybridquadsortPoint, s : Double) -> SorthybridquadsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridquadsortPoint::dot(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridquadsortPoint::cross(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridquadsortPoint::norm(self : SorthybridquadsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridquadsortPoint::normalize(self : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridquadsortPoint::negate(self : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridquadsortPoint::mid(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridquadsortPoint::lerp(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint, t : Double) -> SorthybridquadsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridquadsortPoint::to_string(self : SorthybridquadsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridquadsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_quadsort_make_series(vals : Array[Double], name : String) -> SorthybridquadsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridquadsortSeries::len(self : SorthybridquadsortSeries) -> Int { self.vals.length() }

pub fn SorthybridquadsortSeries::sum(self : SorthybridquadsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridquadsortSeries::mean(self : SorthybridquadsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridquadsortSeries::min(self : SorthybridquadsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridquadsortSeries::max(self : SorthybridquadsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridquadsortSeries::range(self : SorthybridquadsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridquadsortSeries::variance(self : SorthybridquadsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridquadsortSeries::std(self : SorthybridquadsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridquadsortSeries::median(self : SorthybridquadsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridquadsortSeries::scale(self : SorthybridquadsortSeries, f : Double) -> SorthybridquadsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridquadsortSeries::add(self : SorthybridquadsortSeries, other : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridquadsortSeries::sub(self : SorthybridquadsortSeries, other : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridquadsortSeries::normalize(self : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridquadsortSeries::cumsum(self : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridquadsortSeries::to_string(self : SorthybridquadsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridquadsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_quadsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridquadsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_quadsort_matrix_identity(n : Int) -> SorthybridquadsortMatrix {
  let m = sort_hybrid_quadsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridquadsortMatrix::get(self : SorthybridquadsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridquadsortMatrix::transpose(self : SorthybridquadsortMatrix) -> SorthybridquadsortMatrix {
  let result = sort_hybrid_quadsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridquadsortMatrix::add(self : SorthybridquadsortMatrix, other : SorthybridquadsortMatrix) -> SorthybridquadsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_quadsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridquadsortMatrix::scale(self : SorthybridquadsortMatrix, s : Double) -> SorthybridquadsortMatrix {
  let result = sort_hybrid_quadsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridquadsortMatrix::multiply(self : SorthybridquadsortMatrix, other : SorthybridquadsortMatrix) -> SorthybridquadsortMatrix {
  if self.cols != other.rows { return sort_hybrid_quadsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_quadsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SorthybridquadsortMatrix::trace(self : SorthybridquadsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridquadsortMatrix::det(self : SorthybridquadsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridquadsortMatrix::norm(self : SorthybridquadsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridquadsortMatrix::to_string(self : SorthybridquadsortMatrix) -> String {
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

pub(all) struct SorthybridquadsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_quadsort_make_vector(comps : Array[Double]) -> SorthybridquadsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_quadsort_vector_zero(dim : Int) -> SorthybridquadsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridquadsortVector::add(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> SorthybridquadsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridquadsortVector::sub(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> SorthybridquadsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridquadsortVector::scale(self : SorthybridquadsortVector, s : Double) -> SorthybridquadsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridquadsortVector::dot(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridquadsortVector::norm(self : SorthybridquadsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridquadsortVector::normalize(self : SorthybridquadsortVector) -> SorthybridquadsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridquadsortVector::dist(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridquadsortVector::to_string(self : SorthybridquadsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridquadsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_frame_make(size : Int) -> SorthybridquadsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortFrame::len(self : SorthybridquadsortFrame) -> Int { self.size }

pub fn SorthybridquadsortFrame::get(self : SorthybridquadsortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortFrame::set(self : SorthybridquadsortFrame, i : Int, v : Double) -> SorthybridquadsortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortFrame::sum(self : SorthybridquadsortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortFrame::mean(self : SorthybridquadsortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortFrame::scale(self : SorthybridquadsortFrame, f : Double) -> SorthybridquadsortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortFrame::add(self : SorthybridquadsortFrame, other : SorthybridquadsortFrame) -> SorthybridquadsortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortFrame::copy(self : SorthybridquadsortFrame) -> SorthybridquadsortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortFrame::fill(self : SorthybridquadsortFrame, v : Double) -> SorthybridquadsortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortFrame::min(self : SorthybridquadsortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortFrame::max(self : SorthybridquadsortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortFrame::to_string(self : SorthybridquadsortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_table_make(size : Int) -> SorthybridquadsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortTable::len(self : SorthybridquadsortTable) -> Int { self.size }

pub fn SorthybridquadsortTable::get(self : SorthybridquadsortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortTable::set(self : SorthybridquadsortTable, i : Int, v : Double) -> SorthybridquadsortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortTable::sum(self : SorthybridquadsortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortTable::mean(self : SorthybridquadsortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortTable::scale(self : SorthybridquadsortTable, f : Double) -> SorthybridquadsortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortTable::add(self : SorthybridquadsortTable, other : SorthybridquadsortTable) -> SorthybridquadsortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortTable::copy(self : SorthybridquadsortTable) -> SorthybridquadsortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortTable::fill(self : SorthybridquadsortTable, v : Double) -> SorthybridquadsortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortTable::min(self : SorthybridquadsortTable) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortTable::max(self : SorthybridquadsortTable) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortTable::to_string(self : SorthybridquadsortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_graphn_make(size : Int) -> SorthybridquadsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortGraphN::len(self : SorthybridquadsortGraphN) -> Int { self.size }

pub fn SorthybridquadsortGraphN::get(self : SorthybridquadsortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortGraphN::set(self : SorthybridquadsortGraphN, i : Int, v : Double) -> SorthybridquadsortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortGraphN::sum(self : SorthybridquadsortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortGraphN::mean(self : SorthybridquadsortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortGraphN::scale(self : SorthybridquadsortGraphN, f : Double) -> SorthybridquadsortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortGraphN::add(self : SorthybridquadsortGraphN, other : SorthybridquadsortGraphN) -> SorthybridquadsortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortGraphN::copy(self : SorthybridquadsortGraphN) -> SorthybridquadsortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortGraphN::fill(self : SorthybridquadsortGraphN, v : Double) -> SorthybridquadsortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortGraphN::min(self : SorthybridquadsortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortGraphN::max(self : SorthybridquadsortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortGraphN::to_string(self : SorthybridquadsortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_node_make(size : Int) -> SorthybridquadsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortNode::len(self : SorthybridquadsortNode) -> Int { self.size }

pub fn SorthybridquadsortNode::get(self : SorthybridquadsortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortNode::set(self : SorthybridquadsortNode, i : Int, v : Double) -> SorthybridquadsortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortNode::sum(self : SorthybridquadsortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortNode::mean(self : SorthybridquadsortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortNode::scale(self : SorthybridquadsortNode, f : Double) -> SorthybridquadsortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortNode::add(self : SorthybridquadsortNode, other : SorthybridquadsortNode) -> SorthybridquadsortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortNode::copy(self : SorthybridquadsortNode) -> SorthybridquadsortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortNode::fill(self : SorthybridquadsortNode, v : Double) -> SorthybridquadsortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortNode::min(self : SorthybridquadsortNode) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortNode::max(self : SorthybridquadsortNode) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortNode::to_string(self : SorthybridquadsortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_edge_make(size : Int) -> SorthybridquadsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortEdge::len(self : SorthybridquadsortEdge) -> Int { self.size }

pub fn SorthybridquadsortEdge::get(self : SorthybridquadsortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortEdge::set(self : SorthybridquadsortEdge, i : Int, v : Double) -> SorthybridquadsortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortEdge::sum(self : SorthybridquadsortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortEdge::mean(self : SorthybridquadsortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortEdge::scale(self : SorthybridquadsortEdge, f : Double) -> SorthybridquadsortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortEdge::add(self : SorthybridquadsortEdge, other : SorthybridquadsortEdge) -> SorthybridquadsortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortEdge::copy(self : SorthybridquadsortEdge) -> SorthybridquadsortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortEdge::fill(self : SorthybridquadsortEdge, v : Double) -> SorthybridquadsortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortEdge::min(self : SorthybridquadsortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortEdge::max(self : SorthybridquadsortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortEdge::to_string(self : SorthybridquadsortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_path_make(size : Int) -> SorthybridquadsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortPath::len(self : SorthybridquadsortPath) -> Int { self.size }

pub fn SorthybridquadsortPath::get(self : SorthybridquadsortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortPath::set(self : SorthybridquadsortPath, i : Int, v : Double) -> SorthybridquadsortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortPath::sum(self : SorthybridquadsortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortPath::mean(self : SorthybridquadsortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortPath::scale(self : SorthybridquadsortPath, f : Double) -> SorthybridquadsortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortPath::add(self : SorthybridquadsortPath, other : SorthybridquadsortPath) -> SorthybridquadsortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortPath::copy(self : SorthybridquadsortPath) -> SorthybridquadsortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortPath::fill(self : SorthybridquadsortPath, v : Double) -> SorthybridquadsortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortPath::min(self : SorthybridquadsortPath) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortPath::max(self : SorthybridquadsortPath) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortPath::to_string(self : SorthybridquadsortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_cluster_make(size : Int) -> SorthybridquadsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortCluster::len(self : SorthybridquadsortCluster) -> Int { self.size }

pub fn SorthybridquadsortCluster::get(self : SorthybridquadsortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortCluster::set(self : SorthybridquadsortCluster, i : Int, v : Double) -> SorthybridquadsortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCluster::sum(self : SorthybridquadsortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortCluster::mean(self : SorthybridquadsortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortCluster::scale(self : SorthybridquadsortCluster, f : Double) -> SorthybridquadsortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCluster::add(self : SorthybridquadsortCluster, other : SorthybridquadsortCluster) -> SorthybridquadsortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortCluster::copy(self : SorthybridquadsortCluster) -> SorthybridquadsortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCluster::fill(self : SorthybridquadsortCluster, v : Double) -> SorthybridquadsortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCluster::min(self : SorthybridquadsortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortCluster::max(self : SorthybridquadsortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortCluster::to_string(self : SorthybridquadsortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_model_make(size : Int) -> SorthybridquadsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortModel::len(self : SorthybridquadsortModel) -> Int { self.size }

pub fn SorthybridquadsortModel::get(self : SorthybridquadsortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortModel::set(self : SorthybridquadsortModel, i : Int, v : Double) -> SorthybridquadsortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortModel::sum(self : SorthybridquadsortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortModel::mean(self : SorthybridquadsortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortModel::scale(self : SorthybridquadsortModel, f : Double) -> SorthybridquadsortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortModel::add(self : SorthybridquadsortModel, other : SorthybridquadsortModel) -> SorthybridquadsortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortModel::copy(self : SorthybridquadsortModel) -> SorthybridquadsortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortModel::fill(self : SorthybridquadsortModel, v : Double) -> SorthybridquadsortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortModel::min(self : SorthybridquadsortModel) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortModel::max(self : SorthybridquadsortModel) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortModel::to_string(self : SorthybridquadsortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_layer_make(size : Int) -> SorthybridquadsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortLayer::len(self : SorthybridquadsortLayer) -> Int { self.size }

pub fn SorthybridquadsortLayer::get(self : SorthybridquadsortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortLayer::set(self : SorthybridquadsortLayer, i : Int, v : Double) -> SorthybridquadsortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortLayer::sum(self : SorthybridquadsortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortLayer::mean(self : SorthybridquadsortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortLayer::scale(self : SorthybridquadsortLayer, f : Double) -> SorthybridquadsortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortLayer::add(self : SorthybridquadsortLayer, other : SorthybridquadsortLayer) -> SorthybridquadsortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortLayer::copy(self : SorthybridquadsortLayer) -> SorthybridquadsortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortLayer::fill(self : SorthybridquadsortLayer, v : Double) -> SorthybridquadsortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortLayer::min(self : SorthybridquadsortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortLayer::max(self : SorthybridquadsortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortLayer::to_string(self : SorthybridquadsortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_buffer_make(size : Int) -> SorthybridquadsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortBuffer::len(self : SorthybridquadsortBuffer) -> Int { self.size }

pub fn SorthybridquadsortBuffer::get(self : SorthybridquadsortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortBuffer::set(self : SorthybridquadsortBuffer, i : Int, v : Double) -> SorthybridquadsortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortBuffer::sum(self : SorthybridquadsortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortBuffer::mean(self : SorthybridquadsortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortBuffer::scale(self : SorthybridquadsortBuffer, f : Double) -> SorthybridquadsortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortBuffer::add(self : SorthybridquadsortBuffer, other : SorthybridquadsortBuffer) -> SorthybridquadsortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortBuffer::copy(self : SorthybridquadsortBuffer) -> SorthybridquadsortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortBuffer::fill(self : SorthybridquadsortBuffer, v : Double) -> SorthybridquadsortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortBuffer::min(self : SorthybridquadsortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortBuffer::max(self : SorthybridquadsortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortBuffer::to_string(self : SorthybridquadsortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_cursor_make(size : Int) -> SorthybridquadsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortCursor::len(self : SorthybridquadsortCursor) -> Int { self.size }

pub fn SorthybridquadsortCursor::get(self : SorthybridquadsortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortCursor::set(self : SorthybridquadsortCursor, i : Int, v : Double) -> SorthybridquadsortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCursor::sum(self : SorthybridquadsortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortCursor::mean(self : SorthybridquadsortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortCursor::scale(self : SorthybridquadsortCursor, f : Double) -> SorthybridquadsortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCursor::add(self : SorthybridquadsortCursor, other : SorthybridquadsortCursor) -> SorthybridquadsortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortCursor::copy(self : SorthybridquadsortCursor) -> SorthybridquadsortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCursor::fill(self : SorthybridquadsortCursor, v : Double) -> SorthybridquadsortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortCursor::min(self : SorthybridquadsortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortCursor::max(self : SorthybridquadsortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortCursor::to_string(self : SorthybridquadsortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_view_make(size : Int) -> SorthybridquadsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortView::len(self : SorthybridquadsortView) -> Int { self.size }

pub fn SorthybridquadsortView::get(self : SorthybridquadsortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortView::set(self : SorthybridquadsortView, i : Int, v : Double) -> SorthybridquadsortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortView::sum(self : SorthybridquadsortView) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortView::mean(self : SorthybridquadsortView) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortView::scale(self : SorthybridquadsortView, f : Double) -> SorthybridquadsortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortView::add(self : SorthybridquadsortView, other : SorthybridquadsortView) -> SorthybridquadsortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortView::copy(self : SorthybridquadsortView) -> SorthybridquadsortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortView::fill(self : SorthybridquadsortView, v : Double) -> SorthybridquadsortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortView::min(self : SorthybridquadsortView) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortView::max(self : SorthybridquadsortView) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortView::to_string(self : SorthybridquadsortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_range_make(size : Int) -> SorthybridquadsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortRange::len(self : SorthybridquadsortRange) -> Int { self.size }

pub fn SorthybridquadsortRange::get(self : SorthybridquadsortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortRange::set(self : SorthybridquadsortRange, i : Int, v : Double) -> SorthybridquadsortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortRange::sum(self : SorthybridquadsortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortRange::mean(self : SorthybridquadsortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortRange::scale(self : SorthybridquadsortRange, f : Double) -> SorthybridquadsortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortRange::add(self : SorthybridquadsortRange, other : SorthybridquadsortRange) -> SorthybridquadsortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortRange::copy(self : SorthybridquadsortRange) -> SorthybridquadsortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortRange::fill(self : SorthybridquadsortRange, v : Double) -> SorthybridquadsortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortRange::min(self : SorthybridquadsortRange) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortRange::max(self : SorthybridquadsortRange) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortRange::to_string(self : SorthybridquadsortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_slice_make(size : Int) -> SorthybridquadsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridquadsortSlice::len(self : SorthybridquadsortSlice) -> Int { self.size }

pub fn SorthybridquadsortSlice::get(self : SorthybridquadsortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridquadsortSlice::set(self : SorthybridquadsortSlice, i : Int, v : Double) -> SorthybridquadsortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortSlice::sum(self : SorthybridquadsortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybridquadsortSlice::mean(self : SorthybridquadsortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybridquadsortSlice::scale(self : SorthybridquadsortSlice, f : Double) -> SorthybridquadsortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortSlice::add(self : SorthybridquadsortSlice, other : SorthybridquadsortSlice) -> SorthybridquadsortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridquadsortSlice::copy(self : SorthybridquadsortSlice) -> SorthybridquadsortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortSlice::fill(self : SorthybridquadsortSlice, v : Double) -> SorthybridquadsortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridquadsortSlice::min(self : SorthybridquadsortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybridquadsortSlice::max(self : SorthybridquadsortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybridquadsortSlice::to_string(self : SorthybridquadsortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

