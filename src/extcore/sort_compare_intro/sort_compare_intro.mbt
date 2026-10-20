///===
/// extcore/sort_compare_intro

pub(all) struct SortcompareintroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_intro_make_point(x : Double, y : Double) -> SortcompareintroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_intro_make_point3(x : Double, y : Double, z : Double) -> SortcompareintroPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareintroPoint::x(self : SortcompareintroPoint) -> Double { self.x }

pub fn SortcompareintroPoint::y(self : SortcompareintroPoint) -> Double { self.y }

pub fn SortcompareintroPoint::z(self : SortcompareintroPoint) -> Double { self.z }

pub fn SortcompareintroPoint::label(self : SortcompareintroPoint) -> Int { self.label }

pub fn SortcompareintroPoint::dist(self : SortcompareintroPoint, other : SortcompareintroPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareintroPoint::add(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareintroPoint::sub(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareintroPoint::scale(self : SortcompareintroPoint, s : Double) -> SortcompareintroPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareintroPoint::dot(self : SortcompareintroPoint, other : SortcompareintroPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareintroPoint::cross(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareintroPoint::norm(self : SortcompareintroPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareintroPoint::normalize(self : SortcompareintroPoint) -> SortcompareintroPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareintroPoint::negate(self : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareintroPoint::mid(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareintroPoint::lerp(self : SortcompareintroPoint, other : SortcompareintroPoint, t : Double) -> SortcompareintroPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareintroPoint::to_string(self : SortcompareintroPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareintroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_intro_make_series(vals : Array[Double], name : String) -> SortcompareintroSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareintroSeries::len(self : SortcompareintroSeries) -> Int { self.vals.length() }

pub fn SortcompareintroSeries::sum(self : SortcompareintroSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareintroSeries::mean(self : SortcompareintroSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareintroSeries::min(self : SortcompareintroSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareintroSeries::max(self : SortcompareintroSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareintroSeries::range(self : SortcompareintroSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareintroSeries::variance(self : SortcompareintroSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareintroSeries::std(self : SortcompareintroSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareintroSeries::median(self : SortcompareintroSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareintroSeries::scale(self : SortcompareintroSeries, f : Double) -> SortcompareintroSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareintroSeries::add(self : SortcompareintroSeries, other : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareintroSeries::sub(self : SortcompareintroSeries, other : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareintroSeries::normalize(self : SortcompareintroSeries) -> SortcompareintroSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareintroSeries::cumsum(self : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareintroSeries::to_string(self : SortcompareintroSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareintroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_intro_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareintroMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_intro_matrix_identity(n : Int) -> SortcompareintroMatrix {
  let m = sort_compare_intro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareintroMatrix::get(self : SortcompareintroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareintroMatrix::transpose(self : SortcompareintroMatrix) -> SortcompareintroMatrix {
  let result = sort_compare_intro_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareintroMatrix::add(self : SortcompareintroMatrix, other : SortcompareintroMatrix) -> SortcompareintroMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_intro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareintroMatrix::scale(self : SortcompareintroMatrix, s : Double) -> SortcompareintroMatrix {
  let result = sort_compare_intro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareintroMatrix::multiply(self : SortcompareintroMatrix, other : SortcompareintroMatrix) -> SortcompareintroMatrix {
  if self.cols != other.rows { return sort_compare_intro_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_intro_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SortcompareintroMatrix::trace(self : SortcompareintroMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareintroMatrix::det(self : SortcompareintroMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareintroMatrix::norm(self : SortcompareintroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareintroMatrix::to_string(self : SortcompareintroMatrix) -> String {
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

pub(all) struct SortcompareintroVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_intro_make_vector(comps : Array[Double]) -> SortcompareintroVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_intro_vector_zero(dim : Int) -> SortcompareintroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareintroVector::add(self : SortcompareintroVector, other : SortcompareintroVector) -> SortcompareintroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareintroVector::sub(self : SortcompareintroVector, other : SortcompareintroVector) -> SortcompareintroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareintroVector::scale(self : SortcompareintroVector, s : Double) -> SortcompareintroVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareintroVector::dot(self : SortcompareintroVector, other : SortcompareintroVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareintroVector::norm(self : SortcompareintroVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareintroVector::normalize(self : SortcompareintroVector) -> SortcompareintroVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareintroVector::dist(self : SortcompareintroVector, other : SortcompareintroVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareintroVector::to_string(self : SortcompareintroVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareintroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_frame_make(size : Int) -> SortcompareintroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroFrame::len(self : SortcompareintroFrame) -> Int { self.size }

pub fn SortcompareintroFrame::get(self : SortcompareintroFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroFrame::set(self : SortcompareintroFrame, i : Int, v : Double) -> SortcompareintroFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroFrame::sum(self : SortcompareintroFrame) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroFrame::mean(self : SortcompareintroFrame) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroFrame::scale(self : SortcompareintroFrame, f : Double) -> SortcompareintroFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroFrame::add(self : SortcompareintroFrame, other : SortcompareintroFrame) -> SortcompareintroFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroFrame::copy(self : SortcompareintroFrame) -> SortcompareintroFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroFrame::fill(self : SortcompareintroFrame, v : Double) -> SortcompareintroFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroFrame::min(self : SortcompareintroFrame) -> Double { @_common.min(self.data) }

pub fn SortcompareintroFrame::max(self : SortcompareintroFrame) -> Double { @_common.max(self.data) }

pub fn SortcompareintroFrame::to_string(self : SortcompareintroFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_table_make(size : Int) -> SortcompareintroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroTable::len(self : SortcompareintroTable) -> Int { self.size }

pub fn SortcompareintroTable::get(self : SortcompareintroTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroTable::set(self : SortcompareintroTable, i : Int, v : Double) -> SortcompareintroTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroTable::sum(self : SortcompareintroTable) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroTable::mean(self : SortcompareintroTable) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroTable::scale(self : SortcompareintroTable, f : Double) -> SortcompareintroTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroTable::add(self : SortcompareintroTable, other : SortcompareintroTable) -> SortcompareintroTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroTable::copy(self : SortcompareintroTable) -> SortcompareintroTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroTable::fill(self : SortcompareintroTable, v : Double) -> SortcompareintroTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroTable::min(self : SortcompareintroTable) -> Double { @_common.min(self.data) }

pub fn SortcompareintroTable::max(self : SortcompareintroTable) -> Double { @_common.max(self.data) }

pub fn SortcompareintroTable::to_string(self : SortcompareintroTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_graphn_make(size : Int) -> SortcompareintroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroGraphN::len(self : SortcompareintroGraphN) -> Int { self.size }

pub fn SortcompareintroGraphN::get(self : SortcompareintroGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroGraphN::set(self : SortcompareintroGraphN, i : Int, v : Double) -> SortcompareintroGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroGraphN::sum(self : SortcompareintroGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroGraphN::mean(self : SortcompareintroGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroGraphN::scale(self : SortcompareintroGraphN, f : Double) -> SortcompareintroGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroGraphN::add(self : SortcompareintroGraphN, other : SortcompareintroGraphN) -> SortcompareintroGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroGraphN::copy(self : SortcompareintroGraphN) -> SortcompareintroGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroGraphN::fill(self : SortcompareintroGraphN, v : Double) -> SortcompareintroGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroGraphN::min(self : SortcompareintroGraphN) -> Double { @_common.min(self.data) }

pub fn SortcompareintroGraphN::max(self : SortcompareintroGraphN) -> Double { @_common.max(self.data) }

pub fn SortcompareintroGraphN::to_string(self : SortcompareintroGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_node_make(size : Int) -> SortcompareintroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroNode::len(self : SortcompareintroNode) -> Int { self.size }

pub fn SortcompareintroNode::get(self : SortcompareintroNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroNode::set(self : SortcompareintroNode, i : Int, v : Double) -> SortcompareintroNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroNode::sum(self : SortcompareintroNode) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroNode::mean(self : SortcompareintroNode) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroNode::scale(self : SortcompareintroNode, f : Double) -> SortcompareintroNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroNode::add(self : SortcompareintroNode, other : SortcompareintroNode) -> SortcompareintroNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroNode::copy(self : SortcompareintroNode) -> SortcompareintroNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroNode::fill(self : SortcompareintroNode, v : Double) -> SortcompareintroNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroNode::min(self : SortcompareintroNode) -> Double { @_common.min(self.data) }

pub fn SortcompareintroNode::max(self : SortcompareintroNode) -> Double { @_common.max(self.data) }

pub fn SortcompareintroNode::to_string(self : SortcompareintroNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_edge_make(size : Int) -> SortcompareintroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroEdge::len(self : SortcompareintroEdge) -> Int { self.size }

pub fn SortcompareintroEdge::get(self : SortcompareintroEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroEdge::set(self : SortcompareintroEdge, i : Int, v : Double) -> SortcompareintroEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroEdge::sum(self : SortcompareintroEdge) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroEdge::mean(self : SortcompareintroEdge) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroEdge::scale(self : SortcompareintroEdge, f : Double) -> SortcompareintroEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroEdge::add(self : SortcompareintroEdge, other : SortcompareintroEdge) -> SortcompareintroEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroEdge::copy(self : SortcompareintroEdge) -> SortcompareintroEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroEdge::fill(self : SortcompareintroEdge, v : Double) -> SortcompareintroEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroEdge::min(self : SortcompareintroEdge) -> Double { @_common.min(self.data) }

pub fn SortcompareintroEdge::max(self : SortcompareintroEdge) -> Double { @_common.max(self.data) }

pub fn SortcompareintroEdge::to_string(self : SortcompareintroEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_path_make(size : Int) -> SortcompareintroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroPath::len(self : SortcompareintroPath) -> Int { self.size }

pub fn SortcompareintroPath::get(self : SortcompareintroPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroPath::set(self : SortcompareintroPath, i : Int, v : Double) -> SortcompareintroPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroPath::sum(self : SortcompareintroPath) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroPath::mean(self : SortcompareintroPath) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroPath::scale(self : SortcompareintroPath, f : Double) -> SortcompareintroPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroPath::add(self : SortcompareintroPath, other : SortcompareintroPath) -> SortcompareintroPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroPath::copy(self : SortcompareintroPath) -> SortcompareintroPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroPath::fill(self : SortcompareintroPath, v : Double) -> SortcompareintroPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroPath::min(self : SortcompareintroPath) -> Double { @_common.min(self.data) }

pub fn SortcompareintroPath::max(self : SortcompareintroPath) -> Double { @_common.max(self.data) }

pub fn SortcompareintroPath::to_string(self : SortcompareintroPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_cluster_make(size : Int) -> SortcompareintroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroCluster::len(self : SortcompareintroCluster) -> Int { self.size }

pub fn SortcompareintroCluster::get(self : SortcompareintroCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroCluster::set(self : SortcompareintroCluster, i : Int, v : Double) -> SortcompareintroCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroCluster::sum(self : SortcompareintroCluster) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroCluster::mean(self : SortcompareintroCluster) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroCluster::scale(self : SortcompareintroCluster, f : Double) -> SortcompareintroCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroCluster::add(self : SortcompareintroCluster, other : SortcompareintroCluster) -> SortcompareintroCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroCluster::copy(self : SortcompareintroCluster) -> SortcompareintroCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroCluster::fill(self : SortcompareintroCluster, v : Double) -> SortcompareintroCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroCluster::min(self : SortcompareintroCluster) -> Double { @_common.min(self.data) }

pub fn SortcompareintroCluster::max(self : SortcompareintroCluster) -> Double { @_common.max(self.data) }

pub fn SortcompareintroCluster::to_string(self : SortcompareintroCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_model_make(size : Int) -> SortcompareintroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroModel::len(self : SortcompareintroModel) -> Int { self.size }

pub fn SortcompareintroModel::get(self : SortcompareintroModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroModel::set(self : SortcompareintroModel, i : Int, v : Double) -> SortcompareintroModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroModel::sum(self : SortcompareintroModel) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroModel::mean(self : SortcompareintroModel) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroModel::scale(self : SortcompareintroModel, f : Double) -> SortcompareintroModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroModel::add(self : SortcompareintroModel, other : SortcompareintroModel) -> SortcompareintroModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroModel::copy(self : SortcompareintroModel) -> SortcompareintroModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroModel::fill(self : SortcompareintroModel, v : Double) -> SortcompareintroModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroModel::min(self : SortcompareintroModel) -> Double { @_common.min(self.data) }

pub fn SortcompareintroModel::max(self : SortcompareintroModel) -> Double { @_common.max(self.data) }

pub fn SortcompareintroModel::to_string(self : SortcompareintroModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_layer_make(size : Int) -> SortcompareintroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroLayer::len(self : SortcompareintroLayer) -> Int { self.size }

pub fn SortcompareintroLayer::get(self : SortcompareintroLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroLayer::set(self : SortcompareintroLayer, i : Int, v : Double) -> SortcompareintroLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroLayer::sum(self : SortcompareintroLayer) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroLayer::mean(self : SortcompareintroLayer) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroLayer::scale(self : SortcompareintroLayer, f : Double) -> SortcompareintroLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroLayer::add(self : SortcompareintroLayer, other : SortcompareintroLayer) -> SortcompareintroLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroLayer::copy(self : SortcompareintroLayer) -> SortcompareintroLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroLayer::fill(self : SortcompareintroLayer, v : Double) -> SortcompareintroLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroLayer::min(self : SortcompareintroLayer) -> Double { @_common.min(self.data) }

pub fn SortcompareintroLayer::max(self : SortcompareintroLayer) -> Double { @_common.max(self.data) }

pub fn SortcompareintroLayer::to_string(self : SortcompareintroLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_buffer_make(size : Int) -> SortcompareintroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroBuffer::len(self : SortcompareintroBuffer) -> Int { self.size }

pub fn SortcompareintroBuffer::get(self : SortcompareintroBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroBuffer::set(self : SortcompareintroBuffer, i : Int, v : Double) -> SortcompareintroBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroBuffer::sum(self : SortcompareintroBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroBuffer::mean(self : SortcompareintroBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroBuffer::scale(self : SortcompareintroBuffer, f : Double) -> SortcompareintroBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroBuffer::add(self : SortcompareintroBuffer, other : SortcompareintroBuffer) -> SortcompareintroBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroBuffer::copy(self : SortcompareintroBuffer) -> SortcompareintroBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroBuffer::fill(self : SortcompareintroBuffer, v : Double) -> SortcompareintroBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroBuffer::min(self : SortcompareintroBuffer) -> Double { @_common.min(self.data) }

pub fn SortcompareintroBuffer::max(self : SortcompareintroBuffer) -> Double { @_common.max(self.data) }

pub fn SortcompareintroBuffer::to_string(self : SortcompareintroBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_cursor_make(size : Int) -> SortcompareintroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroCursor::len(self : SortcompareintroCursor) -> Int { self.size }

pub fn SortcompareintroCursor::get(self : SortcompareintroCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroCursor::set(self : SortcompareintroCursor, i : Int, v : Double) -> SortcompareintroCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroCursor::sum(self : SortcompareintroCursor) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroCursor::mean(self : SortcompareintroCursor) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroCursor::scale(self : SortcompareintroCursor, f : Double) -> SortcompareintroCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroCursor::add(self : SortcompareintroCursor, other : SortcompareintroCursor) -> SortcompareintroCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroCursor::copy(self : SortcompareintroCursor) -> SortcompareintroCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroCursor::fill(self : SortcompareintroCursor, v : Double) -> SortcompareintroCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroCursor::min(self : SortcompareintroCursor) -> Double { @_common.min(self.data) }

pub fn SortcompareintroCursor::max(self : SortcompareintroCursor) -> Double { @_common.max(self.data) }

pub fn SortcompareintroCursor::to_string(self : SortcompareintroCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_view_make(size : Int) -> SortcompareintroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroView::len(self : SortcompareintroView) -> Int { self.size }

pub fn SortcompareintroView::get(self : SortcompareintroView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroView::set(self : SortcompareintroView, i : Int, v : Double) -> SortcompareintroView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroView::sum(self : SortcompareintroView) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroView::mean(self : SortcompareintroView) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroView::scale(self : SortcompareintroView, f : Double) -> SortcompareintroView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroView::add(self : SortcompareintroView, other : SortcompareintroView) -> SortcompareintroView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroView::copy(self : SortcompareintroView) -> SortcompareintroView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroView::fill(self : SortcompareintroView, v : Double) -> SortcompareintroView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroView::min(self : SortcompareintroView) -> Double { @_common.min(self.data) }

pub fn SortcompareintroView::max(self : SortcompareintroView) -> Double { @_common.max(self.data) }

pub fn SortcompareintroView::to_string(self : SortcompareintroView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_range_make(size : Int) -> SortcompareintroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroRange::len(self : SortcompareintroRange) -> Int { self.size }

pub fn SortcompareintroRange::get(self : SortcompareintroRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroRange::set(self : SortcompareintroRange, i : Int, v : Double) -> SortcompareintroRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroRange::sum(self : SortcompareintroRange) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroRange::mean(self : SortcompareintroRange) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroRange::scale(self : SortcompareintroRange, f : Double) -> SortcompareintroRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroRange::add(self : SortcompareintroRange, other : SortcompareintroRange) -> SortcompareintroRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroRange::copy(self : SortcompareintroRange) -> SortcompareintroRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroRange::fill(self : SortcompareintroRange, v : Double) -> SortcompareintroRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroRange::min(self : SortcompareintroRange) -> Double { @_common.min(self.data) }

pub fn SortcompareintroRange::max(self : SortcompareintroRange) -> Double { @_common.max(self.data) }

pub fn SortcompareintroRange::to_string(self : SortcompareintroRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareintroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_slice_make(size : Int) -> SortcompareintroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareintroSlice::len(self : SortcompareintroSlice) -> Int { self.size }

pub fn SortcompareintroSlice::get(self : SortcompareintroSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareintroSlice::set(self : SortcompareintroSlice, i : Int, v : Double) -> SortcompareintroSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareintroSlice::sum(self : SortcompareintroSlice) -> Double { @_common.sum(self.data) }

pub fn SortcompareintroSlice::mean(self : SortcompareintroSlice) -> Double { @_common.mean(self.data) }

pub fn SortcompareintroSlice::scale(self : SortcompareintroSlice, f : Double) -> SortcompareintroSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareintroSlice::add(self : SortcompareintroSlice, other : SortcompareintroSlice) -> SortcompareintroSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareintroSlice::copy(self : SortcompareintroSlice) -> SortcompareintroSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareintroSlice::fill(self : SortcompareintroSlice, v : Double) -> SortcompareintroSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareintroSlice::min(self : SortcompareintroSlice) -> Double { @_common.min(self.data) }

pub fn SortcompareintroSlice::max(self : SortcompareintroSlice) -> Double { @_common.max(self.data) }

pub fn SortcompareintroSlice::to_string(self : SortcompareintroSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

