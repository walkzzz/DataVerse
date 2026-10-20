///===
/// extcore/sort_hybrid_introsort

pub(all) struct SorthybridintrosortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_introsort_make_point(x : Double, y : Double) -> SorthybridintrosortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_introsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridintrosortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridintrosortPoint::x(self : SorthybridintrosortPoint) -> Double { self.x }

pub fn SorthybridintrosortPoint::y(self : SorthybridintrosortPoint) -> Double { self.y }

pub fn SorthybridintrosortPoint::z(self : SorthybridintrosortPoint) -> Double { self.z }

pub fn SorthybridintrosortPoint::label(self : SorthybridintrosortPoint) -> Int { self.label }

pub fn SorthybridintrosortPoint::dist(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridintrosortPoint::add(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridintrosortPoint::sub(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridintrosortPoint::scale(self : SorthybridintrosortPoint, s : Double) -> SorthybridintrosortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridintrosortPoint::dot(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridintrosortPoint::cross(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridintrosortPoint::norm(self : SorthybridintrosortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridintrosortPoint::normalize(self : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridintrosortPoint::negate(self : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridintrosortPoint::mid(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridintrosortPoint::lerp(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint, t : Double) -> SorthybridintrosortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridintrosortPoint::to_string(self : SorthybridintrosortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridintrosortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_introsort_make_series(vals : Array[Double], name : String) -> SorthybridintrosortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridintrosortSeries::len(self : SorthybridintrosortSeries) -> Int { self.vals.length() }

pub fn SorthybridintrosortSeries::sum(self : SorthybridintrosortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridintrosortSeries::mean(self : SorthybridintrosortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridintrosortSeries::min(self : SorthybridintrosortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridintrosortSeries::max(self : SorthybridintrosortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridintrosortSeries::range(self : SorthybridintrosortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridintrosortSeries::variance(self : SorthybridintrosortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridintrosortSeries::std(self : SorthybridintrosortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridintrosortSeries::median(self : SorthybridintrosortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridintrosortSeries::scale(self : SorthybridintrosortSeries, f : Double) -> SorthybridintrosortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridintrosortSeries::add(self : SorthybridintrosortSeries, other : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridintrosortSeries::sub(self : SorthybridintrosortSeries, other : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridintrosortSeries::normalize(self : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridintrosortSeries::cumsum(self : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridintrosortSeries::to_string(self : SorthybridintrosortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridintrosortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_introsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridintrosortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_introsort_matrix_identity(n : Int) -> SorthybridintrosortMatrix {
  let m = sort_hybrid_introsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridintrosortMatrix::get(self : SorthybridintrosortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridintrosortMatrix::transpose(self : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  let result = sort_hybrid_introsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridintrosortMatrix::add(self : SorthybridintrosortMatrix, other : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_introsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridintrosortMatrix::scale(self : SorthybridintrosortMatrix, s : Double) -> SorthybridintrosortMatrix {
  let result = sort_hybrid_introsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridintrosortMatrix::multiply(self : SorthybridintrosortMatrix, other : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  if self.cols != other.rows { return sort_hybrid_introsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_introsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SorthybridintrosortMatrix::trace(self : SorthybridintrosortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridintrosortMatrix::det(self : SorthybridintrosortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridintrosortMatrix::norm(self : SorthybridintrosortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridintrosortMatrix::to_string(self : SorthybridintrosortMatrix) -> String {
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

pub(all) struct SorthybridintrosortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_introsort_make_vector(comps : Array[Double]) -> SorthybridintrosortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_introsort_vector_zero(dim : Int) -> SorthybridintrosortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridintrosortVector::add(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridintrosortVector::sub(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridintrosortVector::scale(self : SorthybridintrosortVector, s : Double) -> SorthybridintrosortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridintrosortVector::dot(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridintrosortVector::norm(self : SorthybridintrosortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridintrosortVector::normalize(self : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridintrosortVector::dist(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridintrosortVector::to_string(self : SorthybridintrosortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridintrosortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_frame_make(size : Int) -> SorthybridintrosortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortFrame::len(self : SorthybridintrosortFrame) -> Int { self.size }

pub fn SorthybridintrosortFrame::get(self : SorthybridintrosortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortFrame::set(self : SorthybridintrosortFrame, i : Int, v : Double) -> SorthybridintrosortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortFrame::sum(self : SorthybridintrosortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortFrame::mean(self : SorthybridintrosortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortFrame::scale(self : SorthybridintrosortFrame, f : Double) -> SorthybridintrosortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortFrame::add(self : SorthybridintrosortFrame, other : SorthybridintrosortFrame) -> SorthybridintrosortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortFrame::copy(self : SorthybridintrosortFrame) -> SorthybridintrosortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortFrame::fill(self : SorthybridintrosortFrame, v : Double) -> SorthybridintrosortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortFrame::min(self : SorthybridintrosortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortFrame::max(self : SorthybridintrosortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortFrame::to_string(self : SorthybridintrosortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_table_make(size : Int) -> SorthybridintrosortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortTable::len(self : SorthybridintrosortTable) -> Int { self.size }

pub fn SorthybridintrosortTable::get(self : SorthybridintrosortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortTable::set(self : SorthybridintrosortTable, i : Int, v : Double) -> SorthybridintrosortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortTable::sum(self : SorthybridintrosortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortTable::mean(self : SorthybridintrosortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortTable::scale(self : SorthybridintrosortTable, f : Double) -> SorthybridintrosortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortTable::add(self : SorthybridintrosortTable, other : SorthybridintrosortTable) -> SorthybridintrosortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortTable::copy(self : SorthybridintrosortTable) -> SorthybridintrosortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortTable::fill(self : SorthybridintrosortTable, v : Double) -> SorthybridintrosortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortTable::min(self : SorthybridintrosortTable) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortTable::max(self : SorthybridintrosortTable) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortTable::to_string(self : SorthybridintrosortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_graphn_make(size : Int) -> SorthybridintrosortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortGraphN::len(self : SorthybridintrosortGraphN) -> Int { self.size }

pub fn SorthybridintrosortGraphN::get(self : SorthybridintrosortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortGraphN::set(self : SorthybridintrosortGraphN, i : Int, v : Double) -> SorthybridintrosortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortGraphN::sum(self : SorthybridintrosortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortGraphN::mean(self : SorthybridintrosortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortGraphN::scale(self : SorthybridintrosortGraphN, f : Double) -> SorthybridintrosortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortGraphN::add(self : SorthybridintrosortGraphN, other : SorthybridintrosortGraphN) -> SorthybridintrosortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortGraphN::copy(self : SorthybridintrosortGraphN) -> SorthybridintrosortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortGraphN::fill(self : SorthybridintrosortGraphN, v : Double) -> SorthybridintrosortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortGraphN::min(self : SorthybridintrosortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortGraphN::max(self : SorthybridintrosortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortGraphN::to_string(self : SorthybridintrosortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_node_make(size : Int) -> SorthybridintrosortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortNode::len(self : SorthybridintrosortNode) -> Int { self.size }

pub fn SorthybridintrosortNode::get(self : SorthybridintrosortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortNode::set(self : SorthybridintrosortNode, i : Int, v : Double) -> SorthybridintrosortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortNode::sum(self : SorthybridintrosortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortNode::mean(self : SorthybridintrosortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortNode::scale(self : SorthybridintrosortNode, f : Double) -> SorthybridintrosortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortNode::add(self : SorthybridintrosortNode, other : SorthybridintrosortNode) -> SorthybridintrosortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortNode::copy(self : SorthybridintrosortNode) -> SorthybridintrosortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortNode::fill(self : SorthybridintrosortNode, v : Double) -> SorthybridintrosortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortNode::min(self : SorthybridintrosortNode) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortNode::max(self : SorthybridintrosortNode) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortNode::to_string(self : SorthybridintrosortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_edge_make(size : Int) -> SorthybridintrosortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortEdge::len(self : SorthybridintrosortEdge) -> Int { self.size }

pub fn SorthybridintrosortEdge::get(self : SorthybridintrosortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortEdge::set(self : SorthybridintrosortEdge, i : Int, v : Double) -> SorthybridintrosortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortEdge::sum(self : SorthybridintrosortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortEdge::mean(self : SorthybridintrosortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortEdge::scale(self : SorthybridintrosortEdge, f : Double) -> SorthybridintrosortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortEdge::add(self : SorthybridintrosortEdge, other : SorthybridintrosortEdge) -> SorthybridintrosortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortEdge::copy(self : SorthybridintrosortEdge) -> SorthybridintrosortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortEdge::fill(self : SorthybridintrosortEdge, v : Double) -> SorthybridintrosortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortEdge::min(self : SorthybridintrosortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortEdge::max(self : SorthybridintrosortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortEdge::to_string(self : SorthybridintrosortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_path_make(size : Int) -> SorthybridintrosortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortPath::len(self : SorthybridintrosortPath) -> Int { self.size }

pub fn SorthybridintrosortPath::get(self : SorthybridintrosortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortPath::set(self : SorthybridintrosortPath, i : Int, v : Double) -> SorthybridintrosortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortPath::sum(self : SorthybridintrosortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortPath::mean(self : SorthybridintrosortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortPath::scale(self : SorthybridintrosortPath, f : Double) -> SorthybridintrosortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortPath::add(self : SorthybridintrosortPath, other : SorthybridintrosortPath) -> SorthybridintrosortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortPath::copy(self : SorthybridintrosortPath) -> SorthybridintrosortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortPath::fill(self : SorthybridintrosortPath, v : Double) -> SorthybridintrosortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortPath::min(self : SorthybridintrosortPath) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortPath::max(self : SorthybridintrosortPath) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortPath::to_string(self : SorthybridintrosortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_cluster_make(size : Int) -> SorthybridintrosortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortCluster::len(self : SorthybridintrosortCluster) -> Int { self.size }

pub fn SorthybridintrosortCluster::get(self : SorthybridintrosortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortCluster::set(self : SorthybridintrosortCluster, i : Int, v : Double) -> SorthybridintrosortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCluster::sum(self : SorthybridintrosortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortCluster::mean(self : SorthybridintrosortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortCluster::scale(self : SorthybridintrosortCluster, f : Double) -> SorthybridintrosortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCluster::add(self : SorthybridintrosortCluster, other : SorthybridintrosortCluster) -> SorthybridintrosortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortCluster::copy(self : SorthybridintrosortCluster) -> SorthybridintrosortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCluster::fill(self : SorthybridintrosortCluster, v : Double) -> SorthybridintrosortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCluster::min(self : SorthybridintrosortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortCluster::max(self : SorthybridintrosortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortCluster::to_string(self : SorthybridintrosortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_model_make(size : Int) -> SorthybridintrosortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortModel::len(self : SorthybridintrosortModel) -> Int { self.size }

pub fn SorthybridintrosortModel::get(self : SorthybridintrosortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortModel::set(self : SorthybridintrosortModel, i : Int, v : Double) -> SorthybridintrosortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortModel::sum(self : SorthybridintrosortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortModel::mean(self : SorthybridintrosortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortModel::scale(self : SorthybridintrosortModel, f : Double) -> SorthybridintrosortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortModel::add(self : SorthybridintrosortModel, other : SorthybridintrosortModel) -> SorthybridintrosortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortModel::copy(self : SorthybridintrosortModel) -> SorthybridintrosortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortModel::fill(self : SorthybridintrosortModel, v : Double) -> SorthybridintrosortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortModel::min(self : SorthybridintrosortModel) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortModel::max(self : SorthybridintrosortModel) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortModel::to_string(self : SorthybridintrosortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_layer_make(size : Int) -> SorthybridintrosortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortLayer::len(self : SorthybridintrosortLayer) -> Int { self.size }

pub fn SorthybridintrosortLayer::get(self : SorthybridintrosortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortLayer::set(self : SorthybridintrosortLayer, i : Int, v : Double) -> SorthybridintrosortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortLayer::sum(self : SorthybridintrosortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortLayer::mean(self : SorthybridintrosortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortLayer::scale(self : SorthybridintrosortLayer, f : Double) -> SorthybridintrosortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortLayer::add(self : SorthybridintrosortLayer, other : SorthybridintrosortLayer) -> SorthybridintrosortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortLayer::copy(self : SorthybridintrosortLayer) -> SorthybridintrosortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortLayer::fill(self : SorthybridintrosortLayer, v : Double) -> SorthybridintrosortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortLayer::min(self : SorthybridintrosortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortLayer::max(self : SorthybridintrosortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortLayer::to_string(self : SorthybridintrosortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_buffer_make(size : Int) -> SorthybridintrosortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortBuffer::len(self : SorthybridintrosortBuffer) -> Int { self.size }

pub fn SorthybridintrosortBuffer::get(self : SorthybridintrosortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortBuffer::set(self : SorthybridintrosortBuffer, i : Int, v : Double) -> SorthybridintrosortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortBuffer::sum(self : SorthybridintrosortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortBuffer::mean(self : SorthybridintrosortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortBuffer::scale(self : SorthybridintrosortBuffer, f : Double) -> SorthybridintrosortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortBuffer::add(self : SorthybridintrosortBuffer, other : SorthybridintrosortBuffer) -> SorthybridintrosortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortBuffer::copy(self : SorthybridintrosortBuffer) -> SorthybridintrosortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortBuffer::fill(self : SorthybridintrosortBuffer, v : Double) -> SorthybridintrosortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortBuffer::min(self : SorthybridintrosortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortBuffer::max(self : SorthybridintrosortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortBuffer::to_string(self : SorthybridintrosortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_cursor_make(size : Int) -> SorthybridintrosortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortCursor::len(self : SorthybridintrosortCursor) -> Int { self.size }

pub fn SorthybridintrosortCursor::get(self : SorthybridintrosortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortCursor::set(self : SorthybridintrosortCursor, i : Int, v : Double) -> SorthybridintrosortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCursor::sum(self : SorthybridintrosortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortCursor::mean(self : SorthybridintrosortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortCursor::scale(self : SorthybridintrosortCursor, f : Double) -> SorthybridintrosortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCursor::add(self : SorthybridintrosortCursor, other : SorthybridintrosortCursor) -> SorthybridintrosortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortCursor::copy(self : SorthybridintrosortCursor) -> SorthybridintrosortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCursor::fill(self : SorthybridintrosortCursor, v : Double) -> SorthybridintrosortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortCursor::min(self : SorthybridintrosortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortCursor::max(self : SorthybridintrosortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortCursor::to_string(self : SorthybridintrosortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_view_make(size : Int) -> SorthybridintrosortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortView::len(self : SorthybridintrosortView) -> Int { self.size }

pub fn SorthybridintrosortView::get(self : SorthybridintrosortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortView::set(self : SorthybridintrosortView, i : Int, v : Double) -> SorthybridintrosortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortView::sum(self : SorthybridintrosortView) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortView::mean(self : SorthybridintrosortView) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortView::scale(self : SorthybridintrosortView, f : Double) -> SorthybridintrosortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortView::add(self : SorthybridintrosortView, other : SorthybridintrosortView) -> SorthybridintrosortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortView::copy(self : SorthybridintrosortView) -> SorthybridintrosortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortView::fill(self : SorthybridintrosortView, v : Double) -> SorthybridintrosortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortView::min(self : SorthybridintrosortView) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortView::max(self : SorthybridintrosortView) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortView::to_string(self : SorthybridintrosortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_range_make(size : Int) -> SorthybridintrosortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortRange::len(self : SorthybridintrosortRange) -> Int { self.size }

pub fn SorthybridintrosortRange::get(self : SorthybridintrosortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortRange::set(self : SorthybridintrosortRange, i : Int, v : Double) -> SorthybridintrosortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortRange::sum(self : SorthybridintrosortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortRange::mean(self : SorthybridintrosortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortRange::scale(self : SorthybridintrosortRange, f : Double) -> SorthybridintrosortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortRange::add(self : SorthybridintrosortRange, other : SorthybridintrosortRange) -> SorthybridintrosortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortRange::copy(self : SorthybridintrosortRange) -> SorthybridintrosortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortRange::fill(self : SorthybridintrosortRange, v : Double) -> SorthybridintrosortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortRange::min(self : SorthybridintrosortRange) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortRange::max(self : SorthybridintrosortRange) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortRange::to_string(self : SorthybridintrosortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_slice_make(size : Int) -> SorthybridintrosortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridintrosortSlice::len(self : SorthybridintrosortSlice) -> Int { self.size }

pub fn SorthybridintrosortSlice::get(self : SorthybridintrosortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridintrosortSlice::set(self : SorthybridintrosortSlice, i : Int, v : Double) -> SorthybridintrosortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortSlice::sum(self : SorthybridintrosortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybridintrosortSlice::mean(self : SorthybridintrosortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybridintrosortSlice::scale(self : SorthybridintrosortSlice, f : Double) -> SorthybridintrosortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortSlice::add(self : SorthybridintrosortSlice, other : SorthybridintrosortSlice) -> SorthybridintrosortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridintrosortSlice::copy(self : SorthybridintrosortSlice) -> SorthybridintrosortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortSlice::fill(self : SorthybridintrosortSlice, v : Double) -> SorthybridintrosortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridintrosortSlice::min(self : SorthybridintrosortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybridintrosortSlice::max(self : SorthybridintrosortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybridintrosortSlice::to_string(self : SorthybridintrosortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

