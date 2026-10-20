///===
/// extcore/sort_hybrid_wikisort

pub(all) struct SorthybridwikisortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_wikisort_make_point(x : Double, y : Double) -> SorthybridwikisortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_wikisort_make_point3(x : Double, y : Double, z : Double) -> SorthybridwikisortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridwikisortPoint::x(self : SorthybridwikisortPoint) -> Double { self.x }

pub fn SorthybridwikisortPoint::y(self : SorthybridwikisortPoint) -> Double { self.y }

pub fn SorthybridwikisortPoint::z(self : SorthybridwikisortPoint) -> Double { self.z }

pub fn SorthybridwikisortPoint::label(self : SorthybridwikisortPoint) -> Int { self.label }

pub fn SorthybridwikisortPoint::dist(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridwikisortPoint::add(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridwikisortPoint::sub(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridwikisortPoint::scale(self : SorthybridwikisortPoint, s : Double) -> SorthybridwikisortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridwikisortPoint::dot(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridwikisortPoint::cross(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridwikisortPoint::norm(self : SorthybridwikisortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridwikisortPoint::normalize(self : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridwikisortPoint::negate(self : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridwikisortPoint::mid(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridwikisortPoint::lerp(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint, t : Double) -> SorthybridwikisortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridwikisortPoint::to_string(self : SorthybridwikisortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridwikisortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_wikisort_make_series(vals : Array[Double], name : String) -> SorthybridwikisortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridwikisortSeries::len(self : SorthybridwikisortSeries) -> Int { self.vals.length() }

pub fn SorthybridwikisortSeries::sum(self : SorthybridwikisortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridwikisortSeries::mean(self : SorthybridwikisortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridwikisortSeries::min(self : SorthybridwikisortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridwikisortSeries::max(self : SorthybridwikisortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridwikisortSeries::range(self : SorthybridwikisortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridwikisortSeries::variance(self : SorthybridwikisortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridwikisortSeries::std(self : SorthybridwikisortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridwikisortSeries::median(self : SorthybridwikisortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridwikisortSeries::scale(self : SorthybridwikisortSeries, f : Double) -> SorthybridwikisortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridwikisortSeries::add(self : SorthybridwikisortSeries, other : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridwikisortSeries::sub(self : SorthybridwikisortSeries, other : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridwikisortSeries::normalize(self : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridwikisortSeries::cumsum(self : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridwikisortSeries::to_string(self : SorthybridwikisortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridwikisortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_wikisort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridwikisortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_wikisort_matrix_identity(n : Int) -> SorthybridwikisortMatrix {
  let m = sort_hybrid_wikisort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridwikisortMatrix::get(self : SorthybridwikisortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridwikisortMatrix::transpose(self : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  let result = sort_hybrid_wikisort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridwikisortMatrix::add(self : SorthybridwikisortMatrix, other : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_wikisort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridwikisortMatrix::scale(self : SorthybridwikisortMatrix, s : Double) -> SorthybridwikisortMatrix {
  let result = sort_hybrid_wikisort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridwikisortMatrix::multiply(self : SorthybridwikisortMatrix, other : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  if self.cols != other.rows { return sort_hybrid_wikisort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_wikisort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SorthybridwikisortMatrix::trace(self : SorthybridwikisortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridwikisortMatrix::det(self : SorthybridwikisortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridwikisortMatrix::norm(self : SorthybridwikisortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridwikisortMatrix::to_string(self : SorthybridwikisortMatrix) -> String {
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

pub(all) struct SorthybridwikisortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_wikisort_make_vector(comps : Array[Double]) -> SorthybridwikisortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_wikisort_vector_zero(dim : Int) -> SorthybridwikisortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridwikisortVector::add(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridwikisortVector::sub(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridwikisortVector::scale(self : SorthybridwikisortVector, s : Double) -> SorthybridwikisortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridwikisortVector::dot(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridwikisortVector::norm(self : SorthybridwikisortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridwikisortVector::normalize(self : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridwikisortVector::dist(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridwikisortVector::to_string(self : SorthybridwikisortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridwikisortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_frame_make(size : Int) -> SorthybridwikisortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortFrame::len(self : SorthybridwikisortFrame) -> Int { self.size }

pub fn SorthybridwikisortFrame::get(self : SorthybridwikisortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortFrame::set(self : SorthybridwikisortFrame, i : Int, v : Double) -> SorthybridwikisortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortFrame::sum(self : SorthybridwikisortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortFrame::mean(self : SorthybridwikisortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortFrame::scale(self : SorthybridwikisortFrame, f : Double) -> SorthybridwikisortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortFrame::add(self : SorthybridwikisortFrame, other : SorthybridwikisortFrame) -> SorthybridwikisortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortFrame::copy(self : SorthybridwikisortFrame) -> SorthybridwikisortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortFrame::fill(self : SorthybridwikisortFrame, v : Double) -> SorthybridwikisortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortFrame::min(self : SorthybridwikisortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortFrame::max(self : SorthybridwikisortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortFrame::to_string(self : SorthybridwikisortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_table_make(size : Int) -> SorthybridwikisortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortTable::len(self : SorthybridwikisortTable) -> Int { self.size }

pub fn SorthybridwikisortTable::get(self : SorthybridwikisortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortTable::set(self : SorthybridwikisortTable, i : Int, v : Double) -> SorthybridwikisortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortTable::sum(self : SorthybridwikisortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortTable::mean(self : SorthybridwikisortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortTable::scale(self : SorthybridwikisortTable, f : Double) -> SorthybridwikisortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortTable::add(self : SorthybridwikisortTable, other : SorthybridwikisortTable) -> SorthybridwikisortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortTable::copy(self : SorthybridwikisortTable) -> SorthybridwikisortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortTable::fill(self : SorthybridwikisortTable, v : Double) -> SorthybridwikisortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortTable::min(self : SorthybridwikisortTable) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortTable::max(self : SorthybridwikisortTable) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortTable::to_string(self : SorthybridwikisortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_graphn_make(size : Int) -> SorthybridwikisortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortGraphN::len(self : SorthybridwikisortGraphN) -> Int { self.size }

pub fn SorthybridwikisortGraphN::get(self : SorthybridwikisortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortGraphN::set(self : SorthybridwikisortGraphN, i : Int, v : Double) -> SorthybridwikisortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortGraphN::sum(self : SorthybridwikisortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortGraphN::mean(self : SorthybridwikisortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortGraphN::scale(self : SorthybridwikisortGraphN, f : Double) -> SorthybridwikisortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortGraphN::add(self : SorthybridwikisortGraphN, other : SorthybridwikisortGraphN) -> SorthybridwikisortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortGraphN::copy(self : SorthybridwikisortGraphN) -> SorthybridwikisortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortGraphN::fill(self : SorthybridwikisortGraphN, v : Double) -> SorthybridwikisortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortGraphN::min(self : SorthybridwikisortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortGraphN::max(self : SorthybridwikisortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortGraphN::to_string(self : SorthybridwikisortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_node_make(size : Int) -> SorthybridwikisortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortNode::len(self : SorthybridwikisortNode) -> Int { self.size }

pub fn SorthybridwikisortNode::get(self : SorthybridwikisortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortNode::set(self : SorthybridwikisortNode, i : Int, v : Double) -> SorthybridwikisortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortNode::sum(self : SorthybridwikisortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortNode::mean(self : SorthybridwikisortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortNode::scale(self : SorthybridwikisortNode, f : Double) -> SorthybridwikisortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortNode::add(self : SorthybridwikisortNode, other : SorthybridwikisortNode) -> SorthybridwikisortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortNode::copy(self : SorthybridwikisortNode) -> SorthybridwikisortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortNode::fill(self : SorthybridwikisortNode, v : Double) -> SorthybridwikisortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortNode::min(self : SorthybridwikisortNode) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortNode::max(self : SorthybridwikisortNode) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortNode::to_string(self : SorthybridwikisortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_edge_make(size : Int) -> SorthybridwikisortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortEdge::len(self : SorthybridwikisortEdge) -> Int { self.size }

pub fn SorthybridwikisortEdge::get(self : SorthybridwikisortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortEdge::set(self : SorthybridwikisortEdge, i : Int, v : Double) -> SorthybridwikisortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortEdge::sum(self : SorthybridwikisortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortEdge::mean(self : SorthybridwikisortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortEdge::scale(self : SorthybridwikisortEdge, f : Double) -> SorthybridwikisortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortEdge::add(self : SorthybridwikisortEdge, other : SorthybridwikisortEdge) -> SorthybridwikisortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortEdge::copy(self : SorthybridwikisortEdge) -> SorthybridwikisortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortEdge::fill(self : SorthybridwikisortEdge, v : Double) -> SorthybridwikisortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortEdge::min(self : SorthybridwikisortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortEdge::max(self : SorthybridwikisortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortEdge::to_string(self : SorthybridwikisortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_path_make(size : Int) -> SorthybridwikisortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortPath::len(self : SorthybridwikisortPath) -> Int { self.size }

pub fn SorthybridwikisortPath::get(self : SorthybridwikisortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortPath::set(self : SorthybridwikisortPath, i : Int, v : Double) -> SorthybridwikisortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortPath::sum(self : SorthybridwikisortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortPath::mean(self : SorthybridwikisortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortPath::scale(self : SorthybridwikisortPath, f : Double) -> SorthybridwikisortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortPath::add(self : SorthybridwikisortPath, other : SorthybridwikisortPath) -> SorthybridwikisortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortPath::copy(self : SorthybridwikisortPath) -> SorthybridwikisortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortPath::fill(self : SorthybridwikisortPath, v : Double) -> SorthybridwikisortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortPath::min(self : SorthybridwikisortPath) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortPath::max(self : SorthybridwikisortPath) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortPath::to_string(self : SorthybridwikisortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_cluster_make(size : Int) -> SorthybridwikisortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortCluster::len(self : SorthybridwikisortCluster) -> Int { self.size }

pub fn SorthybridwikisortCluster::get(self : SorthybridwikisortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortCluster::set(self : SorthybridwikisortCluster, i : Int, v : Double) -> SorthybridwikisortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCluster::sum(self : SorthybridwikisortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortCluster::mean(self : SorthybridwikisortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortCluster::scale(self : SorthybridwikisortCluster, f : Double) -> SorthybridwikisortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCluster::add(self : SorthybridwikisortCluster, other : SorthybridwikisortCluster) -> SorthybridwikisortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortCluster::copy(self : SorthybridwikisortCluster) -> SorthybridwikisortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCluster::fill(self : SorthybridwikisortCluster, v : Double) -> SorthybridwikisortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCluster::min(self : SorthybridwikisortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortCluster::max(self : SorthybridwikisortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortCluster::to_string(self : SorthybridwikisortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_model_make(size : Int) -> SorthybridwikisortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortModel::len(self : SorthybridwikisortModel) -> Int { self.size }

pub fn SorthybridwikisortModel::get(self : SorthybridwikisortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortModel::set(self : SorthybridwikisortModel, i : Int, v : Double) -> SorthybridwikisortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortModel::sum(self : SorthybridwikisortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortModel::mean(self : SorthybridwikisortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortModel::scale(self : SorthybridwikisortModel, f : Double) -> SorthybridwikisortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortModel::add(self : SorthybridwikisortModel, other : SorthybridwikisortModel) -> SorthybridwikisortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortModel::copy(self : SorthybridwikisortModel) -> SorthybridwikisortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortModel::fill(self : SorthybridwikisortModel, v : Double) -> SorthybridwikisortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortModel::min(self : SorthybridwikisortModel) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortModel::max(self : SorthybridwikisortModel) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortModel::to_string(self : SorthybridwikisortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_layer_make(size : Int) -> SorthybridwikisortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortLayer::len(self : SorthybridwikisortLayer) -> Int { self.size }

pub fn SorthybridwikisortLayer::get(self : SorthybridwikisortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortLayer::set(self : SorthybridwikisortLayer, i : Int, v : Double) -> SorthybridwikisortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortLayer::sum(self : SorthybridwikisortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortLayer::mean(self : SorthybridwikisortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortLayer::scale(self : SorthybridwikisortLayer, f : Double) -> SorthybridwikisortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortLayer::add(self : SorthybridwikisortLayer, other : SorthybridwikisortLayer) -> SorthybridwikisortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortLayer::copy(self : SorthybridwikisortLayer) -> SorthybridwikisortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortLayer::fill(self : SorthybridwikisortLayer, v : Double) -> SorthybridwikisortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortLayer::min(self : SorthybridwikisortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortLayer::max(self : SorthybridwikisortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortLayer::to_string(self : SorthybridwikisortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_buffer_make(size : Int) -> SorthybridwikisortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortBuffer::len(self : SorthybridwikisortBuffer) -> Int { self.size }

pub fn SorthybridwikisortBuffer::get(self : SorthybridwikisortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortBuffer::set(self : SorthybridwikisortBuffer, i : Int, v : Double) -> SorthybridwikisortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortBuffer::sum(self : SorthybridwikisortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortBuffer::mean(self : SorthybridwikisortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortBuffer::scale(self : SorthybridwikisortBuffer, f : Double) -> SorthybridwikisortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortBuffer::add(self : SorthybridwikisortBuffer, other : SorthybridwikisortBuffer) -> SorthybridwikisortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortBuffer::copy(self : SorthybridwikisortBuffer) -> SorthybridwikisortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortBuffer::fill(self : SorthybridwikisortBuffer, v : Double) -> SorthybridwikisortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortBuffer::min(self : SorthybridwikisortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortBuffer::max(self : SorthybridwikisortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortBuffer::to_string(self : SorthybridwikisortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_cursor_make(size : Int) -> SorthybridwikisortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortCursor::len(self : SorthybridwikisortCursor) -> Int { self.size }

pub fn SorthybridwikisortCursor::get(self : SorthybridwikisortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortCursor::set(self : SorthybridwikisortCursor, i : Int, v : Double) -> SorthybridwikisortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCursor::sum(self : SorthybridwikisortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortCursor::mean(self : SorthybridwikisortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortCursor::scale(self : SorthybridwikisortCursor, f : Double) -> SorthybridwikisortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCursor::add(self : SorthybridwikisortCursor, other : SorthybridwikisortCursor) -> SorthybridwikisortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortCursor::copy(self : SorthybridwikisortCursor) -> SorthybridwikisortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCursor::fill(self : SorthybridwikisortCursor, v : Double) -> SorthybridwikisortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortCursor::min(self : SorthybridwikisortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortCursor::max(self : SorthybridwikisortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortCursor::to_string(self : SorthybridwikisortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_view_make(size : Int) -> SorthybridwikisortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortView::len(self : SorthybridwikisortView) -> Int { self.size }

pub fn SorthybridwikisortView::get(self : SorthybridwikisortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortView::set(self : SorthybridwikisortView, i : Int, v : Double) -> SorthybridwikisortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortView::sum(self : SorthybridwikisortView) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortView::mean(self : SorthybridwikisortView) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortView::scale(self : SorthybridwikisortView, f : Double) -> SorthybridwikisortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortView::add(self : SorthybridwikisortView, other : SorthybridwikisortView) -> SorthybridwikisortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortView::copy(self : SorthybridwikisortView) -> SorthybridwikisortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortView::fill(self : SorthybridwikisortView, v : Double) -> SorthybridwikisortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortView::min(self : SorthybridwikisortView) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortView::max(self : SorthybridwikisortView) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortView::to_string(self : SorthybridwikisortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_range_make(size : Int) -> SorthybridwikisortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortRange::len(self : SorthybridwikisortRange) -> Int { self.size }

pub fn SorthybridwikisortRange::get(self : SorthybridwikisortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortRange::set(self : SorthybridwikisortRange, i : Int, v : Double) -> SorthybridwikisortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortRange::sum(self : SorthybridwikisortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortRange::mean(self : SorthybridwikisortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortRange::scale(self : SorthybridwikisortRange, f : Double) -> SorthybridwikisortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortRange::add(self : SorthybridwikisortRange, other : SorthybridwikisortRange) -> SorthybridwikisortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortRange::copy(self : SorthybridwikisortRange) -> SorthybridwikisortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortRange::fill(self : SorthybridwikisortRange, v : Double) -> SorthybridwikisortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortRange::min(self : SorthybridwikisortRange) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortRange::max(self : SorthybridwikisortRange) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortRange::to_string(self : SorthybridwikisortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_slice_make(size : Int) -> SorthybridwikisortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridwikisortSlice::len(self : SorthybridwikisortSlice) -> Int { self.size }

pub fn SorthybridwikisortSlice::get(self : SorthybridwikisortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridwikisortSlice::set(self : SorthybridwikisortSlice, i : Int, v : Double) -> SorthybridwikisortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortSlice::sum(self : SorthybridwikisortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybridwikisortSlice::mean(self : SorthybridwikisortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybridwikisortSlice::scale(self : SorthybridwikisortSlice, f : Double) -> SorthybridwikisortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortSlice::add(self : SorthybridwikisortSlice, other : SorthybridwikisortSlice) -> SorthybridwikisortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridwikisortSlice::copy(self : SorthybridwikisortSlice) -> SorthybridwikisortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortSlice::fill(self : SorthybridwikisortSlice, v : Double) -> SorthybridwikisortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridwikisortSlice::min(self : SorthybridwikisortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybridwikisortSlice::max(self : SorthybridwikisortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybridwikisortSlice::to_string(self : SorthybridwikisortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

