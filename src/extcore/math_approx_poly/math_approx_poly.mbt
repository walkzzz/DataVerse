///===
/// extcore/math_approx_poly

pub(all) struct MathapproxpolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_poly_make_point(x : Double, y : Double) -> MathapproxpolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_poly_make_point3(x : Double, y : Double, z : Double) -> MathapproxpolyPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxpolyPoint::x(self : MathapproxpolyPoint) -> Double { self.x }

pub fn MathapproxpolyPoint::y(self : MathapproxpolyPoint) -> Double { self.y }

pub fn MathapproxpolyPoint::z(self : MathapproxpolyPoint) -> Double { self.z }

pub fn MathapproxpolyPoint::label(self : MathapproxpolyPoint) -> Int { self.label }

pub fn MathapproxpolyPoint::dist(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxpolyPoint::add(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxpolyPoint::sub(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxpolyPoint::scale(self : MathapproxpolyPoint, s : Double) -> MathapproxpolyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxpolyPoint::dot(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxpolyPoint::cross(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxpolyPoint::norm(self : MathapproxpolyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxpolyPoint::normalize(self : MathapproxpolyPoint) -> MathapproxpolyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxpolyPoint::negate(self : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxpolyPoint::mid(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxpolyPoint::lerp(self : MathapproxpolyPoint, other : MathapproxpolyPoint, t : Double) -> MathapproxpolyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxpolyPoint::to_string(self : MathapproxpolyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxpolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_poly_make_series(vals : Array[Double], name : String) -> MathapproxpolySeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxpolySeries::len(self : MathapproxpolySeries) -> Int { self.vals.length() }

pub fn MathapproxpolySeries::sum(self : MathapproxpolySeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxpolySeries::mean(self : MathapproxpolySeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxpolySeries::min(self : MathapproxpolySeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxpolySeries::max(self : MathapproxpolySeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxpolySeries::range(self : MathapproxpolySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxpolySeries::variance(self : MathapproxpolySeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxpolySeries::std(self : MathapproxpolySeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxpolySeries::median(self : MathapproxpolySeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxpolySeries::scale(self : MathapproxpolySeries, f : Double) -> MathapproxpolySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxpolySeries::add(self : MathapproxpolySeries, other : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxpolySeries::sub(self : MathapproxpolySeries, other : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxpolySeries::normalize(self : MathapproxpolySeries) -> MathapproxpolySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxpolySeries::cumsum(self : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxpolySeries::to_string(self : MathapproxpolySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_poly_matrix_identity(n : Int) -> MathapproxpolyMatrix {
  let m = math_approx_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxpolyMatrix::get(self : MathapproxpolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxpolyMatrix::transpose(self : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxpolyMatrix::add(self : MathapproxpolyMatrix, other : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxpolyMatrix::scale(self : MathapproxpolyMatrix, s : Double) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxpolyMatrix::multiply(self : MathapproxpolyMatrix, other : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if self.cols != other.rows { return math_approx_poly_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_poly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathapproxpolyMatrix::trace(self : MathapproxpolyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxpolyMatrix::det(self : MathapproxpolyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxpolyMatrix::norm(self : MathapproxpolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxpolyMatrix::to_string(self : MathapproxpolyMatrix) -> String {
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

pub(all) struct MathapproxpolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_poly_make_vector(comps : Array[Double]) -> MathapproxpolyVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_poly_vector_zero(dim : Int) -> MathapproxpolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxpolyVector::add(self : MathapproxpolyVector, other : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxpolyVector::sub(self : MathapproxpolyVector, other : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxpolyVector::scale(self : MathapproxpolyVector, s : Double) -> MathapproxpolyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxpolyVector::dot(self : MathapproxpolyVector, other : MathapproxpolyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxpolyVector::norm(self : MathapproxpolyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxpolyVector::normalize(self : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxpolyVector::dist(self : MathapproxpolyVector, other : MathapproxpolyVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxpolyVector::to_string(self : MathapproxpolyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_frame_make(size : Int) -> MathapproxpolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyFrame::len(self : MathapproxpolyFrame) -> Int { self.size }

pub fn MathapproxpolyFrame::get(self : MathapproxpolyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyFrame::set(self : MathapproxpolyFrame, i : Int, v : Double) -> MathapproxpolyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyFrame::sum(self : MathapproxpolyFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyFrame::mean(self : MathapproxpolyFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyFrame::scale(self : MathapproxpolyFrame, f : Double) -> MathapproxpolyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyFrame::add(self : MathapproxpolyFrame, other : MathapproxpolyFrame) -> MathapproxpolyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyFrame::copy(self : MathapproxpolyFrame) -> MathapproxpolyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyFrame::fill(self : MathapproxpolyFrame, v : Double) -> MathapproxpolyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyFrame::min(self : MathapproxpolyFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyFrame::max(self : MathapproxpolyFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyFrame::to_string(self : MathapproxpolyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_table_make(size : Int) -> MathapproxpolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyTable::len(self : MathapproxpolyTable) -> Int { self.size }

pub fn MathapproxpolyTable::get(self : MathapproxpolyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyTable::set(self : MathapproxpolyTable, i : Int, v : Double) -> MathapproxpolyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyTable::sum(self : MathapproxpolyTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyTable::mean(self : MathapproxpolyTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyTable::scale(self : MathapproxpolyTable, f : Double) -> MathapproxpolyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyTable::add(self : MathapproxpolyTable, other : MathapproxpolyTable) -> MathapproxpolyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyTable::copy(self : MathapproxpolyTable) -> MathapproxpolyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyTable::fill(self : MathapproxpolyTable, v : Double) -> MathapproxpolyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyTable::min(self : MathapproxpolyTable) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyTable::max(self : MathapproxpolyTable) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyTable::to_string(self : MathapproxpolyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_graphn_make(size : Int) -> MathapproxpolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyGraphN::len(self : MathapproxpolyGraphN) -> Int { self.size }

pub fn MathapproxpolyGraphN::get(self : MathapproxpolyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyGraphN::set(self : MathapproxpolyGraphN, i : Int, v : Double) -> MathapproxpolyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyGraphN::sum(self : MathapproxpolyGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyGraphN::mean(self : MathapproxpolyGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyGraphN::scale(self : MathapproxpolyGraphN, f : Double) -> MathapproxpolyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyGraphN::add(self : MathapproxpolyGraphN, other : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyGraphN::copy(self : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyGraphN::fill(self : MathapproxpolyGraphN, v : Double) -> MathapproxpolyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyGraphN::min(self : MathapproxpolyGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyGraphN::max(self : MathapproxpolyGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyGraphN::to_string(self : MathapproxpolyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_node_make(size : Int) -> MathapproxpolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyNode::len(self : MathapproxpolyNode) -> Int { self.size }

pub fn MathapproxpolyNode::get(self : MathapproxpolyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyNode::set(self : MathapproxpolyNode, i : Int, v : Double) -> MathapproxpolyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyNode::sum(self : MathapproxpolyNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyNode::mean(self : MathapproxpolyNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyNode::scale(self : MathapproxpolyNode, f : Double) -> MathapproxpolyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyNode::add(self : MathapproxpolyNode, other : MathapproxpolyNode) -> MathapproxpolyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyNode::copy(self : MathapproxpolyNode) -> MathapproxpolyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyNode::fill(self : MathapproxpolyNode, v : Double) -> MathapproxpolyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyNode::min(self : MathapproxpolyNode) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyNode::max(self : MathapproxpolyNode) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyNode::to_string(self : MathapproxpolyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_edge_make(size : Int) -> MathapproxpolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyEdge::len(self : MathapproxpolyEdge) -> Int { self.size }

pub fn MathapproxpolyEdge::get(self : MathapproxpolyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyEdge::set(self : MathapproxpolyEdge, i : Int, v : Double) -> MathapproxpolyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyEdge::sum(self : MathapproxpolyEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyEdge::mean(self : MathapproxpolyEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyEdge::scale(self : MathapproxpolyEdge, f : Double) -> MathapproxpolyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyEdge::add(self : MathapproxpolyEdge, other : MathapproxpolyEdge) -> MathapproxpolyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyEdge::copy(self : MathapproxpolyEdge) -> MathapproxpolyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyEdge::fill(self : MathapproxpolyEdge, v : Double) -> MathapproxpolyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyEdge::min(self : MathapproxpolyEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyEdge::max(self : MathapproxpolyEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyEdge::to_string(self : MathapproxpolyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_path_make(size : Int) -> MathapproxpolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyPath::len(self : MathapproxpolyPath) -> Int { self.size }

pub fn MathapproxpolyPath::get(self : MathapproxpolyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyPath::set(self : MathapproxpolyPath, i : Int, v : Double) -> MathapproxpolyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyPath::sum(self : MathapproxpolyPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyPath::mean(self : MathapproxpolyPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyPath::scale(self : MathapproxpolyPath, f : Double) -> MathapproxpolyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyPath::add(self : MathapproxpolyPath, other : MathapproxpolyPath) -> MathapproxpolyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyPath::copy(self : MathapproxpolyPath) -> MathapproxpolyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyPath::fill(self : MathapproxpolyPath, v : Double) -> MathapproxpolyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyPath::min(self : MathapproxpolyPath) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyPath::max(self : MathapproxpolyPath) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyPath::to_string(self : MathapproxpolyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cluster_make(size : Int) -> MathapproxpolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyCluster::len(self : MathapproxpolyCluster) -> Int { self.size }

pub fn MathapproxpolyCluster::get(self : MathapproxpolyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyCluster::set(self : MathapproxpolyCluster, i : Int, v : Double) -> MathapproxpolyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCluster::sum(self : MathapproxpolyCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyCluster::mean(self : MathapproxpolyCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyCluster::scale(self : MathapproxpolyCluster, f : Double) -> MathapproxpolyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCluster::add(self : MathapproxpolyCluster, other : MathapproxpolyCluster) -> MathapproxpolyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyCluster::copy(self : MathapproxpolyCluster) -> MathapproxpolyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCluster::fill(self : MathapproxpolyCluster, v : Double) -> MathapproxpolyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCluster::min(self : MathapproxpolyCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyCluster::max(self : MathapproxpolyCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyCluster::to_string(self : MathapproxpolyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_model_make(size : Int) -> MathapproxpolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyModel::len(self : MathapproxpolyModel) -> Int { self.size }

pub fn MathapproxpolyModel::get(self : MathapproxpolyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyModel::set(self : MathapproxpolyModel, i : Int, v : Double) -> MathapproxpolyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyModel::sum(self : MathapproxpolyModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyModel::mean(self : MathapproxpolyModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyModel::scale(self : MathapproxpolyModel, f : Double) -> MathapproxpolyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyModel::add(self : MathapproxpolyModel, other : MathapproxpolyModel) -> MathapproxpolyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyModel::copy(self : MathapproxpolyModel) -> MathapproxpolyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyModel::fill(self : MathapproxpolyModel, v : Double) -> MathapproxpolyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyModel::min(self : MathapproxpolyModel) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyModel::max(self : MathapproxpolyModel) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyModel::to_string(self : MathapproxpolyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_layer_make(size : Int) -> MathapproxpolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyLayer::len(self : MathapproxpolyLayer) -> Int { self.size }

pub fn MathapproxpolyLayer::get(self : MathapproxpolyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyLayer::set(self : MathapproxpolyLayer, i : Int, v : Double) -> MathapproxpolyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyLayer::sum(self : MathapproxpolyLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyLayer::mean(self : MathapproxpolyLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyLayer::scale(self : MathapproxpolyLayer, f : Double) -> MathapproxpolyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyLayer::add(self : MathapproxpolyLayer, other : MathapproxpolyLayer) -> MathapproxpolyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyLayer::copy(self : MathapproxpolyLayer) -> MathapproxpolyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyLayer::fill(self : MathapproxpolyLayer, v : Double) -> MathapproxpolyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyLayer::min(self : MathapproxpolyLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyLayer::max(self : MathapproxpolyLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyLayer::to_string(self : MathapproxpolyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_buffer_make(size : Int) -> MathapproxpolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyBuffer::len(self : MathapproxpolyBuffer) -> Int { self.size }

pub fn MathapproxpolyBuffer::get(self : MathapproxpolyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyBuffer::set(self : MathapproxpolyBuffer, i : Int, v : Double) -> MathapproxpolyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyBuffer::sum(self : MathapproxpolyBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyBuffer::mean(self : MathapproxpolyBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyBuffer::scale(self : MathapproxpolyBuffer, f : Double) -> MathapproxpolyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyBuffer::add(self : MathapproxpolyBuffer, other : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyBuffer::copy(self : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyBuffer::fill(self : MathapproxpolyBuffer, v : Double) -> MathapproxpolyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyBuffer::min(self : MathapproxpolyBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyBuffer::max(self : MathapproxpolyBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyBuffer::to_string(self : MathapproxpolyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cursor_make(size : Int) -> MathapproxpolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyCursor::len(self : MathapproxpolyCursor) -> Int { self.size }

pub fn MathapproxpolyCursor::get(self : MathapproxpolyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyCursor::set(self : MathapproxpolyCursor, i : Int, v : Double) -> MathapproxpolyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCursor::sum(self : MathapproxpolyCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyCursor::mean(self : MathapproxpolyCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyCursor::scale(self : MathapproxpolyCursor, f : Double) -> MathapproxpolyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCursor::add(self : MathapproxpolyCursor, other : MathapproxpolyCursor) -> MathapproxpolyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyCursor::copy(self : MathapproxpolyCursor) -> MathapproxpolyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCursor::fill(self : MathapproxpolyCursor, v : Double) -> MathapproxpolyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyCursor::min(self : MathapproxpolyCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyCursor::max(self : MathapproxpolyCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyCursor::to_string(self : MathapproxpolyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_view_make(size : Int) -> MathapproxpolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyView::len(self : MathapproxpolyView) -> Int { self.size }

pub fn MathapproxpolyView::get(self : MathapproxpolyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyView::set(self : MathapproxpolyView, i : Int, v : Double) -> MathapproxpolyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyView::sum(self : MathapproxpolyView) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyView::mean(self : MathapproxpolyView) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyView::scale(self : MathapproxpolyView, f : Double) -> MathapproxpolyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyView::add(self : MathapproxpolyView, other : MathapproxpolyView) -> MathapproxpolyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyView::copy(self : MathapproxpolyView) -> MathapproxpolyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyView::fill(self : MathapproxpolyView, v : Double) -> MathapproxpolyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyView::min(self : MathapproxpolyView) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyView::max(self : MathapproxpolyView) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyView::to_string(self : MathapproxpolyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_range_make(size : Int) -> MathapproxpolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolyRange::len(self : MathapproxpolyRange) -> Int { self.size }

pub fn MathapproxpolyRange::get(self : MathapproxpolyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolyRange::set(self : MathapproxpolyRange, i : Int, v : Double) -> MathapproxpolyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolyRange::sum(self : MathapproxpolyRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolyRange::mean(self : MathapproxpolyRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolyRange::scale(self : MathapproxpolyRange, f : Double) -> MathapproxpolyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyRange::add(self : MathapproxpolyRange, other : MathapproxpolyRange) -> MathapproxpolyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolyRange::copy(self : MathapproxpolyRange) -> MathapproxpolyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyRange::fill(self : MathapproxpolyRange, v : Double) -> MathapproxpolyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolyRange::min(self : MathapproxpolyRange) -> Double { @_common.min(self.data) }

pub fn MathapproxpolyRange::max(self : MathapproxpolyRange) -> Double { @_common.max(self.data) }

pub fn MathapproxpolyRange::to_string(self : MathapproxpolyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_slice_make(size : Int) -> MathapproxpolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpolySlice::len(self : MathapproxpolySlice) -> Int { self.size }

pub fn MathapproxpolySlice::get(self : MathapproxpolySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpolySlice::set(self : MathapproxpolySlice, i : Int, v : Double) -> MathapproxpolySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpolySlice::sum(self : MathapproxpolySlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxpolySlice::mean(self : MathapproxpolySlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxpolySlice::scale(self : MathapproxpolySlice, f : Double) -> MathapproxpolySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpolySlice::add(self : MathapproxpolySlice, other : MathapproxpolySlice) -> MathapproxpolySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpolySlice::copy(self : MathapproxpolySlice) -> MathapproxpolySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpolySlice::fill(self : MathapproxpolySlice, v : Double) -> MathapproxpolySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpolySlice::min(self : MathapproxpolySlice) -> Double { @_common.min(self.data) }

pub fn MathapproxpolySlice::max(self : MathapproxpolySlice) -> Double { @_common.max(self.data) }

pub fn MathapproxpolySlice::to_string(self : MathapproxpolySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

