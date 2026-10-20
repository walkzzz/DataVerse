///===
/// extcore/sort_hybrid_grailsort

pub(all) struct SorthybridgrailsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_grailsort_make_point(x : Double, y : Double) -> SorthybridgrailsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_grailsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridgrailsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridgrailsortPoint::x(self : SorthybridgrailsortPoint) -> Double { self.x }

pub fn SorthybridgrailsortPoint::y(self : SorthybridgrailsortPoint) -> Double { self.y }

pub fn SorthybridgrailsortPoint::z(self : SorthybridgrailsortPoint) -> Double { self.z }

pub fn SorthybridgrailsortPoint::label(self : SorthybridgrailsortPoint) -> Int { self.label }

pub fn SorthybridgrailsortPoint::dist(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridgrailsortPoint::add(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridgrailsortPoint::sub(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridgrailsortPoint::scale(self : SorthybridgrailsortPoint, s : Double) -> SorthybridgrailsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridgrailsortPoint::dot(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridgrailsortPoint::cross(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridgrailsortPoint::norm(self : SorthybridgrailsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridgrailsortPoint::normalize(self : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridgrailsortPoint::negate(self : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridgrailsortPoint::mid(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridgrailsortPoint::lerp(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint, t : Double) -> SorthybridgrailsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridgrailsortPoint::to_string(self : SorthybridgrailsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridgrailsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_grailsort_make_series(vals : Array[Double], name : String) -> SorthybridgrailsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridgrailsortSeries::len(self : SorthybridgrailsortSeries) -> Int { self.vals.length() }

pub fn SorthybridgrailsortSeries::sum(self : SorthybridgrailsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridgrailsortSeries::mean(self : SorthybridgrailsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridgrailsortSeries::min(self : SorthybridgrailsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridgrailsortSeries::max(self : SorthybridgrailsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridgrailsortSeries::range(self : SorthybridgrailsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridgrailsortSeries::variance(self : SorthybridgrailsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridgrailsortSeries::std(self : SorthybridgrailsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridgrailsortSeries::median(self : SorthybridgrailsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridgrailsortSeries::scale(self : SorthybridgrailsortSeries, f : Double) -> SorthybridgrailsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridgrailsortSeries::add(self : SorthybridgrailsortSeries, other : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridgrailsortSeries::sub(self : SorthybridgrailsortSeries, other : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridgrailsortSeries::normalize(self : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridgrailsortSeries::cumsum(self : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridgrailsortSeries::to_string(self : SorthybridgrailsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridgrailsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_grailsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridgrailsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_grailsort_matrix_identity(n : Int) -> SorthybridgrailsortMatrix {
  let m = sort_hybrid_grailsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridgrailsortMatrix::get(self : SorthybridgrailsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridgrailsortMatrix::transpose(self : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  let result = sort_hybrid_grailsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridgrailsortMatrix::add(self : SorthybridgrailsortMatrix, other : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_grailsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridgrailsortMatrix::scale(self : SorthybridgrailsortMatrix, s : Double) -> SorthybridgrailsortMatrix {
  let result = sort_hybrid_grailsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridgrailsortMatrix::multiply(self : SorthybridgrailsortMatrix, other : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  if self.cols != other.rows { return sort_hybrid_grailsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_grailsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SorthybridgrailsortMatrix::trace(self : SorthybridgrailsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridgrailsortMatrix::det(self : SorthybridgrailsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridgrailsortMatrix::norm(self : SorthybridgrailsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridgrailsortMatrix::to_string(self : SorthybridgrailsortMatrix) -> String {
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

pub(all) struct SorthybridgrailsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_grailsort_make_vector(comps : Array[Double]) -> SorthybridgrailsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_grailsort_vector_zero(dim : Int) -> SorthybridgrailsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridgrailsortVector::add(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridgrailsortVector::sub(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridgrailsortVector::scale(self : SorthybridgrailsortVector, s : Double) -> SorthybridgrailsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridgrailsortVector::dot(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridgrailsortVector::norm(self : SorthybridgrailsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridgrailsortVector::normalize(self : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridgrailsortVector::dist(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridgrailsortVector::to_string(self : SorthybridgrailsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridgrailsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_frame_make(size : Int) -> SorthybridgrailsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortFrame::len(self : SorthybridgrailsortFrame) -> Int { self.size }

pub fn SorthybridgrailsortFrame::get(self : SorthybridgrailsortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortFrame::set(self : SorthybridgrailsortFrame, i : Int, v : Double) -> SorthybridgrailsortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortFrame::sum(self : SorthybridgrailsortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortFrame::mean(self : SorthybridgrailsortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortFrame::scale(self : SorthybridgrailsortFrame, f : Double) -> SorthybridgrailsortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortFrame::add(self : SorthybridgrailsortFrame, other : SorthybridgrailsortFrame) -> SorthybridgrailsortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortFrame::copy(self : SorthybridgrailsortFrame) -> SorthybridgrailsortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortFrame::fill(self : SorthybridgrailsortFrame, v : Double) -> SorthybridgrailsortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortFrame::min(self : SorthybridgrailsortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortFrame::max(self : SorthybridgrailsortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortFrame::to_string(self : SorthybridgrailsortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_table_make(size : Int) -> SorthybridgrailsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortTable::len(self : SorthybridgrailsortTable) -> Int { self.size }

pub fn SorthybridgrailsortTable::get(self : SorthybridgrailsortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortTable::set(self : SorthybridgrailsortTable, i : Int, v : Double) -> SorthybridgrailsortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortTable::sum(self : SorthybridgrailsortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortTable::mean(self : SorthybridgrailsortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortTable::scale(self : SorthybridgrailsortTable, f : Double) -> SorthybridgrailsortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortTable::add(self : SorthybridgrailsortTable, other : SorthybridgrailsortTable) -> SorthybridgrailsortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortTable::copy(self : SorthybridgrailsortTable) -> SorthybridgrailsortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortTable::fill(self : SorthybridgrailsortTable, v : Double) -> SorthybridgrailsortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortTable::min(self : SorthybridgrailsortTable) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortTable::max(self : SorthybridgrailsortTable) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortTable::to_string(self : SorthybridgrailsortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_graphn_make(size : Int) -> SorthybridgrailsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortGraphN::len(self : SorthybridgrailsortGraphN) -> Int { self.size }

pub fn SorthybridgrailsortGraphN::get(self : SorthybridgrailsortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortGraphN::set(self : SorthybridgrailsortGraphN, i : Int, v : Double) -> SorthybridgrailsortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortGraphN::sum(self : SorthybridgrailsortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortGraphN::mean(self : SorthybridgrailsortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortGraphN::scale(self : SorthybridgrailsortGraphN, f : Double) -> SorthybridgrailsortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortGraphN::add(self : SorthybridgrailsortGraphN, other : SorthybridgrailsortGraphN) -> SorthybridgrailsortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortGraphN::copy(self : SorthybridgrailsortGraphN) -> SorthybridgrailsortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortGraphN::fill(self : SorthybridgrailsortGraphN, v : Double) -> SorthybridgrailsortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortGraphN::min(self : SorthybridgrailsortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortGraphN::max(self : SorthybridgrailsortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortGraphN::to_string(self : SorthybridgrailsortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_node_make(size : Int) -> SorthybridgrailsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortNode::len(self : SorthybridgrailsortNode) -> Int { self.size }

pub fn SorthybridgrailsortNode::get(self : SorthybridgrailsortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortNode::set(self : SorthybridgrailsortNode, i : Int, v : Double) -> SorthybridgrailsortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortNode::sum(self : SorthybridgrailsortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortNode::mean(self : SorthybridgrailsortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortNode::scale(self : SorthybridgrailsortNode, f : Double) -> SorthybridgrailsortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortNode::add(self : SorthybridgrailsortNode, other : SorthybridgrailsortNode) -> SorthybridgrailsortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortNode::copy(self : SorthybridgrailsortNode) -> SorthybridgrailsortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortNode::fill(self : SorthybridgrailsortNode, v : Double) -> SorthybridgrailsortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortNode::min(self : SorthybridgrailsortNode) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortNode::max(self : SorthybridgrailsortNode) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortNode::to_string(self : SorthybridgrailsortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_edge_make(size : Int) -> SorthybridgrailsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortEdge::len(self : SorthybridgrailsortEdge) -> Int { self.size }

pub fn SorthybridgrailsortEdge::get(self : SorthybridgrailsortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortEdge::set(self : SorthybridgrailsortEdge, i : Int, v : Double) -> SorthybridgrailsortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortEdge::sum(self : SorthybridgrailsortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortEdge::mean(self : SorthybridgrailsortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortEdge::scale(self : SorthybridgrailsortEdge, f : Double) -> SorthybridgrailsortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortEdge::add(self : SorthybridgrailsortEdge, other : SorthybridgrailsortEdge) -> SorthybridgrailsortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortEdge::copy(self : SorthybridgrailsortEdge) -> SorthybridgrailsortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortEdge::fill(self : SorthybridgrailsortEdge, v : Double) -> SorthybridgrailsortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortEdge::min(self : SorthybridgrailsortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortEdge::max(self : SorthybridgrailsortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortEdge::to_string(self : SorthybridgrailsortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_path_make(size : Int) -> SorthybridgrailsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortPath::len(self : SorthybridgrailsortPath) -> Int { self.size }

pub fn SorthybridgrailsortPath::get(self : SorthybridgrailsortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortPath::set(self : SorthybridgrailsortPath, i : Int, v : Double) -> SorthybridgrailsortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortPath::sum(self : SorthybridgrailsortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortPath::mean(self : SorthybridgrailsortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortPath::scale(self : SorthybridgrailsortPath, f : Double) -> SorthybridgrailsortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortPath::add(self : SorthybridgrailsortPath, other : SorthybridgrailsortPath) -> SorthybridgrailsortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortPath::copy(self : SorthybridgrailsortPath) -> SorthybridgrailsortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortPath::fill(self : SorthybridgrailsortPath, v : Double) -> SorthybridgrailsortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortPath::min(self : SorthybridgrailsortPath) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortPath::max(self : SorthybridgrailsortPath) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortPath::to_string(self : SorthybridgrailsortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_cluster_make(size : Int) -> SorthybridgrailsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortCluster::len(self : SorthybridgrailsortCluster) -> Int { self.size }

pub fn SorthybridgrailsortCluster::get(self : SorthybridgrailsortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortCluster::set(self : SorthybridgrailsortCluster, i : Int, v : Double) -> SorthybridgrailsortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCluster::sum(self : SorthybridgrailsortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortCluster::mean(self : SorthybridgrailsortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortCluster::scale(self : SorthybridgrailsortCluster, f : Double) -> SorthybridgrailsortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCluster::add(self : SorthybridgrailsortCluster, other : SorthybridgrailsortCluster) -> SorthybridgrailsortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortCluster::copy(self : SorthybridgrailsortCluster) -> SorthybridgrailsortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCluster::fill(self : SorthybridgrailsortCluster, v : Double) -> SorthybridgrailsortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCluster::min(self : SorthybridgrailsortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortCluster::max(self : SorthybridgrailsortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortCluster::to_string(self : SorthybridgrailsortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_model_make(size : Int) -> SorthybridgrailsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortModel::len(self : SorthybridgrailsortModel) -> Int { self.size }

pub fn SorthybridgrailsortModel::get(self : SorthybridgrailsortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortModel::set(self : SorthybridgrailsortModel, i : Int, v : Double) -> SorthybridgrailsortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortModel::sum(self : SorthybridgrailsortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortModel::mean(self : SorthybridgrailsortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortModel::scale(self : SorthybridgrailsortModel, f : Double) -> SorthybridgrailsortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortModel::add(self : SorthybridgrailsortModel, other : SorthybridgrailsortModel) -> SorthybridgrailsortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortModel::copy(self : SorthybridgrailsortModel) -> SorthybridgrailsortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortModel::fill(self : SorthybridgrailsortModel, v : Double) -> SorthybridgrailsortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortModel::min(self : SorthybridgrailsortModel) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortModel::max(self : SorthybridgrailsortModel) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortModel::to_string(self : SorthybridgrailsortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_layer_make(size : Int) -> SorthybridgrailsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortLayer::len(self : SorthybridgrailsortLayer) -> Int { self.size }

pub fn SorthybridgrailsortLayer::get(self : SorthybridgrailsortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortLayer::set(self : SorthybridgrailsortLayer, i : Int, v : Double) -> SorthybridgrailsortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortLayer::sum(self : SorthybridgrailsortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortLayer::mean(self : SorthybridgrailsortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortLayer::scale(self : SorthybridgrailsortLayer, f : Double) -> SorthybridgrailsortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortLayer::add(self : SorthybridgrailsortLayer, other : SorthybridgrailsortLayer) -> SorthybridgrailsortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortLayer::copy(self : SorthybridgrailsortLayer) -> SorthybridgrailsortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortLayer::fill(self : SorthybridgrailsortLayer, v : Double) -> SorthybridgrailsortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortLayer::min(self : SorthybridgrailsortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortLayer::max(self : SorthybridgrailsortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortLayer::to_string(self : SorthybridgrailsortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_buffer_make(size : Int) -> SorthybridgrailsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortBuffer::len(self : SorthybridgrailsortBuffer) -> Int { self.size }

pub fn SorthybridgrailsortBuffer::get(self : SorthybridgrailsortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortBuffer::set(self : SorthybridgrailsortBuffer, i : Int, v : Double) -> SorthybridgrailsortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortBuffer::sum(self : SorthybridgrailsortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortBuffer::mean(self : SorthybridgrailsortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortBuffer::scale(self : SorthybridgrailsortBuffer, f : Double) -> SorthybridgrailsortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortBuffer::add(self : SorthybridgrailsortBuffer, other : SorthybridgrailsortBuffer) -> SorthybridgrailsortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortBuffer::copy(self : SorthybridgrailsortBuffer) -> SorthybridgrailsortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortBuffer::fill(self : SorthybridgrailsortBuffer, v : Double) -> SorthybridgrailsortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortBuffer::min(self : SorthybridgrailsortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortBuffer::max(self : SorthybridgrailsortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortBuffer::to_string(self : SorthybridgrailsortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_cursor_make(size : Int) -> SorthybridgrailsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortCursor::len(self : SorthybridgrailsortCursor) -> Int { self.size }

pub fn SorthybridgrailsortCursor::get(self : SorthybridgrailsortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortCursor::set(self : SorthybridgrailsortCursor, i : Int, v : Double) -> SorthybridgrailsortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCursor::sum(self : SorthybridgrailsortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortCursor::mean(self : SorthybridgrailsortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortCursor::scale(self : SorthybridgrailsortCursor, f : Double) -> SorthybridgrailsortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCursor::add(self : SorthybridgrailsortCursor, other : SorthybridgrailsortCursor) -> SorthybridgrailsortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortCursor::copy(self : SorthybridgrailsortCursor) -> SorthybridgrailsortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCursor::fill(self : SorthybridgrailsortCursor, v : Double) -> SorthybridgrailsortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortCursor::min(self : SorthybridgrailsortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortCursor::max(self : SorthybridgrailsortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortCursor::to_string(self : SorthybridgrailsortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_view_make(size : Int) -> SorthybridgrailsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortView::len(self : SorthybridgrailsortView) -> Int { self.size }

pub fn SorthybridgrailsortView::get(self : SorthybridgrailsortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortView::set(self : SorthybridgrailsortView, i : Int, v : Double) -> SorthybridgrailsortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortView::sum(self : SorthybridgrailsortView) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortView::mean(self : SorthybridgrailsortView) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortView::scale(self : SorthybridgrailsortView, f : Double) -> SorthybridgrailsortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortView::add(self : SorthybridgrailsortView, other : SorthybridgrailsortView) -> SorthybridgrailsortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortView::copy(self : SorthybridgrailsortView) -> SorthybridgrailsortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortView::fill(self : SorthybridgrailsortView, v : Double) -> SorthybridgrailsortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortView::min(self : SorthybridgrailsortView) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortView::max(self : SorthybridgrailsortView) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortView::to_string(self : SorthybridgrailsortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_range_make(size : Int) -> SorthybridgrailsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortRange::len(self : SorthybridgrailsortRange) -> Int { self.size }

pub fn SorthybridgrailsortRange::get(self : SorthybridgrailsortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortRange::set(self : SorthybridgrailsortRange, i : Int, v : Double) -> SorthybridgrailsortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortRange::sum(self : SorthybridgrailsortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortRange::mean(self : SorthybridgrailsortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortRange::scale(self : SorthybridgrailsortRange, f : Double) -> SorthybridgrailsortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortRange::add(self : SorthybridgrailsortRange, other : SorthybridgrailsortRange) -> SorthybridgrailsortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortRange::copy(self : SorthybridgrailsortRange) -> SorthybridgrailsortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortRange::fill(self : SorthybridgrailsortRange, v : Double) -> SorthybridgrailsortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortRange::min(self : SorthybridgrailsortRange) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortRange::max(self : SorthybridgrailsortRange) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortRange::to_string(self : SorthybridgrailsortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_slice_make(size : Int) -> SorthybridgrailsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridgrailsortSlice::len(self : SorthybridgrailsortSlice) -> Int { self.size }

pub fn SorthybridgrailsortSlice::get(self : SorthybridgrailsortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridgrailsortSlice::set(self : SorthybridgrailsortSlice, i : Int, v : Double) -> SorthybridgrailsortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortSlice::sum(self : SorthybridgrailsortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybridgrailsortSlice::mean(self : SorthybridgrailsortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybridgrailsortSlice::scale(self : SorthybridgrailsortSlice, f : Double) -> SorthybridgrailsortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortSlice::add(self : SorthybridgrailsortSlice, other : SorthybridgrailsortSlice) -> SorthybridgrailsortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridgrailsortSlice::copy(self : SorthybridgrailsortSlice) -> SorthybridgrailsortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortSlice::fill(self : SorthybridgrailsortSlice, v : Double) -> SorthybridgrailsortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridgrailsortSlice::min(self : SorthybridgrailsortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybridgrailsortSlice::max(self : SorthybridgrailsortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybridgrailsortSlice::to_string(self : SorthybridgrailsortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

