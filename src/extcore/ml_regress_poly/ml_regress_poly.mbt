///===
/// extcore/ml_regress_poly

pub(all) struct MlregresspolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_poly_make_point(x : Double, y : Double) -> MlregresspolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_poly_make_point3(x : Double, y : Double, z : Double) -> MlregresspolyPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresspolyPoint::x(self : MlregresspolyPoint) -> Double { self.x }

pub fn MlregresspolyPoint::y(self : MlregresspolyPoint) -> Double { self.y }

pub fn MlregresspolyPoint::z(self : MlregresspolyPoint) -> Double { self.z }

pub fn MlregresspolyPoint::label(self : MlregresspolyPoint) -> Int { self.label }

pub fn MlregresspolyPoint::dist(self : MlregresspolyPoint, other : MlregresspolyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresspolyPoint::add(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresspolyPoint::sub(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresspolyPoint::scale(self : MlregresspolyPoint, s : Double) -> MlregresspolyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresspolyPoint::dot(self : MlregresspolyPoint, other : MlregresspolyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresspolyPoint::cross(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresspolyPoint::norm(self : MlregresspolyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresspolyPoint::normalize(self : MlregresspolyPoint) -> MlregresspolyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspolyPoint::negate(self : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresspolyPoint::mid(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresspolyPoint::lerp(self : MlregresspolyPoint, other : MlregresspolyPoint, t : Double) -> MlregresspolyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresspolyPoint::to_string(self : MlregresspolyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresspolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_poly_make_series(vals : Array[Double], name : String) -> MlregresspolySeries {
  { vals, name, meta: 0 }
}

pub fn MlregresspolySeries::len(self : MlregresspolySeries) -> Int { self.vals.length() }

pub fn MlregresspolySeries::sum(self : MlregresspolySeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresspolySeries::mean(self : MlregresspolySeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresspolySeries::min(self : MlregresspolySeries) -> Double { @_common.min(self.vals) }

pub fn MlregresspolySeries::max(self : MlregresspolySeries) -> Double { @_common.max(self.vals) }

pub fn MlregresspolySeries::range(self : MlregresspolySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresspolySeries::variance(self : MlregresspolySeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresspolySeries::std(self : MlregresspolySeries) -> Double { @_common.std(self.vals) }

pub fn MlregresspolySeries::median(self : MlregresspolySeries) -> Double { @_common.median(self.vals) }

pub fn MlregresspolySeries::scale(self : MlregresspolySeries, f : Double) -> MlregresspolySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresspolySeries::add(self : MlregresspolySeries, other : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresspolySeries::sub(self : MlregresspolySeries, other : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresspolySeries::normalize(self : MlregresspolySeries) -> MlregresspolySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresspolySeries::cumsum(self : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresspolySeries::to_string(self : MlregresspolySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresspolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_poly_matrix_identity(n : Int) -> MlregresspolyMatrix {
  let m = ml_regress_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresspolyMatrix::get(self : MlregresspolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresspolyMatrix::transpose(self : MlregresspolyMatrix) -> MlregresspolyMatrix {
  let result = ml_regress_poly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresspolyMatrix::add(self : MlregresspolyMatrix, other : MlregresspolyMatrix) -> MlregresspolyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresspolyMatrix::scale(self : MlregresspolyMatrix, s : Double) -> MlregresspolyMatrix {
  let result = ml_regress_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresspolyMatrix::multiply(self : MlregresspolyMatrix, other : MlregresspolyMatrix) -> MlregresspolyMatrix {
  if self.cols != other.rows { return ml_regress_poly_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_poly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlregresspolyMatrix::trace(self : MlregresspolyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresspolyMatrix::det(self : MlregresspolyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresspolyMatrix::norm(self : MlregresspolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresspolyMatrix::to_string(self : MlregresspolyMatrix) -> String {
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

pub(all) struct MlregresspolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_poly_make_vector(comps : Array[Double]) -> MlregresspolyVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_poly_vector_zero(dim : Int) -> MlregresspolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresspolyVector::add(self : MlregresspolyVector, other : MlregresspolyVector) -> MlregresspolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspolyVector::sub(self : MlregresspolyVector, other : MlregresspolyVector) -> MlregresspolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspolyVector::scale(self : MlregresspolyVector, s : Double) -> MlregresspolyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresspolyVector::dot(self : MlregresspolyVector, other : MlregresspolyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresspolyVector::norm(self : MlregresspolyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresspolyVector::normalize(self : MlregresspolyVector) -> MlregresspolyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspolyVector::dist(self : MlregresspolyVector, other : MlregresspolyVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresspolyVector::to_string(self : MlregresspolyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_frame_make(size : Int) -> MlregresspolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyFrame::len(self : MlregresspolyFrame) -> Int { self.size }

pub fn MlregresspolyFrame::get(self : MlregresspolyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyFrame::set(self : MlregresspolyFrame, i : Int, v : Double) -> MlregresspolyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyFrame::sum(self : MlregresspolyFrame) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyFrame::mean(self : MlregresspolyFrame) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyFrame::scale(self : MlregresspolyFrame, f : Double) -> MlregresspolyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyFrame::add(self : MlregresspolyFrame, other : MlregresspolyFrame) -> MlregresspolyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyFrame::copy(self : MlregresspolyFrame) -> MlregresspolyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyFrame::fill(self : MlregresspolyFrame, v : Double) -> MlregresspolyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyFrame::min(self : MlregresspolyFrame) -> Double { @_common.min(self.data) }

pub fn MlregresspolyFrame::max(self : MlregresspolyFrame) -> Double { @_common.max(self.data) }

pub fn MlregresspolyFrame::to_string(self : MlregresspolyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_table_make(size : Int) -> MlregresspolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyTable::len(self : MlregresspolyTable) -> Int { self.size }

pub fn MlregresspolyTable::get(self : MlregresspolyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyTable::set(self : MlregresspolyTable, i : Int, v : Double) -> MlregresspolyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyTable::sum(self : MlregresspolyTable) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyTable::mean(self : MlregresspolyTable) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyTable::scale(self : MlregresspolyTable, f : Double) -> MlregresspolyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyTable::add(self : MlregresspolyTable, other : MlregresspolyTable) -> MlregresspolyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyTable::copy(self : MlregresspolyTable) -> MlregresspolyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyTable::fill(self : MlregresspolyTable, v : Double) -> MlregresspolyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyTable::min(self : MlregresspolyTable) -> Double { @_common.min(self.data) }

pub fn MlregresspolyTable::max(self : MlregresspolyTable) -> Double { @_common.max(self.data) }

pub fn MlregresspolyTable::to_string(self : MlregresspolyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_graphn_make(size : Int) -> MlregresspolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyGraphN::len(self : MlregresspolyGraphN) -> Int { self.size }

pub fn MlregresspolyGraphN::get(self : MlregresspolyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyGraphN::set(self : MlregresspolyGraphN, i : Int, v : Double) -> MlregresspolyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyGraphN::sum(self : MlregresspolyGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyGraphN::mean(self : MlregresspolyGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyGraphN::scale(self : MlregresspolyGraphN, f : Double) -> MlregresspolyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyGraphN::add(self : MlregresspolyGraphN, other : MlregresspolyGraphN) -> MlregresspolyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyGraphN::copy(self : MlregresspolyGraphN) -> MlregresspolyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyGraphN::fill(self : MlregresspolyGraphN, v : Double) -> MlregresspolyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyGraphN::min(self : MlregresspolyGraphN) -> Double { @_common.min(self.data) }

pub fn MlregresspolyGraphN::max(self : MlregresspolyGraphN) -> Double { @_common.max(self.data) }

pub fn MlregresspolyGraphN::to_string(self : MlregresspolyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_node_make(size : Int) -> MlregresspolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyNode::len(self : MlregresspolyNode) -> Int { self.size }

pub fn MlregresspolyNode::get(self : MlregresspolyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyNode::set(self : MlregresspolyNode, i : Int, v : Double) -> MlregresspolyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyNode::sum(self : MlregresspolyNode) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyNode::mean(self : MlregresspolyNode) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyNode::scale(self : MlregresspolyNode, f : Double) -> MlregresspolyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyNode::add(self : MlregresspolyNode, other : MlregresspolyNode) -> MlregresspolyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyNode::copy(self : MlregresspolyNode) -> MlregresspolyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyNode::fill(self : MlregresspolyNode, v : Double) -> MlregresspolyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyNode::min(self : MlregresspolyNode) -> Double { @_common.min(self.data) }

pub fn MlregresspolyNode::max(self : MlregresspolyNode) -> Double { @_common.max(self.data) }

pub fn MlregresspolyNode::to_string(self : MlregresspolyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_edge_make(size : Int) -> MlregresspolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyEdge::len(self : MlregresspolyEdge) -> Int { self.size }

pub fn MlregresspolyEdge::get(self : MlregresspolyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyEdge::set(self : MlregresspolyEdge, i : Int, v : Double) -> MlregresspolyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyEdge::sum(self : MlregresspolyEdge) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyEdge::mean(self : MlregresspolyEdge) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyEdge::scale(self : MlregresspolyEdge, f : Double) -> MlregresspolyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyEdge::add(self : MlregresspolyEdge, other : MlregresspolyEdge) -> MlregresspolyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyEdge::copy(self : MlregresspolyEdge) -> MlregresspolyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyEdge::fill(self : MlregresspolyEdge, v : Double) -> MlregresspolyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyEdge::min(self : MlregresspolyEdge) -> Double { @_common.min(self.data) }

pub fn MlregresspolyEdge::max(self : MlregresspolyEdge) -> Double { @_common.max(self.data) }

pub fn MlregresspolyEdge::to_string(self : MlregresspolyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_path_make(size : Int) -> MlregresspolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyPath::len(self : MlregresspolyPath) -> Int { self.size }

pub fn MlregresspolyPath::get(self : MlregresspolyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyPath::set(self : MlregresspolyPath, i : Int, v : Double) -> MlregresspolyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyPath::sum(self : MlregresspolyPath) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyPath::mean(self : MlregresspolyPath) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyPath::scale(self : MlregresspolyPath, f : Double) -> MlregresspolyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyPath::add(self : MlregresspolyPath, other : MlregresspolyPath) -> MlregresspolyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyPath::copy(self : MlregresspolyPath) -> MlregresspolyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyPath::fill(self : MlregresspolyPath, v : Double) -> MlregresspolyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyPath::min(self : MlregresspolyPath) -> Double { @_common.min(self.data) }

pub fn MlregresspolyPath::max(self : MlregresspolyPath) -> Double { @_common.max(self.data) }

pub fn MlregresspolyPath::to_string(self : MlregresspolyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_cluster_make(size : Int) -> MlregresspolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyCluster::len(self : MlregresspolyCluster) -> Int { self.size }

pub fn MlregresspolyCluster::get(self : MlregresspolyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyCluster::set(self : MlregresspolyCluster, i : Int, v : Double) -> MlregresspolyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyCluster::sum(self : MlregresspolyCluster) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyCluster::mean(self : MlregresspolyCluster) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyCluster::scale(self : MlregresspolyCluster, f : Double) -> MlregresspolyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyCluster::add(self : MlregresspolyCluster, other : MlregresspolyCluster) -> MlregresspolyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyCluster::copy(self : MlregresspolyCluster) -> MlregresspolyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyCluster::fill(self : MlregresspolyCluster, v : Double) -> MlregresspolyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyCluster::min(self : MlregresspolyCluster) -> Double { @_common.min(self.data) }

pub fn MlregresspolyCluster::max(self : MlregresspolyCluster) -> Double { @_common.max(self.data) }

pub fn MlregresspolyCluster::to_string(self : MlregresspolyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_model_make(size : Int) -> MlregresspolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyModel::len(self : MlregresspolyModel) -> Int { self.size }

pub fn MlregresspolyModel::get(self : MlregresspolyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyModel::set(self : MlregresspolyModel, i : Int, v : Double) -> MlregresspolyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyModel::sum(self : MlregresspolyModel) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyModel::mean(self : MlregresspolyModel) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyModel::scale(self : MlregresspolyModel, f : Double) -> MlregresspolyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyModel::add(self : MlregresspolyModel, other : MlregresspolyModel) -> MlregresspolyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyModel::copy(self : MlregresspolyModel) -> MlregresspolyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyModel::fill(self : MlregresspolyModel, v : Double) -> MlregresspolyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyModel::min(self : MlregresspolyModel) -> Double { @_common.min(self.data) }

pub fn MlregresspolyModel::max(self : MlregresspolyModel) -> Double { @_common.max(self.data) }

pub fn MlregresspolyModel::to_string(self : MlregresspolyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_layer_make(size : Int) -> MlregresspolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyLayer::len(self : MlregresspolyLayer) -> Int { self.size }

pub fn MlregresspolyLayer::get(self : MlregresspolyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyLayer::set(self : MlregresspolyLayer, i : Int, v : Double) -> MlregresspolyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyLayer::sum(self : MlregresspolyLayer) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyLayer::mean(self : MlregresspolyLayer) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyLayer::scale(self : MlregresspolyLayer, f : Double) -> MlregresspolyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyLayer::add(self : MlregresspolyLayer, other : MlregresspolyLayer) -> MlregresspolyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyLayer::copy(self : MlregresspolyLayer) -> MlregresspolyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyLayer::fill(self : MlregresspolyLayer, v : Double) -> MlregresspolyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyLayer::min(self : MlregresspolyLayer) -> Double { @_common.min(self.data) }

pub fn MlregresspolyLayer::max(self : MlregresspolyLayer) -> Double { @_common.max(self.data) }

pub fn MlregresspolyLayer::to_string(self : MlregresspolyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_buffer_make(size : Int) -> MlregresspolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyBuffer::len(self : MlregresspolyBuffer) -> Int { self.size }

pub fn MlregresspolyBuffer::get(self : MlregresspolyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyBuffer::set(self : MlregresspolyBuffer, i : Int, v : Double) -> MlregresspolyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyBuffer::sum(self : MlregresspolyBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyBuffer::mean(self : MlregresspolyBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyBuffer::scale(self : MlregresspolyBuffer, f : Double) -> MlregresspolyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyBuffer::add(self : MlregresspolyBuffer, other : MlregresspolyBuffer) -> MlregresspolyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyBuffer::copy(self : MlregresspolyBuffer) -> MlregresspolyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyBuffer::fill(self : MlregresspolyBuffer, v : Double) -> MlregresspolyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyBuffer::min(self : MlregresspolyBuffer) -> Double { @_common.min(self.data) }

pub fn MlregresspolyBuffer::max(self : MlregresspolyBuffer) -> Double { @_common.max(self.data) }

pub fn MlregresspolyBuffer::to_string(self : MlregresspolyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_cursor_make(size : Int) -> MlregresspolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyCursor::len(self : MlregresspolyCursor) -> Int { self.size }

pub fn MlregresspolyCursor::get(self : MlregresspolyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyCursor::set(self : MlregresspolyCursor, i : Int, v : Double) -> MlregresspolyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyCursor::sum(self : MlregresspolyCursor) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyCursor::mean(self : MlregresspolyCursor) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyCursor::scale(self : MlregresspolyCursor, f : Double) -> MlregresspolyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyCursor::add(self : MlregresspolyCursor, other : MlregresspolyCursor) -> MlregresspolyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyCursor::copy(self : MlregresspolyCursor) -> MlregresspolyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyCursor::fill(self : MlregresspolyCursor, v : Double) -> MlregresspolyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyCursor::min(self : MlregresspolyCursor) -> Double { @_common.min(self.data) }

pub fn MlregresspolyCursor::max(self : MlregresspolyCursor) -> Double { @_common.max(self.data) }

pub fn MlregresspolyCursor::to_string(self : MlregresspolyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_view_make(size : Int) -> MlregresspolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyView::len(self : MlregresspolyView) -> Int { self.size }

pub fn MlregresspolyView::get(self : MlregresspolyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyView::set(self : MlregresspolyView, i : Int, v : Double) -> MlregresspolyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyView::sum(self : MlregresspolyView) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyView::mean(self : MlregresspolyView) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyView::scale(self : MlregresspolyView, f : Double) -> MlregresspolyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyView::add(self : MlregresspolyView, other : MlregresspolyView) -> MlregresspolyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyView::copy(self : MlregresspolyView) -> MlregresspolyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyView::fill(self : MlregresspolyView, v : Double) -> MlregresspolyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyView::min(self : MlregresspolyView) -> Double { @_common.min(self.data) }

pub fn MlregresspolyView::max(self : MlregresspolyView) -> Double { @_common.max(self.data) }

pub fn MlregresspolyView::to_string(self : MlregresspolyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_range_make(size : Int) -> MlregresspolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolyRange::len(self : MlregresspolyRange) -> Int { self.size }

pub fn MlregresspolyRange::get(self : MlregresspolyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolyRange::set(self : MlregresspolyRange, i : Int, v : Double) -> MlregresspolyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolyRange::sum(self : MlregresspolyRange) -> Double { @_common.sum(self.data) }

pub fn MlregresspolyRange::mean(self : MlregresspolyRange) -> Double { @_common.mean(self.data) }

pub fn MlregresspolyRange::scale(self : MlregresspolyRange, f : Double) -> MlregresspolyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolyRange::add(self : MlregresspolyRange, other : MlregresspolyRange) -> MlregresspolyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolyRange::copy(self : MlregresspolyRange) -> MlregresspolyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolyRange::fill(self : MlregresspolyRange, v : Double) -> MlregresspolyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolyRange::min(self : MlregresspolyRange) -> Double { @_common.min(self.data) }

pub fn MlregresspolyRange::max(self : MlregresspolyRange) -> Double { @_common.max(self.data) }

pub fn MlregresspolyRange::to_string(self : MlregresspolyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_slice_make(size : Int) -> MlregresspolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspolySlice::len(self : MlregresspolySlice) -> Int { self.size }

pub fn MlregresspolySlice::get(self : MlregresspolySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspolySlice::set(self : MlregresspolySlice, i : Int, v : Double) -> MlregresspolySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspolySlice::sum(self : MlregresspolySlice) -> Double { @_common.sum(self.data) }

pub fn MlregresspolySlice::mean(self : MlregresspolySlice) -> Double { @_common.mean(self.data) }

pub fn MlregresspolySlice::scale(self : MlregresspolySlice, f : Double) -> MlregresspolySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspolySlice::add(self : MlregresspolySlice, other : MlregresspolySlice) -> MlregresspolySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspolySlice::copy(self : MlregresspolySlice) -> MlregresspolySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspolySlice::fill(self : MlregresspolySlice, v : Double) -> MlregresspolySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspolySlice::min(self : MlregresspolySlice) -> Double { @_common.min(self.data) }

pub fn MlregresspolySlice::max(self : MlregresspolySlice) -> Double { @_common.max(self.data) }

pub fn MlregresspolySlice::to_string(self : MlregresspolySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

