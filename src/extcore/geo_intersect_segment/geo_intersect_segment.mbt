///===
/// extcore/geo_intersect_segment

pub(all) struct GeointersectsegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_segment_make_point(x : Double, y : Double) -> GeointersectsegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_segment_make_point3(x : Double, y : Double, z : Double) -> GeointersectsegmentPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectsegmentPoint::x(self : GeointersectsegmentPoint) -> Double { self.x }

pub fn GeointersectsegmentPoint::y(self : GeointersectsegmentPoint) -> Double { self.y }

pub fn GeointersectsegmentPoint::z(self : GeointersectsegmentPoint) -> Double { self.z }

pub fn GeointersectsegmentPoint::label(self : GeointersectsegmentPoint) -> Int { self.label }

pub fn GeointersectsegmentPoint::dist(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectsegmentPoint::add(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectsegmentPoint::sub(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectsegmentPoint::scale(self : GeointersectsegmentPoint, s : Double) -> GeointersectsegmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectsegmentPoint::dot(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectsegmentPoint::cross(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectsegmentPoint::norm(self : GeointersectsegmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectsegmentPoint::normalize(self : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectsegmentPoint::negate(self : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectsegmentPoint::mid(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectsegmentPoint::lerp(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint, t : Double) -> GeointersectsegmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectsegmentPoint::to_string(self : GeointersectsegmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectsegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_segment_make_series(vals : Array[Double], name : String) -> GeointersectsegmentSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectsegmentSeries::len(self : GeointersectsegmentSeries) -> Int { self.vals.length() }

pub fn GeointersectsegmentSeries::sum(self : GeointersectsegmentSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectsegmentSeries::mean(self : GeointersectsegmentSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectsegmentSeries::min(self : GeointersectsegmentSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectsegmentSeries::max(self : GeointersectsegmentSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectsegmentSeries::range(self : GeointersectsegmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectsegmentSeries::variance(self : GeointersectsegmentSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectsegmentSeries::std(self : GeointersectsegmentSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectsegmentSeries::median(self : GeointersectsegmentSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectsegmentSeries::scale(self : GeointersectsegmentSeries, f : Double) -> GeointersectsegmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectsegmentSeries::add(self : GeointersectsegmentSeries, other : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectsegmentSeries::sub(self : GeointersectsegmentSeries, other : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectsegmentSeries::normalize(self : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectsegmentSeries::cumsum(self : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectsegmentSeries::to_string(self : GeointersectsegmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectsegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_segment_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectsegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_segment_matrix_identity(n : Int) -> GeointersectsegmentMatrix {
  let m = geo_intersect_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectsegmentMatrix::get(self : GeointersectsegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectsegmentMatrix::transpose(self : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  let result = geo_intersect_segment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectsegmentMatrix::add(self : GeointersectsegmentMatrix, other : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectsegmentMatrix::scale(self : GeointersectsegmentMatrix, s : Double) -> GeointersectsegmentMatrix {
  let result = geo_intersect_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectsegmentMatrix::multiply(self : GeointersectsegmentMatrix, other : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  if self.cols != other.rows { return geo_intersect_segment_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_segment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeointersectsegmentMatrix::trace(self : GeointersectsegmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectsegmentMatrix::det(self : GeointersectsegmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectsegmentMatrix::norm(self : GeointersectsegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectsegmentMatrix::to_string(self : GeointersectsegmentMatrix) -> String {
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

pub(all) struct GeointersectsegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_segment_make_vector(comps : Array[Double]) -> GeointersectsegmentVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_segment_vector_zero(dim : Int) -> GeointersectsegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectsegmentVector::add(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectsegmentVector::sub(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectsegmentVector::scale(self : GeointersectsegmentVector, s : Double) -> GeointersectsegmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectsegmentVector::dot(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectsegmentVector::norm(self : GeointersectsegmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectsegmentVector::normalize(self : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectsegmentVector::dist(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectsegmentVector::to_string(self : GeointersectsegmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectsegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_frame_make(size : Int) -> GeointersectsegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentFrame::len(self : GeointersectsegmentFrame) -> Int { self.size }

pub fn GeointersectsegmentFrame::get(self : GeointersectsegmentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentFrame::set(self : GeointersectsegmentFrame, i : Int, v : Double) -> GeointersectsegmentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentFrame::sum(self : GeointersectsegmentFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentFrame::mean(self : GeointersectsegmentFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentFrame::scale(self : GeointersectsegmentFrame, f : Double) -> GeointersectsegmentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentFrame::add(self : GeointersectsegmentFrame, other : GeointersectsegmentFrame) -> GeointersectsegmentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentFrame::copy(self : GeointersectsegmentFrame) -> GeointersectsegmentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentFrame::fill(self : GeointersectsegmentFrame, v : Double) -> GeointersectsegmentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentFrame::min(self : GeointersectsegmentFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentFrame::max(self : GeointersectsegmentFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentFrame::to_string(self : GeointersectsegmentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_table_make(size : Int) -> GeointersectsegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentTable::len(self : GeointersectsegmentTable) -> Int { self.size }

pub fn GeointersectsegmentTable::get(self : GeointersectsegmentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentTable::set(self : GeointersectsegmentTable, i : Int, v : Double) -> GeointersectsegmentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentTable::sum(self : GeointersectsegmentTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentTable::mean(self : GeointersectsegmentTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentTable::scale(self : GeointersectsegmentTable, f : Double) -> GeointersectsegmentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentTable::add(self : GeointersectsegmentTable, other : GeointersectsegmentTable) -> GeointersectsegmentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentTable::copy(self : GeointersectsegmentTable) -> GeointersectsegmentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentTable::fill(self : GeointersectsegmentTable, v : Double) -> GeointersectsegmentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentTable::min(self : GeointersectsegmentTable) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentTable::max(self : GeointersectsegmentTable) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentTable::to_string(self : GeointersectsegmentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_graphn_make(size : Int) -> GeointersectsegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentGraphN::len(self : GeointersectsegmentGraphN) -> Int { self.size }

pub fn GeointersectsegmentGraphN::get(self : GeointersectsegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentGraphN::set(self : GeointersectsegmentGraphN, i : Int, v : Double) -> GeointersectsegmentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentGraphN::sum(self : GeointersectsegmentGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentGraphN::mean(self : GeointersectsegmentGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentGraphN::scale(self : GeointersectsegmentGraphN, f : Double) -> GeointersectsegmentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentGraphN::add(self : GeointersectsegmentGraphN, other : GeointersectsegmentGraphN) -> GeointersectsegmentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentGraphN::copy(self : GeointersectsegmentGraphN) -> GeointersectsegmentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentGraphN::fill(self : GeointersectsegmentGraphN, v : Double) -> GeointersectsegmentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentGraphN::min(self : GeointersectsegmentGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentGraphN::max(self : GeointersectsegmentGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentGraphN::to_string(self : GeointersectsegmentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_node_make(size : Int) -> GeointersectsegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentNode::len(self : GeointersectsegmentNode) -> Int { self.size }

pub fn GeointersectsegmentNode::get(self : GeointersectsegmentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentNode::set(self : GeointersectsegmentNode, i : Int, v : Double) -> GeointersectsegmentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentNode::sum(self : GeointersectsegmentNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentNode::mean(self : GeointersectsegmentNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentNode::scale(self : GeointersectsegmentNode, f : Double) -> GeointersectsegmentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentNode::add(self : GeointersectsegmentNode, other : GeointersectsegmentNode) -> GeointersectsegmentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentNode::copy(self : GeointersectsegmentNode) -> GeointersectsegmentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentNode::fill(self : GeointersectsegmentNode, v : Double) -> GeointersectsegmentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentNode::min(self : GeointersectsegmentNode) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentNode::max(self : GeointersectsegmentNode) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentNode::to_string(self : GeointersectsegmentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_edge_make(size : Int) -> GeointersectsegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentEdge::len(self : GeointersectsegmentEdge) -> Int { self.size }

pub fn GeointersectsegmentEdge::get(self : GeointersectsegmentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentEdge::set(self : GeointersectsegmentEdge, i : Int, v : Double) -> GeointersectsegmentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentEdge::sum(self : GeointersectsegmentEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentEdge::mean(self : GeointersectsegmentEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentEdge::scale(self : GeointersectsegmentEdge, f : Double) -> GeointersectsegmentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentEdge::add(self : GeointersectsegmentEdge, other : GeointersectsegmentEdge) -> GeointersectsegmentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentEdge::copy(self : GeointersectsegmentEdge) -> GeointersectsegmentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentEdge::fill(self : GeointersectsegmentEdge, v : Double) -> GeointersectsegmentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentEdge::min(self : GeointersectsegmentEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentEdge::max(self : GeointersectsegmentEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentEdge::to_string(self : GeointersectsegmentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_path_make(size : Int) -> GeointersectsegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentPath::len(self : GeointersectsegmentPath) -> Int { self.size }

pub fn GeointersectsegmentPath::get(self : GeointersectsegmentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentPath::set(self : GeointersectsegmentPath, i : Int, v : Double) -> GeointersectsegmentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentPath::sum(self : GeointersectsegmentPath) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentPath::mean(self : GeointersectsegmentPath) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentPath::scale(self : GeointersectsegmentPath, f : Double) -> GeointersectsegmentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentPath::add(self : GeointersectsegmentPath, other : GeointersectsegmentPath) -> GeointersectsegmentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentPath::copy(self : GeointersectsegmentPath) -> GeointersectsegmentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentPath::fill(self : GeointersectsegmentPath, v : Double) -> GeointersectsegmentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentPath::min(self : GeointersectsegmentPath) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentPath::max(self : GeointersectsegmentPath) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentPath::to_string(self : GeointersectsegmentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_cluster_make(size : Int) -> GeointersectsegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentCluster::len(self : GeointersectsegmentCluster) -> Int { self.size }

pub fn GeointersectsegmentCluster::get(self : GeointersectsegmentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentCluster::set(self : GeointersectsegmentCluster, i : Int, v : Double) -> GeointersectsegmentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCluster::sum(self : GeointersectsegmentCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentCluster::mean(self : GeointersectsegmentCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentCluster::scale(self : GeointersectsegmentCluster, f : Double) -> GeointersectsegmentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCluster::add(self : GeointersectsegmentCluster, other : GeointersectsegmentCluster) -> GeointersectsegmentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentCluster::copy(self : GeointersectsegmentCluster) -> GeointersectsegmentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCluster::fill(self : GeointersectsegmentCluster, v : Double) -> GeointersectsegmentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCluster::min(self : GeointersectsegmentCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentCluster::max(self : GeointersectsegmentCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentCluster::to_string(self : GeointersectsegmentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_model_make(size : Int) -> GeointersectsegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentModel::len(self : GeointersectsegmentModel) -> Int { self.size }

pub fn GeointersectsegmentModel::get(self : GeointersectsegmentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentModel::set(self : GeointersectsegmentModel, i : Int, v : Double) -> GeointersectsegmentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentModel::sum(self : GeointersectsegmentModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentModel::mean(self : GeointersectsegmentModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentModel::scale(self : GeointersectsegmentModel, f : Double) -> GeointersectsegmentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentModel::add(self : GeointersectsegmentModel, other : GeointersectsegmentModel) -> GeointersectsegmentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentModel::copy(self : GeointersectsegmentModel) -> GeointersectsegmentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentModel::fill(self : GeointersectsegmentModel, v : Double) -> GeointersectsegmentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentModel::min(self : GeointersectsegmentModel) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentModel::max(self : GeointersectsegmentModel) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentModel::to_string(self : GeointersectsegmentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_layer_make(size : Int) -> GeointersectsegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentLayer::len(self : GeointersectsegmentLayer) -> Int { self.size }

pub fn GeointersectsegmentLayer::get(self : GeointersectsegmentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentLayer::set(self : GeointersectsegmentLayer, i : Int, v : Double) -> GeointersectsegmentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentLayer::sum(self : GeointersectsegmentLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentLayer::mean(self : GeointersectsegmentLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentLayer::scale(self : GeointersectsegmentLayer, f : Double) -> GeointersectsegmentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentLayer::add(self : GeointersectsegmentLayer, other : GeointersectsegmentLayer) -> GeointersectsegmentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentLayer::copy(self : GeointersectsegmentLayer) -> GeointersectsegmentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentLayer::fill(self : GeointersectsegmentLayer, v : Double) -> GeointersectsegmentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentLayer::min(self : GeointersectsegmentLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentLayer::max(self : GeointersectsegmentLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentLayer::to_string(self : GeointersectsegmentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_buffer_make(size : Int) -> GeointersectsegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentBuffer::len(self : GeointersectsegmentBuffer) -> Int { self.size }

pub fn GeointersectsegmentBuffer::get(self : GeointersectsegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentBuffer::set(self : GeointersectsegmentBuffer, i : Int, v : Double) -> GeointersectsegmentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentBuffer::sum(self : GeointersectsegmentBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentBuffer::mean(self : GeointersectsegmentBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentBuffer::scale(self : GeointersectsegmentBuffer, f : Double) -> GeointersectsegmentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentBuffer::add(self : GeointersectsegmentBuffer, other : GeointersectsegmentBuffer) -> GeointersectsegmentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentBuffer::copy(self : GeointersectsegmentBuffer) -> GeointersectsegmentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentBuffer::fill(self : GeointersectsegmentBuffer, v : Double) -> GeointersectsegmentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentBuffer::min(self : GeointersectsegmentBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentBuffer::max(self : GeointersectsegmentBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentBuffer::to_string(self : GeointersectsegmentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_cursor_make(size : Int) -> GeointersectsegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentCursor::len(self : GeointersectsegmentCursor) -> Int { self.size }

pub fn GeointersectsegmentCursor::get(self : GeointersectsegmentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentCursor::set(self : GeointersectsegmentCursor, i : Int, v : Double) -> GeointersectsegmentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCursor::sum(self : GeointersectsegmentCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentCursor::mean(self : GeointersectsegmentCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentCursor::scale(self : GeointersectsegmentCursor, f : Double) -> GeointersectsegmentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCursor::add(self : GeointersectsegmentCursor, other : GeointersectsegmentCursor) -> GeointersectsegmentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentCursor::copy(self : GeointersectsegmentCursor) -> GeointersectsegmentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCursor::fill(self : GeointersectsegmentCursor, v : Double) -> GeointersectsegmentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentCursor::min(self : GeointersectsegmentCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentCursor::max(self : GeointersectsegmentCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentCursor::to_string(self : GeointersectsegmentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_view_make(size : Int) -> GeointersectsegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentView::len(self : GeointersectsegmentView) -> Int { self.size }

pub fn GeointersectsegmentView::get(self : GeointersectsegmentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentView::set(self : GeointersectsegmentView, i : Int, v : Double) -> GeointersectsegmentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentView::sum(self : GeointersectsegmentView) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentView::mean(self : GeointersectsegmentView) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentView::scale(self : GeointersectsegmentView, f : Double) -> GeointersectsegmentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentView::add(self : GeointersectsegmentView, other : GeointersectsegmentView) -> GeointersectsegmentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentView::copy(self : GeointersectsegmentView) -> GeointersectsegmentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentView::fill(self : GeointersectsegmentView, v : Double) -> GeointersectsegmentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentView::min(self : GeointersectsegmentView) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentView::max(self : GeointersectsegmentView) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentView::to_string(self : GeointersectsegmentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_range_make(size : Int) -> GeointersectsegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentRange::len(self : GeointersectsegmentRange) -> Int { self.size }

pub fn GeointersectsegmentRange::get(self : GeointersectsegmentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentRange::set(self : GeointersectsegmentRange, i : Int, v : Double) -> GeointersectsegmentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentRange::sum(self : GeointersectsegmentRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentRange::mean(self : GeointersectsegmentRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentRange::scale(self : GeointersectsegmentRange, f : Double) -> GeointersectsegmentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentRange::add(self : GeointersectsegmentRange, other : GeointersectsegmentRange) -> GeointersectsegmentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentRange::copy(self : GeointersectsegmentRange) -> GeointersectsegmentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentRange::fill(self : GeointersectsegmentRange, v : Double) -> GeointersectsegmentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentRange::min(self : GeointersectsegmentRange) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentRange::max(self : GeointersectsegmentRange) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentRange::to_string(self : GeointersectsegmentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_slice_make(size : Int) -> GeointersectsegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectsegmentSlice::len(self : GeointersectsegmentSlice) -> Int { self.size }

pub fn GeointersectsegmentSlice::get(self : GeointersectsegmentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectsegmentSlice::set(self : GeointersectsegmentSlice, i : Int, v : Double) -> GeointersectsegmentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentSlice::sum(self : GeointersectsegmentSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectsegmentSlice::mean(self : GeointersectsegmentSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectsegmentSlice::scale(self : GeointersectsegmentSlice, f : Double) -> GeointersectsegmentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentSlice::add(self : GeointersectsegmentSlice, other : GeointersectsegmentSlice) -> GeointersectsegmentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectsegmentSlice::copy(self : GeointersectsegmentSlice) -> GeointersectsegmentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentSlice::fill(self : GeointersectsegmentSlice, v : Double) -> GeointersectsegmentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectsegmentSlice::min(self : GeointersectsegmentSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectsegmentSlice::max(self : GeointersectsegmentSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectsegmentSlice::to_string(self : GeointersectsegmentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

