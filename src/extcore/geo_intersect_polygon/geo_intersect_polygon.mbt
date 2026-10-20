///===
/// extcore/geo_intersect_polygon

pub(all) struct GeointersectpolygonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_polygon_make_point(x : Double, y : Double) -> GeointersectpolygonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_polygon_make_point3(x : Double, y : Double, z : Double) -> GeointersectpolygonPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectpolygonPoint::x(self : GeointersectpolygonPoint) -> Double { self.x }

pub fn GeointersectpolygonPoint::y(self : GeointersectpolygonPoint) -> Double { self.y }

pub fn GeointersectpolygonPoint::z(self : GeointersectpolygonPoint) -> Double { self.z }

pub fn GeointersectpolygonPoint::label(self : GeointersectpolygonPoint) -> Int { self.label }

pub fn GeointersectpolygonPoint::dist(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectpolygonPoint::add(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectpolygonPoint::sub(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectpolygonPoint::scale(self : GeointersectpolygonPoint, s : Double) -> GeointersectpolygonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectpolygonPoint::dot(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectpolygonPoint::cross(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectpolygonPoint::norm(self : GeointersectpolygonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectpolygonPoint::normalize(self : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpolygonPoint::negate(self : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectpolygonPoint::mid(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectpolygonPoint::lerp(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint, t : Double) -> GeointersectpolygonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectpolygonPoint::to_string(self : GeointersectpolygonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectpolygonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_polygon_make_series(vals : Array[Double], name : String) -> GeointersectpolygonSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectpolygonSeries::len(self : GeointersectpolygonSeries) -> Int { self.vals.length() }

pub fn GeointersectpolygonSeries::sum(self : GeointersectpolygonSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectpolygonSeries::mean(self : GeointersectpolygonSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectpolygonSeries::min(self : GeointersectpolygonSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectpolygonSeries::max(self : GeointersectpolygonSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectpolygonSeries::range(self : GeointersectpolygonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectpolygonSeries::variance(self : GeointersectpolygonSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectpolygonSeries::std(self : GeointersectpolygonSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectpolygonSeries::median(self : GeointersectpolygonSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectpolygonSeries::scale(self : GeointersectpolygonSeries, f : Double) -> GeointersectpolygonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectpolygonSeries::add(self : GeointersectpolygonSeries, other : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectpolygonSeries::sub(self : GeointersectpolygonSeries, other : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectpolygonSeries::normalize(self : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectpolygonSeries::cumsum(self : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectpolygonSeries::to_string(self : GeointersectpolygonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpolygonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_polygon_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectpolygonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_polygon_matrix_identity(n : Int) -> GeointersectpolygonMatrix {
  let m = geo_intersect_polygon_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectpolygonMatrix::get(self : GeointersectpolygonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectpolygonMatrix::transpose(self : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  let result = geo_intersect_polygon_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectpolygonMatrix::add(self : GeointersectpolygonMatrix, other : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectpolygonMatrix::scale(self : GeointersectpolygonMatrix, s : Double) -> GeointersectpolygonMatrix {
  let result = geo_intersect_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectpolygonMatrix::multiply(self : GeointersectpolygonMatrix, other : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  if self.cols != other.rows { return geo_intersect_polygon_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_polygon_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectpolygonMatrix::trace(self : GeointersectpolygonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectpolygonMatrix::det(self : GeointersectpolygonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectpolygonMatrix::norm(self : GeointersectpolygonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectpolygonMatrix::to_string(self : GeointersectpolygonMatrix) -> String {
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

pub(all) struct GeointersectpolygonVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_polygon_make_vector(comps : Array[Double]) -> GeointersectpolygonVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_polygon_vector_zero(dim : Int) -> GeointersectpolygonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectpolygonVector::add(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpolygonVector::sub(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpolygonVector::scale(self : GeointersectpolygonVector, s : Double) -> GeointersectpolygonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectpolygonVector::dot(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectpolygonVector::norm(self : GeointersectpolygonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectpolygonVector::normalize(self : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpolygonVector::dist(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectpolygonVector::to_string(self : GeointersectpolygonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpolygonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_frame_make(size : Int) -> GeointersectpolygonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonFrame::len(self : GeointersectpolygonFrame) -> Int { self.size }

pub fn GeointersectpolygonFrame::get(self : GeointersectpolygonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonFrame::set(self : GeointersectpolygonFrame, i : Int, v : Double) -> GeointersectpolygonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonFrame::sum(self : GeointersectpolygonFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonFrame::mean(self : GeointersectpolygonFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonFrame::scale(self : GeointersectpolygonFrame, f : Double) -> GeointersectpolygonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonFrame::add(self : GeointersectpolygonFrame, other : GeointersectpolygonFrame) -> GeointersectpolygonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonFrame::copy(self : GeointersectpolygonFrame) -> GeointersectpolygonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonFrame::fill(self : GeointersectpolygonFrame, v : Double) -> GeointersectpolygonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonFrame::min(self : GeointersectpolygonFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonFrame::max(self : GeointersectpolygonFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonFrame::to_string(self : GeointersectpolygonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_table_make(size : Int) -> GeointersectpolygonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonTable::len(self : GeointersectpolygonTable) -> Int { self.size }

pub fn GeointersectpolygonTable::get(self : GeointersectpolygonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonTable::set(self : GeointersectpolygonTable, i : Int, v : Double) -> GeointersectpolygonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonTable::sum(self : GeointersectpolygonTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonTable::mean(self : GeointersectpolygonTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonTable::scale(self : GeointersectpolygonTable, f : Double) -> GeointersectpolygonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonTable::add(self : GeointersectpolygonTable, other : GeointersectpolygonTable) -> GeointersectpolygonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonTable::copy(self : GeointersectpolygonTable) -> GeointersectpolygonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonTable::fill(self : GeointersectpolygonTable, v : Double) -> GeointersectpolygonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonTable::min(self : GeointersectpolygonTable) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonTable::max(self : GeointersectpolygonTable) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonTable::to_string(self : GeointersectpolygonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_graphn_make(size : Int) -> GeointersectpolygonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonGraphN::len(self : GeointersectpolygonGraphN) -> Int { self.size }

pub fn GeointersectpolygonGraphN::get(self : GeointersectpolygonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonGraphN::set(self : GeointersectpolygonGraphN, i : Int, v : Double) -> GeointersectpolygonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonGraphN::sum(self : GeointersectpolygonGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonGraphN::mean(self : GeointersectpolygonGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonGraphN::scale(self : GeointersectpolygonGraphN, f : Double) -> GeointersectpolygonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonGraphN::add(self : GeointersectpolygonGraphN, other : GeointersectpolygonGraphN) -> GeointersectpolygonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonGraphN::copy(self : GeointersectpolygonGraphN) -> GeointersectpolygonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonGraphN::fill(self : GeointersectpolygonGraphN, v : Double) -> GeointersectpolygonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonGraphN::min(self : GeointersectpolygonGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonGraphN::max(self : GeointersectpolygonGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonGraphN::to_string(self : GeointersectpolygonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_node_make(size : Int) -> GeointersectpolygonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonNode::len(self : GeointersectpolygonNode) -> Int { self.size }

pub fn GeointersectpolygonNode::get(self : GeointersectpolygonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonNode::set(self : GeointersectpolygonNode, i : Int, v : Double) -> GeointersectpolygonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonNode::sum(self : GeointersectpolygonNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonNode::mean(self : GeointersectpolygonNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonNode::scale(self : GeointersectpolygonNode, f : Double) -> GeointersectpolygonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonNode::add(self : GeointersectpolygonNode, other : GeointersectpolygonNode) -> GeointersectpolygonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonNode::copy(self : GeointersectpolygonNode) -> GeointersectpolygonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonNode::fill(self : GeointersectpolygonNode, v : Double) -> GeointersectpolygonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonNode::min(self : GeointersectpolygonNode) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonNode::max(self : GeointersectpolygonNode) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonNode::to_string(self : GeointersectpolygonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_edge_make(size : Int) -> GeointersectpolygonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonEdge::len(self : GeointersectpolygonEdge) -> Int { self.size }

pub fn GeointersectpolygonEdge::get(self : GeointersectpolygonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonEdge::set(self : GeointersectpolygonEdge, i : Int, v : Double) -> GeointersectpolygonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonEdge::sum(self : GeointersectpolygonEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonEdge::mean(self : GeointersectpolygonEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonEdge::scale(self : GeointersectpolygonEdge, f : Double) -> GeointersectpolygonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonEdge::add(self : GeointersectpolygonEdge, other : GeointersectpolygonEdge) -> GeointersectpolygonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonEdge::copy(self : GeointersectpolygonEdge) -> GeointersectpolygonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonEdge::fill(self : GeointersectpolygonEdge, v : Double) -> GeointersectpolygonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonEdge::min(self : GeointersectpolygonEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonEdge::max(self : GeointersectpolygonEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonEdge::to_string(self : GeointersectpolygonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_path_make(size : Int) -> GeointersectpolygonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonPath::len(self : GeointersectpolygonPath) -> Int { self.size }

pub fn GeointersectpolygonPath::get(self : GeointersectpolygonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonPath::set(self : GeointersectpolygonPath, i : Int, v : Double) -> GeointersectpolygonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonPath::sum(self : GeointersectpolygonPath) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonPath::mean(self : GeointersectpolygonPath) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonPath::scale(self : GeointersectpolygonPath, f : Double) -> GeointersectpolygonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonPath::add(self : GeointersectpolygonPath, other : GeointersectpolygonPath) -> GeointersectpolygonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonPath::copy(self : GeointersectpolygonPath) -> GeointersectpolygonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonPath::fill(self : GeointersectpolygonPath, v : Double) -> GeointersectpolygonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonPath::min(self : GeointersectpolygonPath) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonPath::max(self : GeointersectpolygonPath) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonPath::to_string(self : GeointersectpolygonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_cluster_make(size : Int) -> GeointersectpolygonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonCluster::len(self : GeointersectpolygonCluster) -> Int { self.size }

pub fn GeointersectpolygonCluster::get(self : GeointersectpolygonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonCluster::set(self : GeointersectpolygonCluster, i : Int, v : Double) -> GeointersectpolygonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCluster::sum(self : GeointersectpolygonCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonCluster::mean(self : GeointersectpolygonCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonCluster::scale(self : GeointersectpolygonCluster, f : Double) -> GeointersectpolygonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCluster::add(self : GeointersectpolygonCluster, other : GeointersectpolygonCluster) -> GeointersectpolygonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonCluster::copy(self : GeointersectpolygonCluster) -> GeointersectpolygonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCluster::fill(self : GeointersectpolygonCluster, v : Double) -> GeointersectpolygonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCluster::min(self : GeointersectpolygonCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonCluster::max(self : GeointersectpolygonCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonCluster::to_string(self : GeointersectpolygonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_model_make(size : Int) -> GeointersectpolygonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonModel::len(self : GeointersectpolygonModel) -> Int { self.size }

pub fn GeointersectpolygonModel::get(self : GeointersectpolygonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonModel::set(self : GeointersectpolygonModel, i : Int, v : Double) -> GeointersectpolygonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonModel::sum(self : GeointersectpolygonModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonModel::mean(self : GeointersectpolygonModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonModel::scale(self : GeointersectpolygonModel, f : Double) -> GeointersectpolygonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonModel::add(self : GeointersectpolygonModel, other : GeointersectpolygonModel) -> GeointersectpolygonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonModel::copy(self : GeointersectpolygonModel) -> GeointersectpolygonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonModel::fill(self : GeointersectpolygonModel, v : Double) -> GeointersectpolygonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonModel::min(self : GeointersectpolygonModel) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonModel::max(self : GeointersectpolygonModel) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonModel::to_string(self : GeointersectpolygonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_layer_make(size : Int) -> GeointersectpolygonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonLayer::len(self : GeointersectpolygonLayer) -> Int { self.size }

pub fn GeointersectpolygonLayer::get(self : GeointersectpolygonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonLayer::set(self : GeointersectpolygonLayer, i : Int, v : Double) -> GeointersectpolygonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonLayer::sum(self : GeointersectpolygonLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonLayer::mean(self : GeointersectpolygonLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonLayer::scale(self : GeointersectpolygonLayer, f : Double) -> GeointersectpolygonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonLayer::add(self : GeointersectpolygonLayer, other : GeointersectpolygonLayer) -> GeointersectpolygonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonLayer::copy(self : GeointersectpolygonLayer) -> GeointersectpolygonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonLayer::fill(self : GeointersectpolygonLayer, v : Double) -> GeointersectpolygonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonLayer::min(self : GeointersectpolygonLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonLayer::max(self : GeointersectpolygonLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonLayer::to_string(self : GeointersectpolygonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_buffer_make(size : Int) -> GeointersectpolygonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonBuffer::len(self : GeointersectpolygonBuffer) -> Int { self.size }

pub fn GeointersectpolygonBuffer::get(self : GeointersectpolygonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonBuffer::set(self : GeointersectpolygonBuffer, i : Int, v : Double) -> GeointersectpolygonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonBuffer::sum(self : GeointersectpolygonBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonBuffer::mean(self : GeointersectpolygonBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonBuffer::scale(self : GeointersectpolygonBuffer, f : Double) -> GeointersectpolygonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonBuffer::add(self : GeointersectpolygonBuffer, other : GeointersectpolygonBuffer) -> GeointersectpolygonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonBuffer::copy(self : GeointersectpolygonBuffer) -> GeointersectpolygonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonBuffer::fill(self : GeointersectpolygonBuffer, v : Double) -> GeointersectpolygonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonBuffer::min(self : GeointersectpolygonBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonBuffer::max(self : GeointersectpolygonBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonBuffer::to_string(self : GeointersectpolygonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_cursor_make(size : Int) -> GeointersectpolygonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonCursor::len(self : GeointersectpolygonCursor) -> Int { self.size }

pub fn GeointersectpolygonCursor::get(self : GeointersectpolygonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonCursor::set(self : GeointersectpolygonCursor, i : Int, v : Double) -> GeointersectpolygonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCursor::sum(self : GeointersectpolygonCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonCursor::mean(self : GeointersectpolygonCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonCursor::scale(self : GeointersectpolygonCursor, f : Double) -> GeointersectpolygonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCursor::add(self : GeointersectpolygonCursor, other : GeointersectpolygonCursor) -> GeointersectpolygonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonCursor::copy(self : GeointersectpolygonCursor) -> GeointersectpolygonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCursor::fill(self : GeointersectpolygonCursor, v : Double) -> GeointersectpolygonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonCursor::min(self : GeointersectpolygonCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonCursor::max(self : GeointersectpolygonCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonCursor::to_string(self : GeointersectpolygonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_view_make(size : Int) -> GeointersectpolygonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonView::len(self : GeointersectpolygonView) -> Int { self.size }

pub fn GeointersectpolygonView::get(self : GeointersectpolygonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonView::set(self : GeointersectpolygonView, i : Int, v : Double) -> GeointersectpolygonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonView::sum(self : GeointersectpolygonView) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonView::mean(self : GeointersectpolygonView) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonView::scale(self : GeointersectpolygonView, f : Double) -> GeointersectpolygonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonView::add(self : GeointersectpolygonView, other : GeointersectpolygonView) -> GeointersectpolygonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonView::copy(self : GeointersectpolygonView) -> GeointersectpolygonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonView::fill(self : GeointersectpolygonView, v : Double) -> GeointersectpolygonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonView::min(self : GeointersectpolygonView) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonView::max(self : GeointersectpolygonView) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonView::to_string(self : GeointersectpolygonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_range_make(size : Int) -> GeointersectpolygonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonRange::len(self : GeointersectpolygonRange) -> Int { self.size }

pub fn GeointersectpolygonRange::get(self : GeointersectpolygonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonRange::set(self : GeointersectpolygonRange, i : Int, v : Double) -> GeointersectpolygonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonRange::sum(self : GeointersectpolygonRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonRange::mean(self : GeointersectpolygonRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonRange::scale(self : GeointersectpolygonRange, f : Double) -> GeointersectpolygonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonRange::add(self : GeointersectpolygonRange, other : GeointersectpolygonRange) -> GeointersectpolygonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonRange::copy(self : GeointersectpolygonRange) -> GeointersectpolygonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonRange::fill(self : GeointersectpolygonRange, v : Double) -> GeointersectpolygonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonRange::min(self : GeointersectpolygonRange) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonRange::max(self : GeointersectpolygonRange) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonRange::to_string(self : GeointersectpolygonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_slice_make(size : Int) -> GeointersectpolygonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpolygonSlice::len(self : GeointersectpolygonSlice) -> Int { self.size }

pub fn GeointersectpolygonSlice::get(self : GeointersectpolygonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpolygonSlice::set(self : GeointersectpolygonSlice, i : Int, v : Double) -> GeointersectpolygonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonSlice::sum(self : GeointersectpolygonSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectpolygonSlice::mean(self : GeointersectpolygonSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectpolygonSlice::scale(self : GeointersectpolygonSlice, f : Double) -> GeointersectpolygonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonSlice::add(self : GeointersectpolygonSlice, other : GeointersectpolygonSlice) -> GeointersectpolygonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpolygonSlice::copy(self : GeointersectpolygonSlice) -> GeointersectpolygonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonSlice::fill(self : GeointersectpolygonSlice, v : Double) -> GeointersectpolygonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpolygonSlice::min(self : GeointersectpolygonSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectpolygonSlice::max(self : GeointersectpolygonSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectpolygonSlice::to_string(self : GeointersectpolygonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

