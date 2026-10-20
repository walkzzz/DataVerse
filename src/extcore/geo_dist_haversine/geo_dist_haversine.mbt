///===
/// extcore/geo_dist_haversine

pub(all) struct GeodisthaversinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_haversine_make_point(x : Double, y : Double) -> GeodisthaversinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_haversine_make_point3(x : Double, y : Double, z : Double) -> GeodisthaversinePoint {
  { x, y, z, label: 0 }
}

pub fn GeodisthaversinePoint::x(self : GeodisthaversinePoint) -> Double { self.x }

pub fn GeodisthaversinePoint::y(self : GeodisthaversinePoint) -> Double { self.y }

pub fn GeodisthaversinePoint::z(self : GeodisthaversinePoint) -> Double { self.z }

pub fn GeodisthaversinePoint::label(self : GeodisthaversinePoint) -> Int { self.label }

pub fn GeodisthaversinePoint::dist(self : GeodisthaversinePoint, other : GeodisthaversinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodisthaversinePoint::add(self : GeodisthaversinePoint, other : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodisthaversinePoint::sub(self : GeodisthaversinePoint, other : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodisthaversinePoint::scale(self : GeodisthaversinePoint, s : Double) -> GeodisthaversinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodisthaversinePoint::dot(self : GeodisthaversinePoint, other : GeodisthaversinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodisthaversinePoint::cross(self : GeodisthaversinePoint, other : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodisthaversinePoint::norm(self : GeodisthaversinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodisthaversinePoint::normalize(self : GeodisthaversinePoint) -> GeodisthaversinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodisthaversinePoint::negate(self : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodisthaversinePoint::mid(self : GeodisthaversinePoint, other : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodisthaversinePoint::lerp(self : GeodisthaversinePoint, other : GeodisthaversinePoint, t : Double) -> GeodisthaversinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodisthaversinePoint::to_string(self : GeodisthaversinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodisthaversineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_haversine_make_series(vals : Array[Double], name : String) -> GeodisthaversineSeries {
  { vals, name, meta: 0 }
}

pub fn GeodisthaversineSeries::len(self : GeodisthaversineSeries) -> Int { self.vals.length() }

pub fn GeodisthaversineSeries::sum(self : GeodisthaversineSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodisthaversineSeries::mean(self : GeodisthaversineSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodisthaversineSeries::min(self : GeodisthaversineSeries) -> Double { @_common.min(self.vals) }

pub fn GeodisthaversineSeries::max(self : GeodisthaversineSeries) -> Double { @_common.max(self.vals) }

pub fn GeodisthaversineSeries::range(self : GeodisthaversineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodisthaversineSeries::variance(self : GeodisthaversineSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodisthaversineSeries::std(self : GeodisthaversineSeries) -> Double { @_common.std(self.vals) }

pub fn GeodisthaversineSeries::median(self : GeodisthaversineSeries) -> Double { @_common.median(self.vals) }

pub fn GeodisthaversineSeries::scale(self : GeodisthaversineSeries, f : Double) -> GeodisthaversineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodisthaversineSeries::add(self : GeodisthaversineSeries, other : GeodisthaversineSeries) -> GeodisthaversineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodisthaversineSeries::sub(self : GeodisthaversineSeries, other : GeodisthaversineSeries) -> GeodisthaversineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodisthaversineSeries::normalize(self : GeodisthaversineSeries) -> GeodisthaversineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodisthaversineSeries::cumsum(self : GeodisthaversineSeries) -> GeodisthaversineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodisthaversineSeries::to_string(self : GeodisthaversineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodisthaversineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_haversine_make_matrix(rows : Int, cols : Int, val : Double) -> GeodisthaversineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_haversine_matrix_identity(n : Int) -> GeodisthaversineMatrix {
  let m = geo_dist_haversine_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodisthaversineMatrix::get(self : GeodisthaversineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodisthaversineMatrix::transpose(self : GeodisthaversineMatrix) -> GeodisthaversineMatrix {
  let result = geo_dist_haversine_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodisthaversineMatrix::add(self : GeodisthaversineMatrix, other : GeodisthaversineMatrix) -> GeodisthaversineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_haversine_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodisthaversineMatrix::scale(self : GeodisthaversineMatrix, s : Double) -> GeodisthaversineMatrix {
  let result = geo_dist_haversine_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodisthaversineMatrix::multiply(self : GeodisthaversineMatrix, other : GeodisthaversineMatrix) -> GeodisthaversineMatrix {
  if self.cols != other.rows { return geo_dist_haversine_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_haversine_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodisthaversineMatrix::trace(self : GeodisthaversineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodisthaversineMatrix::det(self : GeodisthaversineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodisthaversineMatrix::norm(self : GeodisthaversineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodisthaversineMatrix::to_string(self : GeodisthaversineMatrix) -> String {
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

pub(all) struct GeodisthaversineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_haversine_make_vector(comps : Array[Double]) -> GeodisthaversineVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_haversine_vector_zero(dim : Int) -> GeodisthaversineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodisthaversineVector::add(self : GeodisthaversineVector, other : GeodisthaversineVector) -> GeodisthaversineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodisthaversineVector::sub(self : GeodisthaversineVector, other : GeodisthaversineVector) -> GeodisthaversineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodisthaversineVector::scale(self : GeodisthaversineVector, s : Double) -> GeodisthaversineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodisthaversineVector::dot(self : GeodisthaversineVector, other : GeodisthaversineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodisthaversineVector::norm(self : GeodisthaversineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodisthaversineVector::normalize(self : GeodisthaversineVector) -> GeodisthaversineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodisthaversineVector::dist(self : GeodisthaversineVector, other : GeodisthaversineVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodisthaversineVector::to_string(self : GeodisthaversineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodisthaversineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_frame_make(size : Int) -> GeodisthaversineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineFrame::len(self : GeodisthaversineFrame) -> Int { self.size }

pub fn GeodisthaversineFrame::get(self : GeodisthaversineFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineFrame::set(self : GeodisthaversineFrame, i : Int, v : Double) -> GeodisthaversineFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineFrame::sum(self : GeodisthaversineFrame) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineFrame::mean(self : GeodisthaversineFrame) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineFrame::scale(self : GeodisthaversineFrame, f : Double) -> GeodisthaversineFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineFrame::add(self : GeodisthaversineFrame, other : GeodisthaversineFrame) -> GeodisthaversineFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineFrame::copy(self : GeodisthaversineFrame) -> GeodisthaversineFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineFrame::fill(self : GeodisthaversineFrame, v : Double) -> GeodisthaversineFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineFrame::min(self : GeodisthaversineFrame) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineFrame::max(self : GeodisthaversineFrame) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineFrame::to_string(self : GeodisthaversineFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_table_make(size : Int) -> GeodisthaversineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineTable::len(self : GeodisthaversineTable) -> Int { self.size }

pub fn GeodisthaversineTable::get(self : GeodisthaversineTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineTable::set(self : GeodisthaversineTable, i : Int, v : Double) -> GeodisthaversineTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineTable::sum(self : GeodisthaversineTable) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineTable::mean(self : GeodisthaversineTable) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineTable::scale(self : GeodisthaversineTable, f : Double) -> GeodisthaversineTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineTable::add(self : GeodisthaversineTable, other : GeodisthaversineTable) -> GeodisthaversineTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineTable::copy(self : GeodisthaversineTable) -> GeodisthaversineTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineTable::fill(self : GeodisthaversineTable, v : Double) -> GeodisthaversineTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineTable::min(self : GeodisthaversineTable) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineTable::max(self : GeodisthaversineTable) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineTable::to_string(self : GeodisthaversineTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_graphn_make(size : Int) -> GeodisthaversineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineGraphN::len(self : GeodisthaversineGraphN) -> Int { self.size }

pub fn GeodisthaversineGraphN::get(self : GeodisthaversineGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineGraphN::set(self : GeodisthaversineGraphN, i : Int, v : Double) -> GeodisthaversineGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineGraphN::sum(self : GeodisthaversineGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineGraphN::mean(self : GeodisthaversineGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineGraphN::scale(self : GeodisthaversineGraphN, f : Double) -> GeodisthaversineGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineGraphN::add(self : GeodisthaversineGraphN, other : GeodisthaversineGraphN) -> GeodisthaversineGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineGraphN::copy(self : GeodisthaversineGraphN) -> GeodisthaversineGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineGraphN::fill(self : GeodisthaversineGraphN, v : Double) -> GeodisthaversineGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineGraphN::min(self : GeodisthaversineGraphN) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineGraphN::max(self : GeodisthaversineGraphN) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineGraphN::to_string(self : GeodisthaversineGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_node_make(size : Int) -> GeodisthaversineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineNode::len(self : GeodisthaversineNode) -> Int { self.size }

pub fn GeodisthaversineNode::get(self : GeodisthaversineNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineNode::set(self : GeodisthaversineNode, i : Int, v : Double) -> GeodisthaversineNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineNode::sum(self : GeodisthaversineNode) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineNode::mean(self : GeodisthaversineNode) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineNode::scale(self : GeodisthaversineNode, f : Double) -> GeodisthaversineNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineNode::add(self : GeodisthaversineNode, other : GeodisthaversineNode) -> GeodisthaversineNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineNode::copy(self : GeodisthaversineNode) -> GeodisthaversineNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineNode::fill(self : GeodisthaversineNode, v : Double) -> GeodisthaversineNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineNode::min(self : GeodisthaversineNode) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineNode::max(self : GeodisthaversineNode) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineNode::to_string(self : GeodisthaversineNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_edge_make(size : Int) -> GeodisthaversineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineEdge::len(self : GeodisthaversineEdge) -> Int { self.size }

pub fn GeodisthaversineEdge::get(self : GeodisthaversineEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineEdge::set(self : GeodisthaversineEdge, i : Int, v : Double) -> GeodisthaversineEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineEdge::sum(self : GeodisthaversineEdge) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineEdge::mean(self : GeodisthaversineEdge) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineEdge::scale(self : GeodisthaversineEdge, f : Double) -> GeodisthaversineEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineEdge::add(self : GeodisthaversineEdge, other : GeodisthaversineEdge) -> GeodisthaversineEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineEdge::copy(self : GeodisthaversineEdge) -> GeodisthaversineEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineEdge::fill(self : GeodisthaversineEdge, v : Double) -> GeodisthaversineEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineEdge::min(self : GeodisthaversineEdge) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineEdge::max(self : GeodisthaversineEdge) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineEdge::to_string(self : GeodisthaversineEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_path_make(size : Int) -> GeodisthaversinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversinePath::len(self : GeodisthaversinePath) -> Int { self.size }

pub fn GeodisthaversinePath::get(self : GeodisthaversinePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversinePath::set(self : GeodisthaversinePath, i : Int, v : Double) -> GeodisthaversinePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversinePath::sum(self : GeodisthaversinePath) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversinePath::mean(self : GeodisthaversinePath) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversinePath::scale(self : GeodisthaversinePath, f : Double) -> GeodisthaversinePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversinePath::add(self : GeodisthaversinePath, other : GeodisthaversinePath) -> GeodisthaversinePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversinePath::copy(self : GeodisthaversinePath) -> GeodisthaversinePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversinePath::fill(self : GeodisthaversinePath, v : Double) -> GeodisthaversinePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversinePath::min(self : GeodisthaversinePath) -> Double { @_common.min(self.data) }

pub fn GeodisthaversinePath::max(self : GeodisthaversinePath) -> Double { @_common.max(self.data) }

pub fn GeodisthaversinePath::to_string(self : GeodisthaversinePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_cluster_make(size : Int) -> GeodisthaversineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineCluster::len(self : GeodisthaversineCluster) -> Int { self.size }

pub fn GeodisthaversineCluster::get(self : GeodisthaversineCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineCluster::set(self : GeodisthaversineCluster, i : Int, v : Double) -> GeodisthaversineCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCluster::sum(self : GeodisthaversineCluster) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineCluster::mean(self : GeodisthaversineCluster) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineCluster::scale(self : GeodisthaversineCluster, f : Double) -> GeodisthaversineCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCluster::add(self : GeodisthaversineCluster, other : GeodisthaversineCluster) -> GeodisthaversineCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineCluster::copy(self : GeodisthaversineCluster) -> GeodisthaversineCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCluster::fill(self : GeodisthaversineCluster, v : Double) -> GeodisthaversineCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCluster::min(self : GeodisthaversineCluster) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineCluster::max(self : GeodisthaversineCluster) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineCluster::to_string(self : GeodisthaversineCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_model_make(size : Int) -> GeodisthaversineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineModel::len(self : GeodisthaversineModel) -> Int { self.size }

pub fn GeodisthaversineModel::get(self : GeodisthaversineModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineModel::set(self : GeodisthaversineModel, i : Int, v : Double) -> GeodisthaversineModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineModel::sum(self : GeodisthaversineModel) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineModel::mean(self : GeodisthaversineModel) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineModel::scale(self : GeodisthaversineModel, f : Double) -> GeodisthaversineModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineModel::add(self : GeodisthaversineModel, other : GeodisthaversineModel) -> GeodisthaversineModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineModel::copy(self : GeodisthaversineModel) -> GeodisthaversineModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineModel::fill(self : GeodisthaversineModel, v : Double) -> GeodisthaversineModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineModel::min(self : GeodisthaversineModel) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineModel::max(self : GeodisthaversineModel) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineModel::to_string(self : GeodisthaversineModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_layer_make(size : Int) -> GeodisthaversineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineLayer::len(self : GeodisthaversineLayer) -> Int { self.size }

pub fn GeodisthaversineLayer::get(self : GeodisthaversineLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineLayer::set(self : GeodisthaversineLayer, i : Int, v : Double) -> GeodisthaversineLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineLayer::sum(self : GeodisthaversineLayer) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineLayer::mean(self : GeodisthaversineLayer) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineLayer::scale(self : GeodisthaversineLayer, f : Double) -> GeodisthaversineLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineLayer::add(self : GeodisthaversineLayer, other : GeodisthaversineLayer) -> GeodisthaversineLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineLayer::copy(self : GeodisthaversineLayer) -> GeodisthaversineLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineLayer::fill(self : GeodisthaversineLayer, v : Double) -> GeodisthaversineLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineLayer::min(self : GeodisthaversineLayer) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineLayer::max(self : GeodisthaversineLayer) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineLayer::to_string(self : GeodisthaversineLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_buffer_make(size : Int) -> GeodisthaversineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineBuffer::len(self : GeodisthaversineBuffer) -> Int { self.size }

pub fn GeodisthaversineBuffer::get(self : GeodisthaversineBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineBuffer::set(self : GeodisthaversineBuffer, i : Int, v : Double) -> GeodisthaversineBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineBuffer::sum(self : GeodisthaversineBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineBuffer::mean(self : GeodisthaversineBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineBuffer::scale(self : GeodisthaversineBuffer, f : Double) -> GeodisthaversineBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineBuffer::add(self : GeodisthaversineBuffer, other : GeodisthaversineBuffer) -> GeodisthaversineBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineBuffer::copy(self : GeodisthaversineBuffer) -> GeodisthaversineBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineBuffer::fill(self : GeodisthaversineBuffer, v : Double) -> GeodisthaversineBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineBuffer::min(self : GeodisthaversineBuffer) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineBuffer::max(self : GeodisthaversineBuffer) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineBuffer::to_string(self : GeodisthaversineBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_cursor_make(size : Int) -> GeodisthaversineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineCursor::len(self : GeodisthaversineCursor) -> Int { self.size }

pub fn GeodisthaversineCursor::get(self : GeodisthaversineCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineCursor::set(self : GeodisthaversineCursor, i : Int, v : Double) -> GeodisthaversineCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCursor::sum(self : GeodisthaversineCursor) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineCursor::mean(self : GeodisthaversineCursor) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineCursor::scale(self : GeodisthaversineCursor, f : Double) -> GeodisthaversineCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCursor::add(self : GeodisthaversineCursor, other : GeodisthaversineCursor) -> GeodisthaversineCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineCursor::copy(self : GeodisthaversineCursor) -> GeodisthaversineCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCursor::fill(self : GeodisthaversineCursor, v : Double) -> GeodisthaversineCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineCursor::min(self : GeodisthaversineCursor) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineCursor::max(self : GeodisthaversineCursor) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineCursor::to_string(self : GeodisthaversineCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_view_make(size : Int) -> GeodisthaversineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineView::len(self : GeodisthaversineView) -> Int { self.size }

pub fn GeodisthaversineView::get(self : GeodisthaversineView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineView::set(self : GeodisthaversineView, i : Int, v : Double) -> GeodisthaversineView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineView::sum(self : GeodisthaversineView) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineView::mean(self : GeodisthaversineView) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineView::scale(self : GeodisthaversineView, f : Double) -> GeodisthaversineView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineView::add(self : GeodisthaversineView, other : GeodisthaversineView) -> GeodisthaversineView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineView::copy(self : GeodisthaversineView) -> GeodisthaversineView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineView::fill(self : GeodisthaversineView, v : Double) -> GeodisthaversineView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineView::min(self : GeodisthaversineView) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineView::max(self : GeodisthaversineView) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineView::to_string(self : GeodisthaversineView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_range_make(size : Int) -> GeodisthaversineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineRange::len(self : GeodisthaversineRange) -> Int { self.size }

pub fn GeodisthaversineRange::get(self : GeodisthaversineRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineRange::set(self : GeodisthaversineRange, i : Int, v : Double) -> GeodisthaversineRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineRange::sum(self : GeodisthaversineRange) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineRange::mean(self : GeodisthaversineRange) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineRange::scale(self : GeodisthaversineRange, f : Double) -> GeodisthaversineRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineRange::add(self : GeodisthaversineRange, other : GeodisthaversineRange) -> GeodisthaversineRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineRange::copy(self : GeodisthaversineRange) -> GeodisthaversineRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineRange::fill(self : GeodisthaversineRange, v : Double) -> GeodisthaversineRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineRange::min(self : GeodisthaversineRange) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineRange::max(self : GeodisthaversineRange) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineRange::to_string(self : GeodisthaversineRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_slice_make(size : Int) -> GeodisthaversineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisthaversineSlice::len(self : GeodisthaversineSlice) -> Int { self.size }

pub fn GeodisthaversineSlice::get(self : GeodisthaversineSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisthaversineSlice::set(self : GeodisthaversineSlice, i : Int, v : Double) -> GeodisthaversineSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisthaversineSlice::sum(self : GeodisthaversineSlice) -> Double { @_common.sum(self.data) }

pub fn GeodisthaversineSlice::mean(self : GeodisthaversineSlice) -> Double { @_common.mean(self.data) }

pub fn GeodisthaversineSlice::scale(self : GeodisthaversineSlice, f : Double) -> GeodisthaversineSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineSlice::add(self : GeodisthaversineSlice, other : GeodisthaversineSlice) -> GeodisthaversineSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisthaversineSlice::copy(self : GeodisthaversineSlice) -> GeodisthaversineSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineSlice::fill(self : GeodisthaversineSlice, v : Double) -> GeodisthaversineSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisthaversineSlice::min(self : GeodisthaversineSlice) -> Double { @_common.min(self.data) }

pub fn GeodisthaversineSlice::max(self : GeodisthaversineSlice) -> Double { @_common.max(self.data) }

pub fn GeodisthaversineSlice::to_string(self : GeodisthaversineSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

