///===
/// extcore/math_opt_convex

pub(all) struct MathoptconvexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_opt_convex_make_point(x : Double, y : Double) -> MathoptconvexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_opt_convex_make_point3(x : Double, y : Double, z : Double) -> MathoptconvexPoint {
  { x, y, z, label: 0 }
}

pub fn MathoptconvexPoint::x(self : MathoptconvexPoint) -> Double { self.x }

pub fn MathoptconvexPoint::y(self : MathoptconvexPoint) -> Double { self.y }

pub fn MathoptconvexPoint::z(self : MathoptconvexPoint) -> Double { self.z }

pub fn MathoptconvexPoint::label(self : MathoptconvexPoint) -> Int { self.label }

pub fn MathoptconvexPoint::dist(self : MathoptconvexPoint, other : MathoptconvexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathoptconvexPoint::add(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathoptconvexPoint::sub(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathoptconvexPoint::scale(self : MathoptconvexPoint, s : Double) -> MathoptconvexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathoptconvexPoint::dot(self : MathoptconvexPoint, other : MathoptconvexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathoptconvexPoint::cross(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathoptconvexPoint::norm(self : MathoptconvexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathoptconvexPoint::normalize(self : MathoptconvexPoint) -> MathoptconvexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptconvexPoint::negate(self : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathoptconvexPoint::mid(self : MathoptconvexPoint, other : MathoptconvexPoint) -> MathoptconvexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathoptconvexPoint::lerp(self : MathoptconvexPoint, other : MathoptconvexPoint, t : Double) -> MathoptconvexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathoptconvexPoint::to_string(self : MathoptconvexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathoptconvexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_opt_convex_make_series(vals : Array[Double], name : String) -> MathoptconvexSeries {
  { vals, name, meta: 0 }
}

pub fn MathoptconvexSeries::len(self : MathoptconvexSeries) -> Int { self.vals.length() }

pub fn MathoptconvexSeries::sum(self : MathoptconvexSeries) -> Double { @_common.sum(self.vals) }

pub fn MathoptconvexSeries::mean(self : MathoptconvexSeries) -> Double { @_common.mean(self.vals) }

pub fn MathoptconvexSeries::min(self : MathoptconvexSeries) -> Double { @_common.min(self.vals) }

pub fn MathoptconvexSeries::max(self : MathoptconvexSeries) -> Double { @_common.max(self.vals) }

pub fn MathoptconvexSeries::range(self : MathoptconvexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathoptconvexSeries::variance(self : MathoptconvexSeries) -> Double { @_common.variance(self.vals) }

pub fn MathoptconvexSeries::std(self : MathoptconvexSeries) -> Double { @_common.std(self.vals) }

pub fn MathoptconvexSeries::median(self : MathoptconvexSeries) -> Double { @_common.median(self.vals) }

pub fn MathoptconvexSeries::scale(self : MathoptconvexSeries, f : Double) -> MathoptconvexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathoptconvexSeries::add(self : MathoptconvexSeries, other : MathoptconvexSeries) -> MathoptconvexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathoptconvexSeries::sub(self : MathoptconvexSeries, other : MathoptconvexSeries) -> MathoptconvexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathoptconvexSeries::normalize(self : MathoptconvexSeries) -> MathoptconvexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathoptconvexSeries::cumsum(self : MathoptconvexSeries) -> MathoptconvexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathoptconvexSeries::to_string(self : MathoptconvexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptconvexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_opt_convex_make_matrix(rows : Int, cols : Int, val : Double) -> MathoptconvexMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_opt_convex_matrix_identity(n : Int) -> MathoptconvexMatrix {
  let m = math_opt_convex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathoptconvexMatrix::get(self : MathoptconvexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathoptconvexMatrix::transpose(self : MathoptconvexMatrix) -> MathoptconvexMatrix {
  let result = math_opt_convex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathoptconvexMatrix::add(self : MathoptconvexMatrix, other : MathoptconvexMatrix) -> MathoptconvexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_opt_convex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathoptconvexMatrix::scale(self : MathoptconvexMatrix, s : Double) -> MathoptconvexMatrix {
  let result = math_opt_convex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathoptconvexMatrix::multiply(self : MathoptconvexMatrix, other : MathoptconvexMatrix) -> MathoptconvexMatrix {
  if self.cols != other.rows { return math_opt_convex_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_opt_convex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathoptconvexMatrix::trace(self : MathoptconvexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathoptconvexMatrix::det(self : MathoptconvexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathoptconvexMatrix::norm(self : MathoptconvexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathoptconvexMatrix::to_string(self : MathoptconvexMatrix) -> String {
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

pub(all) struct MathoptconvexVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_opt_convex_make_vector(comps : Array[Double]) -> MathoptconvexVector {
  { comps, dim: comps.length() }
}

pub fn math_opt_convex_vector_zero(dim : Int) -> MathoptconvexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathoptconvexVector::add(self : MathoptconvexVector, other : MathoptconvexVector) -> MathoptconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptconvexVector::sub(self : MathoptconvexVector, other : MathoptconvexVector) -> MathoptconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptconvexVector::scale(self : MathoptconvexVector, s : Double) -> MathoptconvexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathoptconvexVector::dot(self : MathoptconvexVector, other : MathoptconvexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathoptconvexVector::norm(self : MathoptconvexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathoptconvexVector::normalize(self : MathoptconvexVector) -> MathoptconvexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptconvexVector::dist(self : MathoptconvexVector, other : MathoptconvexVector) -> Double {
  self.sub(other).norm()
}

pub fn MathoptconvexVector::to_string(self : MathoptconvexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptconvexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_frame_make(size : Int) -> MathoptconvexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexFrame::len(self : MathoptconvexFrame) -> Int { self.size }

pub fn MathoptconvexFrame::get(self : MathoptconvexFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexFrame::set(self : MathoptconvexFrame, i : Int, v : Double) -> MathoptconvexFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexFrame::sum(self : MathoptconvexFrame) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexFrame::mean(self : MathoptconvexFrame) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexFrame::scale(self : MathoptconvexFrame, f : Double) -> MathoptconvexFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexFrame::add(self : MathoptconvexFrame, other : MathoptconvexFrame) -> MathoptconvexFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexFrame::copy(self : MathoptconvexFrame) -> MathoptconvexFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexFrame::fill(self : MathoptconvexFrame, v : Double) -> MathoptconvexFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexFrame::min(self : MathoptconvexFrame) -> Double { @_common.min(self.data) }

pub fn MathoptconvexFrame::max(self : MathoptconvexFrame) -> Double { @_common.max(self.data) }

pub fn MathoptconvexFrame::to_string(self : MathoptconvexFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_table_make(size : Int) -> MathoptconvexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexTable::len(self : MathoptconvexTable) -> Int { self.size }

pub fn MathoptconvexTable::get(self : MathoptconvexTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexTable::set(self : MathoptconvexTable, i : Int, v : Double) -> MathoptconvexTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexTable::sum(self : MathoptconvexTable) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexTable::mean(self : MathoptconvexTable) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexTable::scale(self : MathoptconvexTable, f : Double) -> MathoptconvexTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexTable::add(self : MathoptconvexTable, other : MathoptconvexTable) -> MathoptconvexTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexTable::copy(self : MathoptconvexTable) -> MathoptconvexTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexTable::fill(self : MathoptconvexTable, v : Double) -> MathoptconvexTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexTable::min(self : MathoptconvexTable) -> Double { @_common.min(self.data) }

pub fn MathoptconvexTable::max(self : MathoptconvexTable) -> Double { @_common.max(self.data) }

pub fn MathoptconvexTable::to_string(self : MathoptconvexTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_graphn_make(size : Int) -> MathoptconvexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexGraphN::len(self : MathoptconvexGraphN) -> Int { self.size }

pub fn MathoptconvexGraphN::get(self : MathoptconvexGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexGraphN::set(self : MathoptconvexGraphN, i : Int, v : Double) -> MathoptconvexGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexGraphN::sum(self : MathoptconvexGraphN) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexGraphN::mean(self : MathoptconvexGraphN) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexGraphN::scale(self : MathoptconvexGraphN, f : Double) -> MathoptconvexGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexGraphN::add(self : MathoptconvexGraphN, other : MathoptconvexGraphN) -> MathoptconvexGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexGraphN::copy(self : MathoptconvexGraphN) -> MathoptconvexGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexGraphN::fill(self : MathoptconvexGraphN, v : Double) -> MathoptconvexGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexGraphN::min(self : MathoptconvexGraphN) -> Double { @_common.min(self.data) }

pub fn MathoptconvexGraphN::max(self : MathoptconvexGraphN) -> Double { @_common.max(self.data) }

pub fn MathoptconvexGraphN::to_string(self : MathoptconvexGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_node_make(size : Int) -> MathoptconvexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexNode::len(self : MathoptconvexNode) -> Int { self.size }

pub fn MathoptconvexNode::get(self : MathoptconvexNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexNode::set(self : MathoptconvexNode, i : Int, v : Double) -> MathoptconvexNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexNode::sum(self : MathoptconvexNode) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexNode::mean(self : MathoptconvexNode) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexNode::scale(self : MathoptconvexNode, f : Double) -> MathoptconvexNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexNode::add(self : MathoptconvexNode, other : MathoptconvexNode) -> MathoptconvexNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexNode::copy(self : MathoptconvexNode) -> MathoptconvexNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexNode::fill(self : MathoptconvexNode, v : Double) -> MathoptconvexNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexNode::min(self : MathoptconvexNode) -> Double { @_common.min(self.data) }

pub fn MathoptconvexNode::max(self : MathoptconvexNode) -> Double { @_common.max(self.data) }

pub fn MathoptconvexNode::to_string(self : MathoptconvexNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_edge_make(size : Int) -> MathoptconvexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexEdge::len(self : MathoptconvexEdge) -> Int { self.size }

pub fn MathoptconvexEdge::get(self : MathoptconvexEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexEdge::set(self : MathoptconvexEdge, i : Int, v : Double) -> MathoptconvexEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexEdge::sum(self : MathoptconvexEdge) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexEdge::mean(self : MathoptconvexEdge) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexEdge::scale(self : MathoptconvexEdge, f : Double) -> MathoptconvexEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexEdge::add(self : MathoptconvexEdge, other : MathoptconvexEdge) -> MathoptconvexEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexEdge::copy(self : MathoptconvexEdge) -> MathoptconvexEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexEdge::fill(self : MathoptconvexEdge, v : Double) -> MathoptconvexEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexEdge::min(self : MathoptconvexEdge) -> Double { @_common.min(self.data) }

pub fn MathoptconvexEdge::max(self : MathoptconvexEdge) -> Double { @_common.max(self.data) }

pub fn MathoptconvexEdge::to_string(self : MathoptconvexEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_path_make(size : Int) -> MathoptconvexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexPath::len(self : MathoptconvexPath) -> Int { self.size }

pub fn MathoptconvexPath::get(self : MathoptconvexPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexPath::set(self : MathoptconvexPath, i : Int, v : Double) -> MathoptconvexPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexPath::sum(self : MathoptconvexPath) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexPath::mean(self : MathoptconvexPath) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexPath::scale(self : MathoptconvexPath, f : Double) -> MathoptconvexPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexPath::add(self : MathoptconvexPath, other : MathoptconvexPath) -> MathoptconvexPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexPath::copy(self : MathoptconvexPath) -> MathoptconvexPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexPath::fill(self : MathoptconvexPath, v : Double) -> MathoptconvexPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexPath::min(self : MathoptconvexPath) -> Double { @_common.min(self.data) }

pub fn MathoptconvexPath::max(self : MathoptconvexPath) -> Double { @_common.max(self.data) }

pub fn MathoptconvexPath::to_string(self : MathoptconvexPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_cluster_make(size : Int) -> MathoptconvexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexCluster::len(self : MathoptconvexCluster) -> Int { self.size }

pub fn MathoptconvexCluster::get(self : MathoptconvexCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexCluster::set(self : MathoptconvexCluster, i : Int, v : Double) -> MathoptconvexCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexCluster::sum(self : MathoptconvexCluster) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexCluster::mean(self : MathoptconvexCluster) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexCluster::scale(self : MathoptconvexCluster, f : Double) -> MathoptconvexCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexCluster::add(self : MathoptconvexCluster, other : MathoptconvexCluster) -> MathoptconvexCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexCluster::copy(self : MathoptconvexCluster) -> MathoptconvexCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexCluster::fill(self : MathoptconvexCluster, v : Double) -> MathoptconvexCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexCluster::min(self : MathoptconvexCluster) -> Double { @_common.min(self.data) }

pub fn MathoptconvexCluster::max(self : MathoptconvexCluster) -> Double { @_common.max(self.data) }

pub fn MathoptconvexCluster::to_string(self : MathoptconvexCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_model_make(size : Int) -> MathoptconvexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexModel::len(self : MathoptconvexModel) -> Int { self.size }

pub fn MathoptconvexModel::get(self : MathoptconvexModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexModel::set(self : MathoptconvexModel, i : Int, v : Double) -> MathoptconvexModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexModel::sum(self : MathoptconvexModel) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexModel::mean(self : MathoptconvexModel) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexModel::scale(self : MathoptconvexModel, f : Double) -> MathoptconvexModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexModel::add(self : MathoptconvexModel, other : MathoptconvexModel) -> MathoptconvexModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexModel::copy(self : MathoptconvexModel) -> MathoptconvexModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexModel::fill(self : MathoptconvexModel, v : Double) -> MathoptconvexModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexModel::min(self : MathoptconvexModel) -> Double { @_common.min(self.data) }

pub fn MathoptconvexModel::max(self : MathoptconvexModel) -> Double { @_common.max(self.data) }

pub fn MathoptconvexModel::to_string(self : MathoptconvexModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_layer_make(size : Int) -> MathoptconvexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexLayer::len(self : MathoptconvexLayer) -> Int { self.size }

pub fn MathoptconvexLayer::get(self : MathoptconvexLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexLayer::set(self : MathoptconvexLayer, i : Int, v : Double) -> MathoptconvexLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexLayer::sum(self : MathoptconvexLayer) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexLayer::mean(self : MathoptconvexLayer) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexLayer::scale(self : MathoptconvexLayer, f : Double) -> MathoptconvexLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexLayer::add(self : MathoptconvexLayer, other : MathoptconvexLayer) -> MathoptconvexLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexLayer::copy(self : MathoptconvexLayer) -> MathoptconvexLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexLayer::fill(self : MathoptconvexLayer, v : Double) -> MathoptconvexLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexLayer::min(self : MathoptconvexLayer) -> Double { @_common.min(self.data) }

pub fn MathoptconvexLayer::max(self : MathoptconvexLayer) -> Double { @_common.max(self.data) }

pub fn MathoptconvexLayer::to_string(self : MathoptconvexLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_buffer_make(size : Int) -> MathoptconvexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexBuffer::len(self : MathoptconvexBuffer) -> Int { self.size }

pub fn MathoptconvexBuffer::get(self : MathoptconvexBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexBuffer::set(self : MathoptconvexBuffer, i : Int, v : Double) -> MathoptconvexBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexBuffer::sum(self : MathoptconvexBuffer) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexBuffer::mean(self : MathoptconvexBuffer) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexBuffer::scale(self : MathoptconvexBuffer, f : Double) -> MathoptconvexBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexBuffer::add(self : MathoptconvexBuffer, other : MathoptconvexBuffer) -> MathoptconvexBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexBuffer::copy(self : MathoptconvexBuffer) -> MathoptconvexBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexBuffer::fill(self : MathoptconvexBuffer, v : Double) -> MathoptconvexBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexBuffer::min(self : MathoptconvexBuffer) -> Double { @_common.min(self.data) }

pub fn MathoptconvexBuffer::max(self : MathoptconvexBuffer) -> Double { @_common.max(self.data) }

pub fn MathoptconvexBuffer::to_string(self : MathoptconvexBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_cursor_make(size : Int) -> MathoptconvexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexCursor::len(self : MathoptconvexCursor) -> Int { self.size }

pub fn MathoptconvexCursor::get(self : MathoptconvexCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexCursor::set(self : MathoptconvexCursor, i : Int, v : Double) -> MathoptconvexCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexCursor::sum(self : MathoptconvexCursor) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexCursor::mean(self : MathoptconvexCursor) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexCursor::scale(self : MathoptconvexCursor, f : Double) -> MathoptconvexCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexCursor::add(self : MathoptconvexCursor, other : MathoptconvexCursor) -> MathoptconvexCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexCursor::copy(self : MathoptconvexCursor) -> MathoptconvexCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexCursor::fill(self : MathoptconvexCursor, v : Double) -> MathoptconvexCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexCursor::min(self : MathoptconvexCursor) -> Double { @_common.min(self.data) }

pub fn MathoptconvexCursor::max(self : MathoptconvexCursor) -> Double { @_common.max(self.data) }

pub fn MathoptconvexCursor::to_string(self : MathoptconvexCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_view_make(size : Int) -> MathoptconvexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexView::len(self : MathoptconvexView) -> Int { self.size }

pub fn MathoptconvexView::get(self : MathoptconvexView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexView::set(self : MathoptconvexView, i : Int, v : Double) -> MathoptconvexView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexView::sum(self : MathoptconvexView) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexView::mean(self : MathoptconvexView) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexView::scale(self : MathoptconvexView, f : Double) -> MathoptconvexView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexView::add(self : MathoptconvexView, other : MathoptconvexView) -> MathoptconvexView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexView::copy(self : MathoptconvexView) -> MathoptconvexView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexView::fill(self : MathoptconvexView, v : Double) -> MathoptconvexView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexView::min(self : MathoptconvexView) -> Double { @_common.min(self.data) }

pub fn MathoptconvexView::max(self : MathoptconvexView) -> Double { @_common.max(self.data) }

pub fn MathoptconvexView::to_string(self : MathoptconvexView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_range_make(size : Int) -> MathoptconvexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexRange::len(self : MathoptconvexRange) -> Int { self.size }

pub fn MathoptconvexRange::get(self : MathoptconvexRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexRange::set(self : MathoptconvexRange, i : Int, v : Double) -> MathoptconvexRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexRange::sum(self : MathoptconvexRange) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexRange::mean(self : MathoptconvexRange) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexRange::scale(self : MathoptconvexRange, f : Double) -> MathoptconvexRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexRange::add(self : MathoptconvexRange, other : MathoptconvexRange) -> MathoptconvexRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexRange::copy(self : MathoptconvexRange) -> MathoptconvexRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexRange::fill(self : MathoptconvexRange, v : Double) -> MathoptconvexRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexRange::min(self : MathoptconvexRange) -> Double { @_common.min(self.data) }

pub fn MathoptconvexRange::max(self : MathoptconvexRange) -> Double { @_common.max(self.data) }

pub fn MathoptconvexRange::to_string(self : MathoptconvexRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptconvexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_convex_slice_make(size : Int) -> MathoptconvexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptconvexSlice::len(self : MathoptconvexSlice) -> Int { self.size }

pub fn MathoptconvexSlice::get(self : MathoptconvexSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptconvexSlice::set(self : MathoptconvexSlice, i : Int, v : Double) -> MathoptconvexSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptconvexSlice::sum(self : MathoptconvexSlice) -> Double { @_common.sum(self.data) }

pub fn MathoptconvexSlice::mean(self : MathoptconvexSlice) -> Double { @_common.mean(self.data) }

pub fn MathoptconvexSlice::scale(self : MathoptconvexSlice, f : Double) -> MathoptconvexSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptconvexSlice::add(self : MathoptconvexSlice, other : MathoptconvexSlice) -> MathoptconvexSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptconvexSlice::copy(self : MathoptconvexSlice) -> MathoptconvexSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptconvexSlice::fill(self : MathoptconvexSlice, v : Double) -> MathoptconvexSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptconvexSlice::min(self : MathoptconvexSlice) -> Double { @_common.min(self.data) }

pub fn MathoptconvexSlice::max(self : MathoptconvexSlice) -> Double { @_common.max(self.data) }

pub fn MathoptconvexSlice::to_string(self : MathoptconvexSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

