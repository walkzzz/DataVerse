///===
/// extcore/opt_convex_gd

pub(all) struct OptconvexgdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_gd_make_point(x : Double, y : Double) -> OptconvexgdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_gd_make_point3(x : Double, y : Double, z : Double) -> OptconvexgdPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexgdPoint::x(self : OptconvexgdPoint) -> Double { self.x }

pub fn OptconvexgdPoint::y(self : OptconvexgdPoint) -> Double { self.y }

pub fn OptconvexgdPoint::z(self : OptconvexgdPoint) -> Double { self.z }

pub fn OptconvexgdPoint::label(self : OptconvexgdPoint) -> Int { self.label }

pub fn OptconvexgdPoint::dist(self : OptconvexgdPoint, other : OptconvexgdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexgdPoint::add(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexgdPoint::sub(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexgdPoint::scale(self : OptconvexgdPoint, s : Double) -> OptconvexgdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexgdPoint::dot(self : OptconvexgdPoint, other : OptconvexgdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexgdPoint::cross(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexgdPoint::norm(self : OptconvexgdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexgdPoint::normalize(self : OptconvexgdPoint) -> OptconvexgdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexgdPoint::negate(self : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexgdPoint::mid(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexgdPoint::lerp(self : OptconvexgdPoint, other : OptconvexgdPoint, t : Double) -> OptconvexgdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexgdPoint::to_string(self : OptconvexgdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexgdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_gd_make_series(vals : Array[Double], name : String) -> OptconvexgdSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexgdSeries::len(self : OptconvexgdSeries) -> Int { self.vals.length() }

pub fn OptconvexgdSeries::sum(self : OptconvexgdSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexgdSeries::mean(self : OptconvexgdSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexgdSeries::min(self : OptconvexgdSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexgdSeries::max(self : OptconvexgdSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexgdSeries::range(self : OptconvexgdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexgdSeries::variance(self : OptconvexgdSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexgdSeries::std(self : OptconvexgdSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexgdSeries::median(self : OptconvexgdSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexgdSeries::scale(self : OptconvexgdSeries, f : Double) -> OptconvexgdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexgdSeries::add(self : OptconvexgdSeries, other : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexgdSeries::sub(self : OptconvexgdSeries, other : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexgdSeries::normalize(self : OptconvexgdSeries) -> OptconvexgdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexgdSeries::cumsum(self : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexgdSeries::to_string(self : OptconvexgdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexgdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_gd_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexgdMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn opt_convex_gd_matrix_identity(n : Int) -> OptconvexgdMatrix {
  let m = opt_convex_gd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexgdMatrix::get(self : OptconvexgdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexgdMatrix::transpose(self : OptconvexgdMatrix) -> OptconvexgdMatrix {
  let result = opt_convex_gd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexgdMatrix::add(self : OptconvexgdMatrix, other : OptconvexgdMatrix) -> OptconvexgdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_gd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexgdMatrix::scale(self : OptconvexgdMatrix, s : Double) -> OptconvexgdMatrix {
  let result = opt_convex_gd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexgdMatrix::multiply(self : OptconvexgdMatrix, other : OptconvexgdMatrix) -> OptconvexgdMatrix {
  if self.cols != other.rows { return opt_convex_gd_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_gd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvexgdMatrix::trace(self : OptconvexgdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexgdMatrix::det(self : OptconvexgdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexgdMatrix::norm(self : OptconvexgdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexgdMatrix::to_string(self : OptconvexgdMatrix) -> String {
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

pub(all) struct OptconvexgdVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_gd_make_vector(comps : Array[Double]) -> OptconvexgdVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_gd_vector_zero(dim : Int) -> OptconvexgdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexgdVector::add(self : OptconvexgdVector, other : OptconvexgdVector) -> OptconvexgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexgdVector::sub(self : OptconvexgdVector, other : OptconvexgdVector) -> OptconvexgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexgdVector::scale(self : OptconvexgdVector, s : Double) -> OptconvexgdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexgdVector::dot(self : OptconvexgdVector, other : OptconvexgdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexgdVector::norm(self : OptconvexgdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexgdVector::normalize(self : OptconvexgdVector) -> OptconvexgdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexgdVector::dist(self : OptconvexgdVector, other : OptconvexgdVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexgdVector::to_string(self : OptconvexgdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexgdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_frame_make(size : Int) -> OptconvexgdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdFrame::len(self : OptconvexgdFrame) -> Int { self.size }

pub fn OptconvexgdFrame::get(self : OptconvexgdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdFrame::set(self : OptconvexgdFrame, i : Int, v : Double) -> OptconvexgdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdFrame::sum(self : OptconvexgdFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdFrame::mean(self : OptconvexgdFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdFrame::scale(self : OptconvexgdFrame, f : Double) -> OptconvexgdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdFrame::add(self : OptconvexgdFrame, other : OptconvexgdFrame) -> OptconvexgdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdFrame::copy(self : OptconvexgdFrame) -> OptconvexgdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdFrame::fill(self : OptconvexgdFrame, v : Double) -> OptconvexgdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdFrame::min(self : OptconvexgdFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexgdFrame::max(self : OptconvexgdFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexgdFrame::to_string(self : OptconvexgdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_table_make(size : Int) -> OptconvexgdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdTable::len(self : OptconvexgdTable) -> Int { self.size }

pub fn OptconvexgdTable::get(self : OptconvexgdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdTable::set(self : OptconvexgdTable, i : Int, v : Double) -> OptconvexgdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdTable::sum(self : OptconvexgdTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdTable::mean(self : OptconvexgdTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdTable::scale(self : OptconvexgdTable, f : Double) -> OptconvexgdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdTable::add(self : OptconvexgdTable, other : OptconvexgdTable) -> OptconvexgdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdTable::copy(self : OptconvexgdTable) -> OptconvexgdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdTable::fill(self : OptconvexgdTable, v : Double) -> OptconvexgdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdTable::min(self : OptconvexgdTable) -> Double { @_common.min(self.data) }

pub fn OptconvexgdTable::max(self : OptconvexgdTable) -> Double { @_common.max(self.data) }

pub fn OptconvexgdTable::to_string(self : OptconvexgdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_graphn_make(size : Int) -> OptconvexgdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdGraphN::len(self : OptconvexgdGraphN) -> Int { self.size }

pub fn OptconvexgdGraphN::get(self : OptconvexgdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdGraphN::set(self : OptconvexgdGraphN, i : Int, v : Double) -> OptconvexgdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdGraphN::sum(self : OptconvexgdGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdGraphN::mean(self : OptconvexgdGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdGraphN::scale(self : OptconvexgdGraphN, f : Double) -> OptconvexgdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdGraphN::add(self : OptconvexgdGraphN, other : OptconvexgdGraphN) -> OptconvexgdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdGraphN::copy(self : OptconvexgdGraphN) -> OptconvexgdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdGraphN::fill(self : OptconvexgdGraphN, v : Double) -> OptconvexgdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdGraphN::min(self : OptconvexgdGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexgdGraphN::max(self : OptconvexgdGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexgdGraphN::to_string(self : OptconvexgdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_node_make(size : Int) -> OptconvexgdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdNode::len(self : OptconvexgdNode) -> Int { self.size }

pub fn OptconvexgdNode::get(self : OptconvexgdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdNode::set(self : OptconvexgdNode, i : Int, v : Double) -> OptconvexgdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdNode::sum(self : OptconvexgdNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdNode::mean(self : OptconvexgdNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdNode::scale(self : OptconvexgdNode, f : Double) -> OptconvexgdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdNode::add(self : OptconvexgdNode, other : OptconvexgdNode) -> OptconvexgdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdNode::copy(self : OptconvexgdNode) -> OptconvexgdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdNode::fill(self : OptconvexgdNode, v : Double) -> OptconvexgdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdNode::min(self : OptconvexgdNode) -> Double { @_common.min(self.data) }

pub fn OptconvexgdNode::max(self : OptconvexgdNode) -> Double { @_common.max(self.data) }

pub fn OptconvexgdNode::to_string(self : OptconvexgdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_edge_make(size : Int) -> OptconvexgdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdEdge::len(self : OptconvexgdEdge) -> Int { self.size }

pub fn OptconvexgdEdge::get(self : OptconvexgdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdEdge::set(self : OptconvexgdEdge, i : Int, v : Double) -> OptconvexgdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdEdge::sum(self : OptconvexgdEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdEdge::mean(self : OptconvexgdEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdEdge::scale(self : OptconvexgdEdge, f : Double) -> OptconvexgdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdEdge::add(self : OptconvexgdEdge, other : OptconvexgdEdge) -> OptconvexgdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdEdge::copy(self : OptconvexgdEdge) -> OptconvexgdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdEdge::fill(self : OptconvexgdEdge, v : Double) -> OptconvexgdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdEdge::min(self : OptconvexgdEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexgdEdge::max(self : OptconvexgdEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexgdEdge::to_string(self : OptconvexgdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_path_make(size : Int) -> OptconvexgdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdPath::len(self : OptconvexgdPath) -> Int { self.size }

pub fn OptconvexgdPath::get(self : OptconvexgdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdPath::set(self : OptconvexgdPath, i : Int, v : Double) -> OptconvexgdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdPath::sum(self : OptconvexgdPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdPath::mean(self : OptconvexgdPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdPath::scale(self : OptconvexgdPath, f : Double) -> OptconvexgdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdPath::add(self : OptconvexgdPath, other : OptconvexgdPath) -> OptconvexgdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdPath::copy(self : OptconvexgdPath) -> OptconvexgdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdPath::fill(self : OptconvexgdPath, v : Double) -> OptconvexgdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdPath::min(self : OptconvexgdPath) -> Double { @_common.min(self.data) }

pub fn OptconvexgdPath::max(self : OptconvexgdPath) -> Double { @_common.max(self.data) }

pub fn OptconvexgdPath::to_string(self : OptconvexgdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_cluster_make(size : Int) -> OptconvexgdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdCluster::len(self : OptconvexgdCluster) -> Int { self.size }

pub fn OptconvexgdCluster::get(self : OptconvexgdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdCluster::set(self : OptconvexgdCluster, i : Int, v : Double) -> OptconvexgdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdCluster::sum(self : OptconvexgdCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdCluster::mean(self : OptconvexgdCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdCluster::scale(self : OptconvexgdCluster, f : Double) -> OptconvexgdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdCluster::add(self : OptconvexgdCluster, other : OptconvexgdCluster) -> OptconvexgdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdCluster::copy(self : OptconvexgdCluster) -> OptconvexgdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdCluster::fill(self : OptconvexgdCluster, v : Double) -> OptconvexgdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdCluster::min(self : OptconvexgdCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexgdCluster::max(self : OptconvexgdCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexgdCluster::to_string(self : OptconvexgdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_model_make(size : Int) -> OptconvexgdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdModel::len(self : OptconvexgdModel) -> Int { self.size }

pub fn OptconvexgdModel::get(self : OptconvexgdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdModel::set(self : OptconvexgdModel, i : Int, v : Double) -> OptconvexgdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdModel::sum(self : OptconvexgdModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdModel::mean(self : OptconvexgdModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdModel::scale(self : OptconvexgdModel, f : Double) -> OptconvexgdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdModel::add(self : OptconvexgdModel, other : OptconvexgdModel) -> OptconvexgdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdModel::copy(self : OptconvexgdModel) -> OptconvexgdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdModel::fill(self : OptconvexgdModel, v : Double) -> OptconvexgdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdModel::min(self : OptconvexgdModel) -> Double { @_common.min(self.data) }

pub fn OptconvexgdModel::max(self : OptconvexgdModel) -> Double { @_common.max(self.data) }

pub fn OptconvexgdModel::to_string(self : OptconvexgdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_layer_make(size : Int) -> OptconvexgdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdLayer::len(self : OptconvexgdLayer) -> Int { self.size }

pub fn OptconvexgdLayer::get(self : OptconvexgdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdLayer::set(self : OptconvexgdLayer, i : Int, v : Double) -> OptconvexgdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdLayer::sum(self : OptconvexgdLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdLayer::mean(self : OptconvexgdLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdLayer::scale(self : OptconvexgdLayer, f : Double) -> OptconvexgdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdLayer::add(self : OptconvexgdLayer, other : OptconvexgdLayer) -> OptconvexgdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdLayer::copy(self : OptconvexgdLayer) -> OptconvexgdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdLayer::fill(self : OptconvexgdLayer, v : Double) -> OptconvexgdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdLayer::min(self : OptconvexgdLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexgdLayer::max(self : OptconvexgdLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexgdLayer::to_string(self : OptconvexgdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_buffer_make(size : Int) -> OptconvexgdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdBuffer::len(self : OptconvexgdBuffer) -> Int { self.size }

pub fn OptconvexgdBuffer::get(self : OptconvexgdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdBuffer::set(self : OptconvexgdBuffer, i : Int, v : Double) -> OptconvexgdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdBuffer::sum(self : OptconvexgdBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdBuffer::mean(self : OptconvexgdBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdBuffer::scale(self : OptconvexgdBuffer, f : Double) -> OptconvexgdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdBuffer::add(self : OptconvexgdBuffer, other : OptconvexgdBuffer) -> OptconvexgdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdBuffer::copy(self : OptconvexgdBuffer) -> OptconvexgdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdBuffer::fill(self : OptconvexgdBuffer, v : Double) -> OptconvexgdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdBuffer::min(self : OptconvexgdBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexgdBuffer::max(self : OptconvexgdBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexgdBuffer::to_string(self : OptconvexgdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_cursor_make(size : Int) -> OptconvexgdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdCursor::len(self : OptconvexgdCursor) -> Int { self.size }

pub fn OptconvexgdCursor::get(self : OptconvexgdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdCursor::set(self : OptconvexgdCursor, i : Int, v : Double) -> OptconvexgdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdCursor::sum(self : OptconvexgdCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdCursor::mean(self : OptconvexgdCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdCursor::scale(self : OptconvexgdCursor, f : Double) -> OptconvexgdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdCursor::add(self : OptconvexgdCursor, other : OptconvexgdCursor) -> OptconvexgdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdCursor::copy(self : OptconvexgdCursor) -> OptconvexgdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdCursor::fill(self : OptconvexgdCursor, v : Double) -> OptconvexgdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdCursor::min(self : OptconvexgdCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexgdCursor::max(self : OptconvexgdCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexgdCursor::to_string(self : OptconvexgdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_view_make(size : Int) -> OptconvexgdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdView::len(self : OptconvexgdView) -> Int { self.size }

pub fn OptconvexgdView::get(self : OptconvexgdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdView::set(self : OptconvexgdView, i : Int, v : Double) -> OptconvexgdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdView::sum(self : OptconvexgdView) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdView::mean(self : OptconvexgdView) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdView::scale(self : OptconvexgdView, f : Double) -> OptconvexgdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdView::add(self : OptconvexgdView, other : OptconvexgdView) -> OptconvexgdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdView::copy(self : OptconvexgdView) -> OptconvexgdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdView::fill(self : OptconvexgdView, v : Double) -> OptconvexgdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdView::min(self : OptconvexgdView) -> Double { @_common.min(self.data) }

pub fn OptconvexgdView::max(self : OptconvexgdView) -> Double { @_common.max(self.data) }

pub fn OptconvexgdView::to_string(self : OptconvexgdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_range_make(size : Int) -> OptconvexgdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdRange::len(self : OptconvexgdRange) -> Int { self.size }

pub fn OptconvexgdRange::get(self : OptconvexgdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdRange::set(self : OptconvexgdRange, i : Int, v : Double) -> OptconvexgdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdRange::sum(self : OptconvexgdRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdRange::mean(self : OptconvexgdRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdRange::scale(self : OptconvexgdRange, f : Double) -> OptconvexgdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdRange::add(self : OptconvexgdRange, other : OptconvexgdRange) -> OptconvexgdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdRange::copy(self : OptconvexgdRange) -> OptconvexgdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdRange::fill(self : OptconvexgdRange, v : Double) -> OptconvexgdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdRange::min(self : OptconvexgdRange) -> Double { @_common.min(self.data) }

pub fn OptconvexgdRange::max(self : OptconvexgdRange) -> Double { @_common.max(self.data) }

pub fn OptconvexgdRange::to_string(self : OptconvexgdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexgdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_slice_make(size : Int) -> OptconvexgdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexgdSlice::len(self : OptconvexgdSlice) -> Int { self.size }

pub fn OptconvexgdSlice::get(self : OptconvexgdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexgdSlice::set(self : OptconvexgdSlice, i : Int, v : Double) -> OptconvexgdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexgdSlice::sum(self : OptconvexgdSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexgdSlice::mean(self : OptconvexgdSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexgdSlice::scale(self : OptconvexgdSlice, f : Double) -> OptconvexgdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexgdSlice::add(self : OptconvexgdSlice, other : OptconvexgdSlice) -> OptconvexgdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexgdSlice::copy(self : OptconvexgdSlice) -> OptconvexgdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexgdSlice::fill(self : OptconvexgdSlice, v : Double) -> OptconvexgdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexgdSlice::min(self : OptconvexgdSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexgdSlice::max(self : OptconvexgdSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexgdSlice::to_string(self : OptconvexgdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

