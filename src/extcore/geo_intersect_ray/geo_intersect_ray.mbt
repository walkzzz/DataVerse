///===
/// extcore/geo_intersect_ray

pub(all) struct GeointersectrayPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_ray_make_point(x : Double, y : Double) -> GeointersectrayPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_ray_make_point3(x : Double, y : Double, z : Double) -> GeointersectrayPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectrayPoint::x(self : GeointersectrayPoint) -> Double { self.x }

pub fn GeointersectrayPoint::y(self : GeointersectrayPoint) -> Double { self.y }

pub fn GeointersectrayPoint::z(self : GeointersectrayPoint) -> Double { self.z }

pub fn GeointersectrayPoint::label(self : GeointersectrayPoint) -> Int { self.label }

pub fn GeointersectrayPoint::dist(self : GeointersectrayPoint, other : GeointersectrayPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectrayPoint::add(self : GeointersectrayPoint, other : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectrayPoint::sub(self : GeointersectrayPoint, other : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectrayPoint::scale(self : GeointersectrayPoint, s : Double) -> GeointersectrayPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectrayPoint::dot(self : GeointersectrayPoint, other : GeointersectrayPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectrayPoint::cross(self : GeointersectrayPoint, other : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectrayPoint::norm(self : GeointersectrayPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectrayPoint::normalize(self : GeointersectrayPoint) -> GeointersectrayPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectrayPoint::negate(self : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectrayPoint::mid(self : GeointersectrayPoint, other : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectrayPoint::lerp(self : GeointersectrayPoint, other : GeointersectrayPoint, t : Double) -> GeointersectrayPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectrayPoint::to_string(self : GeointersectrayPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectraySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_ray_make_series(vals : Array[Double], name : String) -> GeointersectraySeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectraySeries::len(self : GeointersectraySeries) -> Int { self.vals.length() }

pub fn GeointersectraySeries::sum(self : GeointersectraySeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectraySeries::mean(self : GeointersectraySeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectraySeries::min(self : GeointersectraySeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectraySeries::max(self : GeointersectraySeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectraySeries::range(self : GeointersectraySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectraySeries::variance(self : GeointersectraySeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectraySeries::std(self : GeointersectraySeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectraySeries::median(self : GeointersectraySeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectraySeries::scale(self : GeointersectraySeries, f : Double) -> GeointersectraySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectraySeries::add(self : GeointersectraySeries, other : GeointersectraySeries) -> GeointersectraySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectraySeries::sub(self : GeointersectraySeries, other : GeointersectraySeries) -> GeointersectraySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectraySeries::normalize(self : GeointersectraySeries) -> GeointersectraySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectraySeries::cumsum(self : GeointersectraySeries) -> GeointersectraySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectraySeries::to_string(self : GeointersectraySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectrayMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_ray_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectrayMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_intersect_ray_matrix_identity(n : Int) -> GeointersectrayMatrix {
  let m = geo_intersect_ray_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectrayMatrix::get(self : GeointersectrayMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectrayMatrix::transpose(self : GeointersectrayMatrix) -> GeointersectrayMatrix {
  let result = geo_intersect_ray_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectrayMatrix::add(self : GeointersectrayMatrix, other : GeointersectrayMatrix) -> GeointersectrayMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_ray_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectrayMatrix::scale(self : GeointersectrayMatrix, s : Double) -> GeointersectrayMatrix {
  let result = geo_intersect_ray_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectrayMatrix::multiply(self : GeointersectrayMatrix, other : GeointersectrayMatrix) -> GeointersectrayMatrix {
  if self.cols != other.rows { return geo_intersect_ray_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_ray_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeointersectrayMatrix::trace(self : GeointersectrayMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectrayMatrix::det(self : GeointersectrayMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectrayMatrix::norm(self : GeointersectrayMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectrayMatrix::to_string(self : GeointersectrayMatrix) -> String {
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

pub(all) struct GeointersectrayVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_ray_make_vector(comps : Array[Double]) -> GeointersectrayVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_ray_vector_zero(dim : Int) -> GeointersectrayVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectrayVector::add(self : GeointersectrayVector, other : GeointersectrayVector) -> GeointersectrayVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectrayVector::sub(self : GeointersectrayVector, other : GeointersectrayVector) -> GeointersectrayVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectrayVector::scale(self : GeointersectrayVector, s : Double) -> GeointersectrayVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectrayVector::dot(self : GeointersectrayVector, other : GeointersectrayVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectrayVector::norm(self : GeointersectrayVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectrayVector::normalize(self : GeointersectrayVector) -> GeointersectrayVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectrayVector::dist(self : GeointersectrayVector, other : GeointersectrayVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectrayVector::to_string(self : GeointersectrayVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectrayFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_frame_make(size : Int) -> GeointersectrayFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayFrame::len(self : GeointersectrayFrame) -> Int { self.size }

pub fn GeointersectrayFrame::get(self : GeointersectrayFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayFrame::set(self : GeointersectrayFrame, i : Int, v : Double) -> GeointersectrayFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayFrame::sum(self : GeointersectrayFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayFrame::mean(self : GeointersectrayFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayFrame::scale(self : GeointersectrayFrame, f : Double) -> GeointersectrayFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayFrame::add(self : GeointersectrayFrame, other : GeointersectrayFrame) -> GeointersectrayFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayFrame::copy(self : GeointersectrayFrame) -> GeointersectrayFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayFrame::fill(self : GeointersectrayFrame, v : Double) -> GeointersectrayFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayFrame::min(self : GeointersectrayFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectrayFrame::max(self : GeointersectrayFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectrayFrame::to_string(self : GeointersectrayFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_table_make(size : Int) -> GeointersectrayTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayTable::len(self : GeointersectrayTable) -> Int { self.size }

pub fn GeointersectrayTable::get(self : GeointersectrayTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayTable::set(self : GeointersectrayTable, i : Int, v : Double) -> GeointersectrayTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayTable::sum(self : GeointersectrayTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayTable::mean(self : GeointersectrayTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayTable::scale(self : GeointersectrayTable, f : Double) -> GeointersectrayTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayTable::add(self : GeointersectrayTable, other : GeointersectrayTable) -> GeointersectrayTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayTable::copy(self : GeointersectrayTable) -> GeointersectrayTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayTable::fill(self : GeointersectrayTable, v : Double) -> GeointersectrayTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayTable::min(self : GeointersectrayTable) -> Double { @_common.min(self.data) }

pub fn GeointersectrayTable::max(self : GeointersectrayTable) -> Double { @_common.max(self.data) }

pub fn GeointersectrayTable::to_string(self : GeointersectrayTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_graphn_make(size : Int) -> GeointersectrayGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayGraphN::len(self : GeointersectrayGraphN) -> Int { self.size }

pub fn GeointersectrayGraphN::get(self : GeointersectrayGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayGraphN::set(self : GeointersectrayGraphN, i : Int, v : Double) -> GeointersectrayGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayGraphN::sum(self : GeointersectrayGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayGraphN::mean(self : GeointersectrayGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayGraphN::scale(self : GeointersectrayGraphN, f : Double) -> GeointersectrayGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayGraphN::add(self : GeointersectrayGraphN, other : GeointersectrayGraphN) -> GeointersectrayGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayGraphN::copy(self : GeointersectrayGraphN) -> GeointersectrayGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayGraphN::fill(self : GeointersectrayGraphN, v : Double) -> GeointersectrayGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayGraphN::min(self : GeointersectrayGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectrayGraphN::max(self : GeointersectrayGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectrayGraphN::to_string(self : GeointersectrayGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_node_make(size : Int) -> GeointersectrayNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayNode::len(self : GeointersectrayNode) -> Int { self.size }

pub fn GeointersectrayNode::get(self : GeointersectrayNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayNode::set(self : GeointersectrayNode, i : Int, v : Double) -> GeointersectrayNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayNode::sum(self : GeointersectrayNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayNode::mean(self : GeointersectrayNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayNode::scale(self : GeointersectrayNode, f : Double) -> GeointersectrayNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayNode::add(self : GeointersectrayNode, other : GeointersectrayNode) -> GeointersectrayNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayNode::copy(self : GeointersectrayNode) -> GeointersectrayNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayNode::fill(self : GeointersectrayNode, v : Double) -> GeointersectrayNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayNode::min(self : GeointersectrayNode) -> Double { @_common.min(self.data) }

pub fn GeointersectrayNode::max(self : GeointersectrayNode) -> Double { @_common.max(self.data) }

pub fn GeointersectrayNode::to_string(self : GeointersectrayNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_edge_make(size : Int) -> GeointersectrayEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayEdge::len(self : GeointersectrayEdge) -> Int { self.size }

pub fn GeointersectrayEdge::get(self : GeointersectrayEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayEdge::set(self : GeointersectrayEdge, i : Int, v : Double) -> GeointersectrayEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayEdge::sum(self : GeointersectrayEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayEdge::mean(self : GeointersectrayEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayEdge::scale(self : GeointersectrayEdge, f : Double) -> GeointersectrayEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayEdge::add(self : GeointersectrayEdge, other : GeointersectrayEdge) -> GeointersectrayEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayEdge::copy(self : GeointersectrayEdge) -> GeointersectrayEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayEdge::fill(self : GeointersectrayEdge, v : Double) -> GeointersectrayEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayEdge::min(self : GeointersectrayEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectrayEdge::max(self : GeointersectrayEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectrayEdge::to_string(self : GeointersectrayEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_path_make(size : Int) -> GeointersectrayPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayPath::len(self : GeointersectrayPath) -> Int { self.size }

pub fn GeointersectrayPath::get(self : GeointersectrayPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayPath::set(self : GeointersectrayPath, i : Int, v : Double) -> GeointersectrayPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayPath::sum(self : GeointersectrayPath) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayPath::mean(self : GeointersectrayPath) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayPath::scale(self : GeointersectrayPath, f : Double) -> GeointersectrayPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayPath::add(self : GeointersectrayPath, other : GeointersectrayPath) -> GeointersectrayPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayPath::copy(self : GeointersectrayPath) -> GeointersectrayPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayPath::fill(self : GeointersectrayPath, v : Double) -> GeointersectrayPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayPath::min(self : GeointersectrayPath) -> Double { @_common.min(self.data) }

pub fn GeointersectrayPath::max(self : GeointersectrayPath) -> Double { @_common.max(self.data) }

pub fn GeointersectrayPath::to_string(self : GeointersectrayPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_cluster_make(size : Int) -> GeointersectrayCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayCluster::len(self : GeointersectrayCluster) -> Int { self.size }

pub fn GeointersectrayCluster::get(self : GeointersectrayCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayCluster::set(self : GeointersectrayCluster, i : Int, v : Double) -> GeointersectrayCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayCluster::sum(self : GeointersectrayCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayCluster::mean(self : GeointersectrayCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayCluster::scale(self : GeointersectrayCluster, f : Double) -> GeointersectrayCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayCluster::add(self : GeointersectrayCluster, other : GeointersectrayCluster) -> GeointersectrayCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayCluster::copy(self : GeointersectrayCluster) -> GeointersectrayCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayCluster::fill(self : GeointersectrayCluster, v : Double) -> GeointersectrayCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayCluster::min(self : GeointersectrayCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectrayCluster::max(self : GeointersectrayCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectrayCluster::to_string(self : GeointersectrayCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_model_make(size : Int) -> GeointersectrayModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayModel::len(self : GeointersectrayModel) -> Int { self.size }

pub fn GeointersectrayModel::get(self : GeointersectrayModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayModel::set(self : GeointersectrayModel, i : Int, v : Double) -> GeointersectrayModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayModel::sum(self : GeointersectrayModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayModel::mean(self : GeointersectrayModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayModel::scale(self : GeointersectrayModel, f : Double) -> GeointersectrayModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayModel::add(self : GeointersectrayModel, other : GeointersectrayModel) -> GeointersectrayModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayModel::copy(self : GeointersectrayModel) -> GeointersectrayModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayModel::fill(self : GeointersectrayModel, v : Double) -> GeointersectrayModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayModel::min(self : GeointersectrayModel) -> Double { @_common.min(self.data) }

pub fn GeointersectrayModel::max(self : GeointersectrayModel) -> Double { @_common.max(self.data) }

pub fn GeointersectrayModel::to_string(self : GeointersectrayModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_layer_make(size : Int) -> GeointersectrayLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayLayer::len(self : GeointersectrayLayer) -> Int { self.size }

pub fn GeointersectrayLayer::get(self : GeointersectrayLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayLayer::set(self : GeointersectrayLayer, i : Int, v : Double) -> GeointersectrayLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayLayer::sum(self : GeointersectrayLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayLayer::mean(self : GeointersectrayLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayLayer::scale(self : GeointersectrayLayer, f : Double) -> GeointersectrayLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayLayer::add(self : GeointersectrayLayer, other : GeointersectrayLayer) -> GeointersectrayLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayLayer::copy(self : GeointersectrayLayer) -> GeointersectrayLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayLayer::fill(self : GeointersectrayLayer, v : Double) -> GeointersectrayLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayLayer::min(self : GeointersectrayLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectrayLayer::max(self : GeointersectrayLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectrayLayer::to_string(self : GeointersectrayLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_buffer_make(size : Int) -> GeointersectrayBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayBuffer::len(self : GeointersectrayBuffer) -> Int { self.size }

pub fn GeointersectrayBuffer::get(self : GeointersectrayBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayBuffer::set(self : GeointersectrayBuffer, i : Int, v : Double) -> GeointersectrayBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayBuffer::sum(self : GeointersectrayBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayBuffer::mean(self : GeointersectrayBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayBuffer::scale(self : GeointersectrayBuffer, f : Double) -> GeointersectrayBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayBuffer::add(self : GeointersectrayBuffer, other : GeointersectrayBuffer) -> GeointersectrayBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayBuffer::copy(self : GeointersectrayBuffer) -> GeointersectrayBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayBuffer::fill(self : GeointersectrayBuffer, v : Double) -> GeointersectrayBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayBuffer::min(self : GeointersectrayBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectrayBuffer::max(self : GeointersectrayBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectrayBuffer::to_string(self : GeointersectrayBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_cursor_make(size : Int) -> GeointersectrayCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayCursor::len(self : GeointersectrayCursor) -> Int { self.size }

pub fn GeointersectrayCursor::get(self : GeointersectrayCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayCursor::set(self : GeointersectrayCursor, i : Int, v : Double) -> GeointersectrayCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayCursor::sum(self : GeointersectrayCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayCursor::mean(self : GeointersectrayCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayCursor::scale(self : GeointersectrayCursor, f : Double) -> GeointersectrayCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayCursor::add(self : GeointersectrayCursor, other : GeointersectrayCursor) -> GeointersectrayCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayCursor::copy(self : GeointersectrayCursor) -> GeointersectrayCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayCursor::fill(self : GeointersectrayCursor, v : Double) -> GeointersectrayCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayCursor::min(self : GeointersectrayCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectrayCursor::max(self : GeointersectrayCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectrayCursor::to_string(self : GeointersectrayCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_view_make(size : Int) -> GeointersectrayView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayView::len(self : GeointersectrayView) -> Int { self.size }

pub fn GeointersectrayView::get(self : GeointersectrayView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayView::set(self : GeointersectrayView, i : Int, v : Double) -> GeointersectrayView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayView::sum(self : GeointersectrayView) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayView::mean(self : GeointersectrayView) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayView::scale(self : GeointersectrayView, f : Double) -> GeointersectrayView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayView::add(self : GeointersectrayView, other : GeointersectrayView) -> GeointersectrayView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayView::copy(self : GeointersectrayView) -> GeointersectrayView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayView::fill(self : GeointersectrayView, v : Double) -> GeointersectrayView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayView::min(self : GeointersectrayView) -> Double { @_common.min(self.data) }

pub fn GeointersectrayView::max(self : GeointersectrayView) -> Double { @_common.max(self.data) }

pub fn GeointersectrayView::to_string(self : GeointersectrayView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectrayRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_range_make(size : Int) -> GeointersectrayRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectrayRange::len(self : GeointersectrayRange) -> Int { self.size }

pub fn GeointersectrayRange::get(self : GeointersectrayRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectrayRange::set(self : GeointersectrayRange, i : Int, v : Double) -> GeointersectrayRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectrayRange::sum(self : GeointersectrayRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectrayRange::mean(self : GeointersectrayRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectrayRange::scale(self : GeointersectrayRange, f : Double) -> GeointersectrayRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectrayRange::add(self : GeointersectrayRange, other : GeointersectrayRange) -> GeointersectrayRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectrayRange::copy(self : GeointersectrayRange) -> GeointersectrayRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectrayRange::fill(self : GeointersectrayRange, v : Double) -> GeointersectrayRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectrayRange::min(self : GeointersectrayRange) -> Double { @_common.min(self.data) }

pub fn GeointersectrayRange::max(self : GeointersectrayRange) -> Double { @_common.max(self.data) }

pub fn GeointersectrayRange::to_string(self : GeointersectrayRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectraySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_slice_make(size : Int) -> GeointersectraySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectraySlice::len(self : GeointersectraySlice) -> Int { self.size }

pub fn GeointersectraySlice::get(self : GeointersectraySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectraySlice::set(self : GeointersectraySlice, i : Int, v : Double) -> GeointersectraySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectraySlice::sum(self : GeointersectraySlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectraySlice::mean(self : GeointersectraySlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectraySlice::scale(self : GeointersectraySlice, f : Double) -> GeointersectraySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectraySlice::add(self : GeointersectraySlice, other : GeointersectraySlice) -> GeointersectraySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectraySlice::copy(self : GeointersectraySlice) -> GeointersectraySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectraySlice::fill(self : GeointersectraySlice, v : Double) -> GeointersectraySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectraySlice::min(self : GeointersectraySlice) -> Double { @_common.min(self.data) }

pub fn GeointersectraySlice::max(self : GeointersectraySlice) -> Double { @_common.max(self.data) }

pub fn GeointersectraySlice::to_string(self : GeointersectraySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

