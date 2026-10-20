///===
/// extcore/math_opt_nonconvex

pub(all) struct MathoptnonconvexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_opt_nonconvex_make_point(x : Double, y : Double) -> MathoptnonconvexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_opt_nonconvex_make_point3(x : Double, y : Double, z : Double) -> MathoptnonconvexPoint {
  { x, y, z, label: 0 }
}

pub fn MathoptnonconvexPoint::x(self : MathoptnonconvexPoint) -> Double { self.x }

pub fn MathoptnonconvexPoint::y(self : MathoptnonconvexPoint) -> Double { self.y }

pub fn MathoptnonconvexPoint::z(self : MathoptnonconvexPoint) -> Double { self.z }

pub fn MathoptnonconvexPoint::label(self : MathoptnonconvexPoint) -> Int { self.label }

pub fn MathoptnonconvexPoint::dist(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathoptnonconvexPoint::add(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathoptnonconvexPoint::sub(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathoptnonconvexPoint::scale(self : MathoptnonconvexPoint, s : Double) -> MathoptnonconvexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathoptnonconvexPoint::dot(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathoptnonconvexPoint::cross(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathoptnonconvexPoint::norm(self : MathoptnonconvexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathoptnonconvexPoint::normalize(self : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptnonconvexPoint::negate(self : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathoptnonconvexPoint::mid(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint) -> MathoptnonconvexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathoptnonconvexPoint::lerp(self : MathoptnonconvexPoint, other : MathoptnonconvexPoint, t : Double) -> MathoptnonconvexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathoptnonconvexPoint::to_string(self : MathoptnonconvexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathoptnonconvexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_opt_nonconvex_make_series(vals : Array[Double], name : String) -> MathoptnonconvexSeries {
  { vals, name, meta: 0 }
}

pub fn MathoptnonconvexSeries::len(self : MathoptnonconvexSeries) -> Int { self.vals.length() }

pub fn MathoptnonconvexSeries::sum(self : MathoptnonconvexSeries) -> Double { @_common.sum(self.vals) }

pub fn MathoptnonconvexSeries::mean(self : MathoptnonconvexSeries) -> Double { @_common.mean(self.vals) }

pub fn MathoptnonconvexSeries::min(self : MathoptnonconvexSeries) -> Double { @_common.min(self.vals) }

pub fn MathoptnonconvexSeries::max(self : MathoptnonconvexSeries) -> Double { @_common.max(self.vals) }

pub fn MathoptnonconvexSeries::range(self : MathoptnonconvexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathoptnonconvexSeries::variance(self : MathoptnonconvexSeries) -> Double { @_common.variance(self.vals) }

pub fn MathoptnonconvexSeries::std(self : MathoptnonconvexSeries) -> Double { @_common.std(self.vals) }

pub fn MathoptnonconvexSeries::median(self : MathoptnonconvexSeries) -> Double { @_common.median(self.vals) }

pub fn MathoptnonconvexSeries::scale(self : MathoptnonconvexSeries, f : Double) -> MathoptnonconvexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathoptnonconvexSeries::add(self : MathoptnonconvexSeries, other : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathoptnonconvexSeries::sub(self : MathoptnonconvexSeries, other : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathoptnonconvexSeries::normalize(self : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathoptnonconvexSeries::cumsum(self : MathoptnonconvexSeries) -> MathoptnonconvexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathoptnonconvexSeries::to_string(self : MathoptnonconvexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptnonconvexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_opt_nonconvex_make_matrix(rows : Int, cols : Int, val : Double) -> MathoptnonconvexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_opt_nonconvex_matrix_identity(n : Int) -> MathoptnonconvexMatrix {
  let m = math_opt_nonconvex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathoptnonconvexMatrix::get(self : MathoptnonconvexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathoptnonconvexMatrix::transpose(self : MathoptnonconvexMatrix) -> MathoptnonconvexMatrix {
  let result = math_opt_nonconvex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathoptnonconvexMatrix::add(self : MathoptnonconvexMatrix, other : MathoptnonconvexMatrix) -> MathoptnonconvexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_opt_nonconvex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathoptnonconvexMatrix::scale(self : MathoptnonconvexMatrix, s : Double) -> MathoptnonconvexMatrix {
  let result = math_opt_nonconvex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathoptnonconvexMatrix::multiply(self : MathoptnonconvexMatrix, other : MathoptnonconvexMatrix) -> MathoptnonconvexMatrix {
  if self.cols != other.rows { return math_opt_nonconvex_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_opt_nonconvex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathoptnonconvexMatrix::trace(self : MathoptnonconvexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathoptnonconvexMatrix::det(self : MathoptnonconvexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathoptnonconvexMatrix::norm(self : MathoptnonconvexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathoptnonconvexMatrix::to_string(self : MathoptnonconvexMatrix) -> String {
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

pub(all) struct MathoptnonconvexVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_opt_nonconvex_make_vector(comps : Array[Double]) -> MathoptnonconvexVector {
  { comps, dim: comps.length() }
}

pub fn math_opt_nonconvex_vector_zero(dim : Int) -> MathoptnonconvexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathoptnonconvexVector::add(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> MathoptnonconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptnonconvexVector::sub(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> MathoptnonconvexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathoptnonconvexVector::scale(self : MathoptnonconvexVector, s : Double) -> MathoptnonconvexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathoptnonconvexVector::dot(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathoptnonconvexVector::norm(self : MathoptnonconvexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathoptnonconvexVector::normalize(self : MathoptnonconvexVector) -> MathoptnonconvexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathoptnonconvexVector::dist(self : MathoptnonconvexVector, other : MathoptnonconvexVector) -> Double {
  self.sub(other).norm()
}

pub fn MathoptnonconvexVector::to_string(self : MathoptnonconvexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathoptnonconvexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_frame_make(size : Int) -> MathoptnonconvexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexFrame::len(self : MathoptnonconvexFrame) -> Int { self.size }

pub fn MathoptnonconvexFrame::get(self : MathoptnonconvexFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexFrame::set(self : MathoptnonconvexFrame, i : Int, v : Double) -> MathoptnonconvexFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexFrame::sum(self : MathoptnonconvexFrame) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexFrame::mean(self : MathoptnonconvexFrame) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexFrame::scale(self : MathoptnonconvexFrame, f : Double) -> MathoptnonconvexFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexFrame::add(self : MathoptnonconvexFrame, other : MathoptnonconvexFrame) -> MathoptnonconvexFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexFrame::copy(self : MathoptnonconvexFrame) -> MathoptnonconvexFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexFrame::fill(self : MathoptnonconvexFrame, v : Double) -> MathoptnonconvexFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexFrame::min(self : MathoptnonconvexFrame) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexFrame::max(self : MathoptnonconvexFrame) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexFrame::to_string(self : MathoptnonconvexFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_table_make(size : Int) -> MathoptnonconvexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexTable::len(self : MathoptnonconvexTable) -> Int { self.size }

pub fn MathoptnonconvexTable::get(self : MathoptnonconvexTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexTable::set(self : MathoptnonconvexTable, i : Int, v : Double) -> MathoptnonconvexTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexTable::sum(self : MathoptnonconvexTable) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexTable::mean(self : MathoptnonconvexTable) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexTable::scale(self : MathoptnonconvexTable, f : Double) -> MathoptnonconvexTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexTable::add(self : MathoptnonconvexTable, other : MathoptnonconvexTable) -> MathoptnonconvexTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexTable::copy(self : MathoptnonconvexTable) -> MathoptnonconvexTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexTable::fill(self : MathoptnonconvexTable, v : Double) -> MathoptnonconvexTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexTable::min(self : MathoptnonconvexTable) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexTable::max(self : MathoptnonconvexTable) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexTable::to_string(self : MathoptnonconvexTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_graphn_make(size : Int) -> MathoptnonconvexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexGraphN::len(self : MathoptnonconvexGraphN) -> Int { self.size }

pub fn MathoptnonconvexGraphN::get(self : MathoptnonconvexGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexGraphN::set(self : MathoptnonconvexGraphN, i : Int, v : Double) -> MathoptnonconvexGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexGraphN::sum(self : MathoptnonconvexGraphN) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexGraphN::mean(self : MathoptnonconvexGraphN) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexGraphN::scale(self : MathoptnonconvexGraphN, f : Double) -> MathoptnonconvexGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexGraphN::add(self : MathoptnonconvexGraphN, other : MathoptnonconvexGraphN) -> MathoptnonconvexGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexGraphN::copy(self : MathoptnonconvexGraphN) -> MathoptnonconvexGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexGraphN::fill(self : MathoptnonconvexGraphN, v : Double) -> MathoptnonconvexGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexGraphN::min(self : MathoptnonconvexGraphN) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexGraphN::max(self : MathoptnonconvexGraphN) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexGraphN::to_string(self : MathoptnonconvexGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_node_make(size : Int) -> MathoptnonconvexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexNode::len(self : MathoptnonconvexNode) -> Int { self.size }

pub fn MathoptnonconvexNode::get(self : MathoptnonconvexNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexNode::set(self : MathoptnonconvexNode, i : Int, v : Double) -> MathoptnonconvexNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexNode::sum(self : MathoptnonconvexNode) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexNode::mean(self : MathoptnonconvexNode) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexNode::scale(self : MathoptnonconvexNode, f : Double) -> MathoptnonconvexNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexNode::add(self : MathoptnonconvexNode, other : MathoptnonconvexNode) -> MathoptnonconvexNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexNode::copy(self : MathoptnonconvexNode) -> MathoptnonconvexNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexNode::fill(self : MathoptnonconvexNode, v : Double) -> MathoptnonconvexNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexNode::min(self : MathoptnonconvexNode) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexNode::max(self : MathoptnonconvexNode) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexNode::to_string(self : MathoptnonconvexNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_edge_make(size : Int) -> MathoptnonconvexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexEdge::len(self : MathoptnonconvexEdge) -> Int { self.size }

pub fn MathoptnonconvexEdge::get(self : MathoptnonconvexEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexEdge::set(self : MathoptnonconvexEdge, i : Int, v : Double) -> MathoptnonconvexEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexEdge::sum(self : MathoptnonconvexEdge) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexEdge::mean(self : MathoptnonconvexEdge) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexEdge::scale(self : MathoptnonconvexEdge, f : Double) -> MathoptnonconvexEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexEdge::add(self : MathoptnonconvexEdge, other : MathoptnonconvexEdge) -> MathoptnonconvexEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexEdge::copy(self : MathoptnonconvexEdge) -> MathoptnonconvexEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexEdge::fill(self : MathoptnonconvexEdge, v : Double) -> MathoptnonconvexEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexEdge::min(self : MathoptnonconvexEdge) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexEdge::max(self : MathoptnonconvexEdge) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexEdge::to_string(self : MathoptnonconvexEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_path_make(size : Int) -> MathoptnonconvexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexPath::len(self : MathoptnonconvexPath) -> Int { self.size }

pub fn MathoptnonconvexPath::get(self : MathoptnonconvexPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexPath::set(self : MathoptnonconvexPath, i : Int, v : Double) -> MathoptnonconvexPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexPath::sum(self : MathoptnonconvexPath) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexPath::mean(self : MathoptnonconvexPath) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexPath::scale(self : MathoptnonconvexPath, f : Double) -> MathoptnonconvexPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexPath::add(self : MathoptnonconvexPath, other : MathoptnonconvexPath) -> MathoptnonconvexPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexPath::copy(self : MathoptnonconvexPath) -> MathoptnonconvexPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexPath::fill(self : MathoptnonconvexPath, v : Double) -> MathoptnonconvexPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexPath::min(self : MathoptnonconvexPath) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexPath::max(self : MathoptnonconvexPath) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexPath::to_string(self : MathoptnonconvexPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_cluster_make(size : Int) -> MathoptnonconvexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexCluster::len(self : MathoptnonconvexCluster) -> Int { self.size }

pub fn MathoptnonconvexCluster::get(self : MathoptnonconvexCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexCluster::set(self : MathoptnonconvexCluster, i : Int, v : Double) -> MathoptnonconvexCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCluster::sum(self : MathoptnonconvexCluster) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexCluster::mean(self : MathoptnonconvexCluster) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexCluster::scale(self : MathoptnonconvexCluster, f : Double) -> MathoptnonconvexCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCluster::add(self : MathoptnonconvexCluster, other : MathoptnonconvexCluster) -> MathoptnonconvexCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexCluster::copy(self : MathoptnonconvexCluster) -> MathoptnonconvexCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCluster::fill(self : MathoptnonconvexCluster, v : Double) -> MathoptnonconvexCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCluster::min(self : MathoptnonconvexCluster) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexCluster::max(self : MathoptnonconvexCluster) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexCluster::to_string(self : MathoptnonconvexCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_model_make(size : Int) -> MathoptnonconvexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexModel::len(self : MathoptnonconvexModel) -> Int { self.size }

pub fn MathoptnonconvexModel::get(self : MathoptnonconvexModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexModel::set(self : MathoptnonconvexModel, i : Int, v : Double) -> MathoptnonconvexModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexModel::sum(self : MathoptnonconvexModel) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexModel::mean(self : MathoptnonconvexModel) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexModel::scale(self : MathoptnonconvexModel, f : Double) -> MathoptnonconvexModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexModel::add(self : MathoptnonconvexModel, other : MathoptnonconvexModel) -> MathoptnonconvexModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexModel::copy(self : MathoptnonconvexModel) -> MathoptnonconvexModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexModel::fill(self : MathoptnonconvexModel, v : Double) -> MathoptnonconvexModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexModel::min(self : MathoptnonconvexModel) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexModel::max(self : MathoptnonconvexModel) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexModel::to_string(self : MathoptnonconvexModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_layer_make(size : Int) -> MathoptnonconvexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexLayer::len(self : MathoptnonconvexLayer) -> Int { self.size }

pub fn MathoptnonconvexLayer::get(self : MathoptnonconvexLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexLayer::set(self : MathoptnonconvexLayer, i : Int, v : Double) -> MathoptnonconvexLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexLayer::sum(self : MathoptnonconvexLayer) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexLayer::mean(self : MathoptnonconvexLayer) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexLayer::scale(self : MathoptnonconvexLayer, f : Double) -> MathoptnonconvexLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexLayer::add(self : MathoptnonconvexLayer, other : MathoptnonconvexLayer) -> MathoptnonconvexLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexLayer::copy(self : MathoptnonconvexLayer) -> MathoptnonconvexLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexLayer::fill(self : MathoptnonconvexLayer, v : Double) -> MathoptnonconvexLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexLayer::min(self : MathoptnonconvexLayer) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexLayer::max(self : MathoptnonconvexLayer) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexLayer::to_string(self : MathoptnonconvexLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_buffer_make(size : Int) -> MathoptnonconvexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexBuffer::len(self : MathoptnonconvexBuffer) -> Int { self.size }

pub fn MathoptnonconvexBuffer::get(self : MathoptnonconvexBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexBuffer::set(self : MathoptnonconvexBuffer, i : Int, v : Double) -> MathoptnonconvexBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexBuffer::sum(self : MathoptnonconvexBuffer) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexBuffer::mean(self : MathoptnonconvexBuffer) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexBuffer::scale(self : MathoptnonconvexBuffer, f : Double) -> MathoptnonconvexBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexBuffer::add(self : MathoptnonconvexBuffer, other : MathoptnonconvexBuffer) -> MathoptnonconvexBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexBuffer::copy(self : MathoptnonconvexBuffer) -> MathoptnonconvexBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexBuffer::fill(self : MathoptnonconvexBuffer, v : Double) -> MathoptnonconvexBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexBuffer::min(self : MathoptnonconvexBuffer) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexBuffer::max(self : MathoptnonconvexBuffer) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexBuffer::to_string(self : MathoptnonconvexBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_cursor_make(size : Int) -> MathoptnonconvexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexCursor::len(self : MathoptnonconvexCursor) -> Int { self.size }

pub fn MathoptnonconvexCursor::get(self : MathoptnonconvexCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexCursor::set(self : MathoptnonconvexCursor, i : Int, v : Double) -> MathoptnonconvexCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCursor::sum(self : MathoptnonconvexCursor) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexCursor::mean(self : MathoptnonconvexCursor) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexCursor::scale(self : MathoptnonconvexCursor, f : Double) -> MathoptnonconvexCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCursor::add(self : MathoptnonconvexCursor, other : MathoptnonconvexCursor) -> MathoptnonconvexCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexCursor::copy(self : MathoptnonconvexCursor) -> MathoptnonconvexCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCursor::fill(self : MathoptnonconvexCursor, v : Double) -> MathoptnonconvexCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexCursor::min(self : MathoptnonconvexCursor) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexCursor::max(self : MathoptnonconvexCursor) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexCursor::to_string(self : MathoptnonconvexCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_view_make(size : Int) -> MathoptnonconvexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexView::len(self : MathoptnonconvexView) -> Int { self.size }

pub fn MathoptnonconvexView::get(self : MathoptnonconvexView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexView::set(self : MathoptnonconvexView, i : Int, v : Double) -> MathoptnonconvexView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexView::sum(self : MathoptnonconvexView) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexView::mean(self : MathoptnonconvexView) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexView::scale(self : MathoptnonconvexView, f : Double) -> MathoptnonconvexView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexView::add(self : MathoptnonconvexView, other : MathoptnonconvexView) -> MathoptnonconvexView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexView::copy(self : MathoptnonconvexView) -> MathoptnonconvexView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexView::fill(self : MathoptnonconvexView, v : Double) -> MathoptnonconvexView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexView::min(self : MathoptnonconvexView) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexView::max(self : MathoptnonconvexView) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexView::to_string(self : MathoptnonconvexView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_range_make(size : Int) -> MathoptnonconvexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexRange::len(self : MathoptnonconvexRange) -> Int { self.size }

pub fn MathoptnonconvexRange::get(self : MathoptnonconvexRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexRange::set(self : MathoptnonconvexRange, i : Int, v : Double) -> MathoptnonconvexRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexRange::sum(self : MathoptnonconvexRange) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexRange::mean(self : MathoptnonconvexRange) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexRange::scale(self : MathoptnonconvexRange, f : Double) -> MathoptnonconvexRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexRange::add(self : MathoptnonconvexRange, other : MathoptnonconvexRange) -> MathoptnonconvexRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexRange::copy(self : MathoptnonconvexRange) -> MathoptnonconvexRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexRange::fill(self : MathoptnonconvexRange, v : Double) -> MathoptnonconvexRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexRange::min(self : MathoptnonconvexRange) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexRange::max(self : MathoptnonconvexRange) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexRange::to_string(self : MathoptnonconvexRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathoptnonconvexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_opt_nonconvex_slice_make(size : Int) -> MathoptnonconvexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathoptnonconvexSlice::len(self : MathoptnonconvexSlice) -> Int { self.size }

pub fn MathoptnonconvexSlice::get(self : MathoptnonconvexSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathoptnonconvexSlice::set(self : MathoptnonconvexSlice, i : Int, v : Double) -> MathoptnonconvexSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexSlice::sum(self : MathoptnonconvexSlice) -> Double { @_common.sum(self.data) }

pub fn MathoptnonconvexSlice::mean(self : MathoptnonconvexSlice) -> Double { @_common.mean(self.data) }

pub fn MathoptnonconvexSlice::scale(self : MathoptnonconvexSlice, f : Double) -> MathoptnonconvexSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexSlice::add(self : MathoptnonconvexSlice, other : MathoptnonconvexSlice) -> MathoptnonconvexSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathoptnonconvexSlice::copy(self : MathoptnonconvexSlice) -> MathoptnonconvexSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexSlice::fill(self : MathoptnonconvexSlice, v : Double) -> MathoptnonconvexSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathoptnonconvexSlice::min(self : MathoptnonconvexSlice) -> Double { @_common.min(self.data) }

pub fn MathoptnonconvexSlice::max(self : MathoptnonconvexSlice) -> Double { @_common.max(self.data) }

pub fn MathoptnonconvexSlice::to_string(self : MathoptnonconvexSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

