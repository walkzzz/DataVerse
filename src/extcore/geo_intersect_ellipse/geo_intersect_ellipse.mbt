///===
/// extcore/geo_intersect_ellipse

pub(all) struct GeointersectellipsePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_ellipse_make_point(x : Double, y : Double) -> GeointersectellipsePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_ellipse_make_point3(x : Double, y : Double, z : Double) -> GeointersectellipsePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectellipsePoint::x(self : GeointersectellipsePoint) -> Double { self.x }

pub fn GeointersectellipsePoint::y(self : GeointersectellipsePoint) -> Double { self.y }

pub fn GeointersectellipsePoint::z(self : GeointersectellipsePoint) -> Double { self.z }

pub fn GeointersectellipsePoint::label(self : GeointersectellipsePoint) -> Int { self.label }

pub fn GeointersectellipsePoint::dist(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectellipsePoint::add(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectellipsePoint::sub(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectellipsePoint::scale(self : GeointersectellipsePoint, s : Double) -> GeointersectellipsePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectellipsePoint::dot(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectellipsePoint::cross(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectellipsePoint::norm(self : GeointersectellipsePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectellipsePoint::normalize(self : GeointersectellipsePoint) -> GeointersectellipsePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectellipsePoint::negate(self : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectellipsePoint::mid(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectellipsePoint::lerp(self : GeointersectellipsePoint, other : GeointersectellipsePoint, t : Double) -> GeointersectellipsePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectellipsePoint::to_string(self : GeointersectellipsePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectellipseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_ellipse_make_series(vals : Array[Double], name : String) -> GeointersectellipseSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectellipseSeries::len(self : GeointersectellipseSeries) -> Int { self.vals.length() }

pub fn GeointersectellipseSeries::sum(self : GeointersectellipseSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectellipseSeries::mean(self : GeointersectellipseSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectellipseSeries::min(self : GeointersectellipseSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectellipseSeries::max(self : GeointersectellipseSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectellipseSeries::range(self : GeointersectellipseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectellipseSeries::variance(self : GeointersectellipseSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectellipseSeries::std(self : GeointersectellipseSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectellipseSeries::median(self : GeointersectellipseSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectellipseSeries::scale(self : GeointersectellipseSeries, f : Double) -> GeointersectellipseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectellipseSeries::add(self : GeointersectellipseSeries, other : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectellipseSeries::sub(self : GeointersectellipseSeries, other : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectellipseSeries::normalize(self : GeointersectellipseSeries) -> GeointersectellipseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectellipseSeries::cumsum(self : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectellipseSeries::to_string(self : GeointersectellipseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectellipseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_ellipse_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectellipseMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_intersect_ellipse_matrix_identity(n : Int) -> GeointersectellipseMatrix {
  let m = geo_intersect_ellipse_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectellipseMatrix::get(self : GeointersectellipseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectellipseMatrix::transpose(self : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  let result = geo_intersect_ellipse_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectellipseMatrix::add(self : GeointersectellipseMatrix, other : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectellipseMatrix::scale(self : GeointersectellipseMatrix, s : Double) -> GeointersectellipseMatrix {
  let result = geo_intersect_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectellipseMatrix::multiply(self : GeointersectellipseMatrix, other : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  if self.cols != other.rows { return geo_intersect_ellipse_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_ellipse_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeointersectellipseMatrix::trace(self : GeointersectellipseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectellipseMatrix::det(self : GeointersectellipseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectellipseMatrix::norm(self : GeointersectellipseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectellipseMatrix::to_string(self : GeointersectellipseMatrix) -> String {
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

pub(all) struct GeointersectellipseVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_ellipse_make_vector(comps : Array[Double]) -> GeointersectellipseVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_ellipse_vector_zero(dim : Int) -> GeointersectellipseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectellipseVector::add(self : GeointersectellipseVector, other : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectellipseVector::sub(self : GeointersectellipseVector, other : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectellipseVector::scale(self : GeointersectellipseVector, s : Double) -> GeointersectellipseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectellipseVector::dot(self : GeointersectellipseVector, other : GeointersectellipseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectellipseVector::norm(self : GeointersectellipseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectellipseVector::normalize(self : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectellipseVector::dist(self : GeointersectellipseVector, other : GeointersectellipseVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectellipseVector::to_string(self : GeointersectellipseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectellipseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_frame_make(size : Int) -> GeointersectellipseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseFrame::len(self : GeointersectellipseFrame) -> Int { self.size }

pub fn GeointersectellipseFrame::get(self : GeointersectellipseFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseFrame::set(self : GeointersectellipseFrame, i : Int, v : Double) -> GeointersectellipseFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseFrame::sum(self : GeointersectellipseFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseFrame::mean(self : GeointersectellipseFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseFrame::scale(self : GeointersectellipseFrame, f : Double) -> GeointersectellipseFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseFrame::add(self : GeointersectellipseFrame, other : GeointersectellipseFrame) -> GeointersectellipseFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseFrame::copy(self : GeointersectellipseFrame) -> GeointersectellipseFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseFrame::fill(self : GeointersectellipseFrame, v : Double) -> GeointersectellipseFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseFrame::min(self : GeointersectellipseFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseFrame::max(self : GeointersectellipseFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseFrame::to_string(self : GeointersectellipseFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_table_make(size : Int) -> GeointersectellipseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseTable::len(self : GeointersectellipseTable) -> Int { self.size }

pub fn GeointersectellipseTable::get(self : GeointersectellipseTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseTable::set(self : GeointersectellipseTable, i : Int, v : Double) -> GeointersectellipseTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseTable::sum(self : GeointersectellipseTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseTable::mean(self : GeointersectellipseTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseTable::scale(self : GeointersectellipseTable, f : Double) -> GeointersectellipseTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseTable::add(self : GeointersectellipseTable, other : GeointersectellipseTable) -> GeointersectellipseTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseTable::copy(self : GeointersectellipseTable) -> GeointersectellipseTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseTable::fill(self : GeointersectellipseTable, v : Double) -> GeointersectellipseTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseTable::min(self : GeointersectellipseTable) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseTable::max(self : GeointersectellipseTable) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseTable::to_string(self : GeointersectellipseTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_graphn_make(size : Int) -> GeointersectellipseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseGraphN::len(self : GeointersectellipseGraphN) -> Int { self.size }

pub fn GeointersectellipseGraphN::get(self : GeointersectellipseGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseGraphN::set(self : GeointersectellipseGraphN, i : Int, v : Double) -> GeointersectellipseGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseGraphN::sum(self : GeointersectellipseGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseGraphN::mean(self : GeointersectellipseGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseGraphN::scale(self : GeointersectellipseGraphN, f : Double) -> GeointersectellipseGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseGraphN::add(self : GeointersectellipseGraphN, other : GeointersectellipseGraphN) -> GeointersectellipseGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseGraphN::copy(self : GeointersectellipseGraphN) -> GeointersectellipseGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseGraphN::fill(self : GeointersectellipseGraphN, v : Double) -> GeointersectellipseGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseGraphN::min(self : GeointersectellipseGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseGraphN::max(self : GeointersectellipseGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseGraphN::to_string(self : GeointersectellipseGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_node_make(size : Int) -> GeointersectellipseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseNode::len(self : GeointersectellipseNode) -> Int { self.size }

pub fn GeointersectellipseNode::get(self : GeointersectellipseNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseNode::set(self : GeointersectellipseNode, i : Int, v : Double) -> GeointersectellipseNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseNode::sum(self : GeointersectellipseNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseNode::mean(self : GeointersectellipseNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseNode::scale(self : GeointersectellipseNode, f : Double) -> GeointersectellipseNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseNode::add(self : GeointersectellipseNode, other : GeointersectellipseNode) -> GeointersectellipseNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseNode::copy(self : GeointersectellipseNode) -> GeointersectellipseNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseNode::fill(self : GeointersectellipseNode, v : Double) -> GeointersectellipseNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseNode::min(self : GeointersectellipseNode) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseNode::max(self : GeointersectellipseNode) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseNode::to_string(self : GeointersectellipseNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_edge_make(size : Int) -> GeointersectellipseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseEdge::len(self : GeointersectellipseEdge) -> Int { self.size }

pub fn GeointersectellipseEdge::get(self : GeointersectellipseEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseEdge::set(self : GeointersectellipseEdge, i : Int, v : Double) -> GeointersectellipseEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseEdge::sum(self : GeointersectellipseEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseEdge::mean(self : GeointersectellipseEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseEdge::scale(self : GeointersectellipseEdge, f : Double) -> GeointersectellipseEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseEdge::add(self : GeointersectellipseEdge, other : GeointersectellipseEdge) -> GeointersectellipseEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseEdge::copy(self : GeointersectellipseEdge) -> GeointersectellipseEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseEdge::fill(self : GeointersectellipseEdge, v : Double) -> GeointersectellipseEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseEdge::min(self : GeointersectellipseEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseEdge::max(self : GeointersectellipseEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseEdge::to_string(self : GeointersectellipseEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipsePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_path_make(size : Int) -> GeointersectellipsePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipsePath::len(self : GeointersectellipsePath) -> Int { self.size }

pub fn GeointersectellipsePath::get(self : GeointersectellipsePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipsePath::set(self : GeointersectellipsePath, i : Int, v : Double) -> GeointersectellipsePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipsePath::sum(self : GeointersectellipsePath) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipsePath::mean(self : GeointersectellipsePath) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipsePath::scale(self : GeointersectellipsePath, f : Double) -> GeointersectellipsePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipsePath::add(self : GeointersectellipsePath, other : GeointersectellipsePath) -> GeointersectellipsePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipsePath::copy(self : GeointersectellipsePath) -> GeointersectellipsePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipsePath::fill(self : GeointersectellipsePath, v : Double) -> GeointersectellipsePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipsePath::min(self : GeointersectellipsePath) -> Double { @_common.min(self.data) }

pub fn GeointersectellipsePath::max(self : GeointersectellipsePath) -> Double { @_common.max(self.data) }

pub fn GeointersectellipsePath::to_string(self : GeointersectellipsePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_cluster_make(size : Int) -> GeointersectellipseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseCluster::len(self : GeointersectellipseCluster) -> Int { self.size }

pub fn GeointersectellipseCluster::get(self : GeointersectellipseCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseCluster::set(self : GeointersectellipseCluster, i : Int, v : Double) -> GeointersectellipseCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCluster::sum(self : GeointersectellipseCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseCluster::mean(self : GeointersectellipseCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseCluster::scale(self : GeointersectellipseCluster, f : Double) -> GeointersectellipseCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCluster::add(self : GeointersectellipseCluster, other : GeointersectellipseCluster) -> GeointersectellipseCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseCluster::copy(self : GeointersectellipseCluster) -> GeointersectellipseCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCluster::fill(self : GeointersectellipseCluster, v : Double) -> GeointersectellipseCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCluster::min(self : GeointersectellipseCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseCluster::max(self : GeointersectellipseCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseCluster::to_string(self : GeointersectellipseCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_model_make(size : Int) -> GeointersectellipseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseModel::len(self : GeointersectellipseModel) -> Int { self.size }

pub fn GeointersectellipseModel::get(self : GeointersectellipseModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseModel::set(self : GeointersectellipseModel, i : Int, v : Double) -> GeointersectellipseModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseModel::sum(self : GeointersectellipseModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseModel::mean(self : GeointersectellipseModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseModel::scale(self : GeointersectellipseModel, f : Double) -> GeointersectellipseModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseModel::add(self : GeointersectellipseModel, other : GeointersectellipseModel) -> GeointersectellipseModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseModel::copy(self : GeointersectellipseModel) -> GeointersectellipseModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseModel::fill(self : GeointersectellipseModel, v : Double) -> GeointersectellipseModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseModel::min(self : GeointersectellipseModel) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseModel::max(self : GeointersectellipseModel) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseModel::to_string(self : GeointersectellipseModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_layer_make(size : Int) -> GeointersectellipseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseLayer::len(self : GeointersectellipseLayer) -> Int { self.size }

pub fn GeointersectellipseLayer::get(self : GeointersectellipseLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseLayer::set(self : GeointersectellipseLayer, i : Int, v : Double) -> GeointersectellipseLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseLayer::sum(self : GeointersectellipseLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseLayer::mean(self : GeointersectellipseLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseLayer::scale(self : GeointersectellipseLayer, f : Double) -> GeointersectellipseLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseLayer::add(self : GeointersectellipseLayer, other : GeointersectellipseLayer) -> GeointersectellipseLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseLayer::copy(self : GeointersectellipseLayer) -> GeointersectellipseLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseLayer::fill(self : GeointersectellipseLayer, v : Double) -> GeointersectellipseLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseLayer::min(self : GeointersectellipseLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseLayer::max(self : GeointersectellipseLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseLayer::to_string(self : GeointersectellipseLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_buffer_make(size : Int) -> GeointersectellipseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseBuffer::len(self : GeointersectellipseBuffer) -> Int { self.size }

pub fn GeointersectellipseBuffer::get(self : GeointersectellipseBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseBuffer::set(self : GeointersectellipseBuffer, i : Int, v : Double) -> GeointersectellipseBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseBuffer::sum(self : GeointersectellipseBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseBuffer::mean(self : GeointersectellipseBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseBuffer::scale(self : GeointersectellipseBuffer, f : Double) -> GeointersectellipseBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseBuffer::add(self : GeointersectellipseBuffer, other : GeointersectellipseBuffer) -> GeointersectellipseBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseBuffer::copy(self : GeointersectellipseBuffer) -> GeointersectellipseBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseBuffer::fill(self : GeointersectellipseBuffer, v : Double) -> GeointersectellipseBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseBuffer::min(self : GeointersectellipseBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseBuffer::max(self : GeointersectellipseBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseBuffer::to_string(self : GeointersectellipseBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_cursor_make(size : Int) -> GeointersectellipseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseCursor::len(self : GeointersectellipseCursor) -> Int { self.size }

pub fn GeointersectellipseCursor::get(self : GeointersectellipseCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseCursor::set(self : GeointersectellipseCursor, i : Int, v : Double) -> GeointersectellipseCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCursor::sum(self : GeointersectellipseCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseCursor::mean(self : GeointersectellipseCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseCursor::scale(self : GeointersectellipseCursor, f : Double) -> GeointersectellipseCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCursor::add(self : GeointersectellipseCursor, other : GeointersectellipseCursor) -> GeointersectellipseCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseCursor::copy(self : GeointersectellipseCursor) -> GeointersectellipseCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCursor::fill(self : GeointersectellipseCursor, v : Double) -> GeointersectellipseCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseCursor::min(self : GeointersectellipseCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseCursor::max(self : GeointersectellipseCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseCursor::to_string(self : GeointersectellipseCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_view_make(size : Int) -> GeointersectellipseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseView::len(self : GeointersectellipseView) -> Int { self.size }

pub fn GeointersectellipseView::get(self : GeointersectellipseView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseView::set(self : GeointersectellipseView, i : Int, v : Double) -> GeointersectellipseView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseView::sum(self : GeointersectellipseView) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseView::mean(self : GeointersectellipseView) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseView::scale(self : GeointersectellipseView, f : Double) -> GeointersectellipseView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseView::add(self : GeointersectellipseView, other : GeointersectellipseView) -> GeointersectellipseView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseView::copy(self : GeointersectellipseView) -> GeointersectellipseView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseView::fill(self : GeointersectellipseView, v : Double) -> GeointersectellipseView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseView::min(self : GeointersectellipseView) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseView::max(self : GeointersectellipseView) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseView::to_string(self : GeointersectellipseView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_range_make(size : Int) -> GeointersectellipseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseRange::len(self : GeointersectellipseRange) -> Int { self.size }

pub fn GeointersectellipseRange::get(self : GeointersectellipseRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseRange::set(self : GeointersectellipseRange, i : Int, v : Double) -> GeointersectellipseRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseRange::sum(self : GeointersectellipseRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseRange::mean(self : GeointersectellipseRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseRange::scale(self : GeointersectellipseRange, f : Double) -> GeointersectellipseRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseRange::add(self : GeointersectellipseRange, other : GeointersectellipseRange) -> GeointersectellipseRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseRange::copy(self : GeointersectellipseRange) -> GeointersectellipseRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseRange::fill(self : GeointersectellipseRange, v : Double) -> GeointersectellipseRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseRange::min(self : GeointersectellipseRange) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseRange::max(self : GeointersectellipseRange) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseRange::to_string(self : GeointersectellipseRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_slice_make(size : Int) -> GeointersectellipseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectellipseSlice::len(self : GeointersectellipseSlice) -> Int { self.size }

pub fn GeointersectellipseSlice::get(self : GeointersectellipseSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectellipseSlice::set(self : GeointersectellipseSlice, i : Int, v : Double) -> GeointersectellipseSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectellipseSlice::sum(self : GeointersectellipseSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectellipseSlice::mean(self : GeointersectellipseSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectellipseSlice::scale(self : GeointersectellipseSlice, f : Double) -> GeointersectellipseSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseSlice::add(self : GeointersectellipseSlice, other : GeointersectellipseSlice) -> GeointersectellipseSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectellipseSlice::copy(self : GeointersectellipseSlice) -> GeointersectellipseSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseSlice::fill(self : GeointersectellipseSlice, v : Double) -> GeointersectellipseSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectellipseSlice::min(self : GeointersectellipseSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectellipseSlice::max(self : GeointersectellipseSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectellipseSlice::to_string(self : GeointersectellipseSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

