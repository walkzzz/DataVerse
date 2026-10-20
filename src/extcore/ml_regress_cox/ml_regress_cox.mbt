///===
/// extcore/ml_regress_cox

pub(all) struct MlregresscoxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_cox_make_point(x : Double, y : Double) -> MlregresscoxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_cox_make_point3(x : Double, y : Double, z : Double) -> MlregresscoxPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresscoxPoint::x(self : MlregresscoxPoint) -> Double { self.x }

pub fn MlregresscoxPoint::y(self : MlregresscoxPoint) -> Double { self.y }

pub fn MlregresscoxPoint::z(self : MlregresscoxPoint) -> Double { self.z }

pub fn MlregresscoxPoint::label(self : MlregresscoxPoint) -> Int { self.label }

pub fn MlregresscoxPoint::dist(self : MlregresscoxPoint, other : MlregresscoxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresscoxPoint::add(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresscoxPoint::sub(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresscoxPoint::scale(self : MlregresscoxPoint, s : Double) -> MlregresscoxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresscoxPoint::dot(self : MlregresscoxPoint, other : MlregresscoxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresscoxPoint::cross(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresscoxPoint::norm(self : MlregresscoxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresscoxPoint::normalize(self : MlregresscoxPoint) -> MlregresscoxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresscoxPoint::negate(self : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresscoxPoint::mid(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresscoxPoint::lerp(self : MlregresscoxPoint, other : MlregresscoxPoint, t : Double) -> MlregresscoxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresscoxPoint::to_string(self : MlregresscoxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresscoxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_cox_make_series(vals : Array[Double], name : String) -> MlregresscoxSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresscoxSeries::len(self : MlregresscoxSeries) -> Int { self.vals.length() }

pub fn MlregresscoxSeries::sum(self : MlregresscoxSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresscoxSeries::mean(self : MlregresscoxSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresscoxSeries::min(self : MlregresscoxSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresscoxSeries::max(self : MlregresscoxSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresscoxSeries::range(self : MlregresscoxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresscoxSeries::variance(self : MlregresscoxSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresscoxSeries::std(self : MlregresscoxSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresscoxSeries::median(self : MlregresscoxSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresscoxSeries::scale(self : MlregresscoxSeries, f : Double) -> MlregresscoxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresscoxSeries::add(self : MlregresscoxSeries, other : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresscoxSeries::sub(self : MlregresscoxSeries, other : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresscoxSeries::normalize(self : MlregresscoxSeries) -> MlregresscoxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresscoxSeries::cumsum(self : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresscoxSeries::to_string(self : MlregresscoxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresscoxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_cox_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresscoxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_cox_matrix_identity(n : Int) -> MlregresscoxMatrix {
  let m = ml_regress_cox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresscoxMatrix::get(self : MlregresscoxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresscoxMatrix::transpose(self : MlregresscoxMatrix) -> MlregresscoxMatrix {
  let result = ml_regress_cox_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresscoxMatrix::add(self : MlregresscoxMatrix, other : MlregresscoxMatrix) -> MlregresscoxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_cox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresscoxMatrix::scale(self : MlregresscoxMatrix, s : Double) -> MlregresscoxMatrix {
  let result = ml_regress_cox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresscoxMatrix::multiply(self : MlregresscoxMatrix, other : MlregresscoxMatrix) -> MlregresscoxMatrix {
  if self.cols != other.rows { return ml_regress_cox_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_cox_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlregresscoxMatrix::trace(self : MlregresscoxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresscoxMatrix::det(self : MlregresscoxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresscoxMatrix::norm(self : MlregresscoxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresscoxMatrix::to_string(self : MlregresscoxMatrix) -> String {
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

pub(all) struct MlregresscoxVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_cox_make_vector(comps : Array[Double]) -> MlregresscoxVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_cox_vector_zero(dim : Int) -> MlregresscoxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresscoxVector::add(self : MlregresscoxVector, other : MlregresscoxVector) -> MlregresscoxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresscoxVector::sub(self : MlregresscoxVector, other : MlregresscoxVector) -> MlregresscoxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresscoxVector::scale(self : MlregresscoxVector, s : Double) -> MlregresscoxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresscoxVector::dot(self : MlregresscoxVector, other : MlregresscoxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresscoxVector::norm(self : MlregresscoxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresscoxVector::normalize(self : MlregresscoxVector) -> MlregresscoxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresscoxVector::dist(self : MlregresscoxVector, other : MlregresscoxVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresscoxVector::to_string(self : MlregresscoxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresscoxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_frame_make(size : Int) -> MlregresscoxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxFrame::len(self : MlregresscoxFrame) -> Int { self.size }

pub fn MlregresscoxFrame::get(self : MlregresscoxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxFrame::set(self : MlregresscoxFrame, i : Int, v : Double) -> MlregresscoxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxFrame::sum(self : MlregresscoxFrame) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxFrame::mean(self : MlregresscoxFrame) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxFrame::scale(self : MlregresscoxFrame, f : Double) -> MlregresscoxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxFrame::add(self : MlregresscoxFrame, other : MlregresscoxFrame) -> MlregresscoxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxFrame::copy(self : MlregresscoxFrame) -> MlregresscoxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxFrame::fill(self : MlregresscoxFrame, v : Double) -> MlregresscoxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxFrame::min(self : MlregresscoxFrame) -> Double { @_common.min(self.data) }

pub fn MlregresscoxFrame::max(self : MlregresscoxFrame) -> Double { @_common.max(self.data) }

pub fn MlregresscoxFrame::to_string(self : MlregresscoxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_table_make(size : Int) -> MlregresscoxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxTable::len(self : MlregresscoxTable) -> Int { self.size }

pub fn MlregresscoxTable::get(self : MlregresscoxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxTable::set(self : MlregresscoxTable, i : Int, v : Double) -> MlregresscoxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxTable::sum(self : MlregresscoxTable) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxTable::mean(self : MlregresscoxTable) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxTable::scale(self : MlregresscoxTable, f : Double) -> MlregresscoxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxTable::add(self : MlregresscoxTable, other : MlregresscoxTable) -> MlregresscoxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxTable::copy(self : MlregresscoxTable) -> MlregresscoxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxTable::fill(self : MlregresscoxTable, v : Double) -> MlregresscoxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxTable::min(self : MlregresscoxTable) -> Double { @_common.min(self.data) }

pub fn MlregresscoxTable::max(self : MlregresscoxTable) -> Double { @_common.max(self.data) }

pub fn MlregresscoxTable::to_string(self : MlregresscoxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_graphn_make(size : Int) -> MlregresscoxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxGraphN::len(self : MlregresscoxGraphN) -> Int { self.size }

pub fn MlregresscoxGraphN::get(self : MlregresscoxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxGraphN::set(self : MlregresscoxGraphN, i : Int, v : Double) -> MlregresscoxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxGraphN::sum(self : MlregresscoxGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxGraphN::mean(self : MlregresscoxGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxGraphN::scale(self : MlregresscoxGraphN, f : Double) -> MlregresscoxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxGraphN::add(self : MlregresscoxGraphN, other : MlregresscoxGraphN) -> MlregresscoxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxGraphN::copy(self : MlregresscoxGraphN) -> MlregresscoxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxGraphN::fill(self : MlregresscoxGraphN, v : Double) -> MlregresscoxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxGraphN::min(self : MlregresscoxGraphN) -> Double { @_common.min(self.data) }

pub fn MlregresscoxGraphN::max(self : MlregresscoxGraphN) -> Double { @_common.max(self.data) }

pub fn MlregresscoxGraphN::to_string(self : MlregresscoxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_node_make(size : Int) -> MlregresscoxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxNode::len(self : MlregresscoxNode) -> Int { self.size }

pub fn MlregresscoxNode::get(self : MlregresscoxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxNode::set(self : MlregresscoxNode, i : Int, v : Double) -> MlregresscoxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxNode::sum(self : MlregresscoxNode) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxNode::mean(self : MlregresscoxNode) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxNode::scale(self : MlregresscoxNode, f : Double) -> MlregresscoxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxNode::add(self : MlregresscoxNode, other : MlregresscoxNode) -> MlregresscoxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxNode::copy(self : MlregresscoxNode) -> MlregresscoxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxNode::fill(self : MlregresscoxNode, v : Double) -> MlregresscoxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxNode::min(self : MlregresscoxNode) -> Double { @_common.min(self.data) }

pub fn MlregresscoxNode::max(self : MlregresscoxNode) -> Double { @_common.max(self.data) }

pub fn MlregresscoxNode::to_string(self : MlregresscoxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_edge_make(size : Int) -> MlregresscoxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxEdge::len(self : MlregresscoxEdge) -> Int { self.size }

pub fn MlregresscoxEdge::get(self : MlregresscoxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxEdge::set(self : MlregresscoxEdge, i : Int, v : Double) -> MlregresscoxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxEdge::sum(self : MlregresscoxEdge) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxEdge::mean(self : MlregresscoxEdge) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxEdge::scale(self : MlregresscoxEdge, f : Double) -> MlregresscoxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxEdge::add(self : MlregresscoxEdge, other : MlregresscoxEdge) -> MlregresscoxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxEdge::copy(self : MlregresscoxEdge) -> MlregresscoxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxEdge::fill(self : MlregresscoxEdge, v : Double) -> MlregresscoxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxEdge::min(self : MlregresscoxEdge) -> Double { @_common.min(self.data) }

pub fn MlregresscoxEdge::max(self : MlregresscoxEdge) -> Double { @_common.max(self.data) }

pub fn MlregresscoxEdge::to_string(self : MlregresscoxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_path_make(size : Int) -> MlregresscoxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxPath::len(self : MlregresscoxPath) -> Int { self.size }

pub fn MlregresscoxPath::get(self : MlregresscoxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxPath::set(self : MlregresscoxPath, i : Int, v : Double) -> MlregresscoxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxPath::sum(self : MlregresscoxPath) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxPath::mean(self : MlregresscoxPath) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxPath::scale(self : MlregresscoxPath, f : Double) -> MlregresscoxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxPath::add(self : MlregresscoxPath, other : MlregresscoxPath) -> MlregresscoxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxPath::copy(self : MlregresscoxPath) -> MlregresscoxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxPath::fill(self : MlregresscoxPath, v : Double) -> MlregresscoxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxPath::min(self : MlregresscoxPath) -> Double { @_common.min(self.data) }

pub fn MlregresscoxPath::max(self : MlregresscoxPath) -> Double { @_common.max(self.data) }

pub fn MlregresscoxPath::to_string(self : MlregresscoxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_cluster_make(size : Int) -> MlregresscoxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxCluster::len(self : MlregresscoxCluster) -> Int { self.size }

pub fn MlregresscoxCluster::get(self : MlregresscoxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxCluster::set(self : MlregresscoxCluster, i : Int, v : Double) -> MlregresscoxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxCluster::sum(self : MlregresscoxCluster) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxCluster::mean(self : MlregresscoxCluster) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxCluster::scale(self : MlregresscoxCluster, f : Double) -> MlregresscoxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxCluster::add(self : MlregresscoxCluster, other : MlregresscoxCluster) -> MlregresscoxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxCluster::copy(self : MlregresscoxCluster) -> MlregresscoxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxCluster::fill(self : MlregresscoxCluster, v : Double) -> MlregresscoxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxCluster::min(self : MlregresscoxCluster) -> Double { @_common.min(self.data) }

pub fn MlregresscoxCluster::max(self : MlregresscoxCluster) -> Double { @_common.max(self.data) }

pub fn MlregresscoxCluster::to_string(self : MlregresscoxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_model_make(size : Int) -> MlregresscoxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxModel::len(self : MlregresscoxModel) -> Int { self.size }

pub fn MlregresscoxModel::get(self : MlregresscoxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxModel::set(self : MlregresscoxModel, i : Int, v : Double) -> MlregresscoxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxModel::sum(self : MlregresscoxModel) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxModel::mean(self : MlregresscoxModel) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxModel::scale(self : MlregresscoxModel, f : Double) -> MlregresscoxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxModel::add(self : MlregresscoxModel, other : MlregresscoxModel) -> MlregresscoxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxModel::copy(self : MlregresscoxModel) -> MlregresscoxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxModel::fill(self : MlregresscoxModel, v : Double) -> MlregresscoxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxModel::min(self : MlregresscoxModel) -> Double { @_common.min(self.data) }

pub fn MlregresscoxModel::max(self : MlregresscoxModel) -> Double { @_common.max(self.data) }

pub fn MlregresscoxModel::to_string(self : MlregresscoxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_layer_make(size : Int) -> MlregresscoxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxLayer::len(self : MlregresscoxLayer) -> Int { self.size }

pub fn MlregresscoxLayer::get(self : MlregresscoxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxLayer::set(self : MlregresscoxLayer, i : Int, v : Double) -> MlregresscoxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxLayer::sum(self : MlregresscoxLayer) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxLayer::mean(self : MlregresscoxLayer) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxLayer::scale(self : MlregresscoxLayer, f : Double) -> MlregresscoxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxLayer::add(self : MlregresscoxLayer, other : MlregresscoxLayer) -> MlregresscoxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxLayer::copy(self : MlregresscoxLayer) -> MlregresscoxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxLayer::fill(self : MlregresscoxLayer, v : Double) -> MlregresscoxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxLayer::min(self : MlregresscoxLayer) -> Double { @_common.min(self.data) }

pub fn MlregresscoxLayer::max(self : MlregresscoxLayer) -> Double { @_common.max(self.data) }

pub fn MlregresscoxLayer::to_string(self : MlregresscoxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_buffer_make(size : Int) -> MlregresscoxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxBuffer::len(self : MlregresscoxBuffer) -> Int { self.size }

pub fn MlregresscoxBuffer::get(self : MlregresscoxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxBuffer::set(self : MlregresscoxBuffer, i : Int, v : Double) -> MlregresscoxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxBuffer::sum(self : MlregresscoxBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxBuffer::mean(self : MlregresscoxBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxBuffer::scale(self : MlregresscoxBuffer, f : Double) -> MlregresscoxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxBuffer::add(self : MlregresscoxBuffer, other : MlregresscoxBuffer) -> MlregresscoxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxBuffer::copy(self : MlregresscoxBuffer) -> MlregresscoxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxBuffer::fill(self : MlregresscoxBuffer, v : Double) -> MlregresscoxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxBuffer::min(self : MlregresscoxBuffer) -> Double { @_common.min(self.data) }

pub fn MlregresscoxBuffer::max(self : MlregresscoxBuffer) -> Double { @_common.max(self.data) }

pub fn MlregresscoxBuffer::to_string(self : MlregresscoxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_cursor_make(size : Int) -> MlregresscoxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxCursor::len(self : MlregresscoxCursor) -> Int { self.size }

pub fn MlregresscoxCursor::get(self : MlregresscoxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxCursor::set(self : MlregresscoxCursor, i : Int, v : Double) -> MlregresscoxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxCursor::sum(self : MlregresscoxCursor) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxCursor::mean(self : MlregresscoxCursor) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxCursor::scale(self : MlregresscoxCursor, f : Double) -> MlregresscoxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxCursor::add(self : MlregresscoxCursor, other : MlregresscoxCursor) -> MlregresscoxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxCursor::copy(self : MlregresscoxCursor) -> MlregresscoxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxCursor::fill(self : MlregresscoxCursor, v : Double) -> MlregresscoxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxCursor::min(self : MlregresscoxCursor) -> Double { @_common.min(self.data) }

pub fn MlregresscoxCursor::max(self : MlregresscoxCursor) -> Double { @_common.max(self.data) }

pub fn MlregresscoxCursor::to_string(self : MlregresscoxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_view_make(size : Int) -> MlregresscoxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxView::len(self : MlregresscoxView) -> Int { self.size }

pub fn MlregresscoxView::get(self : MlregresscoxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxView::set(self : MlregresscoxView, i : Int, v : Double) -> MlregresscoxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxView::sum(self : MlregresscoxView) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxView::mean(self : MlregresscoxView) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxView::scale(self : MlregresscoxView, f : Double) -> MlregresscoxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxView::add(self : MlregresscoxView, other : MlregresscoxView) -> MlregresscoxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxView::copy(self : MlregresscoxView) -> MlregresscoxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxView::fill(self : MlregresscoxView, v : Double) -> MlregresscoxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxView::min(self : MlregresscoxView) -> Double { @_common.min(self.data) }

pub fn MlregresscoxView::max(self : MlregresscoxView) -> Double { @_common.max(self.data) }

pub fn MlregresscoxView::to_string(self : MlregresscoxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_range_make(size : Int) -> MlregresscoxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxRange::len(self : MlregresscoxRange) -> Int { self.size }

pub fn MlregresscoxRange::get(self : MlregresscoxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxRange::set(self : MlregresscoxRange, i : Int, v : Double) -> MlregresscoxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxRange::sum(self : MlregresscoxRange) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxRange::mean(self : MlregresscoxRange) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxRange::scale(self : MlregresscoxRange, f : Double) -> MlregresscoxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxRange::add(self : MlregresscoxRange, other : MlregresscoxRange) -> MlregresscoxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxRange::copy(self : MlregresscoxRange) -> MlregresscoxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxRange::fill(self : MlregresscoxRange, v : Double) -> MlregresscoxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxRange::min(self : MlregresscoxRange) -> Double { @_common.min(self.data) }

pub fn MlregresscoxRange::max(self : MlregresscoxRange) -> Double { @_common.max(self.data) }

pub fn MlregresscoxRange::to_string(self : MlregresscoxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresscoxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_slice_make(size : Int) -> MlregresscoxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresscoxSlice::len(self : MlregresscoxSlice) -> Int { self.size }

pub fn MlregresscoxSlice::get(self : MlregresscoxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresscoxSlice::set(self : MlregresscoxSlice, i : Int, v : Double) -> MlregresscoxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresscoxSlice::sum(self : MlregresscoxSlice) -> Double { @_common.sum(self.data) }

pub fn MlregresscoxSlice::mean(self : MlregresscoxSlice) -> Double { @_common.mean(self.data) }

pub fn MlregresscoxSlice::scale(self : MlregresscoxSlice, f : Double) -> MlregresscoxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresscoxSlice::add(self : MlregresscoxSlice, other : MlregresscoxSlice) -> MlregresscoxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresscoxSlice::copy(self : MlregresscoxSlice) -> MlregresscoxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresscoxSlice::fill(self : MlregresscoxSlice, v : Double) -> MlregresscoxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresscoxSlice::min(self : MlregresscoxSlice) -> Double { @_common.min(self.data) }

pub fn MlregresscoxSlice::max(self : MlregresscoxSlice) -> Double { @_common.max(self.data) }

pub fn MlregresscoxSlice::to_string(self : MlregresscoxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

