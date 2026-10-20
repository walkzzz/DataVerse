///===
/// extcore/math_cholesky

pub(all) struct MathcholeskyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_cholesky_make_point(x : Double, y : Double) -> MathcholeskyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_cholesky_make_point3(x : Double, y : Double, z : Double) -> MathcholeskyPoint {
  { x, y, z, label: 0 }
}

pub fn MathcholeskyPoint::x(self : MathcholeskyPoint) -> Double { self.x }

pub fn MathcholeskyPoint::y(self : MathcholeskyPoint) -> Double { self.y }

pub fn MathcholeskyPoint::z(self : MathcholeskyPoint) -> Double { self.z }

pub fn MathcholeskyPoint::label(self : MathcholeskyPoint) -> Int { self.label }

pub fn MathcholeskyPoint::dist(self : MathcholeskyPoint, other : MathcholeskyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathcholeskyPoint::add(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathcholeskyPoint::sub(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathcholeskyPoint::scale(self : MathcholeskyPoint, s : Double) -> MathcholeskyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathcholeskyPoint::dot(self : MathcholeskyPoint, other : MathcholeskyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathcholeskyPoint::cross(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathcholeskyPoint::norm(self : MathcholeskyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathcholeskyPoint::normalize(self : MathcholeskyPoint) -> MathcholeskyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcholeskyPoint::negate(self : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathcholeskyPoint::mid(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathcholeskyPoint::lerp(self : MathcholeskyPoint, other : MathcholeskyPoint, t : Double) -> MathcholeskyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathcholeskyPoint::to_string(self : MathcholeskyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathcholeskySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_cholesky_make_series(vals : Array[Double], name : String) -> MathcholeskySeries {
  { vals, name, meta: 0 }
}

pub fn MathcholeskySeries::len(self : MathcholeskySeries) -> Int { self.vals.length() }

pub fn MathcholeskySeries::sum(self : MathcholeskySeries) -> Double { @_common.sum(self.vals) }

pub fn MathcholeskySeries::mean(self : MathcholeskySeries) -> Double { @_common.mean(self.vals) }

pub fn MathcholeskySeries::min(self : MathcholeskySeries) -> Double { @_common.min(self.vals) }

pub fn MathcholeskySeries::max(self : MathcholeskySeries) -> Double { @_common.max(self.vals) }

pub fn MathcholeskySeries::range(self : MathcholeskySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathcholeskySeries::variance(self : MathcholeskySeries) -> Double { @_common.variance(self.vals) }

pub fn MathcholeskySeries::std(self : MathcholeskySeries) -> Double { @_common.std(self.vals) }

pub fn MathcholeskySeries::median(self : MathcholeskySeries) -> Double { @_common.median(self.vals) }

pub fn MathcholeskySeries::scale(self : MathcholeskySeries, f : Double) -> MathcholeskySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathcholeskySeries::add(self : MathcholeskySeries, other : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathcholeskySeries::sub(self : MathcholeskySeries, other : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathcholeskySeries::normalize(self : MathcholeskySeries) -> MathcholeskySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathcholeskySeries::cumsum(self : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathcholeskySeries::to_string(self : MathcholeskySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcholeskyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_cholesky_make_matrix(rows : Int, cols : Int, val : Double) -> MathcholeskyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_cholesky_matrix_identity(n : Int) -> MathcholeskyMatrix {
  let m = math_cholesky_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathcholeskyMatrix::get(self : MathcholeskyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathcholeskyMatrix::transpose(self : MathcholeskyMatrix) -> MathcholeskyMatrix {
  let result = math_cholesky_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathcholeskyMatrix::add(self : MathcholeskyMatrix, other : MathcholeskyMatrix) -> MathcholeskyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_cholesky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathcholeskyMatrix::scale(self : MathcholeskyMatrix, s : Double) -> MathcholeskyMatrix {
  let result = math_cholesky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathcholeskyMatrix::multiply(self : MathcholeskyMatrix, other : MathcholeskyMatrix) -> MathcholeskyMatrix {
  if self.cols != other.rows { return math_cholesky_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_cholesky_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathcholeskyMatrix::trace(self : MathcholeskyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathcholeskyMatrix::det(self : MathcholeskyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathcholeskyMatrix::norm(self : MathcholeskyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathcholeskyMatrix::to_string(self : MathcholeskyMatrix) -> String {
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

pub(all) struct MathcholeskyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_cholesky_make_vector(comps : Array[Double]) -> MathcholeskyVector {
  { comps, dim: comps.length() }
}

pub fn math_cholesky_vector_zero(dim : Int) -> MathcholeskyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathcholeskyVector::add(self : MathcholeskyVector, other : MathcholeskyVector) -> MathcholeskyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathcholeskyVector::sub(self : MathcholeskyVector, other : MathcholeskyVector) -> MathcholeskyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathcholeskyVector::scale(self : MathcholeskyVector, s : Double) -> MathcholeskyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathcholeskyVector::dot(self : MathcholeskyVector, other : MathcholeskyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathcholeskyVector::norm(self : MathcholeskyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathcholeskyVector::normalize(self : MathcholeskyVector) -> MathcholeskyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcholeskyVector::dist(self : MathcholeskyVector, other : MathcholeskyVector) -> Double {
  self.sub(other).norm()
}

pub fn MathcholeskyVector::to_string(self : MathcholeskyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcholeskyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_frame_make(size : Int) -> MathcholeskyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyFrame::len(self : MathcholeskyFrame) -> Int { self.size }

pub fn MathcholeskyFrame::get(self : MathcholeskyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyFrame::set(self : MathcholeskyFrame, i : Int, v : Double) -> MathcholeskyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyFrame::sum(self : MathcholeskyFrame) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyFrame::mean(self : MathcholeskyFrame) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyFrame::scale(self : MathcholeskyFrame, f : Double) -> MathcholeskyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyFrame::add(self : MathcholeskyFrame, other : MathcholeskyFrame) -> MathcholeskyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyFrame::copy(self : MathcholeskyFrame) -> MathcholeskyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyFrame::fill(self : MathcholeskyFrame, v : Double) -> MathcholeskyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyFrame::min(self : MathcholeskyFrame) -> Double { @_common.min(self.data) }

pub fn MathcholeskyFrame::max(self : MathcholeskyFrame) -> Double { @_common.max(self.data) }

pub fn MathcholeskyFrame::to_string(self : MathcholeskyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_table_make(size : Int) -> MathcholeskyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyTable::len(self : MathcholeskyTable) -> Int { self.size }

pub fn MathcholeskyTable::get(self : MathcholeskyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyTable::set(self : MathcholeskyTable, i : Int, v : Double) -> MathcholeskyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyTable::sum(self : MathcholeskyTable) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyTable::mean(self : MathcholeskyTable) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyTable::scale(self : MathcholeskyTable, f : Double) -> MathcholeskyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyTable::add(self : MathcholeskyTable, other : MathcholeskyTable) -> MathcholeskyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyTable::copy(self : MathcholeskyTable) -> MathcholeskyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyTable::fill(self : MathcholeskyTable, v : Double) -> MathcholeskyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyTable::min(self : MathcholeskyTable) -> Double { @_common.min(self.data) }

pub fn MathcholeskyTable::max(self : MathcholeskyTable) -> Double { @_common.max(self.data) }

pub fn MathcholeskyTable::to_string(self : MathcholeskyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_graphn_make(size : Int) -> MathcholeskyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyGraphN::len(self : MathcholeskyGraphN) -> Int { self.size }

pub fn MathcholeskyGraphN::get(self : MathcholeskyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyGraphN::set(self : MathcholeskyGraphN, i : Int, v : Double) -> MathcholeskyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyGraphN::sum(self : MathcholeskyGraphN) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyGraphN::mean(self : MathcholeskyGraphN) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyGraphN::scale(self : MathcholeskyGraphN, f : Double) -> MathcholeskyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyGraphN::add(self : MathcholeskyGraphN, other : MathcholeskyGraphN) -> MathcholeskyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyGraphN::copy(self : MathcholeskyGraphN) -> MathcholeskyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyGraphN::fill(self : MathcholeskyGraphN, v : Double) -> MathcholeskyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyGraphN::min(self : MathcholeskyGraphN) -> Double { @_common.min(self.data) }

pub fn MathcholeskyGraphN::max(self : MathcholeskyGraphN) -> Double { @_common.max(self.data) }

pub fn MathcholeskyGraphN::to_string(self : MathcholeskyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_node_make(size : Int) -> MathcholeskyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyNode::len(self : MathcholeskyNode) -> Int { self.size }

pub fn MathcholeskyNode::get(self : MathcholeskyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyNode::set(self : MathcholeskyNode, i : Int, v : Double) -> MathcholeskyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyNode::sum(self : MathcholeskyNode) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyNode::mean(self : MathcholeskyNode) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyNode::scale(self : MathcholeskyNode, f : Double) -> MathcholeskyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyNode::add(self : MathcholeskyNode, other : MathcholeskyNode) -> MathcholeskyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyNode::copy(self : MathcholeskyNode) -> MathcholeskyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyNode::fill(self : MathcholeskyNode, v : Double) -> MathcholeskyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyNode::min(self : MathcholeskyNode) -> Double { @_common.min(self.data) }

pub fn MathcholeskyNode::max(self : MathcholeskyNode) -> Double { @_common.max(self.data) }

pub fn MathcholeskyNode::to_string(self : MathcholeskyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_edge_make(size : Int) -> MathcholeskyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyEdge::len(self : MathcholeskyEdge) -> Int { self.size }

pub fn MathcholeskyEdge::get(self : MathcholeskyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyEdge::set(self : MathcholeskyEdge, i : Int, v : Double) -> MathcholeskyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyEdge::sum(self : MathcholeskyEdge) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyEdge::mean(self : MathcholeskyEdge) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyEdge::scale(self : MathcholeskyEdge, f : Double) -> MathcholeskyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyEdge::add(self : MathcholeskyEdge, other : MathcholeskyEdge) -> MathcholeskyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyEdge::copy(self : MathcholeskyEdge) -> MathcholeskyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyEdge::fill(self : MathcholeskyEdge, v : Double) -> MathcholeskyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyEdge::min(self : MathcholeskyEdge) -> Double { @_common.min(self.data) }

pub fn MathcholeskyEdge::max(self : MathcholeskyEdge) -> Double { @_common.max(self.data) }

pub fn MathcholeskyEdge::to_string(self : MathcholeskyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_path_make(size : Int) -> MathcholeskyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyPath::len(self : MathcholeskyPath) -> Int { self.size }

pub fn MathcholeskyPath::get(self : MathcholeskyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyPath::set(self : MathcholeskyPath, i : Int, v : Double) -> MathcholeskyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyPath::sum(self : MathcholeskyPath) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyPath::mean(self : MathcholeskyPath) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyPath::scale(self : MathcholeskyPath, f : Double) -> MathcholeskyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyPath::add(self : MathcholeskyPath, other : MathcholeskyPath) -> MathcholeskyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyPath::copy(self : MathcholeskyPath) -> MathcholeskyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyPath::fill(self : MathcholeskyPath, v : Double) -> MathcholeskyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyPath::min(self : MathcholeskyPath) -> Double { @_common.min(self.data) }

pub fn MathcholeskyPath::max(self : MathcholeskyPath) -> Double { @_common.max(self.data) }

pub fn MathcholeskyPath::to_string(self : MathcholeskyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_cluster_make(size : Int) -> MathcholeskyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyCluster::len(self : MathcholeskyCluster) -> Int { self.size }

pub fn MathcholeskyCluster::get(self : MathcholeskyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyCluster::set(self : MathcholeskyCluster, i : Int, v : Double) -> MathcholeskyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyCluster::sum(self : MathcholeskyCluster) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyCluster::mean(self : MathcholeskyCluster) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyCluster::scale(self : MathcholeskyCluster, f : Double) -> MathcholeskyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyCluster::add(self : MathcholeskyCluster, other : MathcholeskyCluster) -> MathcholeskyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyCluster::copy(self : MathcholeskyCluster) -> MathcholeskyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyCluster::fill(self : MathcholeskyCluster, v : Double) -> MathcholeskyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyCluster::min(self : MathcholeskyCluster) -> Double { @_common.min(self.data) }

pub fn MathcholeskyCluster::max(self : MathcholeskyCluster) -> Double { @_common.max(self.data) }

pub fn MathcholeskyCluster::to_string(self : MathcholeskyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_model_make(size : Int) -> MathcholeskyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyModel::len(self : MathcholeskyModel) -> Int { self.size }

pub fn MathcholeskyModel::get(self : MathcholeskyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyModel::set(self : MathcholeskyModel, i : Int, v : Double) -> MathcholeskyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyModel::sum(self : MathcholeskyModel) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyModel::mean(self : MathcholeskyModel) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyModel::scale(self : MathcholeskyModel, f : Double) -> MathcholeskyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyModel::add(self : MathcholeskyModel, other : MathcholeskyModel) -> MathcholeskyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyModel::copy(self : MathcholeskyModel) -> MathcholeskyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyModel::fill(self : MathcholeskyModel, v : Double) -> MathcholeskyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyModel::min(self : MathcholeskyModel) -> Double { @_common.min(self.data) }

pub fn MathcholeskyModel::max(self : MathcholeskyModel) -> Double { @_common.max(self.data) }

pub fn MathcholeskyModel::to_string(self : MathcholeskyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_layer_make(size : Int) -> MathcholeskyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyLayer::len(self : MathcholeskyLayer) -> Int { self.size }

pub fn MathcholeskyLayer::get(self : MathcholeskyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyLayer::set(self : MathcholeskyLayer, i : Int, v : Double) -> MathcholeskyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyLayer::sum(self : MathcholeskyLayer) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyLayer::mean(self : MathcholeskyLayer) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyLayer::scale(self : MathcholeskyLayer, f : Double) -> MathcholeskyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyLayer::add(self : MathcholeskyLayer, other : MathcholeskyLayer) -> MathcholeskyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyLayer::copy(self : MathcholeskyLayer) -> MathcholeskyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyLayer::fill(self : MathcholeskyLayer, v : Double) -> MathcholeskyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyLayer::min(self : MathcholeskyLayer) -> Double { @_common.min(self.data) }

pub fn MathcholeskyLayer::max(self : MathcholeskyLayer) -> Double { @_common.max(self.data) }

pub fn MathcholeskyLayer::to_string(self : MathcholeskyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_buffer_make(size : Int) -> MathcholeskyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyBuffer::len(self : MathcholeskyBuffer) -> Int { self.size }

pub fn MathcholeskyBuffer::get(self : MathcholeskyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyBuffer::set(self : MathcholeskyBuffer, i : Int, v : Double) -> MathcholeskyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyBuffer::sum(self : MathcholeskyBuffer) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyBuffer::mean(self : MathcholeskyBuffer) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyBuffer::scale(self : MathcholeskyBuffer, f : Double) -> MathcholeskyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyBuffer::add(self : MathcholeskyBuffer, other : MathcholeskyBuffer) -> MathcholeskyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyBuffer::copy(self : MathcholeskyBuffer) -> MathcholeskyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyBuffer::fill(self : MathcholeskyBuffer, v : Double) -> MathcholeskyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyBuffer::min(self : MathcholeskyBuffer) -> Double { @_common.min(self.data) }

pub fn MathcholeskyBuffer::max(self : MathcholeskyBuffer) -> Double { @_common.max(self.data) }

pub fn MathcholeskyBuffer::to_string(self : MathcholeskyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_cursor_make(size : Int) -> MathcholeskyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyCursor::len(self : MathcholeskyCursor) -> Int { self.size }

pub fn MathcholeskyCursor::get(self : MathcholeskyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyCursor::set(self : MathcholeskyCursor, i : Int, v : Double) -> MathcholeskyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyCursor::sum(self : MathcholeskyCursor) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyCursor::mean(self : MathcholeskyCursor) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyCursor::scale(self : MathcholeskyCursor, f : Double) -> MathcholeskyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyCursor::add(self : MathcholeskyCursor, other : MathcholeskyCursor) -> MathcholeskyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyCursor::copy(self : MathcholeskyCursor) -> MathcholeskyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyCursor::fill(self : MathcholeskyCursor, v : Double) -> MathcholeskyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyCursor::min(self : MathcholeskyCursor) -> Double { @_common.min(self.data) }

pub fn MathcholeskyCursor::max(self : MathcholeskyCursor) -> Double { @_common.max(self.data) }

pub fn MathcholeskyCursor::to_string(self : MathcholeskyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_view_make(size : Int) -> MathcholeskyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyView::len(self : MathcholeskyView) -> Int { self.size }

pub fn MathcholeskyView::get(self : MathcholeskyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyView::set(self : MathcholeskyView, i : Int, v : Double) -> MathcholeskyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyView::sum(self : MathcholeskyView) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyView::mean(self : MathcholeskyView) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyView::scale(self : MathcholeskyView, f : Double) -> MathcholeskyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyView::add(self : MathcholeskyView, other : MathcholeskyView) -> MathcholeskyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyView::copy(self : MathcholeskyView) -> MathcholeskyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyView::fill(self : MathcholeskyView, v : Double) -> MathcholeskyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyView::min(self : MathcholeskyView) -> Double { @_common.min(self.data) }

pub fn MathcholeskyView::max(self : MathcholeskyView) -> Double { @_common.max(self.data) }

pub fn MathcholeskyView::to_string(self : MathcholeskyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_range_make(size : Int) -> MathcholeskyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskyRange::len(self : MathcholeskyRange) -> Int { self.size }

pub fn MathcholeskyRange::get(self : MathcholeskyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskyRange::set(self : MathcholeskyRange, i : Int, v : Double) -> MathcholeskyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskyRange::sum(self : MathcholeskyRange) -> Double { @_common.sum(self.data) }

pub fn MathcholeskyRange::mean(self : MathcholeskyRange) -> Double { @_common.mean(self.data) }

pub fn MathcholeskyRange::scale(self : MathcholeskyRange, f : Double) -> MathcholeskyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskyRange::add(self : MathcholeskyRange, other : MathcholeskyRange) -> MathcholeskyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskyRange::copy(self : MathcholeskyRange) -> MathcholeskyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskyRange::fill(self : MathcholeskyRange, v : Double) -> MathcholeskyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskyRange::min(self : MathcholeskyRange) -> Double { @_common.min(self.data) }

pub fn MathcholeskyRange::max(self : MathcholeskyRange) -> Double { @_common.max(self.data) }

pub fn MathcholeskyRange::to_string(self : MathcholeskyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcholeskySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_slice_make(size : Int) -> MathcholeskySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcholeskySlice::len(self : MathcholeskySlice) -> Int { self.size }

pub fn MathcholeskySlice::get(self : MathcholeskySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcholeskySlice::set(self : MathcholeskySlice, i : Int, v : Double) -> MathcholeskySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcholeskySlice::sum(self : MathcholeskySlice) -> Double { @_common.sum(self.data) }

pub fn MathcholeskySlice::mean(self : MathcholeskySlice) -> Double { @_common.mean(self.data) }

pub fn MathcholeskySlice::scale(self : MathcholeskySlice, f : Double) -> MathcholeskySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcholeskySlice::add(self : MathcholeskySlice, other : MathcholeskySlice) -> MathcholeskySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcholeskySlice::copy(self : MathcholeskySlice) -> MathcholeskySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcholeskySlice::fill(self : MathcholeskySlice, v : Double) -> MathcholeskySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcholeskySlice::min(self : MathcholeskySlice) -> Double { @_common.min(self.data) }

pub fn MathcholeskySlice::max(self : MathcholeskySlice) -> Double { @_common.max(self.data) }

pub fn MathcholeskySlice::to_string(self : MathcholeskySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

