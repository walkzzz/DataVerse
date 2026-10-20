///===
/// extcore/ds_hash_open

pub(all) struct DshashopenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_open_make_point(x : Double, y : Double) -> DshashopenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_open_make_point3(x : Double, y : Double, z : Double) -> DshashopenPoint {
  { x, y, z, label: 0 }
}

pub fn DshashopenPoint::x(self : DshashopenPoint) -> Double { self.x }

pub fn DshashopenPoint::y(self : DshashopenPoint) -> Double { self.y }

pub fn DshashopenPoint::z(self : DshashopenPoint) -> Double { self.z }

pub fn DshashopenPoint::label(self : DshashopenPoint) -> Int { self.label }

pub fn DshashopenPoint::dist(self : DshashopenPoint, other : DshashopenPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashopenPoint::add(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashopenPoint::sub(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashopenPoint::scale(self : DshashopenPoint, s : Double) -> DshashopenPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashopenPoint::dot(self : DshashopenPoint, other : DshashopenPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashopenPoint::cross(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashopenPoint::norm(self : DshashopenPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashopenPoint::normalize(self : DshashopenPoint) -> DshashopenPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashopenPoint::negate(self : DshashopenPoint) -> DshashopenPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashopenPoint::mid(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashopenPoint::lerp(self : DshashopenPoint, other : DshashopenPoint, t : Double) -> DshashopenPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashopenPoint::to_string(self : DshashopenPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashopenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_open_make_series(vals : Array[Double], name : String) -> DshashopenSeries {
  { vals, name, meta: 0 }
}

pub fn DshashopenSeries::len(self : DshashopenSeries) -> Int { self.vals.length() }

pub fn DshashopenSeries::sum(self : DshashopenSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashopenSeries::mean(self : DshashopenSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashopenSeries::min(self : DshashopenSeries) -> Double { @_common.min(self.vals) }

pub fn DshashopenSeries::max(self : DshashopenSeries) -> Double { @_common.max(self.vals) }

pub fn DshashopenSeries::range(self : DshashopenSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashopenSeries::variance(self : DshashopenSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashopenSeries::std(self : DshashopenSeries) -> Double { @_common.std(self.vals) }

pub fn DshashopenSeries::median(self : DshashopenSeries) -> Double { @_common.median(self.vals) }

pub fn DshashopenSeries::scale(self : DshashopenSeries, f : Double) -> DshashopenSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashopenSeries::add(self : DshashopenSeries, other : DshashopenSeries) -> DshashopenSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashopenSeries::sub(self : DshashopenSeries, other : DshashopenSeries) -> DshashopenSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashopenSeries::normalize(self : DshashopenSeries) -> DshashopenSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashopenSeries::cumsum(self : DshashopenSeries) -> DshashopenSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashopenSeries::to_string(self : DshashopenSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashopenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_open_make_matrix(rows : Int, cols : Int, val : Double) -> DshashopenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_open_matrix_identity(n : Int) -> DshashopenMatrix {
  let m = ds_hash_open_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashopenMatrix::get(self : DshashopenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashopenMatrix::transpose(self : DshashopenMatrix) -> DshashopenMatrix {
  let result = ds_hash_open_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashopenMatrix::add(self : DshashopenMatrix, other : DshashopenMatrix) -> DshashopenMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashopenMatrix::scale(self : DshashopenMatrix, s : Double) -> DshashopenMatrix {
  let result = ds_hash_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashopenMatrix::multiply(self : DshashopenMatrix, other : DshashopenMatrix) -> DshashopenMatrix {
  if self.cols != other.rows { return ds_hash_open_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_open_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DshashopenMatrix::trace(self : DshashopenMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashopenMatrix::det(self : DshashopenMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashopenMatrix::norm(self : DshashopenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashopenMatrix::to_string(self : DshashopenMatrix) -> String {
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

pub(all) struct DshashopenVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_open_make_vector(comps : Array[Double]) -> DshashopenVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_open_vector_zero(dim : Int) -> DshashopenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashopenVector::add(self : DshashopenVector, other : DshashopenVector) -> DshashopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashopenVector::sub(self : DshashopenVector, other : DshashopenVector) -> DshashopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashopenVector::scale(self : DshashopenVector, s : Double) -> DshashopenVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashopenVector::dot(self : DshashopenVector, other : DshashopenVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashopenVector::norm(self : DshashopenVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashopenVector::normalize(self : DshashopenVector) -> DshashopenVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashopenVector::dist(self : DshashopenVector, other : DshashopenVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashopenVector::to_string(self : DshashopenVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashopenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_frame_make(size : Int) -> DshashopenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenFrame::len(self : DshashopenFrame) -> Int { self.size }

pub fn DshashopenFrame::get(self : DshashopenFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenFrame::set(self : DshashopenFrame, i : Int, v : Double) -> DshashopenFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenFrame::sum(self : DshashopenFrame) -> Double { @_common.sum(self.data) }

pub fn DshashopenFrame::mean(self : DshashopenFrame) -> Double { @_common.mean(self.data) }

pub fn DshashopenFrame::scale(self : DshashopenFrame, f : Double) -> DshashopenFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenFrame::add(self : DshashopenFrame, other : DshashopenFrame) -> DshashopenFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenFrame::copy(self : DshashopenFrame) -> DshashopenFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenFrame::fill(self : DshashopenFrame, v : Double) -> DshashopenFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenFrame::min(self : DshashopenFrame) -> Double { @_common.min(self.data) }

pub fn DshashopenFrame::max(self : DshashopenFrame) -> Double { @_common.max(self.data) }

pub fn DshashopenFrame::to_string(self : DshashopenFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_table_make(size : Int) -> DshashopenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenTable::len(self : DshashopenTable) -> Int { self.size }

pub fn DshashopenTable::get(self : DshashopenTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenTable::set(self : DshashopenTable, i : Int, v : Double) -> DshashopenTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenTable::sum(self : DshashopenTable) -> Double { @_common.sum(self.data) }

pub fn DshashopenTable::mean(self : DshashopenTable) -> Double { @_common.mean(self.data) }

pub fn DshashopenTable::scale(self : DshashopenTable, f : Double) -> DshashopenTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenTable::add(self : DshashopenTable, other : DshashopenTable) -> DshashopenTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenTable::copy(self : DshashopenTable) -> DshashopenTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenTable::fill(self : DshashopenTable, v : Double) -> DshashopenTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenTable::min(self : DshashopenTable) -> Double { @_common.min(self.data) }

pub fn DshashopenTable::max(self : DshashopenTable) -> Double { @_common.max(self.data) }

pub fn DshashopenTable::to_string(self : DshashopenTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_graphn_make(size : Int) -> DshashopenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenGraphN::len(self : DshashopenGraphN) -> Int { self.size }

pub fn DshashopenGraphN::get(self : DshashopenGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenGraphN::set(self : DshashopenGraphN, i : Int, v : Double) -> DshashopenGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenGraphN::sum(self : DshashopenGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashopenGraphN::mean(self : DshashopenGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashopenGraphN::scale(self : DshashopenGraphN, f : Double) -> DshashopenGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenGraphN::add(self : DshashopenGraphN, other : DshashopenGraphN) -> DshashopenGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenGraphN::copy(self : DshashopenGraphN) -> DshashopenGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenGraphN::fill(self : DshashopenGraphN, v : Double) -> DshashopenGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenGraphN::min(self : DshashopenGraphN) -> Double { @_common.min(self.data) }

pub fn DshashopenGraphN::max(self : DshashopenGraphN) -> Double { @_common.max(self.data) }

pub fn DshashopenGraphN::to_string(self : DshashopenGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_node_make(size : Int) -> DshashopenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenNode::len(self : DshashopenNode) -> Int { self.size }

pub fn DshashopenNode::get(self : DshashopenNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenNode::set(self : DshashopenNode, i : Int, v : Double) -> DshashopenNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenNode::sum(self : DshashopenNode) -> Double { @_common.sum(self.data) }

pub fn DshashopenNode::mean(self : DshashopenNode) -> Double { @_common.mean(self.data) }

pub fn DshashopenNode::scale(self : DshashopenNode, f : Double) -> DshashopenNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenNode::add(self : DshashopenNode, other : DshashopenNode) -> DshashopenNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenNode::copy(self : DshashopenNode) -> DshashopenNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenNode::fill(self : DshashopenNode, v : Double) -> DshashopenNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenNode::min(self : DshashopenNode) -> Double { @_common.min(self.data) }

pub fn DshashopenNode::max(self : DshashopenNode) -> Double { @_common.max(self.data) }

pub fn DshashopenNode::to_string(self : DshashopenNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_edge_make(size : Int) -> DshashopenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenEdge::len(self : DshashopenEdge) -> Int { self.size }

pub fn DshashopenEdge::get(self : DshashopenEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenEdge::set(self : DshashopenEdge, i : Int, v : Double) -> DshashopenEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenEdge::sum(self : DshashopenEdge) -> Double { @_common.sum(self.data) }

pub fn DshashopenEdge::mean(self : DshashopenEdge) -> Double { @_common.mean(self.data) }

pub fn DshashopenEdge::scale(self : DshashopenEdge, f : Double) -> DshashopenEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenEdge::add(self : DshashopenEdge, other : DshashopenEdge) -> DshashopenEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenEdge::copy(self : DshashopenEdge) -> DshashopenEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenEdge::fill(self : DshashopenEdge, v : Double) -> DshashopenEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenEdge::min(self : DshashopenEdge) -> Double { @_common.min(self.data) }

pub fn DshashopenEdge::max(self : DshashopenEdge) -> Double { @_common.max(self.data) }

pub fn DshashopenEdge::to_string(self : DshashopenEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_path_make(size : Int) -> DshashopenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenPath::len(self : DshashopenPath) -> Int { self.size }

pub fn DshashopenPath::get(self : DshashopenPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenPath::set(self : DshashopenPath, i : Int, v : Double) -> DshashopenPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenPath::sum(self : DshashopenPath) -> Double { @_common.sum(self.data) }

pub fn DshashopenPath::mean(self : DshashopenPath) -> Double { @_common.mean(self.data) }

pub fn DshashopenPath::scale(self : DshashopenPath, f : Double) -> DshashopenPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenPath::add(self : DshashopenPath, other : DshashopenPath) -> DshashopenPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenPath::copy(self : DshashopenPath) -> DshashopenPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenPath::fill(self : DshashopenPath, v : Double) -> DshashopenPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenPath::min(self : DshashopenPath) -> Double { @_common.min(self.data) }

pub fn DshashopenPath::max(self : DshashopenPath) -> Double { @_common.max(self.data) }

pub fn DshashopenPath::to_string(self : DshashopenPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_cluster_make(size : Int) -> DshashopenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenCluster::len(self : DshashopenCluster) -> Int { self.size }

pub fn DshashopenCluster::get(self : DshashopenCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenCluster::set(self : DshashopenCluster, i : Int, v : Double) -> DshashopenCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenCluster::sum(self : DshashopenCluster) -> Double { @_common.sum(self.data) }

pub fn DshashopenCluster::mean(self : DshashopenCluster) -> Double { @_common.mean(self.data) }

pub fn DshashopenCluster::scale(self : DshashopenCluster, f : Double) -> DshashopenCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenCluster::add(self : DshashopenCluster, other : DshashopenCluster) -> DshashopenCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenCluster::copy(self : DshashopenCluster) -> DshashopenCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenCluster::fill(self : DshashopenCluster, v : Double) -> DshashopenCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenCluster::min(self : DshashopenCluster) -> Double { @_common.min(self.data) }

pub fn DshashopenCluster::max(self : DshashopenCluster) -> Double { @_common.max(self.data) }

pub fn DshashopenCluster::to_string(self : DshashopenCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_model_make(size : Int) -> DshashopenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenModel::len(self : DshashopenModel) -> Int { self.size }

pub fn DshashopenModel::get(self : DshashopenModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenModel::set(self : DshashopenModel, i : Int, v : Double) -> DshashopenModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenModel::sum(self : DshashopenModel) -> Double { @_common.sum(self.data) }

pub fn DshashopenModel::mean(self : DshashopenModel) -> Double { @_common.mean(self.data) }

pub fn DshashopenModel::scale(self : DshashopenModel, f : Double) -> DshashopenModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenModel::add(self : DshashopenModel, other : DshashopenModel) -> DshashopenModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenModel::copy(self : DshashopenModel) -> DshashopenModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenModel::fill(self : DshashopenModel, v : Double) -> DshashopenModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenModel::min(self : DshashopenModel) -> Double { @_common.min(self.data) }

pub fn DshashopenModel::max(self : DshashopenModel) -> Double { @_common.max(self.data) }

pub fn DshashopenModel::to_string(self : DshashopenModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_layer_make(size : Int) -> DshashopenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenLayer::len(self : DshashopenLayer) -> Int { self.size }

pub fn DshashopenLayer::get(self : DshashopenLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenLayer::set(self : DshashopenLayer, i : Int, v : Double) -> DshashopenLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenLayer::sum(self : DshashopenLayer) -> Double { @_common.sum(self.data) }

pub fn DshashopenLayer::mean(self : DshashopenLayer) -> Double { @_common.mean(self.data) }

pub fn DshashopenLayer::scale(self : DshashopenLayer, f : Double) -> DshashopenLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenLayer::add(self : DshashopenLayer, other : DshashopenLayer) -> DshashopenLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenLayer::copy(self : DshashopenLayer) -> DshashopenLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenLayer::fill(self : DshashopenLayer, v : Double) -> DshashopenLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenLayer::min(self : DshashopenLayer) -> Double { @_common.min(self.data) }

pub fn DshashopenLayer::max(self : DshashopenLayer) -> Double { @_common.max(self.data) }

pub fn DshashopenLayer::to_string(self : DshashopenLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_buffer_make(size : Int) -> DshashopenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenBuffer::len(self : DshashopenBuffer) -> Int { self.size }

pub fn DshashopenBuffer::get(self : DshashopenBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenBuffer::set(self : DshashopenBuffer, i : Int, v : Double) -> DshashopenBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenBuffer::sum(self : DshashopenBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashopenBuffer::mean(self : DshashopenBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashopenBuffer::scale(self : DshashopenBuffer, f : Double) -> DshashopenBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenBuffer::add(self : DshashopenBuffer, other : DshashopenBuffer) -> DshashopenBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenBuffer::copy(self : DshashopenBuffer) -> DshashopenBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenBuffer::fill(self : DshashopenBuffer, v : Double) -> DshashopenBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenBuffer::min(self : DshashopenBuffer) -> Double { @_common.min(self.data) }

pub fn DshashopenBuffer::max(self : DshashopenBuffer) -> Double { @_common.max(self.data) }

pub fn DshashopenBuffer::to_string(self : DshashopenBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_cursor_make(size : Int) -> DshashopenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenCursor::len(self : DshashopenCursor) -> Int { self.size }

pub fn DshashopenCursor::get(self : DshashopenCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenCursor::set(self : DshashopenCursor, i : Int, v : Double) -> DshashopenCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenCursor::sum(self : DshashopenCursor) -> Double { @_common.sum(self.data) }

pub fn DshashopenCursor::mean(self : DshashopenCursor) -> Double { @_common.mean(self.data) }

pub fn DshashopenCursor::scale(self : DshashopenCursor, f : Double) -> DshashopenCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenCursor::add(self : DshashopenCursor, other : DshashopenCursor) -> DshashopenCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenCursor::copy(self : DshashopenCursor) -> DshashopenCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenCursor::fill(self : DshashopenCursor, v : Double) -> DshashopenCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenCursor::min(self : DshashopenCursor) -> Double { @_common.min(self.data) }

pub fn DshashopenCursor::max(self : DshashopenCursor) -> Double { @_common.max(self.data) }

pub fn DshashopenCursor::to_string(self : DshashopenCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_view_make(size : Int) -> DshashopenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenView::len(self : DshashopenView) -> Int { self.size }

pub fn DshashopenView::get(self : DshashopenView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenView::set(self : DshashopenView, i : Int, v : Double) -> DshashopenView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenView::sum(self : DshashopenView) -> Double { @_common.sum(self.data) }

pub fn DshashopenView::mean(self : DshashopenView) -> Double { @_common.mean(self.data) }

pub fn DshashopenView::scale(self : DshashopenView, f : Double) -> DshashopenView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenView::add(self : DshashopenView, other : DshashopenView) -> DshashopenView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenView::copy(self : DshashopenView) -> DshashopenView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenView::fill(self : DshashopenView, v : Double) -> DshashopenView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenView::min(self : DshashopenView) -> Double { @_common.min(self.data) }

pub fn DshashopenView::max(self : DshashopenView) -> Double { @_common.max(self.data) }

pub fn DshashopenView::to_string(self : DshashopenView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_range_make(size : Int) -> DshashopenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenRange::len(self : DshashopenRange) -> Int { self.size }

pub fn DshashopenRange::get(self : DshashopenRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenRange::set(self : DshashopenRange, i : Int, v : Double) -> DshashopenRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenRange::sum(self : DshashopenRange) -> Double { @_common.sum(self.data) }

pub fn DshashopenRange::mean(self : DshashopenRange) -> Double { @_common.mean(self.data) }

pub fn DshashopenRange::scale(self : DshashopenRange, f : Double) -> DshashopenRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenRange::add(self : DshashopenRange, other : DshashopenRange) -> DshashopenRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenRange::copy(self : DshashopenRange) -> DshashopenRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenRange::fill(self : DshashopenRange, v : Double) -> DshashopenRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenRange::min(self : DshashopenRange) -> Double { @_common.min(self.data) }

pub fn DshashopenRange::max(self : DshashopenRange) -> Double { @_common.max(self.data) }

pub fn DshashopenRange::to_string(self : DshashopenRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashopenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_slice_make(size : Int) -> DshashopenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashopenSlice::len(self : DshashopenSlice) -> Int { self.size }

pub fn DshashopenSlice::get(self : DshashopenSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashopenSlice::set(self : DshashopenSlice, i : Int, v : Double) -> DshashopenSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashopenSlice::sum(self : DshashopenSlice) -> Double { @_common.sum(self.data) }

pub fn DshashopenSlice::mean(self : DshashopenSlice) -> Double { @_common.mean(self.data) }

pub fn DshashopenSlice::scale(self : DshashopenSlice, f : Double) -> DshashopenSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashopenSlice::add(self : DshashopenSlice, other : DshashopenSlice) -> DshashopenSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashopenSlice::copy(self : DshashopenSlice) -> DshashopenSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashopenSlice::fill(self : DshashopenSlice, v : Double) -> DshashopenSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashopenSlice::min(self : DshashopenSlice) -> Double { @_common.min(self.data) }

pub fn DshashopenSlice::max(self : DshashopenSlice) -> Double { @_common.max(self.data) }

pub fn DshashopenSlice::to_string(self : DshashopenSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

