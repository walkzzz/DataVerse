///===
/// extcore/geo_dist_ellipsoidal

pub(all) struct GeodistellipsoidalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_ellipsoidal_make_point(x : Double, y : Double) -> GeodistellipsoidalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_ellipsoidal_make_point3(x : Double, y : Double, z : Double) -> GeodistellipsoidalPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistellipsoidalPoint::x(self : GeodistellipsoidalPoint) -> Double { self.x }

pub fn GeodistellipsoidalPoint::y(self : GeodistellipsoidalPoint) -> Double { self.y }

pub fn GeodistellipsoidalPoint::z(self : GeodistellipsoidalPoint) -> Double { self.z }

pub fn GeodistellipsoidalPoint::label(self : GeodistellipsoidalPoint) -> Int { self.label }

pub fn GeodistellipsoidalPoint::dist(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistellipsoidalPoint::add(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistellipsoidalPoint::sub(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistellipsoidalPoint::scale(self : GeodistellipsoidalPoint, s : Double) -> GeodistellipsoidalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistellipsoidalPoint::dot(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistellipsoidalPoint::cross(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistellipsoidalPoint::norm(self : GeodistellipsoidalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistellipsoidalPoint::normalize(self : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistellipsoidalPoint::negate(self : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistellipsoidalPoint::mid(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistellipsoidalPoint::lerp(self : GeodistellipsoidalPoint, other : GeodistellipsoidalPoint, t : Double) -> GeodistellipsoidalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistellipsoidalPoint::to_string(self : GeodistellipsoidalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistellipsoidalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_ellipsoidal_make_series(vals : Array[Double], name : String) -> GeodistellipsoidalSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistellipsoidalSeries::len(self : GeodistellipsoidalSeries) -> Int { self.vals.length() }

pub fn GeodistellipsoidalSeries::sum(self : GeodistellipsoidalSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistellipsoidalSeries::mean(self : GeodistellipsoidalSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistellipsoidalSeries::min(self : GeodistellipsoidalSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistellipsoidalSeries::max(self : GeodistellipsoidalSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistellipsoidalSeries::range(self : GeodistellipsoidalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistellipsoidalSeries::variance(self : GeodistellipsoidalSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistellipsoidalSeries::std(self : GeodistellipsoidalSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistellipsoidalSeries::median(self : GeodistellipsoidalSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistellipsoidalSeries::scale(self : GeodistellipsoidalSeries, f : Double) -> GeodistellipsoidalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistellipsoidalSeries::add(self : GeodistellipsoidalSeries, other : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistellipsoidalSeries::sub(self : GeodistellipsoidalSeries, other : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistellipsoidalSeries::normalize(self : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistellipsoidalSeries::cumsum(self : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistellipsoidalSeries::to_string(self : GeodistellipsoidalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistellipsoidalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_ellipsoidal_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistellipsoidalMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_dist_ellipsoidal_matrix_identity(n : Int) -> GeodistellipsoidalMatrix {
  let m = geo_dist_ellipsoidal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistellipsoidalMatrix::get(self : GeodistellipsoidalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistellipsoidalMatrix::transpose(self : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  let result = geo_dist_ellipsoidal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistellipsoidalMatrix::add(self : GeodistellipsoidalMatrix, other : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_ellipsoidal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistellipsoidalMatrix::scale(self : GeodistellipsoidalMatrix, s : Double) -> GeodistellipsoidalMatrix {
  let result = geo_dist_ellipsoidal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistellipsoidalMatrix::multiply(self : GeodistellipsoidalMatrix, other : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  if self.cols != other.rows { return geo_dist_ellipsoidal_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_ellipsoidal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeodistellipsoidalMatrix::trace(self : GeodistellipsoidalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistellipsoidalMatrix::det(self : GeodistellipsoidalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistellipsoidalMatrix::norm(self : GeodistellipsoidalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistellipsoidalMatrix::to_string(self : GeodistellipsoidalMatrix) -> String {
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

pub(all) struct GeodistellipsoidalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_ellipsoidal_make_vector(comps : Array[Double]) -> GeodistellipsoidalVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_ellipsoidal_vector_zero(dim : Int) -> GeodistellipsoidalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistellipsoidalVector::add(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistellipsoidalVector::sub(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistellipsoidalVector::scale(self : GeodistellipsoidalVector, s : Double) -> GeodistellipsoidalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistellipsoidalVector::dot(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistellipsoidalVector::norm(self : GeodistellipsoidalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistellipsoidalVector::normalize(self : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistellipsoidalVector::dist(self : GeodistellipsoidalVector, other : GeodistellipsoidalVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistellipsoidalVector::to_string(self : GeodistellipsoidalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistellipsoidalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_frame_make(size : Int) -> GeodistellipsoidalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalFrame::len(self : GeodistellipsoidalFrame) -> Int { self.size }

pub fn GeodistellipsoidalFrame::get(self : GeodistellipsoidalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalFrame::set(self : GeodistellipsoidalFrame, i : Int, v : Double) -> GeodistellipsoidalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalFrame::sum(self : GeodistellipsoidalFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalFrame::mean(self : GeodistellipsoidalFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalFrame::scale(self : GeodistellipsoidalFrame, f : Double) -> GeodistellipsoidalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalFrame::add(self : GeodistellipsoidalFrame, other : GeodistellipsoidalFrame) -> GeodistellipsoidalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalFrame::copy(self : GeodistellipsoidalFrame) -> GeodistellipsoidalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalFrame::fill(self : GeodistellipsoidalFrame, v : Double) -> GeodistellipsoidalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalFrame::min(self : GeodistellipsoidalFrame) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalFrame::max(self : GeodistellipsoidalFrame) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalFrame::to_string(self : GeodistellipsoidalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_table_make(size : Int) -> GeodistellipsoidalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalTable::len(self : GeodistellipsoidalTable) -> Int { self.size }

pub fn GeodistellipsoidalTable::get(self : GeodistellipsoidalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalTable::set(self : GeodistellipsoidalTable, i : Int, v : Double) -> GeodistellipsoidalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalTable::sum(self : GeodistellipsoidalTable) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalTable::mean(self : GeodistellipsoidalTable) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalTable::scale(self : GeodistellipsoidalTable, f : Double) -> GeodistellipsoidalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalTable::add(self : GeodistellipsoidalTable, other : GeodistellipsoidalTable) -> GeodistellipsoidalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalTable::copy(self : GeodistellipsoidalTable) -> GeodistellipsoidalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalTable::fill(self : GeodistellipsoidalTable, v : Double) -> GeodistellipsoidalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalTable::min(self : GeodistellipsoidalTable) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalTable::max(self : GeodistellipsoidalTable) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalTable::to_string(self : GeodistellipsoidalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_graphn_make(size : Int) -> GeodistellipsoidalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalGraphN::len(self : GeodistellipsoidalGraphN) -> Int { self.size }

pub fn GeodistellipsoidalGraphN::get(self : GeodistellipsoidalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalGraphN::set(self : GeodistellipsoidalGraphN, i : Int, v : Double) -> GeodistellipsoidalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalGraphN::sum(self : GeodistellipsoidalGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalGraphN::mean(self : GeodistellipsoidalGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalGraphN::scale(self : GeodistellipsoidalGraphN, f : Double) -> GeodistellipsoidalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalGraphN::add(self : GeodistellipsoidalGraphN, other : GeodistellipsoidalGraphN) -> GeodistellipsoidalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalGraphN::copy(self : GeodistellipsoidalGraphN) -> GeodistellipsoidalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalGraphN::fill(self : GeodistellipsoidalGraphN, v : Double) -> GeodistellipsoidalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalGraphN::min(self : GeodistellipsoidalGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalGraphN::max(self : GeodistellipsoidalGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalGraphN::to_string(self : GeodistellipsoidalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_node_make(size : Int) -> GeodistellipsoidalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalNode::len(self : GeodistellipsoidalNode) -> Int { self.size }

pub fn GeodistellipsoidalNode::get(self : GeodistellipsoidalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalNode::set(self : GeodistellipsoidalNode, i : Int, v : Double) -> GeodistellipsoidalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalNode::sum(self : GeodistellipsoidalNode) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalNode::mean(self : GeodistellipsoidalNode) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalNode::scale(self : GeodistellipsoidalNode, f : Double) -> GeodistellipsoidalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalNode::add(self : GeodistellipsoidalNode, other : GeodistellipsoidalNode) -> GeodistellipsoidalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalNode::copy(self : GeodistellipsoidalNode) -> GeodistellipsoidalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalNode::fill(self : GeodistellipsoidalNode, v : Double) -> GeodistellipsoidalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalNode::min(self : GeodistellipsoidalNode) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalNode::max(self : GeodistellipsoidalNode) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalNode::to_string(self : GeodistellipsoidalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_edge_make(size : Int) -> GeodistellipsoidalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalEdge::len(self : GeodistellipsoidalEdge) -> Int { self.size }

pub fn GeodistellipsoidalEdge::get(self : GeodistellipsoidalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalEdge::set(self : GeodistellipsoidalEdge, i : Int, v : Double) -> GeodistellipsoidalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalEdge::sum(self : GeodistellipsoidalEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalEdge::mean(self : GeodistellipsoidalEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalEdge::scale(self : GeodistellipsoidalEdge, f : Double) -> GeodistellipsoidalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalEdge::add(self : GeodistellipsoidalEdge, other : GeodistellipsoidalEdge) -> GeodistellipsoidalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalEdge::copy(self : GeodistellipsoidalEdge) -> GeodistellipsoidalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalEdge::fill(self : GeodistellipsoidalEdge, v : Double) -> GeodistellipsoidalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalEdge::min(self : GeodistellipsoidalEdge) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalEdge::max(self : GeodistellipsoidalEdge) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalEdge::to_string(self : GeodistellipsoidalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_path_make(size : Int) -> GeodistellipsoidalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalPath::len(self : GeodistellipsoidalPath) -> Int { self.size }

pub fn GeodistellipsoidalPath::get(self : GeodistellipsoidalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalPath::set(self : GeodistellipsoidalPath, i : Int, v : Double) -> GeodistellipsoidalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalPath::sum(self : GeodistellipsoidalPath) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalPath::mean(self : GeodistellipsoidalPath) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalPath::scale(self : GeodistellipsoidalPath, f : Double) -> GeodistellipsoidalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalPath::add(self : GeodistellipsoidalPath, other : GeodistellipsoidalPath) -> GeodistellipsoidalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalPath::copy(self : GeodistellipsoidalPath) -> GeodistellipsoidalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalPath::fill(self : GeodistellipsoidalPath, v : Double) -> GeodistellipsoidalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalPath::min(self : GeodistellipsoidalPath) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalPath::max(self : GeodistellipsoidalPath) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalPath::to_string(self : GeodistellipsoidalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_cluster_make(size : Int) -> GeodistellipsoidalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalCluster::len(self : GeodistellipsoidalCluster) -> Int { self.size }

pub fn GeodistellipsoidalCluster::get(self : GeodistellipsoidalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalCluster::set(self : GeodistellipsoidalCluster, i : Int, v : Double) -> GeodistellipsoidalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCluster::sum(self : GeodistellipsoidalCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalCluster::mean(self : GeodistellipsoidalCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalCluster::scale(self : GeodistellipsoidalCluster, f : Double) -> GeodistellipsoidalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCluster::add(self : GeodistellipsoidalCluster, other : GeodistellipsoidalCluster) -> GeodistellipsoidalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalCluster::copy(self : GeodistellipsoidalCluster) -> GeodistellipsoidalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCluster::fill(self : GeodistellipsoidalCluster, v : Double) -> GeodistellipsoidalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCluster::min(self : GeodistellipsoidalCluster) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalCluster::max(self : GeodistellipsoidalCluster) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalCluster::to_string(self : GeodistellipsoidalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_model_make(size : Int) -> GeodistellipsoidalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalModel::len(self : GeodistellipsoidalModel) -> Int { self.size }

pub fn GeodistellipsoidalModel::get(self : GeodistellipsoidalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalModel::set(self : GeodistellipsoidalModel, i : Int, v : Double) -> GeodistellipsoidalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalModel::sum(self : GeodistellipsoidalModel) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalModel::mean(self : GeodistellipsoidalModel) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalModel::scale(self : GeodistellipsoidalModel, f : Double) -> GeodistellipsoidalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalModel::add(self : GeodistellipsoidalModel, other : GeodistellipsoidalModel) -> GeodistellipsoidalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalModel::copy(self : GeodistellipsoidalModel) -> GeodistellipsoidalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalModel::fill(self : GeodistellipsoidalModel, v : Double) -> GeodistellipsoidalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalModel::min(self : GeodistellipsoidalModel) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalModel::max(self : GeodistellipsoidalModel) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalModel::to_string(self : GeodistellipsoidalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_layer_make(size : Int) -> GeodistellipsoidalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalLayer::len(self : GeodistellipsoidalLayer) -> Int { self.size }

pub fn GeodistellipsoidalLayer::get(self : GeodistellipsoidalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalLayer::set(self : GeodistellipsoidalLayer, i : Int, v : Double) -> GeodistellipsoidalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalLayer::sum(self : GeodistellipsoidalLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalLayer::mean(self : GeodistellipsoidalLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalLayer::scale(self : GeodistellipsoidalLayer, f : Double) -> GeodistellipsoidalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalLayer::add(self : GeodistellipsoidalLayer, other : GeodistellipsoidalLayer) -> GeodistellipsoidalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalLayer::copy(self : GeodistellipsoidalLayer) -> GeodistellipsoidalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalLayer::fill(self : GeodistellipsoidalLayer, v : Double) -> GeodistellipsoidalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalLayer::min(self : GeodistellipsoidalLayer) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalLayer::max(self : GeodistellipsoidalLayer) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalLayer::to_string(self : GeodistellipsoidalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_buffer_make(size : Int) -> GeodistellipsoidalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalBuffer::len(self : GeodistellipsoidalBuffer) -> Int { self.size }

pub fn GeodistellipsoidalBuffer::get(self : GeodistellipsoidalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalBuffer::set(self : GeodistellipsoidalBuffer, i : Int, v : Double) -> GeodistellipsoidalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalBuffer::sum(self : GeodistellipsoidalBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalBuffer::mean(self : GeodistellipsoidalBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalBuffer::scale(self : GeodistellipsoidalBuffer, f : Double) -> GeodistellipsoidalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalBuffer::add(self : GeodistellipsoidalBuffer, other : GeodistellipsoidalBuffer) -> GeodistellipsoidalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalBuffer::copy(self : GeodistellipsoidalBuffer) -> GeodistellipsoidalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalBuffer::fill(self : GeodistellipsoidalBuffer, v : Double) -> GeodistellipsoidalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalBuffer::min(self : GeodistellipsoidalBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalBuffer::max(self : GeodistellipsoidalBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalBuffer::to_string(self : GeodistellipsoidalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_cursor_make(size : Int) -> GeodistellipsoidalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalCursor::len(self : GeodistellipsoidalCursor) -> Int { self.size }

pub fn GeodistellipsoidalCursor::get(self : GeodistellipsoidalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalCursor::set(self : GeodistellipsoidalCursor, i : Int, v : Double) -> GeodistellipsoidalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCursor::sum(self : GeodistellipsoidalCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalCursor::mean(self : GeodistellipsoidalCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalCursor::scale(self : GeodistellipsoidalCursor, f : Double) -> GeodistellipsoidalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCursor::add(self : GeodistellipsoidalCursor, other : GeodistellipsoidalCursor) -> GeodistellipsoidalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalCursor::copy(self : GeodistellipsoidalCursor) -> GeodistellipsoidalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCursor::fill(self : GeodistellipsoidalCursor, v : Double) -> GeodistellipsoidalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalCursor::min(self : GeodistellipsoidalCursor) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalCursor::max(self : GeodistellipsoidalCursor) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalCursor::to_string(self : GeodistellipsoidalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_view_make(size : Int) -> GeodistellipsoidalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalView::len(self : GeodistellipsoidalView) -> Int { self.size }

pub fn GeodistellipsoidalView::get(self : GeodistellipsoidalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalView::set(self : GeodistellipsoidalView, i : Int, v : Double) -> GeodistellipsoidalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalView::sum(self : GeodistellipsoidalView) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalView::mean(self : GeodistellipsoidalView) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalView::scale(self : GeodistellipsoidalView, f : Double) -> GeodistellipsoidalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalView::add(self : GeodistellipsoidalView, other : GeodistellipsoidalView) -> GeodistellipsoidalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalView::copy(self : GeodistellipsoidalView) -> GeodistellipsoidalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalView::fill(self : GeodistellipsoidalView, v : Double) -> GeodistellipsoidalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalView::min(self : GeodistellipsoidalView) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalView::max(self : GeodistellipsoidalView) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalView::to_string(self : GeodistellipsoidalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_range_make(size : Int) -> GeodistellipsoidalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalRange::len(self : GeodistellipsoidalRange) -> Int { self.size }

pub fn GeodistellipsoidalRange::get(self : GeodistellipsoidalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalRange::set(self : GeodistellipsoidalRange, i : Int, v : Double) -> GeodistellipsoidalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalRange::sum(self : GeodistellipsoidalRange) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalRange::mean(self : GeodistellipsoidalRange) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalRange::scale(self : GeodistellipsoidalRange, f : Double) -> GeodistellipsoidalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalRange::add(self : GeodistellipsoidalRange, other : GeodistellipsoidalRange) -> GeodistellipsoidalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalRange::copy(self : GeodistellipsoidalRange) -> GeodistellipsoidalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalRange::fill(self : GeodistellipsoidalRange, v : Double) -> GeodistellipsoidalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalRange::min(self : GeodistellipsoidalRange) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalRange::max(self : GeodistellipsoidalRange) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalRange::to_string(self : GeodistellipsoidalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_slice_make(size : Int) -> GeodistellipsoidalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistellipsoidalSlice::len(self : GeodistellipsoidalSlice) -> Int { self.size }

pub fn GeodistellipsoidalSlice::get(self : GeodistellipsoidalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistellipsoidalSlice::set(self : GeodistellipsoidalSlice, i : Int, v : Double) -> GeodistellipsoidalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalSlice::sum(self : GeodistellipsoidalSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistellipsoidalSlice::mean(self : GeodistellipsoidalSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistellipsoidalSlice::scale(self : GeodistellipsoidalSlice, f : Double) -> GeodistellipsoidalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalSlice::add(self : GeodistellipsoidalSlice, other : GeodistellipsoidalSlice) -> GeodistellipsoidalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistellipsoidalSlice::copy(self : GeodistellipsoidalSlice) -> GeodistellipsoidalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalSlice::fill(self : GeodistellipsoidalSlice, v : Double) -> GeodistellipsoidalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistellipsoidalSlice::min(self : GeodistellipsoidalSlice) -> Double { @_common.min(self.data) }

pub fn GeodistellipsoidalSlice::max(self : GeodistellipsoidalSlice) -> Double { @_common.max(self.data) }

pub fn GeodistellipsoidalSlice::to_string(self : GeodistellipsoidalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

