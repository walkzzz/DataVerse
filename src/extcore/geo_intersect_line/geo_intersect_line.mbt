///===
/// extcore/geo_intersect_line

pub(all) struct GeointersectlinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_line_make_point(x : Double, y : Double) -> GeointersectlinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_line_make_point3(x : Double, y : Double, z : Double) -> GeointersectlinePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectlinePoint::x(self : GeointersectlinePoint) -> Double { self.x }

pub fn GeointersectlinePoint::y(self : GeointersectlinePoint) -> Double { self.y }

pub fn GeointersectlinePoint::z(self : GeointersectlinePoint) -> Double { self.z }

pub fn GeointersectlinePoint::label(self : GeointersectlinePoint) -> Int { self.label }

pub fn GeointersectlinePoint::dist(self : GeointersectlinePoint, other : GeointersectlinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectlinePoint::add(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectlinePoint::sub(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectlinePoint::scale(self : GeointersectlinePoint, s : Double) -> GeointersectlinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectlinePoint::dot(self : GeointersectlinePoint, other : GeointersectlinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectlinePoint::cross(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectlinePoint::norm(self : GeointersectlinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectlinePoint::normalize(self : GeointersectlinePoint) -> GeointersectlinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectlinePoint::negate(self : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectlinePoint::mid(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectlinePoint::lerp(self : GeointersectlinePoint, other : GeointersectlinePoint, t : Double) -> GeointersectlinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectlinePoint::to_string(self : GeointersectlinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectlineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_line_make_series(vals : Array[Double], name : String) -> GeointersectlineSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectlineSeries::len(self : GeointersectlineSeries) -> Int { self.vals.length() }

pub fn GeointersectlineSeries::sum(self : GeointersectlineSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectlineSeries::mean(self : GeointersectlineSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectlineSeries::min(self : GeointersectlineSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectlineSeries::max(self : GeointersectlineSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectlineSeries::range(self : GeointersectlineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectlineSeries::variance(self : GeointersectlineSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectlineSeries::std(self : GeointersectlineSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectlineSeries::median(self : GeointersectlineSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectlineSeries::scale(self : GeointersectlineSeries, f : Double) -> GeointersectlineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectlineSeries::add(self : GeointersectlineSeries, other : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectlineSeries::sub(self : GeointersectlineSeries, other : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectlineSeries::normalize(self : GeointersectlineSeries) -> GeointersectlineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectlineSeries::cumsum(self : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectlineSeries::to_string(self : GeointersectlineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectlineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_line_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectlineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_line_matrix_identity(n : Int) -> GeointersectlineMatrix {
  let m = geo_intersect_line_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectlineMatrix::get(self : GeointersectlineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectlineMatrix::transpose(self : GeointersectlineMatrix) -> GeointersectlineMatrix {
  let result = geo_intersect_line_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectlineMatrix::add(self : GeointersectlineMatrix, other : GeointersectlineMatrix) -> GeointersectlineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectlineMatrix::scale(self : GeointersectlineMatrix, s : Double) -> GeointersectlineMatrix {
  let result = geo_intersect_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectlineMatrix::multiply(self : GeointersectlineMatrix, other : GeointersectlineMatrix) -> GeointersectlineMatrix {
  if self.cols != other.rows { return geo_intersect_line_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_line_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectlineMatrix::trace(self : GeointersectlineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectlineMatrix::det(self : GeointersectlineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectlineMatrix::norm(self : GeointersectlineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectlineMatrix::to_string(self : GeointersectlineMatrix) -> String {
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

pub(all) struct GeointersectlineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_line_make_vector(comps : Array[Double]) -> GeointersectlineVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_line_vector_zero(dim : Int) -> GeointersectlineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectlineVector::add(self : GeointersectlineVector, other : GeointersectlineVector) -> GeointersectlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectlineVector::sub(self : GeointersectlineVector, other : GeointersectlineVector) -> GeointersectlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectlineVector::scale(self : GeointersectlineVector, s : Double) -> GeointersectlineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectlineVector::dot(self : GeointersectlineVector, other : GeointersectlineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectlineVector::norm(self : GeointersectlineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectlineVector::normalize(self : GeointersectlineVector) -> GeointersectlineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectlineVector::dist(self : GeointersectlineVector, other : GeointersectlineVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectlineVector::to_string(self : GeointersectlineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectlineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_frame_make(size : Int) -> GeointersectlineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineFrame::len(self : GeointersectlineFrame) -> Int { self.size }

pub fn GeointersectlineFrame::get(self : GeointersectlineFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineFrame::set(self : GeointersectlineFrame, i : Int, v : Double) -> GeointersectlineFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineFrame::sum(self : GeointersectlineFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineFrame::mean(self : GeointersectlineFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineFrame::scale(self : GeointersectlineFrame, f : Double) -> GeointersectlineFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineFrame::add(self : GeointersectlineFrame, other : GeointersectlineFrame) -> GeointersectlineFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineFrame::copy(self : GeointersectlineFrame) -> GeointersectlineFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineFrame::fill(self : GeointersectlineFrame, v : Double) -> GeointersectlineFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineFrame::min(self : GeointersectlineFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectlineFrame::max(self : GeointersectlineFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectlineFrame::to_string(self : GeointersectlineFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_table_make(size : Int) -> GeointersectlineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineTable::len(self : GeointersectlineTable) -> Int { self.size }

pub fn GeointersectlineTable::get(self : GeointersectlineTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineTable::set(self : GeointersectlineTable, i : Int, v : Double) -> GeointersectlineTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineTable::sum(self : GeointersectlineTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineTable::mean(self : GeointersectlineTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineTable::scale(self : GeointersectlineTable, f : Double) -> GeointersectlineTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineTable::add(self : GeointersectlineTable, other : GeointersectlineTable) -> GeointersectlineTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineTable::copy(self : GeointersectlineTable) -> GeointersectlineTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineTable::fill(self : GeointersectlineTable, v : Double) -> GeointersectlineTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineTable::min(self : GeointersectlineTable) -> Double { @_common.min(self.data) }

pub fn GeointersectlineTable::max(self : GeointersectlineTable) -> Double { @_common.max(self.data) }

pub fn GeointersectlineTable::to_string(self : GeointersectlineTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_graphn_make(size : Int) -> GeointersectlineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineGraphN::len(self : GeointersectlineGraphN) -> Int { self.size }

pub fn GeointersectlineGraphN::get(self : GeointersectlineGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineGraphN::set(self : GeointersectlineGraphN, i : Int, v : Double) -> GeointersectlineGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineGraphN::sum(self : GeointersectlineGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineGraphN::mean(self : GeointersectlineGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineGraphN::scale(self : GeointersectlineGraphN, f : Double) -> GeointersectlineGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineGraphN::add(self : GeointersectlineGraphN, other : GeointersectlineGraphN) -> GeointersectlineGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineGraphN::copy(self : GeointersectlineGraphN) -> GeointersectlineGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineGraphN::fill(self : GeointersectlineGraphN, v : Double) -> GeointersectlineGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineGraphN::min(self : GeointersectlineGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectlineGraphN::max(self : GeointersectlineGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectlineGraphN::to_string(self : GeointersectlineGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_node_make(size : Int) -> GeointersectlineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineNode::len(self : GeointersectlineNode) -> Int { self.size }

pub fn GeointersectlineNode::get(self : GeointersectlineNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineNode::set(self : GeointersectlineNode, i : Int, v : Double) -> GeointersectlineNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineNode::sum(self : GeointersectlineNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineNode::mean(self : GeointersectlineNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineNode::scale(self : GeointersectlineNode, f : Double) -> GeointersectlineNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineNode::add(self : GeointersectlineNode, other : GeointersectlineNode) -> GeointersectlineNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineNode::copy(self : GeointersectlineNode) -> GeointersectlineNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineNode::fill(self : GeointersectlineNode, v : Double) -> GeointersectlineNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineNode::min(self : GeointersectlineNode) -> Double { @_common.min(self.data) }

pub fn GeointersectlineNode::max(self : GeointersectlineNode) -> Double { @_common.max(self.data) }

pub fn GeointersectlineNode::to_string(self : GeointersectlineNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_edge_make(size : Int) -> GeointersectlineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineEdge::len(self : GeointersectlineEdge) -> Int { self.size }

pub fn GeointersectlineEdge::get(self : GeointersectlineEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineEdge::set(self : GeointersectlineEdge, i : Int, v : Double) -> GeointersectlineEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineEdge::sum(self : GeointersectlineEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineEdge::mean(self : GeointersectlineEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineEdge::scale(self : GeointersectlineEdge, f : Double) -> GeointersectlineEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineEdge::add(self : GeointersectlineEdge, other : GeointersectlineEdge) -> GeointersectlineEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineEdge::copy(self : GeointersectlineEdge) -> GeointersectlineEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineEdge::fill(self : GeointersectlineEdge, v : Double) -> GeointersectlineEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineEdge::min(self : GeointersectlineEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectlineEdge::max(self : GeointersectlineEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectlineEdge::to_string(self : GeointersectlineEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_path_make(size : Int) -> GeointersectlinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlinePath::len(self : GeointersectlinePath) -> Int { self.size }

pub fn GeointersectlinePath::get(self : GeointersectlinePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlinePath::set(self : GeointersectlinePath, i : Int, v : Double) -> GeointersectlinePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlinePath::sum(self : GeointersectlinePath) -> Double { @_common.sum(self.data) }

pub fn GeointersectlinePath::mean(self : GeointersectlinePath) -> Double { @_common.mean(self.data) }

pub fn GeointersectlinePath::scale(self : GeointersectlinePath, f : Double) -> GeointersectlinePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlinePath::add(self : GeointersectlinePath, other : GeointersectlinePath) -> GeointersectlinePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlinePath::copy(self : GeointersectlinePath) -> GeointersectlinePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlinePath::fill(self : GeointersectlinePath, v : Double) -> GeointersectlinePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlinePath::min(self : GeointersectlinePath) -> Double { @_common.min(self.data) }

pub fn GeointersectlinePath::max(self : GeointersectlinePath) -> Double { @_common.max(self.data) }

pub fn GeointersectlinePath::to_string(self : GeointersectlinePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_cluster_make(size : Int) -> GeointersectlineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineCluster::len(self : GeointersectlineCluster) -> Int { self.size }

pub fn GeointersectlineCluster::get(self : GeointersectlineCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineCluster::set(self : GeointersectlineCluster, i : Int, v : Double) -> GeointersectlineCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineCluster::sum(self : GeointersectlineCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineCluster::mean(self : GeointersectlineCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineCluster::scale(self : GeointersectlineCluster, f : Double) -> GeointersectlineCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineCluster::add(self : GeointersectlineCluster, other : GeointersectlineCluster) -> GeointersectlineCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineCluster::copy(self : GeointersectlineCluster) -> GeointersectlineCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineCluster::fill(self : GeointersectlineCluster, v : Double) -> GeointersectlineCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineCluster::min(self : GeointersectlineCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectlineCluster::max(self : GeointersectlineCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectlineCluster::to_string(self : GeointersectlineCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_model_make(size : Int) -> GeointersectlineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineModel::len(self : GeointersectlineModel) -> Int { self.size }

pub fn GeointersectlineModel::get(self : GeointersectlineModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineModel::set(self : GeointersectlineModel, i : Int, v : Double) -> GeointersectlineModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineModel::sum(self : GeointersectlineModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineModel::mean(self : GeointersectlineModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineModel::scale(self : GeointersectlineModel, f : Double) -> GeointersectlineModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineModel::add(self : GeointersectlineModel, other : GeointersectlineModel) -> GeointersectlineModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineModel::copy(self : GeointersectlineModel) -> GeointersectlineModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineModel::fill(self : GeointersectlineModel, v : Double) -> GeointersectlineModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineModel::min(self : GeointersectlineModel) -> Double { @_common.min(self.data) }

pub fn GeointersectlineModel::max(self : GeointersectlineModel) -> Double { @_common.max(self.data) }

pub fn GeointersectlineModel::to_string(self : GeointersectlineModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_layer_make(size : Int) -> GeointersectlineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineLayer::len(self : GeointersectlineLayer) -> Int { self.size }

pub fn GeointersectlineLayer::get(self : GeointersectlineLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineLayer::set(self : GeointersectlineLayer, i : Int, v : Double) -> GeointersectlineLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineLayer::sum(self : GeointersectlineLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineLayer::mean(self : GeointersectlineLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineLayer::scale(self : GeointersectlineLayer, f : Double) -> GeointersectlineLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineLayer::add(self : GeointersectlineLayer, other : GeointersectlineLayer) -> GeointersectlineLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineLayer::copy(self : GeointersectlineLayer) -> GeointersectlineLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineLayer::fill(self : GeointersectlineLayer, v : Double) -> GeointersectlineLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineLayer::min(self : GeointersectlineLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectlineLayer::max(self : GeointersectlineLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectlineLayer::to_string(self : GeointersectlineLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_buffer_make(size : Int) -> GeointersectlineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineBuffer::len(self : GeointersectlineBuffer) -> Int { self.size }

pub fn GeointersectlineBuffer::get(self : GeointersectlineBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineBuffer::set(self : GeointersectlineBuffer, i : Int, v : Double) -> GeointersectlineBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineBuffer::sum(self : GeointersectlineBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineBuffer::mean(self : GeointersectlineBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineBuffer::scale(self : GeointersectlineBuffer, f : Double) -> GeointersectlineBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineBuffer::add(self : GeointersectlineBuffer, other : GeointersectlineBuffer) -> GeointersectlineBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineBuffer::copy(self : GeointersectlineBuffer) -> GeointersectlineBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineBuffer::fill(self : GeointersectlineBuffer, v : Double) -> GeointersectlineBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineBuffer::min(self : GeointersectlineBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectlineBuffer::max(self : GeointersectlineBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectlineBuffer::to_string(self : GeointersectlineBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_cursor_make(size : Int) -> GeointersectlineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineCursor::len(self : GeointersectlineCursor) -> Int { self.size }

pub fn GeointersectlineCursor::get(self : GeointersectlineCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineCursor::set(self : GeointersectlineCursor, i : Int, v : Double) -> GeointersectlineCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineCursor::sum(self : GeointersectlineCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineCursor::mean(self : GeointersectlineCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineCursor::scale(self : GeointersectlineCursor, f : Double) -> GeointersectlineCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineCursor::add(self : GeointersectlineCursor, other : GeointersectlineCursor) -> GeointersectlineCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineCursor::copy(self : GeointersectlineCursor) -> GeointersectlineCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineCursor::fill(self : GeointersectlineCursor, v : Double) -> GeointersectlineCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineCursor::min(self : GeointersectlineCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectlineCursor::max(self : GeointersectlineCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectlineCursor::to_string(self : GeointersectlineCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_view_make(size : Int) -> GeointersectlineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineView::len(self : GeointersectlineView) -> Int { self.size }

pub fn GeointersectlineView::get(self : GeointersectlineView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineView::set(self : GeointersectlineView, i : Int, v : Double) -> GeointersectlineView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineView::sum(self : GeointersectlineView) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineView::mean(self : GeointersectlineView) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineView::scale(self : GeointersectlineView, f : Double) -> GeointersectlineView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineView::add(self : GeointersectlineView, other : GeointersectlineView) -> GeointersectlineView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineView::copy(self : GeointersectlineView) -> GeointersectlineView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineView::fill(self : GeointersectlineView, v : Double) -> GeointersectlineView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineView::min(self : GeointersectlineView) -> Double { @_common.min(self.data) }

pub fn GeointersectlineView::max(self : GeointersectlineView) -> Double { @_common.max(self.data) }

pub fn GeointersectlineView::to_string(self : GeointersectlineView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_range_make(size : Int) -> GeointersectlineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineRange::len(self : GeointersectlineRange) -> Int { self.size }

pub fn GeointersectlineRange::get(self : GeointersectlineRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineRange::set(self : GeointersectlineRange, i : Int, v : Double) -> GeointersectlineRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineRange::sum(self : GeointersectlineRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineRange::mean(self : GeointersectlineRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineRange::scale(self : GeointersectlineRange, f : Double) -> GeointersectlineRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineRange::add(self : GeointersectlineRange, other : GeointersectlineRange) -> GeointersectlineRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineRange::copy(self : GeointersectlineRange) -> GeointersectlineRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineRange::fill(self : GeointersectlineRange, v : Double) -> GeointersectlineRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineRange::min(self : GeointersectlineRange) -> Double { @_common.min(self.data) }

pub fn GeointersectlineRange::max(self : GeointersectlineRange) -> Double { @_common.max(self.data) }

pub fn GeointersectlineRange::to_string(self : GeointersectlineRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectlineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_slice_make(size : Int) -> GeointersectlineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectlineSlice::len(self : GeointersectlineSlice) -> Int { self.size }

pub fn GeointersectlineSlice::get(self : GeointersectlineSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectlineSlice::set(self : GeointersectlineSlice, i : Int, v : Double) -> GeointersectlineSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectlineSlice::sum(self : GeointersectlineSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectlineSlice::mean(self : GeointersectlineSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectlineSlice::scale(self : GeointersectlineSlice, f : Double) -> GeointersectlineSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectlineSlice::add(self : GeointersectlineSlice, other : GeointersectlineSlice) -> GeointersectlineSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectlineSlice::copy(self : GeointersectlineSlice) -> GeointersectlineSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectlineSlice::fill(self : GeointersectlineSlice, v : Double) -> GeointersectlineSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectlineSlice::min(self : GeointersectlineSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectlineSlice::max(self : GeointersectlineSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectlineSlice::to_string(self : GeointersectlineSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

