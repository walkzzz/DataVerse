///===
/// extcore/sort_exchange_pancake

pub(all) struct SortexchangepancakePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_pancake_make_point(x : Double, y : Double) -> SortexchangepancakePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_pancake_make_point3(x : Double, y : Double, z : Double) -> SortexchangepancakePoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangepancakePoint::x(self : SortexchangepancakePoint) -> Double { self.x }

pub fn SortexchangepancakePoint::y(self : SortexchangepancakePoint) -> Double { self.y }

pub fn SortexchangepancakePoint::z(self : SortexchangepancakePoint) -> Double { self.z }

pub fn SortexchangepancakePoint::label(self : SortexchangepancakePoint) -> Int { self.label }

pub fn SortexchangepancakePoint::dist(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangepancakePoint::add(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangepancakePoint::sub(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangepancakePoint::scale(self : SortexchangepancakePoint, s : Double) -> SortexchangepancakePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangepancakePoint::dot(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangepancakePoint::cross(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangepancakePoint::norm(self : SortexchangepancakePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangepancakePoint::normalize(self : SortexchangepancakePoint) -> SortexchangepancakePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangepancakePoint::negate(self : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangepancakePoint::mid(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangepancakePoint::lerp(self : SortexchangepancakePoint, other : SortexchangepancakePoint, t : Double) -> SortexchangepancakePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangepancakePoint::to_string(self : SortexchangepancakePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangepancakeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_pancake_make_series(vals : Array[Double], name : String) -> SortexchangepancakeSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangepancakeSeries::len(self : SortexchangepancakeSeries) -> Int { self.vals.length() }

pub fn SortexchangepancakeSeries::sum(self : SortexchangepancakeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangepancakeSeries::mean(self : SortexchangepancakeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangepancakeSeries::min(self : SortexchangepancakeSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangepancakeSeries::max(self : SortexchangepancakeSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangepancakeSeries::range(self : SortexchangepancakeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangepancakeSeries::variance(self : SortexchangepancakeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangepancakeSeries::std(self : SortexchangepancakeSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangepancakeSeries::median(self : SortexchangepancakeSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangepancakeSeries::scale(self : SortexchangepancakeSeries, f : Double) -> SortexchangepancakeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangepancakeSeries::add(self : SortexchangepancakeSeries, other : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangepancakeSeries::sub(self : SortexchangepancakeSeries, other : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangepancakeSeries::normalize(self : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangepancakeSeries::cumsum(self : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangepancakeSeries::to_string(self : SortexchangepancakeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangepancakeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_pancake_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangepancakeMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn sort_exchange_pancake_matrix_identity(n : Int) -> SortexchangepancakeMatrix {
  let m = sort_exchange_pancake_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangepancakeMatrix::get(self : SortexchangepancakeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangepancakeMatrix::transpose(self : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  let result = sort_exchange_pancake_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangepancakeMatrix::add(self : SortexchangepancakeMatrix, other : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_pancake_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangepancakeMatrix::scale(self : SortexchangepancakeMatrix, s : Double) -> SortexchangepancakeMatrix {
  let result = sort_exchange_pancake_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangepancakeMatrix::multiply(self : SortexchangepancakeMatrix, other : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  if self.cols != other.rows { return sort_exchange_pancake_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_pancake_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SortexchangepancakeMatrix::trace(self : SortexchangepancakeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangepancakeMatrix::det(self : SortexchangepancakeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangepancakeMatrix::norm(self : SortexchangepancakeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangepancakeMatrix::to_string(self : SortexchangepancakeMatrix) -> String {
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

pub(all) struct SortexchangepancakeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_pancake_make_vector(comps : Array[Double]) -> SortexchangepancakeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_pancake_vector_zero(dim : Int) -> SortexchangepancakeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangepancakeVector::add(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangepancakeVector::sub(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangepancakeVector::scale(self : SortexchangepancakeVector, s : Double) -> SortexchangepancakeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangepancakeVector::dot(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangepancakeVector::norm(self : SortexchangepancakeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangepancakeVector::normalize(self : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangepancakeVector::dist(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangepancakeVector::to_string(self : SortexchangepancakeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangepancakeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_frame_make(size : Int) -> SortexchangepancakeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeFrame::len(self : SortexchangepancakeFrame) -> Int { self.size }

pub fn SortexchangepancakeFrame::get(self : SortexchangepancakeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeFrame::set(self : SortexchangepancakeFrame, i : Int, v : Double) -> SortexchangepancakeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeFrame::sum(self : SortexchangepancakeFrame) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeFrame::mean(self : SortexchangepancakeFrame) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeFrame::scale(self : SortexchangepancakeFrame, f : Double) -> SortexchangepancakeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeFrame::add(self : SortexchangepancakeFrame, other : SortexchangepancakeFrame) -> SortexchangepancakeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeFrame::copy(self : SortexchangepancakeFrame) -> SortexchangepancakeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeFrame::fill(self : SortexchangepancakeFrame, v : Double) -> SortexchangepancakeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeFrame::min(self : SortexchangepancakeFrame) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeFrame::max(self : SortexchangepancakeFrame) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeFrame::to_string(self : SortexchangepancakeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_table_make(size : Int) -> SortexchangepancakeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeTable::len(self : SortexchangepancakeTable) -> Int { self.size }

pub fn SortexchangepancakeTable::get(self : SortexchangepancakeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeTable::set(self : SortexchangepancakeTable, i : Int, v : Double) -> SortexchangepancakeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeTable::sum(self : SortexchangepancakeTable) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeTable::mean(self : SortexchangepancakeTable) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeTable::scale(self : SortexchangepancakeTable, f : Double) -> SortexchangepancakeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeTable::add(self : SortexchangepancakeTable, other : SortexchangepancakeTable) -> SortexchangepancakeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeTable::copy(self : SortexchangepancakeTable) -> SortexchangepancakeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeTable::fill(self : SortexchangepancakeTable, v : Double) -> SortexchangepancakeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeTable::min(self : SortexchangepancakeTable) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeTable::max(self : SortexchangepancakeTable) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeTable::to_string(self : SortexchangepancakeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_graphn_make(size : Int) -> SortexchangepancakeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeGraphN::len(self : SortexchangepancakeGraphN) -> Int { self.size }

pub fn SortexchangepancakeGraphN::get(self : SortexchangepancakeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeGraphN::set(self : SortexchangepancakeGraphN, i : Int, v : Double) -> SortexchangepancakeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeGraphN::sum(self : SortexchangepancakeGraphN) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeGraphN::mean(self : SortexchangepancakeGraphN) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeGraphN::scale(self : SortexchangepancakeGraphN, f : Double) -> SortexchangepancakeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeGraphN::add(self : SortexchangepancakeGraphN, other : SortexchangepancakeGraphN) -> SortexchangepancakeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeGraphN::copy(self : SortexchangepancakeGraphN) -> SortexchangepancakeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeGraphN::fill(self : SortexchangepancakeGraphN, v : Double) -> SortexchangepancakeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeGraphN::min(self : SortexchangepancakeGraphN) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeGraphN::max(self : SortexchangepancakeGraphN) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeGraphN::to_string(self : SortexchangepancakeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_node_make(size : Int) -> SortexchangepancakeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeNode::len(self : SortexchangepancakeNode) -> Int { self.size }

pub fn SortexchangepancakeNode::get(self : SortexchangepancakeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeNode::set(self : SortexchangepancakeNode, i : Int, v : Double) -> SortexchangepancakeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeNode::sum(self : SortexchangepancakeNode) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeNode::mean(self : SortexchangepancakeNode) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeNode::scale(self : SortexchangepancakeNode, f : Double) -> SortexchangepancakeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeNode::add(self : SortexchangepancakeNode, other : SortexchangepancakeNode) -> SortexchangepancakeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeNode::copy(self : SortexchangepancakeNode) -> SortexchangepancakeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeNode::fill(self : SortexchangepancakeNode, v : Double) -> SortexchangepancakeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeNode::min(self : SortexchangepancakeNode) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeNode::max(self : SortexchangepancakeNode) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeNode::to_string(self : SortexchangepancakeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_edge_make(size : Int) -> SortexchangepancakeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeEdge::len(self : SortexchangepancakeEdge) -> Int { self.size }

pub fn SortexchangepancakeEdge::get(self : SortexchangepancakeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeEdge::set(self : SortexchangepancakeEdge, i : Int, v : Double) -> SortexchangepancakeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeEdge::sum(self : SortexchangepancakeEdge) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeEdge::mean(self : SortexchangepancakeEdge) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeEdge::scale(self : SortexchangepancakeEdge, f : Double) -> SortexchangepancakeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeEdge::add(self : SortexchangepancakeEdge, other : SortexchangepancakeEdge) -> SortexchangepancakeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeEdge::copy(self : SortexchangepancakeEdge) -> SortexchangepancakeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeEdge::fill(self : SortexchangepancakeEdge, v : Double) -> SortexchangepancakeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeEdge::min(self : SortexchangepancakeEdge) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeEdge::max(self : SortexchangepancakeEdge) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeEdge::to_string(self : SortexchangepancakeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_path_make(size : Int) -> SortexchangepancakePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakePath::len(self : SortexchangepancakePath) -> Int { self.size }

pub fn SortexchangepancakePath::get(self : SortexchangepancakePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakePath::set(self : SortexchangepancakePath, i : Int, v : Double) -> SortexchangepancakePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakePath::sum(self : SortexchangepancakePath) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakePath::mean(self : SortexchangepancakePath) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakePath::scale(self : SortexchangepancakePath, f : Double) -> SortexchangepancakePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakePath::add(self : SortexchangepancakePath, other : SortexchangepancakePath) -> SortexchangepancakePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakePath::copy(self : SortexchangepancakePath) -> SortexchangepancakePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakePath::fill(self : SortexchangepancakePath, v : Double) -> SortexchangepancakePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakePath::min(self : SortexchangepancakePath) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakePath::max(self : SortexchangepancakePath) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakePath::to_string(self : SortexchangepancakePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_cluster_make(size : Int) -> SortexchangepancakeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeCluster::len(self : SortexchangepancakeCluster) -> Int { self.size }

pub fn SortexchangepancakeCluster::get(self : SortexchangepancakeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeCluster::set(self : SortexchangepancakeCluster, i : Int, v : Double) -> SortexchangepancakeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCluster::sum(self : SortexchangepancakeCluster) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeCluster::mean(self : SortexchangepancakeCluster) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeCluster::scale(self : SortexchangepancakeCluster, f : Double) -> SortexchangepancakeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCluster::add(self : SortexchangepancakeCluster, other : SortexchangepancakeCluster) -> SortexchangepancakeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeCluster::copy(self : SortexchangepancakeCluster) -> SortexchangepancakeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCluster::fill(self : SortexchangepancakeCluster, v : Double) -> SortexchangepancakeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCluster::min(self : SortexchangepancakeCluster) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeCluster::max(self : SortexchangepancakeCluster) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeCluster::to_string(self : SortexchangepancakeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_model_make(size : Int) -> SortexchangepancakeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeModel::len(self : SortexchangepancakeModel) -> Int { self.size }

pub fn SortexchangepancakeModel::get(self : SortexchangepancakeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeModel::set(self : SortexchangepancakeModel, i : Int, v : Double) -> SortexchangepancakeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeModel::sum(self : SortexchangepancakeModel) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeModel::mean(self : SortexchangepancakeModel) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeModel::scale(self : SortexchangepancakeModel, f : Double) -> SortexchangepancakeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeModel::add(self : SortexchangepancakeModel, other : SortexchangepancakeModel) -> SortexchangepancakeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeModel::copy(self : SortexchangepancakeModel) -> SortexchangepancakeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeModel::fill(self : SortexchangepancakeModel, v : Double) -> SortexchangepancakeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeModel::min(self : SortexchangepancakeModel) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeModel::max(self : SortexchangepancakeModel) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeModel::to_string(self : SortexchangepancakeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_layer_make(size : Int) -> SortexchangepancakeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeLayer::len(self : SortexchangepancakeLayer) -> Int { self.size }

pub fn SortexchangepancakeLayer::get(self : SortexchangepancakeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeLayer::set(self : SortexchangepancakeLayer, i : Int, v : Double) -> SortexchangepancakeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeLayer::sum(self : SortexchangepancakeLayer) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeLayer::mean(self : SortexchangepancakeLayer) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeLayer::scale(self : SortexchangepancakeLayer, f : Double) -> SortexchangepancakeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeLayer::add(self : SortexchangepancakeLayer, other : SortexchangepancakeLayer) -> SortexchangepancakeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeLayer::copy(self : SortexchangepancakeLayer) -> SortexchangepancakeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeLayer::fill(self : SortexchangepancakeLayer, v : Double) -> SortexchangepancakeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeLayer::min(self : SortexchangepancakeLayer) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeLayer::max(self : SortexchangepancakeLayer) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeLayer::to_string(self : SortexchangepancakeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_buffer_make(size : Int) -> SortexchangepancakeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeBuffer::len(self : SortexchangepancakeBuffer) -> Int { self.size }

pub fn SortexchangepancakeBuffer::get(self : SortexchangepancakeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeBuffer::set(self : SortexchangepancakeBuffer, i : Int, v : Double) -> SortexchangepancakeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeBuffer::sum(self : SortexchangepancakeBuffer) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeBuffer::mean(self : SortexchangepancakeBuffer) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeBuffer::scale(self : SortexchangepancakeBuffer, f : Double) -> SortexchangepancakeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeBuffer::add(self : SortexchangepancakeBuffer, other : SortexchangepancakeBuffer) -> SortexchangepancakeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeBuffer::copy(self : SortexchangepancakeBuffer) -> SortexchangepancakeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeBuffer::fill(self : SortexchangepancakeBuffer, v : Double) -> SortexchangepancakeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeBuffer::min(self : SortexchangepancakeBuffer) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeBuffer::max(self : SortexchangepancakeBuffer) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeBuffer::to_string(self : SortexchangepancakeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_cursor_make(size : Int) -> SortexchangepancakeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeCursor::len(self : SortexchangepancakeCursor) -> Int { self.size }

pub fn SortexchangepancakeCursor::get(self : SortexchangepancakeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeCursor::set(self : SortexchangepancakeCursor, i : Int, v : Double) -> SortexchangepancakeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCursor::sum(self : SortexchangepancakeCursor) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeCursor::mean(self : SortexchangepancakeCursor) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeCursor::scale(self : SortexchangepancakeCursor, f : Double) -> SortexchangepancakeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCursor::add(self : SortexchangepancakeCursor, other : SortexchangepancakeCursor) -> SortexchangepancakeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeCursor::copy(self : SortexchangepancakeCursor) -> SortexchangepancakeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCursor::fill(self : SortexchangepancakeCursor, v : Double) -> SortexchangepancakeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeCursor::min(self : SortexchangepancakeCursor) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeCursor::max(self : SortexchangepancakeCursor) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeCursor::to_string(self : SortexchangepancakeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_view_make(size : Int) -> SortexchangepancakeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeView::len(self : SortexchangepancakeView) -> Int { self.size }

pub fn SortexchangepancakeView::get(self : SortexchangepancakeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeView::set(self : SortexchangepancakeView, i : Int, v : Double) -> SortexchangepancakeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeView::sum(self : SortexchangepancakeView) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeView::mean(self : SortexchangepancakeView) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeView::scale(self : SortexchangepancakeView, f : Double) -> SortexchangepancakeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeView::add(self : SortexchangepancakeView, other : SortexchangepancakeView) -> SortexchangepancakeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeView::copy(self : SortexchangepancakeView) -> SortexchangepancakeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeView::fill(self : SortexchangepancakeView, v : Double) -> SortexchangepancakeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeView::min(self : SortexchangepancakeView) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeView::max(self : SortexchangepancakeView) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeView::to_string(self : SortexchangepancakeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_range_make(size : Int) -> SortexchangepancakeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeRange::len(self : SortexchangepancakeRange) -> Int { self.size }

pub fn SortexchangepancakeRange::get(self : SortexchangepancakeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeRange::set(self : SortexchangepancakeRange, i : Int, v : Double) -> SortexchangepancakeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeRange::sum(self : SortexchangepancakeRange) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeRange::mean(self : SortexchangepancakeRange) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeRange::scale(self : SortexchangepancakeRange, f : Double) -> SortexchangepancakeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeRange::add(self : SortexchangepancakeRange, other : SortexchangepancakeRange) -> SortexchangepancakeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeRange::copy(self : SortexchangepancakeRange) -> SortexchangepancakeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeRange::fill(self : SortexchangepancakeRange, v : Double) -> SortexchangepancakeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeRange::min(self : SortexchangepancakeRange) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeRange::max(self : SortexchangepancakeRange) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeRange::to_string(self : SortexchangepancakeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_slice_make(size : Int) -> SortexchangepancakeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangepancakeSlice::len(self : SortexchangepancakeSlice) -> Int { self.size }

pub fn SortexchangepancakeSlice::get(self : SortexchangepancakeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangepancakeSlice::set(self : SortexchangepancakeSlice, i : Int, v : Double) -> SortexchangepancakeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeSlice::sum(self : SortexchangepancakeSlice) -> Double { @_common.sum(self.data) }

pub fn SortexchangepancakeSlice::mean(self : SortexchangepancakeSlice) -> Double { @_common.mean(self.data) }

pub fn SortexchangepancakeSlice::scale(self : SortexchangepancakeSlice, f : Double) -> SortexchangepancakeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeSlice::add(self : SortexchangepancakeSlice, other : SortexchangepancakeSlice) -> SortexchangepancakeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangepancakeSlice::copy(self : SortexchangepancakeSlice) -> SortexchangepancakeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeSlice::fill(self : SortexchangepancakeSlice, v : Double) -> SortexchangepancakeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangepancakeSlice::min(self : SortexchangepancakeSlice) -> Double { @_common.min(self.data) }

pub fn SortexchangepancakeSlice::max(self : SortexchangepancakeSlice) -> Double { @_common.max(self.data) }

pub fn SortexchangepancakeSlice::to_string(self : SortexchangepancakeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

