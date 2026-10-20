///===
/// extcore/geo_dist_projected

pub(all) struct GeodistprojectedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_projected_make_point(x : Double, y : Double) -> GeodistprojectedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_projected_make_point3(x : Double, y : Double, z : Double) -> GeodistprojectedPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistprojectedPoint::x(self : GeodistprojectedPoint) -> Double { self.x }

pub fn GeodistprojectedPoint::y(self : GeodistprojectedPoint) -> Double { self.y }

pub fn GeodistprojectedPoint::z(self : GeodistprojectedPoint) -> Double { self.z }

pub fn GeodistprojectedPoint::label(self : GeodistprojectedPoint) -> Int { self.label }

pub fn GeodistprojectedPoint::dist(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistprojectedPoint::add(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistprojectedPoint::sub(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistprojectedPoint::scale(self : GeodistprojectedPoint, s : Double) -> GeodistprojectedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistprojectedPoint::dot(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistprojectedPoint::cross(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistprojectedPoint::norm(self : GeodistprojectedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistprojectedPoint::normalize(self : GeodistprojectedPoint) -> GeodistprojectedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistprojectedPoint::negate(self : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistprojectedPoint::mid(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistprojectedPoint::lerp(self : GeodistprojectedPoint, other : GeodistprojectedPoint, t : Double) -> GeodistprojectedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistprojectedPoint::to_string(self : GeodistprojectedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistprojectedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_projected_make_series(vals : Array[Double], name : String) -> GeodistprojectedSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistprojectedSeries::len(self : GeodistprojectedSeries) -> Int { self.vals.length() }

pub fn GeodistprojectedSeries::sum(self : GeodistprojectedSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistprojectedSeries::mean(self : GeodistprojectedSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistprojectedSeries::min(self : GeodistprojectedSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistprojectedSeries::max(self : GeodistprojectedSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistprojectedSeries::range(self : GeodistprojectedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistprojectedSeries::variance(self : GeodistprojectedSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistprojectedSeries::std(self : GeodistprojectedSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistprojectedSeries::median(self : GeodistprojectedSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistprojectedSeries::scale(self : GeodistprojectedSeries, f : Double) -> GeodistprojectedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistprojectedSeries::add(self : GeodistprojectedSeries, other : GeodistprojectedSeries) -> GeodistprojectedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistprojectedSeries::sub(self : GeodistprojectedSeries, other : GeodistprojectedSeries) -> GeodistprojectedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistprojectedSeries::normalize(self : GeodistprojectedSeries) -> GeodistprojectedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistprojectedSeries::cumsum(self : GeodistprojectedSeries) -> GeodistprojectedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistprojectedSeries::to_string(self : GeodistprojectedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistprojectedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_projected_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistprojectedMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_dist_projected_matrix_identity(n : Int) -> GeodistprojectedMatrix {
  let m = geo_dist_projected_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistprojectedMatrix::get(self : GeodistprojectedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistprojectedMatrix::transpose(self : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  let result = geo_dist_projected_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistprojectedMatrix::add(self : GeodistprojectedMatrix, other : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_projected_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistprojectedMatrix::scale(self : GeodistprojectedMatrix, s : Double) -> GeodistprojectedMatrix {
  let result = geo_dist_projected_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistprojectedMatrix::multiply(self : GeodistprojectedMatrix, other : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  if self.cols != other.rows { return geo_dist_projected_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_projected_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeodistprojectedMatrix::trace(self : GeodistprojectedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistprojectedMatrix::det(self : GeodistprojectedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistprojectedMatrix::norm(self : GeodistprojectedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistprojectedMatrix::to_string(self : GeodistprojectedMatrix) -> String {
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

pub(all) struct GeodistprojectedVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_projected_make_vector(comps : Array[Double]) -> GeodistprojectedVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_projected_vector_zero(dim : Int) -> GeodistprojectedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistprojectedVector::add(self : GeodistprojectedVector, other : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistprojectedVector::sub(self : GeodistprojectedVector, other : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistprojectedVector::scale(self : GeodistprojectedVector, s : Double) -> GeodistprojectedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistprojectedVector::dot(self : GeodistprojectedVector, other : GeodistprojectedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistprojectedVector::norm(self : GeodistprojectedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistprojectedVector::normalize(self : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistprojectedVector::dist(self : GeodistprojectedVector, other : GeodistprojectedVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistprojectedVector::to_string(self : GeodistprojectedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistprojectedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_frame_make(size : Int) -> GeodistprojectedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedFrame::len(self : GeodistprojectedFrame) -> Int { self.size }

pub fn GeodistprojectedFrame::get(self : GeodistprojectedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedFrame::set(self : GeodistprojectedFrame, i : Int, v : Double) -> GeodistprojectedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedFrame::sum(self : GeodistprojectedFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedFrame::mean(self : GeodistprojectedFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedFrame::scale(self : GeodistprojectedFrame, f : Double) -> GeodistprojectedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedFrame::add(self : GeodistprojectedFrame, other : GeodistprojectedFrame) -> GeodistprojectedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedFrame::copy(self : GeodistprojectedFrame) -> GeodistprojectedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedFrame::fill(self : GeodistprojectedFrame, v : Double) -> GeodistprojectedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedFrame::min(self : GeodistprojectedFrame) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedFrame::max(self : GeodistprojectedFrame) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedFrame::to_string(self : GeodistprojectedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_table_make(size : Int) -> GeodistprojectedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedTable::len(self : GeodistprojectedTable) -> Int { self.size }

pub fn GeodistprojectedTable::get(self : GeodistprojectedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedTable::set(self : GeodistprojectedTable, i : Int, v : Double) -> GeodistprojectedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedTable::sum(self : GeodistprojectedTable) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedTable::mean(self : GeodistprojectedTable) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedTable::scale(self : GeodistprojectedTable, f : Double) -> GeodistprojectedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedTable::add(self : GeodistprojectedTable, other : GeodistprojectedTable) -> GeodistprojectedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedTable::copy(self : GeodistprojectedTable) -> GeodistprojectedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedTable::fill(self : GeodistprojectedTable, v : Double) -> GeodistprojectedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedTable::min(self : GeodistprojectedTable) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedTable::max(self : GeodistprojectedTable) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedTable::to_string(self : GeodistprojectedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_graphn_make(size : Int) -> GeodistprojectedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedGraphN::len(self : GeodistprojectedGraphN) -> Int { self.size }

pub fn GeodistprojectedGraphN::get(self : GeodistprojectedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedGraphN::set(self : GeodistprojectedGraphN, i : Int, v : Double) -> GeodistprojectedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedGraphN::sum(self : GeodistprojectedGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedGraphN::mean(self : GeodistprojectedGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedGraphN::scale(self : GeodistprojectedGraphN, f : Double) -> GeodistprojectedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedGraphN::add(self : GeodistprojectedGraphN, other : GeodistprojectedGraphN) -> GeodistprojectedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedGraphN::copy(self : GeodistprojectedGraphN) -> GeodistprojectedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedGraphN::fill(self : GeodistprojectedGraphN, v : Double) -> GeodistprojectedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedGraphN::min(self : GeodistprojectedGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedGraphN::max(self : GeodistprojectedGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedGraphN::to_string(self : GeodistprojectedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_node_make(size : Int) -> GeodistprojectedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedNode::len(self : GeodistprojectedNode) -> Int { self.size }

pub fn GeodistprojectedNode::get(self : GeodistprojectedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedNode::set(self : GeodistprojectedNode, i : Int, v : Double) -> GeodistprojectedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedNode::sum(self : GeodistprojectedNode) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedNode::mean(self : GeodistprojectedNode) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedNode::scale(self : GeodistprojectedNode, f : Double) -> GeodistprojectedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedNode::add(self : GeodistprojectedNode, other : GeodistprojectedNode) -> GeodistprojectedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedNode::copy(self : GeodistprojectedNode) -> GeodistprojectedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedNode::fill(self : GeodistprojectedNode, v : Double) -> GeodistprojectedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedNode::min(self : GeodistprojectedNode) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedNode::max(self : GeodistprojectedNode) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedNode::to_string(self : GeodistprojectedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_edge_make(size : Int) -> GeodistprojectedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedEdge::len(self : GeodistprojectedEdge) -> Int { self.size }

pub fn GeodistprojectedEdge::get(self : GeodistprojectedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedEdge::set(self : GeodistprojectedEdge, i : Int, v : Double) -> GeodistprojectedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedEdge::sum(self : GeodistprojectedEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedEdge::mean(self : GeodistprojectedEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedEdge::scale(self : GeodistprojectedEdge, f : Double) -> GeodistprojectedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedEdge::add(self : GeodistprojectedEdge, other : GeodistprojectedEdge) -> GeodistprojectedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedEdge::copy(self : GeodistprojectedEdge) -> GeodistprojectedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedEdge::fill(self : GeodistprojectedEdge, v : Double) -> GeodistprojectedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedEdge::min(self : GeodistprojectedEdge) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedEdge::max(self : GeodistprojectedEdge) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedEdge::to_string(self : GeodistprojectedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_path_make(size : Int) -> GeodistprojectedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedPath::len(self : GeodistprojectedPath) -> Int { self.size }

pub fn GeodistprojectedPath::get(self : GeodistprojectedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedPath::set(self : GeodistprojectedPath, i : Int, v : Double) -> GeodistprojectedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedPath::sum(self : GeodistprojectedPath) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedPath::mean(self : GeodistprojectedPath) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedPath::scale(self : GeodistprojectedPath, f : Double) -> GeodistprojectedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedPath::add(self : GeodistprojectedPath, other : GeodistprojectedPath) -> GeodistprojectedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedPath::copy(self : GeodistprojectedPath) -> GeodistprojectedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedPath::fill(self : GeodistprojectedPath, v : Double) -> GeodistprojectedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedPath::min(self : GeodistprojectedPath) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedPath::max(self : GeodistprojectedPath) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedPath::to_string(self : GeodistprojectedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_cluster_make(size : Int) -> GeodistprojectedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedCluster::len(self : GeodistprojectedCluster) -> Int { self.size }

pub fn GeodistprojectedCluster::get(self : GeodistprojectedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedCluster::set(self : GeodistprojectedCluster, i : Int, v : Double) -> GeodistprojectedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCluster::sum(self : GeodistprojectedCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedCluster::mean(self : GeodistprojectedCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedCluster::scale(self : GeodistprojectedCluster, f : Double) -> GeodistprojectedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCluster::add(self : GeodistprojectedCluster, other : GeodistprojectedCluster) -> GeodistprojectedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedCluster::copy(self : GeodistprojectedCluster) -> GeodistprojectedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCluster::fill(self : GeodistprojectedCluster, v : Double) -> GeodistprojectedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCluster::min(self : GeodistprojectedCluster) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedCluster::max(self : GeodistprojectedCluster) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedCluster::to_string(self : GeodistprojectedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_model_make(size : Int) -> GeodistprojectedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedModel::len(self : GeodistprojectedModel) -> Int { self.size }

pub fn GeodistprojectedModel::get(self : GeodistprojectedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedModel::set(self : GeodistprojectedModel, i : Int, v : Double) -> GeodistprojectedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedModel::sum(self : GeodistprojectedModel) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedModel::mean(self : GeodistprojectedModel) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedModel::scale(self : GeodistprojectedModel, f : Double) -> GeodistprojectedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedModel::add(self : GeodistprojectedModel, other : GeodistprojectedModel) -> GeodistprojectedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedModel::copy(self : GeodistprojectedModel) -> GeodistprojectedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedModel::fill(self : GeodistprojectedModel, v : Double) -> GeodistprojectedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedModel::min(self : GeodistprojectedModel) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedModel::max(self : GeodistprojectedModel) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedModel::to_string(self : GeodistprojectedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_layer_make(size : Int) -> GeodistprojectedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedLayer::len(self : GeodistprojectedLayer) -> Int { self.size }

pub fn GeodistprojectedLayer::get(self : GeodistprojectedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedLayer::set(self : GeodistprojectedLayer, i : Int, v : Double) -> GeodistprojectedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedLayer::sum(self : GeodistprojectedLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedLayer::mean(self : GeodistprojectedLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedLayer::scale(self : GeodistprojectedLayer, f : Double) -> GeodistprojectedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedLayer::add(self : GeodistprojectedLayer, other : GeodistprojectedLayer) -> GeodistprojectedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedLayer::copy(self : GeodistprojectedLayer) -> GeodistprojectedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedLayer::fill(self : GeodistprojectedLayer, v : Double) -> GeodistprojectedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedLayer::min(self : GeodistprojectedLayer) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedLayer::max(self : GeodistprojectedLayer) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedLayer::to_string(self : GeodistprojectedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_buffer_make(size : Int) -> GeodistprojectedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedBuffer::len(self : GeodistprojectedBuffer) -> Int { self.size }

pub fn GeodistprojectedBuffer::get(self : GeodistprojectedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedBuffer::set(self : GeodistprojectedBuffer, i : Int, v : Double) -> GeodistprojectedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedBuffer::sum(self : GeodistprojectedBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedBuffer::mean(self : GeodistprojectedBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedBuffer::scale(self : GeodistprojectedBuffer, f : Double) -> GeodistprojectedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedBuffer::add(self : GeodistprojectedBuffer, other : GeodistprojectedBuffer) -> GeodistprojectedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedBuffer::copy(self : GeodistprojectedBuffer) -> GeodistprojectedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedBuffer::fill(self : GeodistprojectedBuffer, v : Double) -> GeodistprojectedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedBuffer::min(self : GeodistprojectedBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedBuffer::max(self : GeodistprojectedBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedBuffer::to_string(self : GeodistprojectedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_cursor_make(size : Int) -> GeodistprojectedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedCursor::len(self : GeodistprojectedCursor) -> Int { self.size }

pub fn GeodistprojectedCursor::get(self : GeodistprojectedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedCursor::set(self : GeodistprojectedCursor, i : Int, v : Double) -> GeodistprojectedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCursor::sum(self : GeodistprojectedCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedCursor::mean(self : GeodistprojectedCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedCursor::scale(self : GeodistprojectedCursor, f : Double) -> GeodistprojectedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCursor::add(self : GeodistprojectedCursor, other : GeodistprojectedCursor) -> GeodistprojectedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedCursor::copy(self : GeodistprojectedCursor) -> GeodistprojectedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCursor::fill(self : GeodistprojectedCursor, v : Double) -> GeodistprojectedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedCursor::min(self : GeodistprojectedCursor) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedCursor::max(self : GeodistprojectedCursor) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedCursor::to_string(self : GeodistprojectedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_view_make(size : Int) -> GeodistprojectedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedView::len(self : GeodistprojectedView) -> Int { self.size }

pub fn GeodistprojectedView::get(self : GeodistprojectedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedView::set(self : GeodistprojectedView, i : Int, v : Double) -> GeodistprojectedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedView::sum(self : GeodistprojectedView) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedView::mean(self : GeodistprojectedView) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedView::scale(self : GeodistprojectedView, f : Double) -> GeodistprojectedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedView::add(self : GeodistprojectedView, other : GeodistprojectedView) -> GeodistprojectedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedView::copy(self : GeodistprojectedView) -> GeodistprojectedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedView::fill(self : GeodistprojectedView, v : Double) -> GeodistprojectedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedView::min(self : GeodistprojectedView) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedView::max(self : GeodistprojectedView) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedView::to_string(self : GeodistprojectedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_range_make(size : Int) -> GeodistprojectedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedRange::len(self : GeodistprojectedRange) -> Int { self.size }

pub fn GeodistprojectedRange::get(self : GeodistprojectedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedRange::set(self : GeodistprojectedRange, i : Int, v : Double) -> GeodistprojectedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedRange::sum(self : GeodistprojectedRange) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedRange::mean(self : GeodistprojectedRange) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedRange::scale(self : GeodistprojectedRange, f : Double) -> GeodistprojectedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedRange::add(self : GeodistprojectedRange, other : GeodistprojectedRange) -> GeodistprojectedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedRange::copy(self : GeodistprojectedRange) -> GeodistprojectedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedRange::fill(self : GeodistprojectedRange, v : Double) -> GeodistprojectedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedRange::min(self : GeodistprojectedRange) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedRange::max(self : GeodistprojectedRange) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedRange::to_string(self : GeodistprojectedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_slice_make(size : Int) -> GeodistprojectedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistprojectedSlice::len(self : GeodistprojectedSlice) -> Int { self.size }

pub fn GeodistprojectedSlice::get(self : GeodistprojectedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistprojectedSlice::set(self : GeodistprojectedSlice, i : Int, v : Double) -> GeodistprojectedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistprojectedSlice::sum(self : GeodistprojectedSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistprojectedSlice::mean(self : GeodistprojectedSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistprojectedSlice::scale(self : GeodistprojectedSlice, f : Double) -> GeodistprojectedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedSlice::add(self : GeodistprojectedSlice, other : GeodistprojectedSlice) -> GeodistprojectedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistprojectedSlice::copy(self : GeodistprojectedSlice) -> GeodistprojectedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedSlice::fill(self : GeodistprojectedSlice, v : Double) -> GeodistprojectedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistprojectedSlice::min(self : GeodistprojectedSlice) -> Double { @_common.min(self.data) }

pub fn GeodistprojectedSlice::max(self : GeodistprojectedSlice) -> Double { @_common.max(self.data) }

pub fn GeodistprojectedSlice::to_string(self : GeodistprojectedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

