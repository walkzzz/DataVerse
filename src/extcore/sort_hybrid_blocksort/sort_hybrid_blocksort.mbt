///===
/// extcore/sort_hybrid_blocksort

pub(all) struct SorthybridblocksortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_blocksort_make_point(x : Double, y : Double) -> SorthybridblocksortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_blocksort_make_point3(x : Double, y : Double, z : Double) -> SorthybridblocksortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridblocksortPoint::x(self : SorthybridblocksortPoint) -> Double { self.x }

pub fn SorthybridblocksortPoint::y(self : SorthybridblocksortPoint) -> Double { self.y }

pub fn SorthybridblocksortPoint::z(self : SorthybridblocksortPoint) -> Double { self.z }

pub fn SorthybridblocksortPoint::label(self : SorthybridblocksortPoint) -> Int { self.label }

pub fn SorthybridblocksortPoint::dist(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridblocksortPoint::add(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridblocksortPoint::sub(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridblocksortPoint::scale(self : SorthybridblocksortPoint, s : Double) -> SorthybridblocksortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridblocksortPoint::dot(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridblocksortPoint::cross(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridblocksortPoint::norm(self : SorthybridblocksortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridblocksortPoint::normalize(self : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridblocksortPoint::negate(self : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridblocksortPoint::mid(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridblocksortPoint::lerp(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint, t : Double) -> SorthybridblocksortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridblocksortPoint::to_string(self : SorthybridblocksortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridblocksortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_blocksort_make_series(vals : Array[Double], name : String) -> SorthybridblocksortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridblocksortSeries::len(self : SorthybridblocksortSeries) -> Int { self.vals.length() }

pub fn SorthybridblocksortSeries::sum(self : SorthybridblocksortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridblocksortSeries::mean(self : SorthybridblocksortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridblocksortSeries::min(self : SorthybridblocksortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridblocksortSeries::max(self : SorthybridblocksortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridblocksortSeries::range(self : SorthybridblocksortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridblocksortSeries::variance(self : SorthybridblocksortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridblocksortSeries::std(self : SorthybridblocksortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridblocksortSeries::median(self : SorthybridblocksortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridblocksortSeries::scale(self : SorthybridblocksortSeries, f : Double) -> SorthybridblocksortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridblocksortSeries::add(self : SorthybridblocksortSeries, other : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridblocksortSeries::sub(self : SorthybridblocksortSeries, other : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridblocksortSeries::normalize(self : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridblocksortSeries::cumsum(self : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridblocksortSeries::to_string(self : SorthybridblocksortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridblocksortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_blocksort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridblocksortMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn sort_hybrid_blocksort_matrix_identity(n : Int) -> SorthybridblocksortMatrix {
  let m = sort_hybrid_blocksort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridblocksortMatrix::get(self : SorthybridblocksortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridblocksortMatrix::transpose(self : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  let result = sort_hybrid_blocksort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridblocksortMatrix::add(self : SorthybridblocksortMatrix, other : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_blocksort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridblocksortMatrix::scale(self : SorthybridblocksortMatrix, s : Double) -> SorthybridblocksortMatrix {
  let result = sort_hybrid_blocksort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridblocksortMatrix::multiply(self : SorthybridblocksortMatrix, other : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  if self.cols != other.rows { return sort_hybrid_blocksort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_blocksort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SorthybridblocksortMatrix::trace(self : SorthybridblocksortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridblocksortMatrix::det(self : SorthybridblocksortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridblocksortMatrix::norm(self : SorthybridblocksortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridblocksortMatrix::to_string(self : SorthybridblocksortMatrix) -> String {
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

pub(all) struct SorthybridblocksortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_blocksort_make_vector(comps : Array[Double]) -> SorthybridblocksortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_blocksort_vector_zero(dim : Int) -> SorthybridblocksortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridblocksortVector::add(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridblocksortVector::sub(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridblocksortVector::scale(self : SorthybridblocksortVector, s : Double) -> SorthybridblocksortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridblocksortVector::dot(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridblocksortVector::norm(self : SorthybridblocksortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridblocksortVector::normalize(self : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridblocksortVector::dist(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridblocksortVector::to_string(self : SorthybridblocksortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridblocksortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_frame_make(size : Int) -> SorthybridblocksortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortFrame::len(self : SorthybridblocksortFrame) -> Int { self.size }

pub fn SorthybridblocksortFrame::get(self : SorthybridblocksortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortFrame::set(self : SorthybridblocksortFrame, i : Int, v : Double) -> SorthybridblocksortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortFrame::sum(self : SorthybridblocksortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortFrame::mean(self : SorthybridblocksortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortFrame::scale(self : SorthybridblocksortFrame, f : Double) -> SorthybridblocksortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortFrame::add(self : SorthybridblocksortFrame, other : SorthybridblocksortFrame) -> SorthybridblocksortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortFrame::copy(self : SorthybridblocksortFrame) -> SorthybridblocksortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortFrame::fill(self : SorthybridblocksortFrame, v : Double) -> SorthybridblocksortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortFrame::min(self : SorthybridblocksortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortFrame::max(self : SorthybridblocksortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortFrame::to_string(self : SorthybridblocksortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_table_make(size : Int) -> SorthybridblocksortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortTable::len(self : SorthybridblocksortTable) -> Int { self.size }

pub fn SorthybridblocksortTable::get(self : SorthybridblocksortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortTable::set(self : SorthybridblocksortTable, i : Int, v : Double) -> SorthybridblocksortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortTable::sum(self : SorthybridblocksortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortTable::mean(self : SorthybridblocksortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortTable::scale(self : SorthybridblocksortTable, f : Double) -> SorthybridblocksortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortTable::add(self : SorthybridblocksortTable, other : SorthybridblocksortTable) -> SorthybridblocksortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortTable::copy(self : SorthybridblocksortTable) -> SorthybridblocksortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortTable::fill(self : SorthybridblocksortTable, v : Double) -> SorthybridblocksortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortTable::min(self : SorthybridblocksortTable) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortTable::max(self : SorthybridblocksortTable) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortTable::to_string(self : SorthybridblocksortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_graphn_make(size : Int) -> SorthybridblocksortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortGraphN::len(self : SorthybridblocksortGraphN) -> Int { self.size }

pub fn SorthybridblocksortGraphN::get(self : SorthybridblocksortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortGraphN::set(self : SorthybridblocksortGraphN, i : Int, v : Double) -> SorthybridblocksortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortGraphN::sum(self : SorthybridblocksortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortGraphN::mean(self : SorthybridblocksortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortGraphN::scale(self : SorthybridblocksortGraphN, f : Double) -> SorthybridblocksortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortGraphN::add(self : SorthybridblocksortGraphN, other : SorthybridblocksortGraphN) -> SorthybridblocksortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortGraphN::copy(self : SorthybridblocksortGraphN) -> SorthybridblocksortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortGraphN::fill(self : SorthybridblocksortGraphN, v : Double) -> SorthybridblocksortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortGraphN::min(self : SorthybridblocksortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortGraphN::max(self : SorthybridblocksortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortGraphN::to_string(self : SorthybridblocksortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_node_make(size : Int) -> SorthybridblocksortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortNode::len(self : SorthybridblocksortNode) -> Int { self.size }

pub fn SorthybridblocksortNode::get(self : SorthybridblocksortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortNode::set(self : SorthybridblocksortNode, i : Int, v : Double) -> SorthybridblocksortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortNode::sum(self : SorthybridblocksortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortNode::mean(self : SorthybridblocksortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortNode::scale(self : SorthybridblocksortNode, f : Double) -> SorthybridblocksortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortNode::add(self : SorthybridblocksortNode, other : SorthybridblocksortNode) -> SorthybridblocksortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortNode::copy(self : SorthybridblocksortNode) -> SorthybridblocksortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortNode::fill(self : SorthybridblocksortNode, v : Double) -> SorthybridblocksortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortNode::min(self : SorthybridblocksortNode) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortNode::max(self : SorthybridblocksortNode) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortNode::to_string(self : SorthybridblocksortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_edge_make(size : Int) -> SorthybridblocksortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortEdge::len(self : SorthybridblocksortEdge) -> Int { self.size }

pub fn SorthybridblocksortEdge::get(self : SorthybridblocksortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortEdge::set(self : SorthybridblocksortEdge, i : Int, v : Double) -> SorthybridblocksortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortEdge::sum(self : SorthybridblocksortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortEdge::mean(self : SorthybridblocksortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortEdge::scale(self : SorthybridblocksortEdge, f : Double) -> SorthybridblocksortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortEdge::add(self : SorthybridblocksortEdge, other : SorthybridblocksortEdge) -> SorthybridblocksortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortEdge::copy(self : SorthybridblocksortEdge) -> SorthybridblocksortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortEdge::fill(self : SorthybridblocksortEdge, v : Double) -> SorthybridblocksortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortEdge::min(self : SorthybridblocksortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortEdge::max(self : SorthybridblocksortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortEdge::to_string(self : SorthybridblocksortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_path_make(size : Int) -> SorthybridblocksortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortPath::len(self : SorthybridblocksortPath) -> Int { self.size }

pub fn SorthybridblocksortPath::get(self : SorthybridblocksortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortPath::set(self : SorthybridblocksortPath, i : Int, v : Double) -> SorthybridblocksortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortPath::sum(self : SorthybridblocksortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortPath::mean(self : SorthybridblocksortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortPath::scale(self : SorthybridblocksortPath, f : Double) -> SorthybridblocksortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortPath::add(self : SorthybridblocksortPath, other : SorthybridblocksortPath) -> SorthybridblocksortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortPath::copy(self : SorthybridblocksortPath) -> SorthybridblocksortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortPath::fill(self : SorthybridblocksortPath, v : Double) -> SorthybridblocksortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortPath::min(self : SorthybridblocksortPath) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortPath::max(self : SorthybridblocksortPath) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortPath::to_string(self : SorthybridblocksortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_cluster_make(size : Int) -> SorthybridblocksortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortCluster::len(self : SorthybridblocksortCluster) -> Int { self.size }

pub fn SorthybridblocksortCluster::get(self : SorthybridblocksortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortCluster::set(self : SorthybridblocksortCluster, i : Int, v : Double) -> SorthybridblocksortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCluster::sum(self : SorthybridblocksortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortCluster::mean(self : SorthybridblocksortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortCluster::scale(self : SorthybridblocksortCluster, f : Double) -> SorthybridblocksortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCluster::add(self : SorthybridblocksortCluster, other : SorthybridblocksortCluster) -> SorthybridblocksortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortCluster::copy(self : SorthybridblocksortCluster) -> SorthybridblocksortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCluster::fill(self : SorthybridblocksortCluster, v : Double) -> SorthybridblocksortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCluster::min(self : SorthybridblocksortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortCluster::max(self : SorthybridblocksortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortCluster::to_string(self : SorthybridblocksortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_model_make(size : Int) -> SorthybridblocksortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortModel::len(self : SorthybridblocksortModel) -> Int { self.size }

pub fn SorthybridblocksortModel::get(self : SorthybridblocksortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortModel::set(self : SorthybridblocksortModel, i : Int, v : Double) -> SorthybridblocksortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortModel::sum(self : SorthybridblocksortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortModel::mean(self : SorthybridblocksortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortModel::scale(self : SorthybridblocksortModel, f : Double) -> SorthybridblocksortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortModel::add(self : SorthybridblocksortModel, other : SorthybridblocksortModel) -> SorthybridblocksortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortModel::copy(self : SorthybridblocksortModel) -> SorthybridblocksortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortModel::fill(self : SorthybridblocksortModel, v : Double) -> SorthybridblocksortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortModel::min(self : SorthybridblocksortModel) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortModel::max(self : SorthybridblocksortModel) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortModel::to_string(self : SorthybridblocksortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_layer_make(size : Int) -> SorthybridblocksortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortLayer::len(self : SorthybridblocksortLayer) -> Int { self.size }

pub fn SorthybridblocksortLayer::get(self : SorthybridblocksortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortLayer::set(self : SorthybridblocksortLayer, i : Int, v : Double) -> SorthybridblocksortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortLayer::sum(self : SorthybridblocksortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortLayer::mean(self : SorthybridblocksortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortLayer::scale(self : SorthybridblocksortLayer, f : Double) -> SorthybridblocksortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortLayer::add(self : SorthybridblocksortLayer, other : SorthybridblocksortLayer) -> SorthybridblocksortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortLayer::copy(self : SorthybridblocksortLayer) -> SorthybridblocksortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortLayer::fill(self : SorthybridblocksortLayer, v : Double) -> SorthybridblocksortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortLayer::min(self : SorthybridblocksortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortLayer::max(self : SorthybridblocksortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortLayer::to_string(self : SorthybridblocksortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_buffer_make(size : Int) -> SorthybridblocksortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortBuffer::len(self : SorthybridblocksortBuffer) -> Int { self.size }

pub fn SorthybridblocksortBuffer::get(self : SorthybridblocksortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortBuffer::set(self : SorthybridblocksortBuffer, i : Int, v : Double) -> SorthybridblocksortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortBuffer::sum(self : SorthybridblocksortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortBuffer::mean(self : SorthybridblocksortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortBuffer::scale(self : SorthybridblocksortBuffer, f : Double) -> SorthybridblocksortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortBuffer::add(self : SorthybridblocksortBuffer, other : SorthybridblocksortBuffer) -> SorthybridblocksortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortBuffer::copy(self : SorthybridblocksortBuffer) -> SorthybridblocksortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortBuffer::fill(self : SorthybridblocksortBuffer, v : Double) -> SorthybridblocksortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortBuffer::min(self : SorthybridblocksortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortBuffer::max(self : SorthybridblocksortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortBuffer::to_string(self : SorthybridblocksortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_cursor_make(size : Int) -> SorthybridblocksortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortCursor::len(self : SorthybridblocksortCursor) -> Int { self.size }

pub fn SorthybridblocksortCursor::get(self : SorthybridblocksortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortCursor::set(self : SorthybridblocksortCursor, i : Int, v : Double) -> SorthybridblocksortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCursor::sum(self : SorthybridblocksortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortCursor::mean(self : SorthybridblocksortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortCursor::scale(self : SorthybridblocksortCursor, f : Double) -> SorthybridblocksortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCursor::add(self : SorthybridblocksortCursor, other : SorthybridblocksortCursor) -> SorthybridblocksortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortCursor::copy(self : SorthybridblocksortCursor) -> SorthybridblocksortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCursor::fill(self : SorthybridblocksortCursor, v : Double) -> SorthybridblocksortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortCursor::min(self : SorthybridblocksortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortCursor::max(self : SorthybridblocksortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortCursor::to_string(self : SorthybridblocksortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_view_make(size : Int) -> SorthybridblocksortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortView::len(self : SorthybridblocksortView) -> Int { self.size }

pub fn SorthybridblocksortView::get(self : SorthybridblocksortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortView::set(self : SorthybridblocksortView, i : Int, v : Double) -> SorthybridblocksortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortView::sum(self : SorthybridblocksortView) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortView::mean(self : SorthybridblocksortView) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortView::scale(self : SorthybridblocksortView, f : Double) -> SorthybridblocksortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortView::add(self : SorthybridblocksortView, other : SorthybridblocksortView) -> SorthybridblocksortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortView::copy(self : SorthybridblocksortView) -> SorthybridblocksortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortView::fill(self : SorthybridblocksortView, v : Double) -> SorthybridblocksortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortView::min(self : SorthybridblocksortView) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortView::max(self : SorthybridblocksortView) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortView::to_string(self : SorthybridblocksortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_range_make(size : Int) -> SorthybridblocksortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortRange::len(self : SorthybridblocksortRange) -> Int { self.size }

pub fn SorthybridblocksortRange::get(self : SorthybridblocksortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortRange::set(self : SorthybridblocksortRange, i : Int, v : Double) -> SorthybridblocksortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortRange::sum(self : SorthybridblocksortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortRange::mean(self : SorthybridblocksortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortRange::scale(self : SorthybridblocksortRange, f : Double) -> SorthybridblocksortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortRange::add(self : SorthybridblocksortRange, other : SorthybridblocksortRange) -> SorthybridblocksortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortRange::copy(self : SorthybridblocksortRange) -> SorthybridblocksortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortRange::fill(self : SorthybridblocksortRange, v : Double) -> SorthybridblocksortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortRange::min(self : SorthybridblocksortRange) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortRange::max(self : SorthybridblocksortRange) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortRange::to_string(self : SorthybridblocksortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_slice_make(size : Int) -> SorthybridblocksortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridblocksortSlice::len(self : SorthybridblocksortSlice) -> Int { self.size }

pub fn SorthybridblocksortSlice::get(self : SorthybridblocksortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridblocksortSlice::set(self : SorthybridblocksortSlice, i : Int, v : Double) -> SorthybridblocksortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortSlice::sum(self : SorthybridblocksortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybridblocksortSlice::mean(self : SorthybridblocksortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybridblocksortSlice::scale(self : SorthybridblocksortSlice, f : Double) -> SorthybridblocksortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortSlice::add(self : SorthybridblocksortSlice, other : SorthybridblocksortSlice) -> SorthybridblocksortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridblocksortSlice::copy(self : SorthybridblocksortSlice) -> SorthybridblocksortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortSlice::fill(self : SorthybridblocksortSlice, v : Double) -> SorthybridblocksortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridblocksortSlice::min(self : SorthybridblocksortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybridblocksortSlice::max(self : SorthybridblocksortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybridblocksortSlice::to_string(self : SorthybridblocksortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

