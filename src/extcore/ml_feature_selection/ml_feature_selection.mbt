///===
/// extcore/ml_feature_selection

pub(all) struct MlfeatureselectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_selection_make_point(x : Double, y : Double) -> MlfeatureselectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_selection_make_point3(x : Double, y : Double, z : Double) -> MlfeatureselectionPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureselectionPoint::x(self : MlfeatureselectionPoint) -> Double { self.x }

pub fn MlfeatureselectionPoint::y(self : MlfeatureselectionPoint) -> Double { self.y }

pub fn MlfeatureselectionPoint::z(self : MlfeatureselectionPoint) -> Double { self.z }

pub fn MlfeatureselectionPoint::label(self : MlfeatureselectionPoint) -> Int { self.label }

pub fn MlfeatureselectionPoint::dist(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureselectionPoint::add(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureselectionPoint::sub(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureselectionPoint::scale(self : MlfeatureselectionPoint, s : Double) -> MlfeatureselectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureselectionPoint::dot(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureselectionPoint::cross(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureselectionPoint::norm(self : MlfeatureselectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureselectionPoint::normalize(self : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureselectionPoint::negate(self : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureselectionPoint::mid(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureselectionPoint::lerp(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint, t : Double) -> MlfeatureselectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureselectionPoint::to_string(self : MlfeatureselectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureselectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_selection_make_series(vals : Array[Double], name : String) -> MlfeatureselectionSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureselectionSeries::len(self : MlfeatureselectionSeries) -> Int { self.vals.length() }

pub fn MlfeatureselectionSeries::sum(self : MlfeatureselectionSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureselectionSeries::mean(self : MlfeatureselectionSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureselectionSeries::min(self : MlfeatureselectionSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureselectionSeries::max(self : MlfeatureselectionSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureselectionSeries::range(self : MlfeatureselectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureselectionSeries::variance(self : MlfeatureselectionSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureselectionSeries::std(self : MlfeatureselectionSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureselectionSeries::median(self : MlfeatureselectionSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureselectionSeries::scale(self : MlfeatureselectionSeries, f : Double) -> MlfeatureselectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureselectionSeries::add(self : MlfeatureselectionSeries, other : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureselectionSeries::sub(self : MlfeatureselectionSeries, other : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureselectionSeries::normalize(self : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureselectionSeries::cumsum(self : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureselectionSeries::to_string(self : MlfeatureselectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureselectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_selection_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureselectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_selection_matrix_identity(n : Int) -> MlfeatureselectionMatrix {
  let m = ml_feature_selection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureselectionMatrix::get(self : MlfeatureselectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureselectionMatrix::transpose(self : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  let result = ml_feature_selection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureselectionMatrix::add(self : MlfeatureselectionMatrix, other : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureselectionMatrix::scale(self : MlfeatureselectionMatrix, s : Double) -> MlfeatureselectionMatrix {
  let result = ml_feature_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureselectionMatrix::multiply(self : MlfeatureselectionMatrix, other : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  if self.cols != other.rows { return ml_feature_selection_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_selection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureselectionMatrix::trace(self : MlfeatureselectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureselectionMatrix::det(self : MlfeatureselectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureselectionMatrix::norm(self : MlfeatureselectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureselectionMatrix::to_string(self : MlfeatureselectionMatrix) -> String {
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

pub(all) struct MlfeatureselectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_selection_make_vector(comps : Array[Double]) -> MlfeatureselectionVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_selection_vector_zero(dim : Int) -> MlfeatureselectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureselectionVector::add(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureselectionVector::sub(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureselectionVector::scale(self : MlfeatureselectionVector, s : Double) -> MlfeatureselectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureselectionVector::dot(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureselectionVector::norm(self : MlfeatureselectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureselectionVector::normalize(self : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureselectionVector::dist(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureselectionVector::to_string(self : MlfeatureselectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureselectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_frame_make(size : Int) -> MlfeatureselectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionFrame::len(self : MlfeatureselectionFrame) -> Int { self.size }

pub fn MlfeatureselectionFrame::get(self : MlfeatureselectionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionFrame::set(self : MlfeatureselectionFrame, i : Int, v : Double) -> MlfeatureselectionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionFrame::sum(self : MlfeatureselectionFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionFrame::mean(self : MlfeatureselectionFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionFrame::scale(self : MlfeatureselectionFrame, f : Double) -> MlfeatureselectionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionFrame::add(self : MlfeatureselectionFrame, other : MlfeatureselectionFrame) -> MlfeatureselectionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionFrame::copy(self : MlfeatureselectionFrame) -> MlfeatureselectionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionFrame::fill(self : MlfeatureselectionFrame, v : Double) -> MlfeatureselectionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionFrame::min(self : MlfeatureselectionFrame) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionFrame::max(self : MlfeatureselectionFrame) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionFrame::to_string(self : MlfeatureselectionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_table_make(size : Int) -> MlfeatureselectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionTable::len(self : MlfeatureselectionTable) -> Int { self.size }

pub fn MlfeatureselectionTable::get(self : MlfeatureselectionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionTable::set(self : MlfeatureselectionTable, i : Int, v : Double) -> MlfeatureselectionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionTable::sum(self : MlfeatureselectionTable) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionTable::mean(self : MlfeatureselectionTable) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionTable::scale(self : MlfeatureselectionTable, f : Double) -> MlfeatureselectionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionTable::add(self : MlfeatureselectionTable, other : MlfeatureselectionTable) -> MlfeatureselectionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionTable::copy(self : MlfeatureselectionTable) -> MlfeatureselectionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionTable::fill(self : MlfeatureselectionTable, v : Double) -> MlfeatureselectionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionTable::min(self : MlfeatureselectionTable) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionTable::max(self : MlfeatureselectionTable) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionTable::to_string(self : MlfeatureselectionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_graphn_make(size : Int) -> MlfeatureselectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionGraphN::len(self : MlfeatureselectionGraphN) -> Int { self.size }

pub fn MlfeatureselectionGraphN::get(self : MlfeatureselectionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionGraphN::set(self : MlfeatureselectionGraphN, i : Int, v : Double) -> MlfeatureselectionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionGraphN::sum(self : MlfeatureselectionGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionGraphN::mean(self : MlfeatureselectionGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionGraphN::scale(self : MlfeatureselectionGraphN, f : Double) -> MlfeatureselectionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionGraphN::add(self : MlfeatureselectionGraphN, other : MlfeatureselectionGraphN) -> MlfeatureselectionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionGraphN::copy(self : MlfeatureselectionGraphN) -> MlfeatureselectionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionGraphN::fill(self : MlfeatureselectionGraphN, v : Double) -> MlfeatureselectionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionGraphN::min(self : MlfeatureselectionGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionGraphN::max(self : MlfeatureselectionGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionGraphN::to_string(self : MlfeatureselectionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_node_make(size : Int) -> MlfeatureselectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionNode::len(self : MlfeatureselectionNode) -> Int { self.size }

pub fn MlfeatureselectionNode::get(self : MlfeatureselectionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionNode::set(self : MlfeatureselectionNode, i : Int, v : Double) -> MlfeatureselectionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionNode::sum(self : MlfeatureselectionNode) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionNode::mean(self : MlfeatureselectionNode) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionNode::scale(self : MlfeatureselectionNode, f : Double) -> MlfeatureselectionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionNode::add(self : MlfeatureselectionNode, other : MlfeatureselectionNode) -> MlfeatureselectionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionNode::copy(self : MlfeatureselectionNode) -> MlfeatureselectionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionNode::fill(self : MlfeatureselectionNode, v : Double) -> MlfeatureselectionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionNode::min(self : MlfeatureselectionNode) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionNode::max(self : MlfeatureselectionNode) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionNode::to_string(self : MlfeatureselectionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_edge_make(size : Int) -> MlfeatureselectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionEdge::len(self : MlfeatureselectionEdge) -> Int { self.size }

pub fn MlfeatureselectionEdge::get(self : MlfeatureselectionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionEdge::set(self : MlfeatureselectionEdge, i : Int, v : Double) -> MlfeatureselectionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionEdge::sum(self : MlfeatureselectionEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionEdge::mean(self : MlfeatureselectionEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionEdge::scale(self : MlfeatureselectionEdge, f : Double) -> MlfeatureselectionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionEdge::add(self : MlfeatureselectionEdge, other : MlfeatureselectionEdge) -> MlfeatureselectionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionEdge::copy(self : MlfeatureselectionEdge) -> MlfeatureselectionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionEdge::fill(self : MlfeatureselectionEdge, v : Double) -> MlfeatureselectionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionEdge::min(self : MlfeatureselectionEdge) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionEdge::max(self : MlfeatureselectionEdge) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionEdge::to_string(self : MlfeatureselectionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_path_make(size : Int) -> MlfeatureselectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionPath::len(self : MlfeatureselectionPath) -> Int { self.size }

pub fn MlfeatureselectionPath::get(self : MlfeatureselectionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionPath::set(self : MlfeatureselectionPath, i : Int, v : Double) -> MlfeatureselectionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionPath::sum(self : MlfeatureselectionPath) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionPath::mean(self : MlfeatureselectionPath) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionPath::scale(self : MlfeatureselectionPath, f : Double) -> MlfeatureselectionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionPath::add(self : MlfeatureselectionPath, other : MlfeatureselectionPath) -> MlfeatureselectionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionPath::copy(self : MlfeatureselectionPath) -> MlfeatureselectionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionPath::fill(self : MlfeatureselectionPath, v : Double) -> MlfeatureselectionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionPath::min(self : MlfeatureselectionPath) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionPath::max(self : MlfeatureselectionPath) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionPath::to_string(self : MlfeatureselectionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_cluster_make(size : Int) -> MlfeatureselectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionCluster::len(self : MlfeatureselectionCluster) -> Int { self.size }

pub fn MlfeatureselectionCluster::get(self : MlfeatureselectionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionCluster::set(self : MlfeatureselectionCluster, i : Int, v : Double) -> MlfeatureselectionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCluster::sum(self : MlfeatureselectionCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionCluster::mean(self : MlfeatureselectionCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionCluster::scale(self : MlfeatureselectionCluster, f : Double) -> MlfeatureselectionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCluster::add(self : MlfeatureselectionCluster, other : MlfeatureselectionCluster) -> MlfeatureselectionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionCluster::copy(self : MlfeatureselectionCluster) -> MlfeatureselectionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCluster::fill(self : MlfeatureselectionCluster, v : Double) -> MlfeatureselectionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCluster::min(self : MlfeatureselectionCluster) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionCluster::max(self : MlfeatureselectionCluster) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionCluster::to_string(self : MlfeatureselectionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_model_make(size : Int) -> MlfeatureselectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionModel::len(self : MlfeatureselectionModel) -> Int { self.size }

pub fn MlfeatureselectionModel::get(self : MlfeatureselectionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionModel::set(self : MlfeatureselectionModel, i : Int, v : Double) -> MlfeatureselectionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionModel::sum(self : MlfeatureselectionModel) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionModel::mean(self : MlfeatureselectionModel) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionModel::scale(self : MlfeatureselectionModel, f : Double) -> MlfeatureselectionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionModel::add(self : MlfeatureselectionModel, other : MlfeatureselectionModel) -> MlfeatureselectionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionModel::copy(self : MlfeatureselectionModel) -> MlfeatureselectionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionModel::fill(self : MlfeatureselectionModel, v : Double) -> MlfeatureselectionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionModel::min(self : MlfeatureselectionModel) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionModel::max(self : MlfeatureselectionModel) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionModel::to_string(self : MlfeatureselectionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_layer_make(size : Int) -> MlfeatureselectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionLayer::len(self : MlfeatureselectionLayer) -> Int { self.size }

pub fn MlfeatureselectionLayer::get(self : MlfeatureselectionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionLayer::set(self : MlfeatureselectionLayer, i : Int, v : Double) -> MlfeatureselectionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionLayer::sum(self : MlfeatureselectionLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionLayer::mean(self : MlfeatureselectionLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionLayer::scale(self : MlfeatureselectionLayer, f : Double) -> MlfeatureselectionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionLayer::add(self : MlfeatureselectionLayer, other : MlfeatureselectionLayer) -> MlfeatureselectionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionLayer::copy(self : MlfeatureselectionLayer) -> MlfeatureselectionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionLayer::fill(self : MlfeatureselectionLayer, v : Double) -> MlfeatureselectionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionLayer::min(self : MlfeatureselectionLayer) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionLayer::max(self : MlfeatureselectionLayer) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionLayer::to_string(self : MlfeatureselectionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_buffer_make(size : Int) -> MlfeatureselectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionBuffer::len(self : MlfeatureselectionBuffer) -> Int { self.size }

pub fn MlfeatureselectionBuffer::get(self : MlfeatureselectionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionBuffer::set(self : MlfeatureselectionBuffer, i : Int, v : Double) -> MlfeatureselectionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionBuffer::sum(self : MlfeatureselectionBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionBuffer::mean(self : MlfeatureselectionBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionBuffer::scale(self : MlfeatureselectionBuffer, f : Double) -> MlfeatureselectionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionBuffer::add(self : MlfeatureselectionBuffer, other : MlfeatureselectionBuffer) -> MlfeatureselectionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionBuffer::copy(self : MlfeatureselectionBuffer) -> MlfeatureselectionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionBuffer::fill(self : MlfeatureselectionBuffer, v : Double) -> MlfeatureselectionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionBuffer::min(self : MlfeatureselectionBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionBuffer::max(self : MlfeatureselectionBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionBuffer::to_string(self : MlfeatureselectionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_cursor_make(size : Int) -> MlfeatureselectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionCursor::len(self : MlfeatureselectionCursor) -> Int { self.size }

pub fn MlfeatureselectionCursor::get(self : MlfeatureselectionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionCursor::set(self : MlfeatureselectionCursor, i : Int, v : Double) -> MlfeatureselectionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCursor::sum(self : MlfeatureselectionCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionCursor::mean(self : MlfeatureselectionCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionCursor::scale(self : MlfeatureselectionCursor, f : Double) -> MlfeatureselectionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCursor::add(self : MlfeatureselectionCursor, other : MlfeatureselectionCursor) -> MlfeatureselectionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionCursor::copy(self : MlfeatureselectionCursor) -> MlfeatureselectionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCursor::fill(self : MlfeatureselectionCursor, v : Double) -> MlfeatureselectionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionCursor::min(self : MlfeatureselectionCursor) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionCursor::max(self : MlfeatureselectionCursor) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionCursor::to_string(self : MlfeatureselectionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_view_make(size : Int) -> MlfeatureselectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionView::len(self : MlfeatureselectionView) -> Int { self.size }

pub fn MlfeatureselectionView::get(self : MlfeatureselectionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionView::set(self : MlfeatureselectionView, i : Int, v : Double) -> MlfeatureselectionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionView::sum(self : MlfeatureselectionView) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionView::mean(self : MlfeatureselectionView) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionView::scale(self : MlfeatureselectionView, f : Double) -> MlfeatureselectionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionView::add(self : MlfeatureselectionView, other : MlfeatureselectionView) -> MlfeatureselectionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionView::copy(self : MlfeatureselectionView) -> MlfeatureselectionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionView::fill(self : MlfeatureselectionView, v : Double) -> MlfeatureselectionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionView::min(self : MlfeatureselectionView) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionView::max(self : MlfeatureselectionView) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionView::to_string(self : MlfeatureselectionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_range_make(size : Int) -> MlfeatureselectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionRange::len(self : MlfeatureselectionRange) -> Int { self.size }

pub fn MlfeatureselectionRange::get(self : MlfeatureselectionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionRange::set(self : MlfeatureselectionRange, i : Int, v : Double) -> MlfeatureselectionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionRange::sum(self : MlfeatureselectionRange) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionRange::mean(self : MlfeatureselectionRange) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionRange::scale(self : MlfeatureselectionRange, f : Double) -> MlfeatureselectionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionRange::add(self : MlfeatureselectionRange, other : MlfeatureselectionRange) -> MlfeatureselectionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionRange::copy(self : MlfeatureselectionRange) -> MlfeatureselectionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionRange::fill(self : MlfeatureselectionRange, v : Double) -> MlfeatureselectionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionRange::min(self : MlfeatureselectionRange) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionRange::max(self : MlfeatureselectionRange) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionRange::to_string(self : MlfeatureselectionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_slice_make(size : Int) -> MlfeatureselectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureselectionSlice::len(self : MlfeatureselectionSlice) -> Int { self.size }

pub fn MlfeatureselectionSlice::get(self : MlfeatureselectionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureselectionSlice::set(self : MlfeatureselectionSlice, i : Int, v : Double) -> MlfeatureselectionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionSlice::sum(self : MlfeatureselectionSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeatureselectionSlice::mean(self : MlfeatureselectionSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeatureselectionSlice::scale(self : MlfeatureselectionSlice, f : Double) -> MlfeatureselectionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionSlice::add(self : MlfeatureselectionSlice, other : MlfeatureselectionSlice) -> MlfeatureselectionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureselectionSlice::copy(self : MlfeatureselectionSlice) -> MlfeatureselectionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionSlice::fill(self : MlfeatureselectionSlice, v : Double) -> MlfeatureselectionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureselectionSlice::min(self : MlfeatureselectionSlice) -> Double { @_common.min(self.data) }

pub fn MlfeatureselectionSlice::max(self : MlfeatureselectionSlice) -> Double { @_common.max(self.data) }

pub fn MlfeatureselectionSlice::to_string(self : MlfeatureselectionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

