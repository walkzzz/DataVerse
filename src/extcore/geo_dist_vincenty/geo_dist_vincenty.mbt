///===
/// extcore/geo_dist_vincenty

pub(all) struct GeodistvincentyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_vincenty_make_point(x : Double, y : Double) -> GeodistvincentyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_vincenty_make_point3(x : Double, y : Double, z : Double) -> GeodistvincentyPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistvincentyPoint::x(self : GeodistvincentyPoint) -> Double { self.x }

pub fn GeodistvincentyPoint::y(self : GeodistvincentyPoint) -> Double { self.y }

pub fn GeodistvincentyPoint::z(self : GeodistvincentyPoint) -> Double { self.z }

pub fn GeodistvincentyPoint::label(self : GeodistvincentyPoint) -> Int { self.label }

pub fn GeodistvincentyPoint::dist(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistvincentyPoint::add(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistvincentyPoint::sub(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistvincentyPoint::scale(self : GeodistvincentyPoint, s : Double) -> GeodistvincentyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistvincentyPoint::dot(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistvincentyPoint::cross(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistvincentyPoint::norm(self : GeodistvincentyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistvincentyPoint::normalize(self : GeodistvincentyPoint) -> GeodistvincentyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistvincentyPoint::negate(self : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistvincentyPoint::mid(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistvincentyPoint::lerp(self : GeodistvincentyPoint, other : GeodistvincentyPoint, t : Double) -> GeodistvincentyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistvincentyPoint::to_string(self : GeodistvincentyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistvincentySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_vincenty_make_series(vals : Array[Double], name : String) -> GeodistvincentySeries {
  { vals, name, meta: 0 }
}

pub fn GeodistvincentySeries::len(self : GeodistvincentySeries) -> Int { self.vals.length() }

pub fn GeodistvincentySeries::sum(self : GeodistvincentySeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistvincentySeries::mean(self : GeodistvincentySeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistvincentySeries::min(self : GeodistvincentySeries) -> Double { @_common.min(self.vals) }

pub fn GeodistvincentySeries::max(self : GeodistvincentySeries) -> Double { @_common.max(self.vals) }

pub fn GeodistvincentySeries::range(self : GeodistvincentySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistvincentySeries::variance(self : GeodistvincentySeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistvincentySeries::std(self : GeodistvincentySeries) -> Double { @_common.std(self.vals) }

pub fn GeodistvincentySeries::median(self : GeodistvincentySeries) -> Double { @_common.median(self.vals) }

pub fn GeodistvincentySeries::scale(self : GeodistvincentySeries, f : Double) -> GeodistvincentySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistvincentySeries::add(self : GeodistvincentySeries, other : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistvincentySeries::sub(self : GeodistvincentySeries, other : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistvincentySeries::normalize(self : GeodistvincentySeries) -> GeodistvincentySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistvincentySeries::cumsum(self : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistvincentySeries::to_string(self : GeodistvincentySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistvincentyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_vincenty_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistvincentyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_vincenty_matrix_identity(n : Int) -> GeodistvincentyMatrix {
  let m = geo_dist_vincenty_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistvincentyMatrix::get(self : GeodistvincentyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistvincentyMatrix::transpose(self : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistvincentyMatrix::add(self : GeodistvincentyMatrix, other : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_vincenty_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistvincentyMatrix::scale(self : GeodistvincentyMatrix, s : Double) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistvincentyMatrix::multiply(self : GeodistvincentyMatrix, other : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if self.cols != other.rows { return geo_dist_vincenty_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_vincenty_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistvincentyMatrix::trace(self : GeodistvincentyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistvincentyMatrix::det(self : GeodistvincentyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistvincentyMatrix::norm(self : GeodistvincentyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistvincentyMatrix::to_string(self : GeodistvincentyMatrix) -> String {
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

pub(all) struct GeodistvincentyVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_vincenty_make_vector(comps : Array[Double]) -> GeodistvincentyVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_vincenty_vector_zero(dim : Int) -> GeodistvincentyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistvincentyVector::add(self : GeodistvincentyVector, other : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistvincentyVector::sub(self : GeodistvincentyVector, other : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistvincentyVector::scale(self : GeodistvincentyVector, s : Double) -> GeodistvincentyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistvincentyVector::dot(self : GeodistvincentyVector, other : GeodistvincentyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistvincentyVector::norm(self : GeodistvincentyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistvincentyVector::normalize(self : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistvincentyVector::dist(self : GeodistvincentyVector, other : GeodistvincentyVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistvincentyVector::to_string(self : GeodistvincentyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistvincentyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_frame_make(size : Int) -> GeodistvincentyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyFrame::len(self : GeodistvincentyFrame) -> Int { self.size }

pub fn GeodistvincentyFrame::get(self : GeodistvincentyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyFrame::set(self : GeodistvincentyFrame, i : Int, v : Double) -> GeodistvincentyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyFrame::sum(self : GeodistvincentyFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyFrame::mean(self : GeodistvincentyFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyFrame::scale(self : GeodistvincentyFrame, f : Double) -> GeodistvincentyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyFrame::add(self : GeodistvincentyFrame, other : GeodistvincentyFrame) -> GeodistvincentyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyFrame::copy(self : GeodistvincentyFrame) -> GeodistvincentyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyFrame::fill(self : GeodistvincentyFrame, v : Double) -> GeodistvincentyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyFrame::min(self : GeodistvincentyFrame) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyFrame::max(self : GeodistvincentyFrame) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyFrame::to_string(self : GeodistvincentyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_table_make(size : Int) -> GeodistvincentyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyTable::len(self : GeodistvincentyTable) -> Int { self.size }

pub fn GeodistvincentyTable::get(self : GeodistvincentyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyTable::set(self : GeodistvincentyTable, i : Int, v : Double) -> GeodistvincentyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyTable::sum(self : GeodistvincentyTable) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyTable::mean(self : GeodistvincentyTable) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyTable::scale(self : GeodistvincentyTable, f : Double) -> GeodistvincentyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyTable::add(self : GeodistvincentyTable, other : GeodistvincentyTable) -> GeodistvincentyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyTable::copy(self : GeodistvincentyTable) -> GeodistvincentyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyTable::fill(self : GeodistvincentyTable, v : Double) -> GeodistvincentyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyTable::min(self : GeodistvincentyTable) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyTable::max(self : GeodistvincentyTable) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyTable::to_string(self : GeodistvincentyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_graphn_make(size : Int) -> GeodistvincentyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyGraphN::len(self : GeodistvincentyGraphN) -> Int { self.size }

pub fn GeodistvincentyGraphN::get(self : GeodistvincentyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyGraphN::set(self : GeodistvincentyGraphN, i : Int, v : Double) -> GeodistvincentyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyGraphN::sum(self : GeodistvincentyGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyGraphN::mean(self : GeodistvincentyGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyGraphN::scale(self : GeodistvincentyGraphN, f : Double) -> GeodistvincentyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyGraphN::add(self : GeodistvincentyGraphN, other : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyGraphN::copy(self : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyGraphN::fill(self : GeodistvincentyGraphN, v : Double) -> GeodistvincentyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyGraphN::min(self : GeodistvincentyGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyGraphN::max(self : GeodistvincentyGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyGraphN::to_string(self : GeodistvincentyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_node_make(size : Int) -> GeodistvincentyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyNode::len(self : GeodistvincentyNode) -> Int { self.size }

pub fn GeodistvincentyNode::get(self : GeodistvincentyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyNode::set(self : GeodistvincentyNode, i : Int, v : Double) -> GeodistvincentyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyNode::sum(self : GeodistvincentyNode) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyNode::mean(self : GeodistvincentyNode) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyNode::scale(self : GeodistvincentyNode, f : Double) -> GeodistvincentyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyNode::add(self : GeodistvincentyNode, other : GeodistvincentyNode) -> GeodistvincentyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyNode::copy(self : GeodistvincentyNode) -> GeodistvincentyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyNode::fill(self : GeodistvincentyNode, v : Double) -> GeodistvincentyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyNode::min(self : GeodistvincentyNode) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyNode::max(self : GeodistvincentyNode) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyNode::to_string(self : GeodistvincentyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_edge_make(size : Int) -> GeodistvincentyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyEdge::len(self : GeodistvincentyEdge) -> Int { self.size }

pub fn GeodistvincentyEdge::get(self : GeodistvincentyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyEdge::set(self : GeodistvincentyEdge, i : Int, v : Double) -> GeodistvincentyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyEdge::sum(self : GeodistvincentyEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyEdge::mean(self : GeodistvincentyEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyEdge::scale(self : GeodistvincentyEdge, f : Double) -> GeodistvincentyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyEdge::add(self : GeodistvincentyEdge, other : GeodistvincentyEdge) -> GeodistvincentyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyEdge::copy(self : GeodistvincentyEdge) -> GeodistvincentyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyEdge::fill(self : GeodistvincentyEdge, v : Double) -> GeodistvincentyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyEdge::min(self : GeodistvincentyEdge) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyEdge::max(self : GeodistvincentyEdge) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyEdge::to_string(self : GeodistvincentyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_path_make(size : Int) -> GeodistvincentyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyPath::len(self : GeodistvincentyPath) -> Int { self.size }

pub fn GeodistvincentyPath::get(self : GeodistvincentyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyPath::set(self : GeodistvincentyPath, i : Int, v : Double) -> GeodistvincentyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyPath::sum(self : GeodistvincentyPath) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyPath::mean(self : GeodistvincentyPath) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyPath::scale(self : GeodistvincentyPath, f : Double) -> GeodistvincentyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyPath::add(self : GeodistvincentyPath, other : GeodistvincentyPath) -> GeodistvincentyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyPath::copy(self : GeodistvincentyPath) -> GeodistvincentyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyPath::fill(self : GeodistvincentyPath, v : Double) -> GeodistvincentyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyPath::min(self : GeodistvincentyPath) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyPath::max(self : GeodistvincentyPath) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyPath::to_string(self : GeodistvincentyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cluster_make(size : Int) -> GeodistvincentyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyCluster::len(self : GeodistvincentyCluster) -> Int { self.size }

pub fn GeodistvincentyCluster::get(self : GeodistvincentyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyCluster::set(self : GeodistvincentyCluster, i : Int, v : Double) -> GeodistvincentyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCluster::sum(self : GeodistvincentyCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyCluster::mean(self : GeodistvincentyCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyCluster::scale(self : GeodistvincentyCluster, f : Double) -> GeodistvincentyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCluster::add(self : GeodistvincentyCluster, other : GeodistvincentyCluster) -> GeodistvincentyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyCluster::copy(self : GeodistvincentyCluster) -> GeodistvincentyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCluster::fill(self : GeodistvincentyCluster, v : Double) -> GeodistvincentyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCluster::min(self : GeodistvincentyCluster) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyCluster::max(self : GeodistvincentyCluster) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyCluster::to_string(self : GeodistvincentyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_model_make(size : Int) -> GeodistvincentyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyModel::len(self : GeodistvincentyModel) -> Int { self.size }

pub fn GeodistvincentyModel::get(self : GeodistvincentyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyModel::set(self : GeodistvincentyModel, i : Int, v : Double) -> GeodistvincentyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyModel::sum(self : GeodistvincentyModel) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyModel::mean(self : GeodistvincentyModel) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyModel::scale(self : GeodistvincentyModel, f : Double) -> GeodistvincentyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyModel::add(self : GeodistvincentyModel, other : GeodistvincentyModel) -> GeodistvincentyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyModel::copy(self : GeodistvincentyModel) -> GeodistvincentyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyModel::fill(self : GeodistvincentyModel, v : Double) -> GeodistvincentyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyModel::min(self : GeodistvincentyModel) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyModel::max(self : GeodistvincentyModel) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyModel::to_string(self : GeodistvincentyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_layer_make(size : Int) -> GeodistvincentyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyLayer::len(self : GeodistvincentyLayer) -> Int { self.size }

pub fn GeodistvincentyLayer::get(self : GeodistvincentyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyLayer::set(self : GeodistvincentyLayer, i : Int, v : Double) -> GeodistvincentyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyLayer::sum(self : GeodistvincentyLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyLayer::mean(self : GeodistvincentyLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyLayer::scale(self : GeodistvincentyLayer, f : Double) -> GeodistvincentyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyLayer::add(self : GeodistvincentyLayer, other : GeodistvincentyLayer) -> GeodistvincentyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyLayer::copy(self : GeodistvincentyLayer) -> GeodistvincentyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyLayer::fill(self : GeodistvincentyLayer, v : Double) -> GeodistvincentyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyLayer::min(self : GeodistvincentyLayer) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyLayer::max(self : GeodistvincentyLayer) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyLayer::to_string(self : GeodistvincentyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_buffer_make(size : Int) -> GeodistvincentyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyBuffer::len(self : GeodistvincentyBuffer) -> Int { self.size }

pub fn GeodistvincentyBuffer::get(self : GeodistvincentyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyBuffer::set(self : GeodistvincentyBuffer, i : Int, v : Double) -> GeodistvincentyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyBuffer::sum(self : GeodistvincentyBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyBuffer::mean(self : GeodistvincentyBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyBuffer::scale(self : GeodistvincentyBuffer, f : Double) -> GeodistvincentyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyBuffer::add(self : GeodistvincentyBuffer, other : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyBuffer::copy(self : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyBuffer::fill(self : GeodistvincentyBuffer, v : Double) -> GeodistvincentyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyBuffer::min(self : GeodistvincentyBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyBuffer::max(self : GeodistvincentyBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyBuffer::to_string(self : GeodistvincentyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cursor_make(size : Int) -> GeodistvincentyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyCursor::len(self : GeodistvincentyCursor) -> Int { self.size }

pub fn GeodistvincentyCursor::get(self : GeodistvincentyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyCursor::set(self : GeodistvincentyCursor, i : Int, v : Double) -> GeodistvincentyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCursor::sum(self : GeodistvincentyCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyCursor::mean(self : GeodistvincentyCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyCursor::scale(self : GeodistvincentyCursor, f : Double) -> GeodistvincentyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCursor::add(self : GeodistvincentyCursor, other : GeodistvincentyCursor) -> GeodistvincentyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyCursor::copy(self : GeodistvincentyCursor) -> GeodistvincentyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCursor::fill(self : GeodistvincentyCursor, v : Double) -> GeodistvincentyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyCursor::min(self : GeodistvincentyCursor) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyCursor::max(self : GeodistvincentyCursor) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyCursor::to_string(self : GeodistvincentyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_view_make(size : Int) -> GeodistvincentyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyView::len(self : GeodistvincentyView) -> Int { self.size }

pub fn GeodistvincentyView::get(self : GeodistvincentyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyView::set(self : GeodistvincentyView, i : Int, v : Double) -> GeodistvincentyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyView::sum(self : GeodistvincentyView) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyView::mean(self : GeodistvincentyView) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyView::scale(self : GeodistvincentyView, f : Double) -> GeodistvincentyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyView::add(self : GeodistvincentyView, other : GeodistvincentyView) -> GeodistvincentyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyView::copy(self : GeodistvincentyView) -> GeodistvincentyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyView::fill(self : GeodistvincentyView, v : Double) -> GeodistvincentyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyView::min(self : GeodistvincentyView) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyView::max(self : GeodistvincentyView) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyView::to_string(self : GeodistvincentyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_range_make(size : Int) -> GeodistvincentyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentyRange::len(self : GeodistvincentyRange) -> Int { self.size }

pub fn GeodistvincentyRange::get(self : GeodistvincentyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentyRange::set(self : GeodistvincentyRange, i : Int, v : Double) -> GeodistvincentyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentyRange::sum(self : GeodistvincentyRange) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentyRange::mean(self : GeodistvincentyRange) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentyRange::scale(self : GeodistvincentyRange, f : Double) -> GeodistvincentyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyRange::add(self : GeodistvincentyRange, other : GeodistvincentyRange) -> GeodistvincentyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentyRange::copy(self : GeodistvincentyRange) -> GeodistvincentyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyRange::fill(self : GeodistvincentyRange, v : Double) -> GeodistvincentyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentyRange::min(self : GeodistvincentyRange) -> Double { @_common.min(self.data) }

pub fn GeodistvincentyRange::max(self : GeodistvincentyRange) -> Double { @_common.max(self.data) }

pub fn GeodistvincentyRange::to_string(self : GeodistvincentyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistvincentySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_slice_make(size : Int) -> GeodistvincentySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistvincentySlice::len(self : GeodistvincentySlice) -> Int { self.size }

pub fn GeodistvincentySlice::get(self : GeodistvincentySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistvincentySlice::set(self : GeodistvincentySlice, i : Int, v : Double) -> GeodistvincentySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistvincentySlice::sum(self : GeodistvincentySlice) -> Double { @_common.sum(self.data) }

pub fn GeodistvincentySlice::mean(self : GeodistvincentySlice) -> Double { @_common.mean(self.data) }

pub fn GeodistvincentySlice::scale(self : GeodistvincentySlice, f : Double) -> GeodistvincentySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistvincentySlice::add(self : GeodistvincentySlice, other : GeodistvincentySlice) -> GeodistvincentySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistvincentySlice::copy(self : GeodistvincentySlice) -> GeodistvincentySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistvincentySlice::fill(self : GeodistvincentySlice, v : Double) -> GeodistvincentySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistvincentySlice::min(self : GeodistvincentySlice) -> Double { @_common.min(self.data) }

pub fn GeodistvincentySlice::max(self : GeodistvincentySlice) -> Double { @_common.max(self.data) }

pub fn GeodistvincentySlice::to_string(self : GeodistvincentySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

