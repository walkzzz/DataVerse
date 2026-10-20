///===
/// extcore/geo_intersect_bbox

pub(all) struct GeointersectbboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_bbox_make_point(x : Double, y : Double) -> GeointersectbboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_bbox_make_point3(x : Double, y : Double, z : Double) -> GeointersectbboxPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectbboxPoint::x(self : GeointersectbboxPoint) -> Double { self.x }

pub fn GeointersectbboxPoint::y(self : GeointersectbboxPoint) -> Double { self.y }

pub fn GeointersectbboxPoint::z(self : GeointersectbboxPoint) -> Double { self.z }

pub fn GeointersectbboxPoint::label(self : GeointersectbboxPoint) -> Int { self.label }

pub fn GeointersectbboxPoint::dist(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectbboxPoint::add(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectbboxPoint::sub(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectbboxPoint::scale(self : GeointersectbboxPoint, s : Double) -> GeointersectbboxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectbboxPoint::dot(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectbboxPoint::cross(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectbboxPoint::norm(self : GeointersectbboxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectbboxPoint::normalize(self : GeointersectbboxPoint) -> GeointersectbboxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectbboxPoint::negate(self : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectbboxPoint::mid(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectbboxPoint::lerp(self : GeointersectbboxPoint, other : GeointersectbboxPoint, t : Double) -> GeointersectbboxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectbboxPoint::to_string(self : GeointersectbboxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectbboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_bbox_make_series(vals : Array[Double], name : String) -> GeointersectbboxSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectbboxSeries::len(self : GeointersectbboxSeries) -> Int { self.vals.length() }

pub fn GeointersectbboxSeries::sum(self : GeointersectbboxSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectbboxSeries::mean(self : GeointersectbboxSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectbboxSeries::min(self : GeointersectbboxSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectbboxSeries::max(self : GeointersectbboxSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectbboxSeries::range(self : GeointersectbboxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectbboxSeries::variance(self : GeointersectbboxSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectbboxSeries::std(self : GeointersectbboxSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectbboxSeries::median(self : GeointersectbboxSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectbboxSeries::scale(self : GeointersectbboxSeries, f : Double) -> GeointersectbboxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectbboxSeries::add(self : GeointersectbboxSeries, other : GeointersectbboxSeries) -> GeointersectbboxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectbboxSeries::sub(self : GeointersectbboxSeries, other : GeointersectbboxSeries) -> GeointersectbboxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectbboxSeries::normalize(self : GeointersectbboxSeries) -> GeointersectbboxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectbboxSeries::cumsum(self : GeointersectbboxSeries) -> GeointersectbboxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectbboxSeries::to_string(self : GeointersectbboxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectbboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_bbox_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectbboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_bbox_matrix_identity(n : Int) -> GeointersectbboxMatrix {
  let m = geo_intersect_bbox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectbboxMatrix::get(self : GeointersectbboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectbboxMatrix::transpose(self : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  let result = geo_intersect_bbox_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectbboxMatrix::add(self : GeointersectbboxMatrix, other : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_bbox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectbboxMatrix::scale(self : GeointersectbboxMatrix, s : Double) -> GeointersectbboxMatrix {
  let result = geo_intersect_bbox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectbboxMatrix::multiply(self : GeointersectbboxMatrix, other : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  if self.cols != other.rows { return geo_intersect_bbox_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_bbox_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeointersectbboxMatrix::trace(self : GeointersectbboxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectbboxMatrix::det(self : GeointersectbboxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectbboxMatrix::norm(self : GeointersectbboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectbboxMatrix::to_string(self : GeointersectbboxMatrix) -> String {
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

pub(all) struct GeointersectbboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_bbox_make_vector(comps : Array[Double]) -> GeointersectbboxVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_bbox_vector_zero(dim : Int) -> GeointersectbboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectbboxVector::add(self : GeointersectbboxVector, other : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectbboxVector::sub(self : GeointersectbboxVector, other : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectbboxVector::scale(self : GeointersectbboxVector, s : Double) -> GeointersectbboxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectbboxVector::dot(self : GeointersectbboxVector, other : GeointersectbboxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectbboxVector::norm(self : GeointersectbboxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectbboxVector::normalize(self : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectbboxVector::dist(self : GeointersectbboxVector, other : GeointersectbboxVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectbboxVector::to_string(self : GeointersectbboxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectbboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_frame_make(size : Int) -> GeointersectbboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxFrame::len(self : GeointersectbboxFrame) -> Int { self.size }

pub fn GeointersectbboxFrame::get(self : GeointersectbboxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxFrame::set(self : GeointersectbboxFrame, i : Int, v : Double) -> GeointersectbboxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxFrame::sum(self : GeointersectbboxFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxFrame::mean(self : GeointersectbboxFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxFrame::scale(self : GeointersectbboxFrame, f : Double) -> GeointersectbboxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxFrame::add(self : GeointersectbboxFrame, other : GeointersectbboxFrame) -> GeointersectbboxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxFrame::copy(self : GeointersectbboxFrame) -> GeointersectbboxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxFrame::fill(self : GeointersectbboxFrame, v : Double) -> GeointersectbboxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxFrame::min(self : GeointersectbboxFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxFrame::max(self : GeointersectbboxFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxFrame::to_string(self : GeointersectbboxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_table_make(size : Int) -> GeointersectbboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxTable::len(self : GeointersectbboxTable) -> Int { self.size }

pub fn GeointersectbboxTable::get(self : GeointersectbboxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxTable::set(self : GeointersectbboxTable, i : Int, v : Double) -> GeointersectbboxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxTable::sum(self : GeointersectbboxTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxTable::mean(self : GeointersectbboxTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxTable::scale(self : GeointersectbboxTable, f : Double) -> GeointersectbboxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxTable::add(self : GeointersectbboxTable, other : GeointersectbboxTable) -> GeointersectbboxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxTable::copy(self : GeointersectbboxTable) -> GeointersectbboxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxTable::fill(self : GeointersectbboxTable, v : Double) -> GeointersectbboxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxTable::min(self : GeointersectbboxTable) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxTable::max(self : GeointersectbboxTable) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxTable::to_string(self : GeointersectbboxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_graphn_make(size : Int) -> GeointersectbboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxGraphN::len(self : GeointersectbboxGraphN) -> Int { self.size }

pub fn GeointersectbboxGraphN::get(self : GeointersectbboxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxGraphN::set(self : GeointersectbboxGraphN, i : Int, v : Double) -> GeointersectbboxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxGraphN::sum(self : GeointersectbboxGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxGraphN::mean(self : GeointersectbboxGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxGraphN::scale(self : GeointersectbboxGraphN, f : Double) -> GeointersectbboxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxGraphN::add(self : GeointersectbboxGraphN, other : GeointersectbboxGraphN) -> GeointersectbboxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxGraphN::copy(self : GeointersectbboxGraphN) -> GeointersectbboxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxGraphN::fill(self : GeointersectbboxGraphN, v : Double) -> GeointersectbboxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxGraphN::min(self : GeointersectbboxGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxGraphN::max(self : GeointersectbboxGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxGraphN::to_string(self : GeointersectbboxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_node_make(size : Int) -> GeointersectbboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxNode::len(self : GeointersectbboxNode) -> Int { self.size }

pub fn GeointersectbboxNode::get(self : GeointersectbboxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxNode::set(self : GeointersectbboxNode, i : Int, v : Double) -> GeointersectbboxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxNode::sum(self : GeointersectbboxNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxNode::mean(self : GeointersectbboxNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxNode::scale(self : GeointersectbboxNode, f : Double) -> GeointersectbboxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxNode::add(self : GeointersectbboxNode, other : GeointersectbboxNode) -> GeointersectbboxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxNode::copy(self : GeointersectbboxNode) -> GeointersectbboxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxNode::fill(self : GeointersectbboxNode, v : Double) -> GeointersectbboxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxNode::min(self : GeointersectbboxNode) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxNode::max(self : GeointersectbboxNode) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxNode::to_string(self : GeointersectbboxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_edge_make(size : Int) -> GeointersectbboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxEdge::len(self : GeointersectbboxEdge) -> Int { self.size }

pub fn GeointersectbboxEdge::get(self : GeointersectbboxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxEdge::set(self : GeointersectbboxEdge, i : Int, v : Double) -> GeointersectbboxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxEdge::sum(self : GeointersectbboxEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxEdge::mean(self : GeointersectbboxEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxEdge::scale(self : GeointersectbboxEdge, f : Double) -> GeointersectbboxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxEdge::add(self : GeointersectbboxEdge, other : GeointersectbboxEdge) -> GeointersectbboxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxEdge::copy(self : GeointersectbboxEdge) -> GeointersectbboxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxEdge::fill(self : GeointersectbboxEdge, v : Double) -> GeointersectbboxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxEdge::min(self : GeointersectbboxEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxEdge::max(self : GeointersectbboxEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxEdge::to_string(self : GeointersectbboxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_path_make(size : Int) -> GeointersectbboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxPath::len(self : GeointersectbboxPath) -> Int { self.size }

pub fn GeointersectbboxPath::get(self : GeointersectbboxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxPath::set(self : GeointersectbboxPath, i : Int, v : Double) -> GeointersectbboxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxPath::sum(self : GeointersectbboxPath) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxPath::mean(self : GeointersectbboxPath) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxPath::scale(self : GeointersectbboxPath, f : Double) -> GeointersectbboxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxPath::add(self : GeointersectbboxPath, other : GeointersectbboxPath) -> GeointersectbboxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxPath::copy(self : GeointersectbboxPath) -> GeointersectbboxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxPath::fill(self : GeointersectbboxPath, v : Double) -> GeointersectbboxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxPath::min(self : GeointersectbboxPath) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxPath::max(self : GeointersectbboxPath) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxPath::to_string(self : GeointersectbboxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_cluster_make(size : Int) -> GeointersectbboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxCluster::len(self : GeointersectbboxCluster) -> Int { self.size }

pub fn GeointersectbboxCluster::get(self : GeointersectbboxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxCluster::set(self : GeointersectbboxCluster, i : Int, v : Double) -> GeointersectbboxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCluster::sum(self : GeointersectbboxCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxCluster::mean(self : GeointersectbboxCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxCluster::scale(self : GeointersectbboxCluster, f : Double) -> GeointersectbboxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCluster::add(self : GeointersectbboxCluster, other : GeointersectbboxCluster) -> GeointersectbboxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxCluster::copy(self : GeointersectbboxCluster) -> GeointersectbboxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCluster::fill(self : GeointersectbboxCluster, v : Double) -> GeointersectbboxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCluster::min(self : GeointersectbboxCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxCluster::max(self : GeointersectbboxCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxCluster::to_string(self : GeointersectbboxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_model_make(size : Int) -> GeointersectbboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxModel::len(self : GeointersectbboxModel) -> Int { self.size }

pub fn GeointersectbboxModel::get(self : GeointersectbboxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxModel::set(self : GeointersectbboxModel, i : Int, v : Double) -> GeointersectbboxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxModel::sum(self : GeointersectbboxModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxModel::mean(self : GeointersectbboxModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxModel::scale(self : GeointersectbboxModel, f : Double) -> GeointersectbboxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxModel::add(self : GeointersectbboxModel, other : GeointersectbboxModel) -> GeointersectbboxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxModel::copy(self : GeointersectbboxModel) -> GeointersectbboxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxModel::fill(self : GeointersectbboxModel, v : Double) -> GeointersectbboxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxModel::min(self : GeointersectbboxModel) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxModel::max(self : GeointersectbboxModel) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxModel::to_string(self : GeointersectbboxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_layer_make(size : Int) -> GeointersectbboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxLayer::len(self : GeointersectbboxLayer) -> Int { self.size }

pub fn GeointersectbboxLayer::get(self : GeointersectbboxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxLayer::set(self : GeointersectbboxLayer, i : Int, v : Double) -> GeointersectbboxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxLayer::sum(self : GeointersectbboxLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxLayer::mean(self : GeointersectbboxLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxLayer::scale(self : GeointersectbboxLayer, f : Double) -> GeointersectbboxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxLayer::add(self : GeointersectbboxLayer, other : GeointersectbboxLayer) -> GeointersectbboxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxLayer::copy(self : GeointersectbboxLayer) -> GeointersectbboxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxLayer::fill(self : GeointersectbboxLayer, v : Double) -> GeointersectbboxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxLayer::min(self : GeointersectbboxLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxLayer::max(self : GeointersectbboxLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxLayer::to_string(self : GeointersectbboxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_buffer_make(size : Int) -> GeointersectbboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxBuffer::len(self : GeointersectbboxBuffer) -> Int { self.size }

pub fn GeointersectbboxBuffer::get(self : GeointersectbboxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxBuffer::set(self : GeointersectbboxBuffer, i : Int, v : Double) -> GeointersectbboxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxBuffer::sum(self : GeointersectbboxBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxBuffer::mean(self : GeointersectbboxBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxBuffer::scale(self : GeointersectbboxBuffer, f : Double) -> GeointersectbboxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxBuffer::add(self : GeointersectbboxBuffer, other : GeointersectbboxBuffer) -> GeointersectbboxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxBuffer::copy(self : GeointersectbboxBuffer) -> GeointersectbboxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxBuffer::fill(self : GeointersectbboxBuffer, v : Double) -> GeointersectbboxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxBuffer::min(self : GeointersectbboxBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxBuffer::max(self : GeointersectbboxBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxBuffer::to_string(self : GeointersectbboxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_cursor_make(size : Int) -> GeointersectbboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxCursor::len(self : GeointersectbboxCursor) -> Int { self.size }

pub fn GeointersectbboxCursor::get(self : GeointersectbboxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxCursor::set(self : GeointersectbboxCursor, i : Int, v : Double) -> GeointersectbboxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCursor::sum(self : GeointersectbboxCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxCursor::mean(self : GeointersectbboxCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxCursor::scale(self : GeointersectbboxCursor, f : Double) -> GeointersectbboxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCursor::add(self : GeointersectbboxCursor, other : GeointersectbboxCursor) -> GeointersectbboxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxCursor::copy(self : GeointersectbboxCursor) -> GeointersectbboxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCursor::fill(self : GeointersectbboxCursor, v : Double) -> GeointersectbboxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxCursor::min(self : GeointersectbboxCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxCursor::max(self : GeointersectbboxCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxCursor::to_string(self : GeointersectbboxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_view_make(size : Int) -> GeointersectbboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxView::len(self : GeointersectbboxView) -> Int { self.size }

pub fn GeointersectbboxView::get(self : GeointersectbboxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxView::set(self : GeointersectbboxView, i : Int, v : Double) -> GeointersectbboxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxView::sum(self : GeointersectbboxView) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxView::mean(self : GeointersectbboxView) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxView::scale(self : GeointersectbboxView, f : Double) -> GeointersectbboxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxView::add(self : GeointersectbboxView, other : GeointersectbboxView) -> GeointersectbboxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxView::copy(self : GeointersectbboxView) -> GeointersectbboxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxView::fill(self : GeointersectbboxView, v : Double) -> GeointersectbboxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxView::min(self : GeointersectbboxView) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxView::max(self : GeointersectbboxView) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxView::to_string(self : GeointersectbboxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_range_make(size : Int) -> GeointersectbboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxRange::len(self : GeointersectbboxRange) -> Int { self.size }

pub fn GeointersectbboxRange::get(self : GeointersectbboxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxRange::set(self : GeointersectbboxRange, i : Int, v : Double) -> GeointersectbboxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxRange::sum(self : GeointersectbboxRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxRange::mean(self : GeointersectbboxRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxRange::scale(self : GeointersectbboxRange, f : Double) -> GeointersectbboxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxRange::add(self : GeointersectbboxRange, other : GeointersectbboxRange) -> GeointersectbboxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxRange::copy(self : GeointersectbboxRange) -> GeointersectbboxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxRange::fill(self : GeointersectbboxRange, v : Double) -> GeointersectbboxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxRange::min(self : GeointersectbboxRange) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxRange::max(self : GeointersectbboxRange) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxRange::to_string(self : GeointersectbboxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_slice_make(size : Int) -> GeointersectbboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectbboxSlice::len(self : GeointersectbboxSlice) -> Int { self.size }

pub fn GeointersectbboxSlice::get(self : GeointersectbboxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectbboxSlice::set(self : GeointersectbboxSlice, i : Int, v : Double) -> GeointersectbboxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectbboxSlice::sum(self : GeointersectbboxSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectbboxSlice::mean(self : GeointersectbboxSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectbboxSlice::scale(self : GeointersectbboxSlice, f : Double) -> GeointersectbboxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxSlice::add(self : GeointersectbboxSlice, other : GeointersectbboxSlice) -> GeointersectbboxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectbboxSlice::copy(self : GeointersectbboxSlice) -> GeointersectbboxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxSlice::fill(self : GeointersectbboxSlice, v : Double) -> GeointersectbboxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectbboxSlice::min(self : GeointersectbboxSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectbboxSlice::max(self : GeointersectbboxSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectbboxSlice::to_string(self : GeointersectbboxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

