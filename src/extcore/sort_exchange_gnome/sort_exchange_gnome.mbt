///===
/// extcore/sort_exchange_gnome

pub(all) struct SortexchangegnomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_gnome_make_point(x : Double, y : Double) -> SortexchangegnomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_gnome_make_point3(x : Double, y : Double, z : Double) -> SortexchangegnomePoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangegnomePoint::x(self : SortexchangegnomePoint) -> Double { self.x }

pub fn SortexchangegnomePoint::y(self : SortexchangegnomePoint) -> Double { self.y }

pub fn SortexchangegnomePoint::z(self : SortexchangegnomePoint) -> Double { self.z }

pub fn SortexchangegnomePoint::label(self : SortexchangegnomePoint) -> Int { self.label }

pub fn SortexchangegnomePoint::dist(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangegnomePoint::add(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangegnomePoint::sub(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangegnomePoint::scale(self : SortexchangegnomePoint, s : Double) -> SortexchangegnomePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangegnomePoint::dot(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangegnomePoint::cross(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangegnomePoint::norm(self : SortexchangegnomePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangegnomePoint::normalize(self : SortexchangegnomePoint) -> SortexchangegnomePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangegnomePoint::negate(self : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangegnomePoint::mid(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangegnomePoint::lerp(self : SortexchangegnomePoint, other : SortexchangegnomePoint, t : Double) -> SortexchangegnomePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangegnomePoint::to_string(self : SortexchangegnomePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangegnomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_gnome_make_series(vals : Array[Double], name : String) -> SortexchangegnomeSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangegnomeSeries::len(self : SortexchangegnomeSeries) -> Int { self.vals.length() }

pub fn SortexchangegnomeSeries::sum(self : SortexchangegnomeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangegnomeSeries::mean(self : SortexchangegnomeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangegnomeSeries::min(self : SortexchangegnomeSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangegnomeSeries::max(self : SortexchangegnomeSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangegnomeSeries::range(self : SortexchangegnomeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangegnomeSeries::variance(self : SortexchangegnomeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangegnomeSeries::std(self : SortexchangegnomeSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangegnomeSeries::median(self : SortexchangegnomeSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangegnomeSeries::scale(self : SortexchangegnomeSeries, f : Double) -> SortexchangegnomeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangegnomeSeries::add(self : SortexchangegnomeSeries, other : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangegnomeSeries::sub(self : SortexchangegnomeSeries, other : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangegnomeSeries::normalize(self : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangegnomeSeries::cumsum(self : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangegnomeSeries::to_string(self : SortexchangegnomeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangegnomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_gnome_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangegnomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_gnome_matrix_identity(n : Int) -> SortexchangegnomeMatrix {
  let m = sort_exchange_gnome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangegnomeMatrix::get(self : SortexchangegnomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangegnomeMatrix::transpose(self : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangegnomeMatrix::add(self : SortexchangegnomeMatrix, other : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_gnome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangegnomeMatrix::scale(self : SortexchangegnomeMatrix, s : Double) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangegnomeMatrix::multiply(self : SortexchangegnomeMatrix, other : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if self.cols != other.rows { return sort_exchange_gnome_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_gnome_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SortexchangegnomeMatrix::trace(self : SortexchangegnomeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangegnomeMatrix::det(self : SortexchangegnomeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangegnomeMatrix::norm(self : SortexchangegnomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangegnomeMatrix::to_string(self : SortexchangegnomeMatrix) -> String {
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

pub(all) struct SortexchangegnomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_gnome_make_vector(comps : Array[Double]) -> SortexchangegnomeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_gnome_vector_zero(dim : Int) -> SortexchangegnomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangegnomeVector::add(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangegnomeVector::sub(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangegnomeVector::scale(self : SortexchangegnomeVector, s : Double) -> SortexchangegnomeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangegnomeVector::dot(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangegnomeVector::norm(self : SortexchangegnomeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangegnomeVector::normalize(self : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangegnomeVector::dist(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangegnomeVector::to_string(self : SortexchangegnomeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangegnomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_frame_make(size : Int) -> SortexchangegnomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeFrame::len(self : SortexchangegnomeFrame) -> Int { self.size }

pub fn SortexchangegnomeFrame::get(self : SortexchangegnomeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeFrame::set(self : SortexchangegnomeFrame, i : Int, v : Double) -> SortexchangegnomeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeFrame::sum(self : SortexchangegnomeFrame) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeFrame::mean(self : SortexchangegnomeFrame) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeFrame::scale(self : SortexchangegnomeFrame, f : Double) -> SortexchangegnomeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeFrame::add(self : SortexchangegnomeFrame, other : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeFrame::copy(self : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeFrame::fill(self : SortexchangegnomeFrame, v : Double) -> SortexchangegnomeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeFrame::min(self : SortexchangegnomeFrame) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeFrame::max(self : SortexchangegnomeFrame) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeFrame::to_string(self : SortexchangegnomeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_table_make(size : Int) -> SortexchangegnomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeTable::len(self : SortexchangegnomeTable) -> Int { self.size }

pub fn SortexchangegnomeTable::get(self : SortexchangegnomeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeTable::set(self : SortexchangegnomeTable, i : Int, v : Double) -> SortexchangegnomeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeTable::sum(self : SortexchangegnomeTable) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeTable::mean(self : SortexchangegnomeTable) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeTable::scale(self : SortexchangegnomeTable, f : Double) -> SortexchangegnomeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeTable::add(self : SortexchangegnomeTable, other : SortexchangegnomeTable) -> SortexchangegnomeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeTable::copy(self : SortexchangegnomeTable) -> SortexchangegnomeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeTable::fill(self : SortexchangegnomeTable, v : Double) -> SortexchangegnomeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeTable::min(self : SortexchangegnomeTable) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeTable::max(self : SortexchangegnomeTable) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeTable::to_string(self : SortexchangegnomeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_graphn_make(size : Int) -> SortexchangegnomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeGraphN::len(self : SortexchangegnomeGraphN) -> Int { self.size }

pub fn SortexchangegnomeGraphN::get(self : SortexchangegnomeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeGraphN::set(self : SortexchangegnomeGraphN, i : Int, v : Double) -> SortexchangegnomeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeGraphN::sum(self : SortexchangegnomeGraphN) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeGraphN::mean(self : SortexchangegnomeGraphN) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeGraphN::scale(self : SortexchangegnomeGraphN, f : Double) -> SortexchangegnomeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeGraphN::add(self : SortexchangegnomeGraphN, other : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeGraphN::copy(self : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeGraphN::fill(self : SortexchangegnomeGraphN, v : Double) -> SortexchangegnomeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeGraphN::min(self : SortexchangegnomeGraphN) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeGraphN::max(self : SortexchangegnomeGraphN) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeGraphN::to_string(self : SortexchangegnomeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_node_make(size : Int) -> SortexchangegnomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeNode::len(self : SortexchangegnomeNode) -> Int { self.size }

pub fn SortexchangegnomeNode::get(self : SortexchangegnomeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeNode::set(self : SortexchangegnomeNode, i : Int, v : Double) -> SortexchangegnomeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeNode::sum(self : SortexchangegnomeNode) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeNode::mean(self : SortexchangegnomeNode) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeNode::scale(self : SortexchangegnomeNode, f : Double) -> SortexchangegnomeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeNode::add(self : SortexchangegnomeNode, other : SortexchangegnomeNode) -> SortexchangegnomeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeNode::copy(self : SortexchangegnomeNode) -> SortexchangegnomeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeNode::fill(self : SortexchangegnomeNode, v : Double) -> SortexchangegnomeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeNode::min(self : SortexchangegnomeNode) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeNode::max(self : SortexchangegnomeNode) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeNode::to_string(self : SortexchangegnomeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_edge_make(size : Int) -> SortexchangegnomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeEdge::len(self : SortexchangegnomeEdge) -> Int { self.size }

pub fn SortexchangegnomeEdge::get(self : SortexchangegnomeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeEdge::set(self : SortexchangegnomeEdge, i : Int, v : Double) -> SortexchangegnomeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeEdge::sum(self : SortexchangegnomeEdge) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeEdge::mean(self : SortexchangegnomeEdge) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeEdge::scale(self : SortexchangegnomeEdge, f : Double) -> SortexchangegnomeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeEdge::add(self : SortexchangegnomeEdge, other : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeEdge::copy(self : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeEdge::fill(self : SortexchangegnomeEdge, v : Double) -> SortexchangegnomeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeEdge::min(self : SortexchangegnomeEdge) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeEdge::max(self : SortexchangegnomeEdge) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeEdge::to_string(self : SortexchangegnomeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_path_make(size : Int) -> SortexchangegnomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomePath::len(self : SortexchangegnomePath) -> Int { self.size }

pub fn SortexchangegnomePath::get(self : SortexchangegnomePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomePath::set(self : SortexchangegnomePath, i : Int, v : Double) -> SortexchangegnomePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomePath::sum(self : SortexchangegnomePath) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomePath::mean(self : SortexchangegnomePath) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomePath::scale(self : SortexchangegnomePath, f : Double) -> SortexchangegnomePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomePath::add(self : SortexchangegnomePath, other : SortexchangegnomePath) -> SortexchangegnomePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomePath::copy(self : SortexchangegnomePath) -> SortexchangegnomePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomePath::fill(self : SortexchangegnomePath, v : Double) -> SortexchangegnomePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomePath::min(self : SortexchangegnomePath) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomePath::max(self : SortexchangegnomePath) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomePath::to_string(self : SortexchangegnomePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cluster_make(size : Int) -> SortexchangegnomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeCluster::len(self : SortexchangegnomeCluster) -> Int { self.size }

pub fn SortexchangegnomeCluster::get(self : SortexchangegnomeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeCluster::set(self : SortexchangegnomeCluster, i : Int, v : Double) -> SortexchangegnomeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCluster::sum(self : SortexchangegnomeCluster) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeCluster::mean(self : SortexchangegnomeCluster) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeCluster::scale(self : SortexchangegnomeCluster, f : Double) -> SortexchangegnomeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCluster::add(self : SortexchangegnomeCluster, other : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeCluster::copy(self : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCluster::fill(self : SortexchangegnomeCluster, v : Double) -> SortexchangegnomeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCluster::min(self : SortexchangegnomeCluster) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeCluster::max(self : SortexchangegnomeCluster) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeCluster::to_string(self : SortexchangegnomeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_model_make(size : Int) -> SortexchangegnomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeModel::len(self : SortexchangegnomeModel) -> Int { self.size }

pub fn SortexchangegnomeModel::get(self : SortexchangegnomeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeModel::set(self : SortexchangegnomeModel, i : Int, v : Double) -> SortexchangegnomeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeModel::sum(self : SortexchangegnomeModel) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeModel::mean(self : SortexchangegnomeModel) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeModel::scale(self : SortexchangegnomeModel, f : Double) -> SortexchangegnomeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeModel::add(self : SortexchangegnomeModel, other : SortexchangegnomeModel) -> SortexchangegnomeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeModel::copy(self : SortexchangegnomeModel) -> SortexchangegnomeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeModel::fill(self : SortexchangegnomeModel, v : Double) -> SortexchangegnomeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeModel::min(self : SortexchangegnomeModel) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeModel::max(self : SortexchangegnomeModel) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeModel::to_string(self : SortexchangegnomeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_layer_make(size : Int) -> SortexchangegnomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeLayer::len(self : SortexchangegnomeLayer) -> Int { self.size }

pub fn SortexchangegnomeLayer::get(self : SortexchangegnomeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeLayer::set(self : SortexchangegnomeLayer, i : Int, v : Double) -> SortexchangegnomeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeLayer::sum(self : SortexchangegnomeLayer) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeLayer::mean(self : SortexchangegnomeLayer) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeLayer::scale(self : SortexchangegnomeLayer, f : Double) -> SortexchangegnomeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeLayer::add(self : SortexchangegnomeLayer, other : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeLayer::copy(self : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeLayer::fill(self : SortexchangegnomeLayer, v : Double) -> SortexchangegnomeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeLayer::min(self : SortexchangegnomeLayer) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeLayer::max(self : SortexchangegnomeLayer) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeLayer::to_string(self : SortexchangegnomeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_buffer_make(size : Int) -> SortexchangegnomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeBuffer::len(self : SortexchangegnomeBuffer) -> Int { self.size }

pub fn SortexchangegnomeBuffer::get(self : SortexchangegnomeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeBuffer::set(self : SortexchangegnomeBuffer, i : Int, v : Double) -> SortexchangegnomeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeBuffer::sum(self : SortexchangegnomeBuffer) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeBuffer::mean(self : SortexchangegnomeBuffer) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeBuffer::scale(self : SortexchangegnomeBuffer, f : Double) -> SortexchangegnomeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeBuffer::add(self : SortexchangegnomeBuffer, other : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeBuffer::copy(self : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeBuffer::fill(self : SortexchangegnomeBuffer, v : Double) -> SortexchangegnomeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeBuffer::min(self : SortexchangegnomeBuffer) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeBuffer::max(self : SortexchangegnomeBuffer) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeBuffer::to_string(self : SortexchangegnomeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cursor_make(size : Int) -> SortexchangegnomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeCursor::len(self : SortexchangegnomeCursor) -> Int { self.size }

pub fn SortexchangegnomeCursor::get(self : SortexchangegnomeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeCursor::set(self : SortexchangegnomeCursor, i : Int, v : Double) -> SortexchangegnomeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCursor::sum(self : SortexchangegnomeCursor) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeCursor::mean(self : SortexchangegnomeCursor) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeCursor::scale(self : SortexchangegnomeCursor, f : Double) -> SortexchangegnomeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCursor::add(self : SortexchangegnomeCursor, other : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeCursor::copy(self : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCursor::fill(self : SortexchangegnomeCursor, v : Double) -> SortexchangegnomeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeCursor::min(self : SortexchangegnomeCursor) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeCursor::max(self : SortexchangegnomeCursor) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeCursor::to_string(self : SortexchangegnomeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_view_make(size : Int) -> SortexchangegnomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeView::len(self : SortexchangegnomeView) -> Int { self.size }

pub fn SortexchangegnomeView::get(self : SortexchangegnomeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeView::set(self : SortexchangegnomeView, i : Int, v : Double) -> SortexchangegnomeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeView::sum(self : SortexchangegnomeView) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeView::mean(self : SortexchangegnomeView) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeView::scale(self : SortexchangegnomeView, f : Double) -> SortexchangegnomeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeView::add(self : SortexchangegnomeView, other : SortexchangegnomeView) -> SortexchangegnomeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeView::copy(self : SortexchangegnomeView) -> SortexchangegnomeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeView::fill(self : SortexchangegnomeView, v : Double) -> SortexchangegnomeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeView::min(self : SortexchangegnomeView) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeView::max(self : SortexchangegnomeView) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeView::to_string(self : SortexchangegnomeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_range_make(size : Int) -> SortexchangegnomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeRange::len(self : SortexchangegnomeRange) -> Int { self.size }

pub fn SortexchangegnomeRange::get(self : SortexchangegnomeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeRange::set(self : SortexchangegnomeRange, i : Int, v : Double) -> SortexchangegnomeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeRange::sum(self : SortexchangegnomeRange) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeRange::mean(self : SortexchangegnomeRange) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeRange::scale(self : SortexchangegnomeRange, f : Double) -> SortexchangegnomeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeRange::add(self : SortexchangegnomeRange, other : SortexchangegnomeRange) -> SortexchangegnomeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeRange::copy(self : SortexchangegnomeRange) -> SortexchangegnomeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeRange::fill(self : SortexchangegnomeRange, v : Double) -> SortexchangegnomeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeRange::min(self : SortexchangegnomeRange) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeRange::max(self : SortexchangegnomeRange) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeRange::to_string(self : SortexchangegnomeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_slice_make(size : Int) -> SortexchangegnomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangegnomeSlice::len(self : SortexchangegnomeSlice) -> Int { self.size }

pub fn SortexchangegnomeSlice::get(self : SortexchangegnomeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangegnomeSlice::set(self : SortexchangegnomeSlice, i : Int, v : Double) -> SortexchangegnomeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeSlice::sum(self : SortexchangegnomeSlice) -> Double { @_common.sum(self.data) }

pub fn SortexchangegnomeSlice::mean(self : SortexchangegnomeSlice) -> Double { @_common.mean(self.data) }

pub fn SortexchangegnomeSlice::scale(self : SortexchangegnomeSlice, f : Double) -> SortexchangegnomeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeSlice::add(self : SortexchangegnomeSlice, other : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangegnomeSlice::copy(self : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeSlice::fill(self : SortexchangegnomeSlice, v : Double) -> SortexchangegnomeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangegnomeSlice::min(self : SortexchangegnomeSlice) -> Double { @_common.min(self.data) }

pub fn SortexchangegnomeSlice::max(self : SortexchangegnomeSlice) -> Double { @_common.max(self.data) }

pub fn SortexchangegnomeSlice::to_string(self : SortexchangegnomeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

