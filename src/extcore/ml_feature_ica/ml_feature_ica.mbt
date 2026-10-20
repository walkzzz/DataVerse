///===
/// extcore/ml_feature_ica

pub(all) struct MlfeatureicaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_ica_make_point(x : Double, y : Double) -> MlfeatureicaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_ica_make_point3(x : Double, y : Double, z : Double) -> MlfeatureicaPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureicaPoint::x(self : MlfeatureicaPoint) -> Double { self.x }

pub fn MlfeatureicaPoint::y(self : MlfeatureicaPoint) -> Double { self.y }

pub fn MlfeatureicaPoint::z(self : MlfeatureicaPoint) -> Double { self.z }

pub fn MlfeatureicaPoint::label(self : MlfeatureicaPoint) -> Int { self.label }

pub fn MlfeatureicaPoint::dist(self : MlfeatureicaPoint, other : MlfeatureicaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureicaPoint::add(self : MlfeatureicaPoint, other : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureicaPoint::sub(self : MlfeatureicaPoint, other : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureicaPoint::scale(self : MlfeatureicaPoint, s : Double) -> MlfeatureicaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureicaPoint::dot(self : MlfeatureicaPoint, other : MlfeatureicaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureicaPoint::cross(self : MlfeatureicaPoint, other : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureicaPoint::norm(self : MlfeatureicaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureicaPoint::normalize(self : MlfeatureicaPoint) -> MlfeatureicaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureicaPoint::negate(self : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureicaPoint::mid(self : MlfeatureicaPoint, other : MlfeatureicaPoint) -> MlfeatureicaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureicaPoint::lerp(self : MlfeatureicaPoint, other : MlfeatureicaPoint, t : Double) -> MlfeatureicaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureicaPoint::to_string(self : MlfeatureicaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureicaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_ica_make_series(vals : Array[Double], name : String) -> MlfeatureicaSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureicaSeries::len(self : MlfeatureicaSeries) -> Int { self.vals.length() }

pub fn MlfeatureicaSeries::sum(self : MlfeatureicaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureicaSeries::mean(self : MlfeatureicaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureicaSeries::min(self : MlfeatureicaSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureicaSeries::max(self : MlfeatureicaSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureicaSeries::range(self : MlfeatureicaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureicaSeries::variance(self : MlfeatureicaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureicaSeries::std(self : MlfeatureicaSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureicaSeries::median(self : MlfeatureicaSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureicaSeries::scale(self : MlfeatureicaSeries, f : Double) -> MlfeatureicaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureicaSeries::add(self : MlfeatureicaSeries, other : MlfeatureicaSeries) -> MlfeatureicaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureicaSeries::sub(self : MlfeatureicaSeries, other : MlfeatureicaSeries) -> MlfeatureicaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureicaSeries::normalize(self : MlfeatureicaSeries) -> MlfeatureicaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureicaSeries::cumsum(self : MlfeatureicaSeries) -> MlfeatureicaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureicaSeries::to_string(self : MlfeatureicaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureicaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_ica_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureicaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_ica_matrix_identity(n : Int) -> MlfeatureicaMatrix {
  let m = ml_feature_ica_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureicaMatrix::get(self : MlfeatureicaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureicaMatrix::transpose(self : MlfeatureicaMatrix) -> MlfeatureicaMatrix {
  let result = ml_feature_ica_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureicaMatrix::add(self : MlfeatureicaMatrix, other : MlfeatureicaMatrix) -> MlfeatureicaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_ica_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureicaMatrix::scale(self : MlfeatureicaMatrix, s : Double) -> MlfeatureicaMatrix {
  let result = ml_feature_ica_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureicaMatrix::multiply(self : MlfeatureicaMatrix, other : MlfeatureicaMatrix) -> MlfeatureicaMatrix {
  if self.cols != other.rows { return ml_feature_ica_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_ica_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureicaMatrix::trace(self : MlfeatureicaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureicaMatrix::det(self : MlfeatureicaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureicaMatrix::norm(self : MlfeatureicaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureicaMatrix::to_string(self : MlfeatureicaMatrix) -> String {
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

pub(all) struct MlfeatureicaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_ica_make_vector(comps : Array[Double]) -> MlfeatureicaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_ica_vector_zero(dim : Int) -> MlfeatureicaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureicaVector::add(self : MlfeatureicaVector, other : MlfeatureicaVector) -> MlfeatureicaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureicaVector::sub(self : MlfeatureicaVector, other : MlfeatureicaVector) -> MlfeatureicaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureicaVector::scale(self : MlfeatureicaVector, s : Double) -> MlfeatureicaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureicaVector::dot(self : MlfeatureicaVector, other : MlfeatureicaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureicaVector::norm(self : MlfeatureicaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureicaVector::normalize(self : MlfeatureicaVector) -> MlfeatureicaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureicaVector::dist(self : MlfeatureicaVector, other : MlfeatureicaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureicaVector::to_string(self : MlfeatureicaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureicaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_frame_make(size : Int) -> MlfeatureicaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaFrame::len(self : MlfeatureicaFrame) -> Int { self.size }

pub fn MlfeatureicaFrame::get(self : MlfeatureicaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaFrame::set(self : MlfeatureicaFrame, i : Int, v : Double) -> MlfeatureicaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaFrame::sum(self : MlfeatureicaFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaFrame::mean(self : MlfeatureicaFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaFrame::scale(self : MlfeatureicaFrame, f : Double) -> MlfeatureicaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaFrame::add(self : MlfeatureicaFrame, other : MlfeatureicaFrame) -> MlfeatureicaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaFrame::copy(self : MlfeatureicaFrame) -> MlfeatureicaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaFrame::fill(self : MlfeatureicaFrame, v : Double) -> MlfeatureicaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaFrame::min(self : MlfeatureicaFrame) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaFrame::max(self : MlfeatureicaFrame) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaFrame::to_string(self : MlfeatureicaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_table_make(size : Int) -> MlfeatureicaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaTable::len(self : MlfeatureicaTable) -> Int { self.size }

pub fn MlfeatureicaTable::get(self : MlfeatureicaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaTable::set(self : MlfeatureicaTable, i : Int, v : Double) -> MlfeatureicaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaTable::sum(self : MlfeatureicaTable) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaTable::mean(self : MlfeatureicaTable) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaTable::scale(self : MlfeatureicaTable, f : Double) -> MlfeatureicaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaTable::add(self : MlfeatureicaTable, other : MlfeatureicaTable) -> MlfeatureicaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaTable::copy(self : MlfeatureicaTable) -> MlfeatureicaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaTable::fill(self : MlfeatureicaTable, v : Double) -> MlfeatureicaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaTable::min(self : MlfeatureicaTable) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaTable::max(self : MlfeatureicaTable) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaTable::to_string(self : MlfeatureicaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_graphn_make(size : Int) -> MlfeatureicaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaGraphN::len(self : MlfeatureicaGraphN) -> Int { self.size }

pub fn MlfeatureicaGraphN::get(self : MlfeatureicaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaGraphN::set(self : MlfeatureicaGraphN, i : Int, v : Double) -> MlfeatureicaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaGraphN::sum(self : MlfeatureicaGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaGraphN::mean(self : MlfeatureicaGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaGraphN::scale(self : MlfeatureicaGraphN, f : Double) -> MlfeatureicaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaGraphN::add(self : MlfeatureicaGraphN, other : MlfeatureicaGraphN) -> MlfeatureicaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaGraphN::copy(self : MlfeatureicaGraphN) -> MlfeatureicaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaGraphN::fill(self : MlfeatureicaGraphN, v : Double) -> MlfeatureicaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaGraphN::min(self : MlfeatureicaGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaGraphN::max(self : MlfeatureicaGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaGraphN::to_string(self : MlfeatureicaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_node_make(size : Int) -> MlfeatureicaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaNode::len(self : MlfeatureicaNode) -> Int { self.size }

pub fn MlfeatureicaNode::get(self : MlfeatureicaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaNode::set(self : MlfeatureicaNode, i : Int, v : Double) -> MlfeatureicaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaNode::sum(self : MlfeatureicaNode) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaNode::mean(self : MlfeatureicaNode) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaNode::scale(self : MlfeatureicaNode, f : Double) -> MlfeatureicaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaNode::add(self : MlfeatureicaNode, other : MlfeatureicaNode) -> MlfeatureicaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaNode::copy(self : MlfeatureicaNode) -> MlfeatureicaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaNode::fill(self : MlfeatureicaNode, v : Double) -> MlfeatureicaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaNode::min(self : MlfeatureicaNode) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaNode::max(self : MlfeatureicaNode) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaNode::to_string(self : MlfeatureicaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_edge_make(size : Int) -> MlfeatureicaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaEdge::len(self : MlfeatureicaEdge) -> Int { self.size }

pub fn MlfeatureicaEdge::get(self : MlfeatureicaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaEdge::set(self : MlfeatureicaEdge, i : Int, v : Double) -> MlfeatureicaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaEdge::sum(self : MlfeatureicaEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaEdge::mean(self : MlfeatureicaEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaEdge::scale(self : MlfeatureicaEdge, f : Double) -> MlfeatureicaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaEdge::add(self : MlfeatureicaEdge, other : MlfeatureicaEdge) -> MlfeatureicaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaEdge::copy(self : MlfeatureicaEdge) -> MlfeatureicaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaEdge::fill(self : MlfeatureicaEdge, v : Double) -> MlfeatureicaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaEdge::min(self : MlfeatureicaEdge) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaEdge::max(self : MlfeatureicaEdge) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaEdge::to_string(self : MlfeatureicaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_path_make(size : Int) -> MlfeatureicaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaPath::len(self : MlfeatureicaPath) -> Int { self.size }

pub fn MlfeatureicaPath::get(self : MlfeatureicaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaPath::set(self : MlfeatureicaPath, i : Int, v : Double) -> MlfeatureicaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaPath::sum(self : MlfeatureicaPath) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaPath::mean(self : MlfeatureicaPath) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaPath::scale(self : MlfeatureicaPath, f : Double) -> MlfeatureicaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaPath::add(self : MlfeatureicaPath, other : MlfeatureicaPath) -> MlfeatureicaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaPath::copy(self : MlfeatureicaPath) -> MlfeatureicaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaPath::fill(self : MlfeatureicaPath, v : Double) -> MlfeatureicaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaPath::min(self : MlfeatureicaPath) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaPath::max(self : MlfeatureicaPath) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaPath::to_string(self : MlfeatureicaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_cluster_make(size : Int) -> MlfeatureicaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaCluster::len(self : MlfeatureicaCluster) -> Int { self.size }

pub fn MlfeatureicaCluster::get(self : MlfeatureicaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaCluster::set(self : MlfeatureicaCluster, i : Int, v : Double) -> MlfeatureicaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCluster::sum(self : MlfeatureicaCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaCluster::mean(self : MlfeatureicaCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaCluster::scale(self : MlfeatureicaCluster, f : Double) -> MlfeatureicaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCluster::add(self : MlfeatureicaCluster, other : MlfeatureicaCluster) -> MlfeatureicaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaCluster::copy(self : MlfeatureicaCluster) -> MlfeatureicaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCluster::fill(self : MlfeatureicaCluster, v : Double) -> MlfeatureicaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCluster::min(self : MlfeatureicaCluster) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaCluster::max(self : MlfeatureicaCluster) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaCluster::to_string(self : MlfeatureicaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_model_make(size : Int) -> MlfeatureicaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaModel::len(self : MlfeatureicaModel) -> Int { self.size }

pub fn MlfeatureicaModel::get(self : MlfeatureicaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaModel::set(self : MlfeatureicaModel, i : Int, v : Double) -> MlfeatureicaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaModel::sum(self : MlfeatureicaModel) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaModel::mean(self : MlfeatureicaModel) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaModel::scale(self : MlfeatureicaModel, f : Double) -> MlfeatureicaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaModel::add(self : MlfeatureicaModel, other : MlfeatureicaModel) -> MlfeatureicaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaModel::copy(self : MlfeatureicaModel) -> MlfeatureicaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaModel::fill(self : MlfeatureicaModel, v : Double) -> MlfeatureicaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaModel::min(self : MlfeatureicaModel) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaModel::max(self : MlfeatureicaModel) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaModel::to_string(self : MlfeatureicaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_layer_make(size : Int) -> MlfeatureicaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaLayer::len(self : MlfeatureicaLayer) -> Int { self.size }

pub fn MlfeatureicaLayer::get(self : MlfeatureicaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaLayer::set(self : MlfeatureicaLayer, i : Int, v : Double) -> MlfeatureicaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaLayer::sum(self : MlfeatureicaLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaLayer::mean(self : MlfeatureicaLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaLayer::scale(self : MlfeatureicaLayer, f : Double) -> MlfeatureicaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaLayer::add(self : MlfeatureicaLayer, other : MlfeatureicaLayer) -> MlfeatureicaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaLayer::copy(self : MlfeatureicaLayer) -> MlfeatureicaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaLayer::fill(self : MlfeatureicaLayer, v : Double) -> MlfeatureicaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaLayer::min(self : MlfeatureicaLayer) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaLayer::max(self : MlfeatureicaLayer) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaLayer::to_string(self : MlfeatureicaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_buffer_make(size : Int) -> MlfeatureicaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaBuffer::len(self : MlfeatureicaBuffer) -> Int { self.size }

pub fn MlfeatureicaBuffer::get(self : MlfeatureicaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaBuffer::set(self : MlfeatureicaBuffer, i : Int, v : Double) -> MlfeatureicaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaBuffer::sum(self : MlfeatureicaBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaBuffer::mean(self : MlfeatureicaBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaBuffer::scale(self : MlfeatureicaBuffer, f : Double) -> MlfeatureicaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaBuffer::add(self : MlfeatureicaBuffer, other : MlfeatureicaBuffer) -> MlfeatureicaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaBuffer::copy(self : MlfeatureicaBuffer) -> MlfeatureicaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaBuffer::fill(self : MlfeatureicaBuffer, v : Double) -> MlfeatureicaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaBuffer::min(self : MlfeatureicaBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaBuffer::max(self : MlfeatureicaBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaBuffer::to_string(self : MlfeatureicaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_cursor_make(size : Int) -> MlfeatureicaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaCursor::len(self : MlfeatureicaCursor) -> Int { self.size }

pub fn MlfeatureicaCursor::get(self : MlfeatureicaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaCursor::set(self : MlfeatureicaCursor, i : Int, v : Double) -> MlfeatureicaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCursor::sum(self : MlfeatureicaCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaCursor::mean(self : MlfeatureicaCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaCursor::scale(self : MlfeatureicaCursor, f : Double) -> MlfeatureicaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCursor::add(self : MlfeatureicaCursor, other : MlfeatureicaCursor) -> MlfeatureicaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaCursor::copy(self : MlfeatureicaCursor) -> MlfeatureicaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCursor::fill(self : MlfeatureicaCursor, v : Double) -> MlfeatureicaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaCursor::min(self : MlfeatureicaCursor) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaCursor::max(self : MlfeatureicaCursor) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaCursor::to_string(self : MlfeatureicaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_view_make(size : Int) -> MlfeatureicaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaView::len(self : MlfeatureicaView) -> Int { self.size }

pub fn MlfeatureicaView::get(self : MlfeatureicaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaView::set(self : MlfeatureicaView, i : Int, v : Double) -> MlfeatureicaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaView::sum(self : MlfeatureicaView) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaView::mean(self : MlfeatureicaView) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaView::scale(self : MlfeatureicaView, f : Double) -> MlfeatureicaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaView::add(self : MlfeatureicaView, other : MlfeatureicaView) -> MlfeatureicaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaView::copy(self : MlfeatureicaView) -> MlfeatureicaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaView::fill(self : MlfeatureicaView, v : Double) -> MlfeatureicaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaView::min(self : MlfeatureicaView) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaView::max(self : MlfeatureicaView) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaView::to_string(self : MlfeatureicaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_range_make(size : Int) -> MlfeatureicaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaRange::len(self : MlfeatureicaRange) -> Int { self.size }

pub fn MlfeatureicaRange::get(self : MlfeatureicaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaRange::set(self : MlfeatureicaRange, i : Int, v : Double) -> MlfeatureicaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaRange::sum(self : MlfeatureicaRange) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaRange::mean(self : MlfeatureicaRange) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaRange::scale(self : MlfeatureicaRange, f : Double) -> MlfeatureicaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaRange::add(self : MlfeatureicaRange, other : MlfeatureicaRange) -> MlfeatureicaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaRange::copy(self : MlfeatureicaRange) -> MlfeatureicaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaRange::fill(self : MlfeatureicaRange, v : Double) -> MlfeatureicaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaRange::min(self : MlfeatureicaRange) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaRange::max(self : MlfeatureicaRange) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaRange::to_string(self : MlfeatureicaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureicaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_ica_slice_make(size : Int) -> MlfeatureicaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureicaSlice::len(self : MlfeatureicaSlice) -> Int { self.size }

pub fn MlfeatureicaSlice::get(self : MlfeatureicaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureicaSlice::set(self : MlfeatureicaSlice, i : Int, v : Double) -> MlfeatureicaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureicaSlice::sum(self : MlfeatureicaSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeatureicaSlice::mean(self : MlfeatureicaSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeatureicaSlice::scale(self : MlfeatureicaSlice, f : Double) -> MlfeatureicaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaSlice::add(self : MlfeatureicaSlice, other : MlfeatureicaSlice) -> MlfeatureicaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureicaSlice::copy(self : MlfeatureicaSlice) -> MlfeatureicaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaSlice::fill(self : MlfeatureicaSlice, v : Double) -> MlfeatureicaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureicaSlice::min(self : MlfeatureicaSlice) -> Double { @_common.min(self.data) }

pub fn MlfeatureicaSlice::max(self : MlfeatureicaSlice) -> Double { @_common.max(self.data) }

pub fn MlfeatureicaSlice::to_string(self : MlfeatureicaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

