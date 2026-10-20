///===
/// extcore/opt_convex_line_search

pub(all) struct OptconvexlinesearchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_line_search_make_point(x : Double, y : Double) -> OptconvexlinesearchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_line_search_make_point3(x : Double, y : Double, z : Double) -> OptconvexlinesearchPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexlinesearchPoint::x(self : OptconvexlinesearchPoint) -> Double { self.x }

pub fn OptconvexlinesearchPoint::y(self : OptconvexlinesearchPoint) -> Double { self.y }

pub fn OptconvexlinesearchPoint::z(self : OptconvexlinesearchPoint) -> Double { self.z }

pub fn OptconvexlinesearchPoint::label(self : OptconvexlinesearchPoint) -> Int { self.label }

pub fn OptconvexlinesearchPoint::dist(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexlinesearchPoint::add(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexlinesearchPoint::sub(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexlinesearchPoint::scale(self : OptconvexlinesearchPoint, s : Double) -> OptconvexlinesearchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexlinesearchPoint::dot(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexlinesearchPoint::cross(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexlinesearchPoint::norm(self : OptconvexlinesearchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexlinesearchPoint::normalize(self : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlinesearchPoint::negate(self : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexlinesearchPoint::mid(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexlinesearchPoint::lerp(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint, t : Double) -> OptconvexlinesearchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexlinesearchPoint::to_string(self : OptconvexlinesearchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexlinesearchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_line_search_make_series(vals : Array[Double], name : String) -> OptconvexlinesearchSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexlinesearchSeries::len(self : OptconvexlinesearchSeries) -> Int { self.vals.length() }

pub fn OptconvexlinesearchSeries::sum(self : OptconvexlinesearchSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexlinesearchSeries::mean(self : OptconvexlinesearchSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexlinesearchSeries::min(self : OptconvexlinesearchSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexlinesearchSeries::max(self : OptconvexlinesearchSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexlinesearchSeries::range(self : OptconvexlinesearchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexlinesearchSeries::variance(self : OptconvexlinesearchSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexlinesearchSeries::std(self : OptconvexlinesearchSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexlinesearchSeries::median(self : OptconvexlinesearchSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexlinesearchSeries::scale(self : OptconvexlinesearchSeries, f : Double) -> OptconvexlinesearchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexlinesearchSeries::add(self : OptconvexlinesearchSeries, other : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexlinesearchSeries::sub(self : OptconvexlinesearchSeries, other : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexlinesearchSeries::normalize(self : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexlinesearchSeries::cumsum(self : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexlinesearchSeries::to_string(self : OptconvexlinesearchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlinesearchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_line_search_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlinesearchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_line_search_matrix_identity(n : Int) -> OptconvexlinesearchMatrix {
  let m = opt_convex_line_search_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexlinesearchMatrix::get(self : OptconvexlinesearchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexlinesearchMatrix::transpose(self : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  let result = opt_convex_line_search_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexlinesearchMatrix::add(self : OptconvexlinesearchMatrix, other : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_line_search_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexlinesearchMatrix::scale(self : OptconvexlinesearchMatrix, s : Double) -> OptconvexlinesearchMatrix {
  let result = opt_convex_line_search_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexlinesearchMatrix::multiply(self : OptconvexlinesearchMatrix, other : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  if self.cols != other.rows { return opt_convex_line_search_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_line_search_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvexlinesearchMatrix::trace(self : OptconvexlinesearchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexlinesearchMatrix::det(self : OptconvexlinesearchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexlinesearchMatrix::norm(self : OptconvexlinesearchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexlinesearchMatrix::to_string(self : OptconvexlinesearchMatrix) -> String {
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

pub(all) struct OptconvexlinesearchVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_line_search_make_vector(comps : Array[Double]) -> OptconvexlinesearchVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_line_search_vector_zero(dim : Int) -> OptconvexlinesearchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexlinesearchVector::add(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlinesearchVector::sub(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlinesearchVector::scale(self : OptconvexlinesearchVector, s : Double) -> OptconvexlinesearchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexlinesearchVector::dot(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexlinesearchVector::norm(self : OptconvexlinesearchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexlinesearchVector::normalize(self : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlinesearchVector::dist(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexlinesearchVector::to_string(self : OptconvexlinesearchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlinesearchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_frame_make(size : Int) -> OptconvexlinesearchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchFrame::len(self : OptconvexlinesearchFrame) -> Int { self.size }

pub fn OptconvexlinesearchFrame::get(self : OptconvexlinesearchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchFrame::set(self : OptconvexlinesearchFrame, i : Int, v : Double) -> OptconvexlinesearchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchFrame::sum(self : OptconvexlinesearchFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchFrame::mean(self : OptconvexlinesearchFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchFrame::scale(self : OptconvexlinesearchFrame, f : Double) -> OptconvexlinesearchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchFrame::add(self : OptconvexlinesearchFrame, other : OptconvexlinesearchFrame) -> OptconvexlinesearchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchFrame::copy(self : OptconvexlinesearchFrame) -> OptconvexlinesearchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchFrame::fill(self : OptconvexlinesearchFrame, v : Double) -> OptconvexlinesearchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchFrame::min(self : OptconvexlinesearchFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchFrame::max(self : OptconvexlinesearchFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchFrame::to_string(self : OptconvexlinesearchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_table_make(size : Int) -> OptconvexlinesearchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchTable::len(self : OptconvexlinesearchTable) -> Int { self.size }

pub fn OptconvexlinesearchTable::get(self : OptconvexlinesearchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchTable::set(self : OptconvexlinesearchTable, i : Int, v : Double) -> OptconvexlinesearchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchTable::sum(self : OptconvexlinesearchTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchTable::mean(self : OptconvexlinesearchTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchTable::scale(self : OptconvexlinesearchTable, f : Double) -> OptconvexlinesearchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchTable::add(self : OptconvexlinesearchTable, other : OptconvexlinesearchTable) -> OptconvexlinesearchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchTable::copy(self : OptconvexlinesearchTable) -> OptconvexlinesearchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchTable::fill(self : OptconvexlinesearchTable, v : Double) -> OptconvexlinesearchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchTable::min(self : OptconvexlinesearchTable) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchTable::max(self : OptconvexlinesearchTable) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchTable::to_string(self : OptconvexlinesearchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_graphn_make(size : Int) -> OptconvexlinesearchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchGraphN::len(self : OptconvexlinesearchGraphN) -> Int { self.size }

pub fn OptconvexlinesearchGraphN::get(self : OptconvexlinesearchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchGraphN::set(self : OptconvexlinesearchGraphN, i : Int, v : Double) -> OptconvexlinesearchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchGraphN::sum(self : OptconvexlinesearchGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchGraphN::mean(self : OptconvexlinesearchGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchGraphN::scale(self : OptconvexlinesearchGraphN, f : Double) -> OptconvexlinesearchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchGraphN::add(self : OptconvexlinesearchGraphN, other : OptconvexlinesearchGraphN) -> OptconvexlinesearchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchGraphN::copy(self : OptconvexlinesearchGraphN) -> OptconvexlinesearchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchGraphN::fill(self : OptconvexlinesearchGraphN, v : Double) -> OptconvexlinesearchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchGraphN::min(self : OptconvexlinesearchGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchGraphN::max(self : OptconvexlinesearchGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchGraphN::to_string(self : OptconvexlinesearchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_node_make(size : Int) -> OptconvexlinesearchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchNode::len(self : OptconvexlinesearchNode) -> Int { self.size }

pub fn OptconvexlinesearchNode::get(self : OptconvexlinesearchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchNode::set(self : OptconvexlinesearchNode, i : Int, v : Double) -> OptconvexlinesearchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchNode::sum(self : OptconvexlinesearchNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchNode::mean(self : OptconvexlinesearchNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchNode::scale(self : OptconvexlinesearchNode, f : Double) -> OptconvexlinesearchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchNode::add(self : OptconvexlinesearchNode, other : OptconvexlinesearchNode) -> OptconvexlinesearchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchNode::copy(self : OptconvexlinesearchNode) -> OptconvexlinesearchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchNode::fill(self : OptconvexlinesearchNode, v : Double) -> OptconvexlinesearchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchNode::min(self : OptconvexlinesearchNode) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchNode::max(self : OptconvexlinesearchNode) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchNode::to_string(self : OptconvexlinesearchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_edge_make(size : Int) -> OptconvexlinesearchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchEdge::len(self : OptconvexlinesearchEdge) -> Int { self.size }

pub fn OptconvexlinesearchEdge::get(self : OptconvexlinesearchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchEdge::set(self : OptconvexlinesearchEdge, i : Int, v : Double) -> OptconvexlinesearchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchEdge::sum(self : OptconvexlinesearchEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchEdge::mean(self : OptconvexlinesearchEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchEdge::scale(self : OptconvexlinesearchEdge, f : Double) -> OptconvexlinesearchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchEdge::add(self : OptconvexlinesearchEdge, other : OptconvexlinesearchEdge) -> OptconvexlinesearchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchEdge::copy(self : OptconvexlinesearchEdge) -> OptconvexlinesearchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchEdge::fill(self : OptconvexlinesearchEdge, v : Double) -> OptconvexlinesearchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchEdge::min(self : OptconvexlinesearchEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchEdge::max(self : OptconvexlinesearchEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchEdge::to_string(self : OptconvexlinesearchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_path_make(size : Int) -> OptconvexlinesearchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchPath::len(self : OptconvexlinesearchPath) -> Int { self.size }

pub fn OptconvexlinesearchPath::get(self : OptconvexlinesearchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchPath::set(self : OptconvexlinesearchPath, i : Int, v : Double) -> OptconvexlinesearchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchPath::sum(self : OptconvexlinesearchPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchPath::mean(self : OptconvexlinesearchPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchPath::scale(self : OptconvexlinesearchPath, f : Double) -> OptconvexlinesearchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchPath::add(self : OptconvexlinesearchPath, other : OptconvexlinesearchPath) -> OptconvexlinesearchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchPath::copy(self : OptconvexlinesearchPath) -> OptconvexlinesearchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchPath::fill(self : OptconvexlinesearchPath, v : Double) -> OptconvexlinesearchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchPath::min(self : OptconvexlinesearchPath) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchPath::max(self : OptconvexlinesearchPath) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchPath::to_string(self : OptconvexlinesearchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_cluster_make(size : Int) -> OptconvexlinesearchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchCluster::len(self : OptconvexlinesearchCluster) -> Int { self.size }

pub fn OptconvexlinesearchCluster::get(self : OptconvexlinesearchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchCluster::set(self : OptconvexlinesearchCluster, i : Int, v : Double) -> OptconvexlinesearchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCluster::sum(self : OptconvexlinesearchCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchCluster::mean(self : OptconvexlinesearchCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchCluster::scale(self : OptconvexlinesearchCluster, f : Double) -> OptconvexlinesearchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCluster::add(self : OptconvexlinesearchCluster, other : OptconvexlinesearchCluster) -> OptconvexlinesearchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchCluster::copy(self : OptconvexlinesearchCluster) -> OptconvexlinesearchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCluster::fill(self : OptconvexlinesearchCluster, v : Double) -> OptconvexlinesearchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCluster::min(self : OptconvexlinesearchCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchCluster::max(self : OptconvexlinesearchCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchCluster::to_string(self : OptconvexlinesearchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_model_make(size : Int) -> OptconvexlinesearchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchModel::len(self : OptconvexlinesearchModel) -> Int { self.size }

pub fn OptconvexlinesearchModel::get(self : OptconvexlinesearchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchModel::set(self : OptconvexlinesearchModel, i : Int, v : Double) -> OptconvexlinesearchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchModel::sum(self : OptconvexlinesearchModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchModel::mean(self : OptconvexlinesearchModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchModel::scale(self : OptconvexlinesearchModel, f : Double) -> OptconvexlinesearchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchModel::add(self : OptconvexlinesearchModel, other : OptconvexlinesearchModel) -> OptconvexlinesearchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchModel::copy(self : OptconvexlinesearchModel) -> OptconvexlinesearchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchModel::fill(self : OptconvexlinesearchModel, v : Double) -> OptconvexlinesearchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchModel::min(self : OptconvexlinesearchModel) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchModel::max(self : OptconvexlinesearchModel) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchModel::to_string(self : OptconvexlinesearchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_layer_make(size : Int) -> OptconvexlinesearchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchLayer::len(self : OptconvexlinesearchLayer) -> Int { self.size }

pub fn OptconvexlinesearchLayer::get(self : OptconvexlinesearchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchLayer::set(self : OptconvexlinesearchLayer, i : Int, v : Double) -> OptconvexlinesearchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchLayer::sum(self : OptconvexlinesearchLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchLayer::mean(self : OptconvexlinesearchLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchLayer::scale(self : OptconvexlinesearchLayer, f : Double) -> OptconvexlinesearchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchLayer::add(self : OptconvexlinesearchLayer, other : OptconvexlinesearchLayer) -> OptconvexlinesearchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchLayer::copy(self : OptconvexlinesearchLayer) -> OptconvexlinesearchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchLayer::fill(self : OptconvexlinesearchLayer, v : Double) -> OptconvexlinesearchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchLayer::min(self : OptconvexlinesearchLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchLayer::max(self : OptconvexlinesearchLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchLayer::to_string(self : OptconvexlinesearchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_buffer_make(size : Int) -> OptconvexlinesearchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchBuffer::len(self : OptconvexlinesearchBuffer) -> Int { self.size }

pub fn OptconvexlinesearchBuffer::get(self : OptconvexlinesearchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchBuffer::set(self : OptconvexlinesearchBuffer, i : Int, v : Double) -> OptconvexlinesearchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchBuffer::sum(self : OptconvexlinesearchBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchBuffer::mean(self : OptconvexlinesearchBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchBuffer::scale(self : OptconvexlinesearchBuffer, f : Double) -> OptconvexlinesearchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchBuffer::add(self : OptconvexlinesearchBuffer, other : OptconvexlinesearchBuffer) -> OptconvexlinesearchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchBuffer::copy(self : OptconvexlinesearchBuffer) -> OptconvexlinesearchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchBuffer::fill(self : OptconvexlinesearchBuffer, v : Double) -> OptconvexlinesearchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchBuffer::min(self : OptconvexlinesearchBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchBuffer::max(self : OptconvexlinesearchBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchBuffer::to_string(self : OptconvexlinesearchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_cursor_make(size : Int) -> OptconvexlinesearchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchCursor::len(self : OptconvexlinesearchCursor) -> Int { self.size }

pub fn OptconvexlinesearchCursor::get(self : OptconvexlinesearchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchCursor::set(self : OptconvexlinesearchCursor, i : Int, v : Double) -> OptconvexlinesearchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCursor::sum(self : OptconvexlinesearchCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchCursor::mean(self : OptconvexlinesearchCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchCursor::scale(self : OptconvexlinesearchCursor, f : Double) -> OptconvexlinesearchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCursor::add(self : OptconvexlinesearchCursor, other : OptconvexlinesearchCursor) -> OptconvexlinesearchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchCursor::copy(self : OptconvexlinesearchCursor) -> OptconvexlinesearchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCursor::fill(self : OptconvexlinesearchCursor, v : Double) -> OptconvexlinesearchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchCursor::min(self : OptconvexlinesearchCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchCursor::max(self : OptconvexlinesearchCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchCursor::to_string(self : OptconvexlinesearchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_view_make(size : Int) -> OptconvexlinesearchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchView::len(self : OptconvexlinesearchView) -> Int { self.size }

pub fn OptconvexlinesearchView::get(self : OptconvexlinesearchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchView::set(self : OptconvexlinesearchView, i : Int, v : Double) -> OptconvexlinesearchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchView::sum(self : OptconvexlinesearchView) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchView::mean(self : OptconvexlinesearchView) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchView::scale(self : OptconvexlinesearchView, f : Double) -> OptconvexlinesearchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchView::add(self : OptconvexlinesearchView, other : OptconvexlinesearchView) -> OptconvexlinesearchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchView::copy(self : OptconvexlinesearchView) -> OptconvexlinesearchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchView::fill(self : OptconvexlinesearchView, v : Double) -> OptconvexlinesearchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchView::min(self : OptconvexlinesearchView) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchView::max(self : OptconvexlinesearchView) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchView::to_string(self : OptconvexlinesearchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_range_make(size : Int) -> OptconvexlinesearchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchRange::len(self : OptconvexlinesearchRange) -> Int { self.size }

pub fn OptconvexlinesearchRange::get(self : OptconvexlinesearchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchRange::set(self : OptconvexlinesearchRange, i : Int, v : Double) -> OptconvexlinesearchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchRange::sum(self : OptconvexlinesearchRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchRange::mean(self : OptconvexlinesearchRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchRange::scale(self : OptconvexlinesearchRange, f : Double) -> OptconvexlinesearchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchRange::add(self : OptconvexlinesearchRange, other : OptconvexlinesearchRange) -> OptconvexlinesearchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchRange::copy(self : OptconvexlinesearchRange) -> OptconvexlinesearchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchRange::fill(self : OptconvexlinesearchRange, v : Double) -> OptconvexlinesearchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchRange::min(self : OptconvexlinesearchRange) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchRange::max(self : OptconvexlinesearchRange) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchRange::to_string(self : OptconvexlinesearchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_slice_make(size : Int) -> OptconvexlinesearchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlinesearchSlice::len(self : OptconvexlinesearchSlice) -> Int { self.size }

pub fn OptconvexlinesearchSlice::get(self : OptconvexlinesearchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlinesearchSlice::set(self : OptconvexlinesearchSlice, i : Int, v : Double) -> OptconvexlinesearchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchSlice::sum(self : OptconvexlinesearchSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexlinesearchSlice::mean(self : OptconvexlinesearchSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexlinesearchSlice::scale(self : OptconvexlinesearchSlice, f : Double) -> OptconvexlinesearchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchSlice::add(self : OptconvexlinesearchSlice, other : OptconvexlinesearchSlice) -> OptconvexlinesearchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlinesearchSlice::copy(self : OptconvexlinesearchSlice) -> OptconvexlinesearchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchSlice::fill(self : OptconvexlinesearchSlice, v : Double) -> OptconvexlinesearchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlinesearchSlice::min(self : OptconvexlinesearchSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexlinesearchSlice::max(self : OptconvexlinesearchSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexlinesearchSlice::to_string(self : OptconvexlinesearchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

