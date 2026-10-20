///===
/// extcore/opt_convex_dfp

pub(all) struct OptconvexdfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_dfp_make_point(x : Double, y : Double) -> OptconvexdfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_dfp_make_point3(x : Double, y : Double, z : Double) -> OptconvexdfpPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexdfpPoint::x(self : OptconvexdfpPoint) -> Double { self.x }

pub fn OptconvexdfpPoint::y(self : OptconvexdfpPoint) -> Double { self.y }

pub fn OptconvexdfpPoint::z(self : OptconvexdfpPoint) -> Double { self.z }

pub fn OptconvexdfpPoint::label(self : OptconvexdfpPoint) -> Int { self.label }

pub fn OptconvexdfpPoint::dist(self : OptconvexdfpPoint, other : OptconvexdfpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexdfpPoint::add(self : OptconvexdfpPoint, other : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexdfpPoint::sub(self : OptconvexdfpPoint, other : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexdfpPoint::scale(self : OptconvexdfpPoint, s : Double) -> OptconvexdfpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexdfpPoint::dot(self : OptconvexdfpPoint, other : OptconvexdfpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexdfpPoint::cross(self : OptconvexdfpPoint, other : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexdfpPoint::norm(self : OptconvexdfpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexdfpPoint::normalize(self : OptconvexdfpPoint) -> OptconvexdfpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexdfpPoint::negate(self : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexdfpPoint::mid(self : OptconvexdfpPoint, other : OptconvexdfpPoint) -> OptconvexdfpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexdfpPoint::lerp(self : OptconvexdfpPoint, other : OptconvexdfpPoint, t : Double) -> OptconvexdfpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexdfpPoint::to_string(self : OptconvexdfpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexdfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_dfp_make_series(vals : Array[Double], name : String) -> OptconvexdfpSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexdfpSeries::len(self : OptconvexdfpSeries) -> Int { self.vals.length() }

pub fn OptconvexdfpSeries::sum(self : OptconvexdfpSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexdfpSeries::mean(self : OptconvexdfpSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexdfpSeries::min(self : OptconvexdfpSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexdfpSeries::max(self : OptconvexdfpSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexdfpSeries::range(self : OptconvexdfpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexdfpSeries::variance(self : OptconvexdfpSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexdfpSeries::std(self : OptconvexdfpSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexdfpSeries::median(self : OptconvexdfpSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexdfpSeries::scale(self : OptconvexdfpSeries, f : Double) -> OptconvexdfpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexdfpSeries::add(self : OptconvexdfpSeries, other : OptconvexdfpSeries) -> OptconvexdfpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexdfpSeries::sub(self : OptconvexdfpSeries, other : OptconvexdfpSeries) -> OptconvexdfpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexdfpSeries::normalize(self : OptconvexdfpSeries) -> OptconvexdfpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexdfpSeries::cumsum(self : OptconvexdfpSeries) -> OptconvexdfpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexdfpSeries::to_string(self : OptconvexdfpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexdfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_dfp_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexdfpMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn opt_convex_dfp_matrix_identity(n : Int) -> OptconvexdfpMatrix {
  let m = opt_convex_dfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexdfpMatrix::get(self : OptconvexdfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexdfpMatrix::transpose(self : OptconvexdfpMatrix) -> OptconvexdfpMatrix {
  let result = opt_convex_dfp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexdfpMatrix::add(self : OptconvexdfpMatrix, other : OptconvexdfpMatrix) -> OptconvexdfpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_dfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexdfpMatrix::scale(self : OptconvexdfpMatrix, s : Double) -> OptconvexdfpMatrix {
  let result = opt_convex_dfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexdfpMatrix::multiply(self : OptconvexdfpMatrix, other : OptconvexdfpMatrix) -> OptconvexdfpMatrix {
  if self.cols != other.rows { return opt_convex_dfp_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_dfp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvexdfpMatrix::trace(self : OptconvexdfpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexdfpMatrix::det(self : OptconvexdfpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexdfpMatrix::norm(self : OptconvexdfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexdfpMatrix::to_string(self : OptconvexdfpMatrix) -> String {
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

pub(all) struct OptconvexdfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_dfp_make_vector(comps : Array[Double]) -> OptconvexdfpVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_dfp_vector_zero(dim : Int) -> OptconvexdfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexdfpVector::add(self : OptconvexdfpVector, other : OptconvexdfpVector) -> OptconvexdfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexdfpVector::sub(self : OptconvexdfpVector, other : OptconvexdfpVector) -> OptconvexdfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexdfpVector::scale(self : OptconvexdfpVector, s : Double) -> OptconvexdfpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexdfpVector::dot(self : OptconvexdfpVector, other : OptconvexdfpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexdfpVector::norm(self : OptconvexdfpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexdfpVector::normalize(self : OptconvexdfpVector) -> OptconvexdfpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexdfpVector::dist(self : OptconvexdfpVector, other : OptconvexdfpVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexdfpVector::to_string(self : OptconvexdfpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexdfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_frame_make(size : Int) -> OptconvexdfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpFrame::len(self : OptconvexdfpFrame) -> Int { self.size }

pub fn OptconvexdfpFrame::get(self : OptconvexdfpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpFrame::set(self : OptconvexdfpFrame, i : Int, v : Double) -> OptconvexdfpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpFrame::sum(self : OptconvexdfpFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpFrame::mean(self : OptconvexdfpFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpFrame::scale(self : OptconvexdfpFrame, f : Double) -> OptconvexdfpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpFrame::add(self : OptconvexdfpFrame, other : OptconvexdfpFrame) -> OptconvexdfpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpFrame::copy(self : OptconvexdfpFrame) -> OptconvexdfpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpFrame::fill(self : OptconvexdfpFrame, v : Double) -> OptconvexdfpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpFrame::min(self : OptconvexdfpFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpFrame::max(self : OptconvexdfpFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpFrame::to_string(self : OptconvexdfpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_table_make(size : Int) -> OptconvexdfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpTable::len(self : OptconvexdfpTable) -> Int { self.size }

pub fn OptconvexdfpTable::get(self : OptconvexdfpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpTable::set(self : OptconvexdfpTable, i : Int, v : Double) -> OptconvexdfpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpTable::sum(self : OptconvexdfpTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpTable::mean(self : OptconvexdfpTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpTable::scale(self : OptconvexdfpTable, f : Double) -> OptconvexdfpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpTable::add(self : OptconvexdfpTable, other : OptconvexdfpTable) -> OptconvexdfpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpTable::copy(self : OptconvexdfpTable) -> OptconvexdfpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpTable::fill(self : OptconvexdfpTable, v : Double) -> OptconvexdfpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpTable::min(self : OptconvexdfpTable) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpTable::max(self : OptconvexdfpTable) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpTable::to_string(self : OptconvexdfpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_graphn_make(size : Int) -> OptconvexdfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpGraphN::len(self : OptconvexdfpGraphN) -> Int { self.size }

pub fn OptconvexdfpGraphN::get(self : OptconvexdfpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpGraphN::set(self : OptconvexdfpGraphN, i : Int, v : Double) -> OptconvexdfpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpGraphN::sum(self : OptconvexdfpGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpGraphN::mean(self : OptconvexdfpGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpGraphN::scale(self : OptconvexdfpGraphN, f : Double) -> OptconvexdfpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpGraphN::add(self : OptconvexdfpGraphN, other : OptconvexdfpGraphN) -> OptconvexdfpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpGraphN::copy(self : OptconvexdfpGraphN) -> OptconvexdfpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpGraphN::fill(self : OptconvexdfpGraphN, v : Double) -> OptconvexdfpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpGraphN::min(self : OptconvexdfpGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpGraphN::max(self : OptconvexdfpGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpGraphN::to_string(self : OptconvexdfpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_node_make(size : Int) -> OptconvexdfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpNode::len(self : OptconvexdfpNode) -> Int { self.size }

pub fn OptconvexdfpNode::get(self : OptconvexdfpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpNode::set(self : OptconvexdfpNode, i : Int, v : Double) -> OptconvexdfpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpNode::sum(self : OptconvexdfpNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpNode::mean(self : OptconvexdfpNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpNode::scale(self : OptconvexdfpNode, f : Double) -> OptconvexdfpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpNode::add(self : OptconvexdfpNode, other : OptconvexdfpNode) -> OptconvexdfpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpNode::copy(self : OptconvexdfpNode) -> OptconvexdfpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpNode::fill(self : OptconvexdfpNode, v : Double) -> OptconvexdfpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpNode::min(self : OptconvexdfpNode) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpNode::max(self : OptconvexdfpNode) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpNode::to_string(self : OptconvexdfpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_edge_make(size : Int) -> OptconvexdfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpEdge::len(self : OptconvexdfpEdge) -> Int { self.size }

pub fn OptconvexdfpEdge::get(self : OptconvexdfpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpEdge::set(self : OptconvexdfpEdge, i : Int, v : Double) -> OptconvexdfpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpEdge::sum(self : OptconvexdfpEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpEdge::mean(self : OptconvexdfpEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpEdge::scale(self : OptconvexdfpEdge, f : Double) -> OptconvexdfpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpEdge::add(self : OptconvexdfpEdge, other : OptconvexdfpEdge) -> OptconvexdfpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpEdge::copy(self : OptconvexdfpEdge) -> OptconvexdfpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpEdge::fill(self : OptconvexdfpEdge, v : Double) -> OptconvexdfpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpEdge::min(self : OptconvexdfpEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpEdge::max(self : OptconvexdfpEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpEdge::to_string(self : OptconvexdfpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_path_make(size : Int) -> OptconvexdfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpPath::len(self : OptconvexdfpPath) -> Int { self.size }

pub fn OptconvexdfpPath::get(self : OptconvexdfpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpPath::set(self : OptconvexdfpPath, i : Int, v : Double) -> OptconvexdfpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpPath::sum(self : OptconvexdfpPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpPath::mean(self : OptconvexdfpPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpPath::scale(self : OptconvexdfpPath, f : Double) -> OptconvexdfpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpPath::add(self : OptconvexdfpPath, other : OptconvexdfpPath) -> OptconvexdfpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpPath::copy(self : OptconvexdfpPath) -> OptconvexdfpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpPath::fill(self : OptconvexdfpPath, v : Double) -> OptconvexdfpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpPath::min(self : OptconvexdfpPath) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpPath::max(self : OptconvexdfpPath) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpPath::to_string(self : OptconvexdfpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_cluster_make(size : Int) -> OptconvexdfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpCluster::len(self : OptconvexdfpCluster) -> Int { self.size }

pub fn OptconvexdfpCluster::get(self : OptconvexdfpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpCluster::set(self : OptconvexdfpCluster, i : Int, v : Double) -> OptconvexdfpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCluster::sum(self : OptconvexdfpCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpCluster::mean(self : OptconvexdfpCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpCluster::scale(self : OptconvexdfpCluster, f : Double) -> OptconvexdfpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCluster::add(self : OptconvexdfpCluster, other : OptconvexdfpCluster) -> OptconvexdfpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpCluster::copy(self : OptconvexdfpCluster) -> OptconvexdfpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCluster::fill(self : OptconvexdfpCluster, v : Double) -> OptconvexdfpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCluster::min(self : OptconvexdfpCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpCluster::max(self : OptconvexdfpCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpCluster::to_string(self : OptconvexdfpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_model_make(size : Int) -> OptconvexdfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpModel::len(self : OptconvexdfpModel) -> Int { self.size }

pub fn OptconvexdfpModel::get(self : OptconvexdfpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpModel::set(self : OptconvexdfpModel, i : Int, v : Double) -> OptconvexdfpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpModel::sum(self : OptconvexdfpModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpModel::mean(self : OptconvexdfpModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpModel::scale(self : OptconvexdfpModel, f : Double) -> OptconvexdfpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpModel::add(self : OptconvexdfpModel, other : OptconvexdfpModel) -> OptconvexdfpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpModel::copy(self : OptconvexdfpModel) -> OptconvexdfpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpModel::fill(self : OptconvexdfpModel, v : Double) -> OptconvexdfpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpModel::min(self : OptconvexdfpModel) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpModel::max(self : OptconvexdfpModel) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpModel::to_string(self : OptconvexdfpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_layer_make(size : Int) -> OptconvexdfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpLayer::len(self : OptconvexdfpLayer) -> Int { self.size }

pub fn OptconvexdfpLayer::get(self : OptconvexdfpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpLayer::set(self : OptconvexdfpLayer, i : Int, v : Double) -> OptconvexdfpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpLayer::sum(self : OptconvexdfpLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpLayer::mean(self : OptconvexdfpLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpLayer::scale(self : OptconvexdfpLayer, f : Double) -> OptconvexdfpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpLayer::add(self : OptconvexdfpLayer, other : OptconvexdfpLayer) -> OptconvexdfpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpLayer::copy(self : OptconvexdfpLayer) -> OptconvexdfpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpLayer::fill(self : OptconvexdfpLayer, v : Double) -> OptconvexdfpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpLayer::min(self : OptconvexdfpLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpLayer::max(self : OptconvexdfpLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpLayer::to_string(self : OptconvexdfpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_buffer_make(size : Int) -> OptconvexdfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpBuffer::len(self : OptconvexdfpBuffer) -> Int { self.size }

pub fn OptconvexdfpBuffer::get(self : OptconvexdfpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpBuffer::set(self : OptconvexdfpBuffer, i : Int, v : Double) -> OptconvexdfpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpBuffer::sum(self : OptconvexdfpBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpBuffer::mean(self : OptconvexdfpBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpBuffer::scale(self : OptconvexdfpBuffer, f : Double) -> OptconvexdfpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpBuffer::add(self : OptconvexdfpBuffer, other : OptconvexdfpBuffer) -> OptconvexdfpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpBuffer::copy(self : OptconvexdfpBuffer) -> OptconvexdfpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpBuffer::fill(self : OptconvexdfpBuffer, v : Double) -> OptconvexdfpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpBuffer::min(self : OptconvexdfpBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpBuffer::max(self : OptconvexdfpBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpBuffer::to_string(self : OptconvexdfpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_cursor_make(size : Int) -> OptconvexdfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpCursor::len(self : OptconvexdfpCursor) -> Int { self.size }

pub fn OptconvexdfpCursor::get(self : OptconvexdfpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpCursor::set(self : OptconvexdfpCursor, i : Int, v : Double) -> OptconvexdfpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCursor::sum(self : OptconvexdfpCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpCursor::mean(self : OptconvexdfpCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpCursor::scale(self : OptconvexdfpCursor, f : Double) -> OptconvexdfpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCursor::add(self : OptconvexdfpCursor, other : OptconvexdfpCursor) -> OptconvexdfpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpCursor::copy(self : OptconvexdfpCursor) -> OptconvexdfpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCursor::fill(self : OptconvexdfpCursor, v : Double) -> OptconvexdfpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpCursor::min(self : OptconvexdfpCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpCursor::max(self : OptconvexdfpCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpCursor::to_string(self : OptconvexdfpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_view_make(size : Int) -> OptconvexdfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpView::len(self : OptconvexdfpView) -> Int { self.size }

pub fn OptconvexdfpView::get(self : OptconvexdfpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpView::set(self : OptconvexdfpView, i : Int, v : Double) -> OptconvexdfpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpView::sum(self : OptconvexdfpView) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpView::mean(self : OptconvexdfpView) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpView::scale(self : OptconvexdfpView, f : Double) -> OptconvexdfpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpView::add(self : OptconvexdfpView, other : OptconvexdfpView) -> OptconvexdfpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpView::copy(self : OptconvexdfpView) -> OptconvexdfpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpView::fill(self : OptconvexdfpView, v : Double) -> OptconvexdfpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpView::min(self : OptconvexdfpView) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpView::max(self : OptconvexdfpView) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpView::to_string(self : OptconvexdfpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_range_make(size : Int) -> OptconvexdfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpRange::len(self : OptconvexdfpRange) -> Int { self.size }

pub fn OptconvexdfpRange::get(self : OptconvexdfpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpRange::set(self : OptconvexdfpRange, i : Int, v : Double) -> OptconvexdfpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpRange::sum(self : OptconvexdfpRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpRange::mean(self : OptconvexdfpRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpRange::scale(self : OptconvexdfpRange, f : Double) -> OptconvexdfpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpRange::add(self : OptconvexdfpRange, other : OptconvexdfpRange) -> OptconvexdfpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpRange::copy(self : OptconvexdfpRange) -> OptconvexdfpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpRange::fill(self : OptconvexdfpRange, v : Double) -> OptconvexdfpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpRange::min(self : OptconvexdfpRange) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpRange::max(self : OptconvexdfpRange) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpRange::to_string(self : OptconvexdfpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexdfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_dfp_slice_make(size : Int) -> OptconvexdfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexdfpSlice::len(self : OptconvexdfpSlice) -> Int { self.size }

pub fn OptconvexdfpSlice::get(self : OptconvexdfpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexdfpSlice::set(self : OptconvexdfpSlice, i : Int, v : Double) -> OptconvexdfpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexdfpSlice::sum(self : OptconvexdfpSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexdfpSlice::mean(self : OptconvexdfpSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexdfpSlice::scale(self : OptconvexdfpSlice, f : Double) -> OptconvexdfpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpSlice::add(self : OptconvexdfpSlice, other : OptconvexdfpSlice) -> OptconvexdfpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexdfpSlice::copy(self : OptconvexdfpSlice) -> OptconvexdfpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpSlice::fill(self : OptconvexdfpSlice, v : Double) -> OptconvexdfpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexdfpSlice::min(self : OptconvexdfpSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexdfpSlice::max(self : OptconvexdfpSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexdfpSlice::to_string(self : OptconvexdfpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

