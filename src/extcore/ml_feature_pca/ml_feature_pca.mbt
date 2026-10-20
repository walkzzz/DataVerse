///===
/// extcore/ml_feature_pca

pub(all) struct MlfeaturepcaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pca_make_point(x : Double, y : Double) -> MlfeaturepcaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pca_make_point3(x : Double, y : Double, z : Double) -> MlfeaturepcaPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturepcaPoint::x(self : MlfeaturepcaPoint) -> Double { self.x }

pub fn MlfeaturepcaPoint::y(self : MlfeaturepcaPoint) -> Double { self.y }

pub fn MlfeaturepcaPoint::z(self : MlfeaturepcaPoint) -> Double { self.z }

pub fn MlfeaturepcaPoint::label(self : MlfeaturepcaPoint) -> Int { self.label }

pub fn MlfeaturepcaPoint::dist(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturepcaPoint::add(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturepcaPoint::sub(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturepcaPoint::scale(self : MlfeaturepcaPoint, s : Double) -> MlfeaturepcaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturepcaPoint::dot(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturepcaPoint::cross(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturepcaPoint::norm(self : MlfeaturepcaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturepcaPoint::normalize(self : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturepcaPoint::negate(self : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturepcaPoint::mid(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturepcaPoint::lerp(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint, t : Double) -> MlfeaturepcaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturepcaPoint::to_string(self : MlfeaturepcaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturepcaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pca_make_series(vals : Array[Double], name : String) -> MlfeaturepcaSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturepcaSeries::len(self : MlfeaturepcaSeries) -> Int { self.vals.length() }

pub fn MlfeaturepcaSeries::sum(self : MlfeaturepcaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturepcaSeries::mean(self : MlfeaturepcaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturepcaSeries::min(self : MlfeaturepcaSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturepcaSeries::max(self : MlfeaturepcaSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturepcaSeries::range(self : MlfeaturepcaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturepcaSeries::variance(self : MlfeaturepcaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturepcaSeries::std(self : MlfeaturepcaSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturepcaSeries::median(self : MlfeaturepcaSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturepcaSeries::scale(self : MlfeaturepcaSeries, f : Double) -> MlfeaturepcaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturepcaSeries::add(self : MlfeaturepcaSeries, other : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturepcaSeries::sub(self : MlfeaturepcaSeries, other : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturepcaSeries::normalize(self : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturepcaSeries::cumsum(self : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturepcaSeries::to_string(self : MlfeaturepcaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturepcaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pca_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturepcaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pca_matrix_identity(n : Int) -> MlfeaturepcaMatrix {
  let m = ml_feature_pca_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturepcaMatrix::get(self : MlfeaturepcaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturepcaMatrix::transpose(self : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturepcaMatrix::add(self : MlfeaturepcaMatrix, other : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_pca_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturepcaMatrix::scale(self : MlfeaturepcaMatrix, s : Double) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturepcaMatrix::multiply(self : MlfeaturepcaMatrix, other : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if self.cols != other.rows { return ml_feature_pca_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_pca_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturepcaMatrix::trace(self : MlfeaturepcaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturepcaMatrix::det(self : MlfeaturepcaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturepcaMatrix::norm(self : MlfeaturepcaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturepcaMatrix::to_string(self : MlfeaturepcaMatrix) -> String {
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

pub(all) struct MlfeaturepcaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pca_make_vector(comps : Array[Double]) -> MlfeaturepcaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pca_vector_zero(dim : Int) -> MlfeaturepcaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturepcaVector::add(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturepcaVector::sub(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturepcaVector::scale(self : MlfeaturepcaVector, s : Double) -> MlfeaturepcaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturepcaVector::dot(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturepcaVector::norm(self : MlfeaturepcaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturepcaVector::normalize(self : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturepcaVector::dist(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturepcaVector::to_string(self : MlfeaturepcaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturepcaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_frame_make(size : Int) -> MlfeaturepcaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaFrame::len(self : MlfeaturepcaFrame) -> Int { self.size }

pub fn MlfeaturepcaFrame::get(self : MlfeaturepcaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaFrame::set(self : MlfeaturepcaFrame, i : Int, v : Double) -> MlfeaturepcaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaFrame::sum(self : MlfeaturepcaFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaFrame::mean(self : MlfeaturepcaFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaFrame::scale(self : MlfeaturepcaFrame, f : Double) -> MlfeaturepcaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaFrame::add(self : MlfeaturepcaFrame, other : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaFrame::copy(self : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaFrame::fill(self : MlfeaturepcaFrame, v : Double) -> MlfeaturepcaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaFrame::min(self : MlfeaturepcaFrame) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaFrame::max(self : MlfeaturepcaFrame) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaFrame::to_string(self : MlfeaturepcaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_table_make(size : Int) -> MlfeaturepcaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaTable::len(self : MlfeaturepcaTable) -> Int { self.size }

pub fn MlfeaturepcaTable::get(self : MlfeaturepcaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaTable::set(self : MlfeaturepcaTable, i : Int, v : Double) -> MlfeaturepcaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaTable::sum(self : MlfeaturepcaTable) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaTable::mean(self : MlfeaturepcaTable) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaTable::scale(self : MlfeaturepcaTable, f : Double) -> MlfeaturepcaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaTable::add(self : MlfeaturepcaTable, other : MlfeaturepcaTable) -> MlfeaturepcaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaTable::copy(self : MlfeaturepcaTable) -> MlfeaturepcaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaTable::fill(self : MlfeaturepcaTable, v : Double) -> MlfeaturepcaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaTable::min(self : MlfeaturepcaTable) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaTable::max(self : MlfeaturepcaTable) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaTable::to_string(self : MlfeaturepcaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_graphn_make(size : Int) -> MlfeaturepcaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaGraphN::len(self : MlfeaturepcaGraphN) -> Int { self.size }

pub fn MlfeaturepcaGraphN::get(self : MlfeaturepcaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaGraphN::set(self : MlfeaturepcaGraphN, i : Int, v : Double) -> MlfeaturepcaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaGraphN::sum(self : MlfeaturepcaGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaGraphN::mean(self : MlfeaturepcaGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaGraphN::scale(self : MlfeaturepcaGraphN, f : Double) -> MlfeaturepcaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaGraphN::add(self : MlfeaturepcaGraphN, other : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaGraphN::copy(self : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaGraphN::fill(self : MlfeaturepcaGraphN, v : Double) -> MlfeaturepcaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaGraphN::min(self : MlfeaturepcaGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaGraphN::max(self : MlfeaturepcaGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaGraphN::to_string(self : MlfeaturepcaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_node_make(size : Int) -> MlfeaturepcaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaNode::len(self : MlfeaturepcaNode) -> Int { self.size }

pub fn MlfeaturepcaNode::get(self : MlfeaturepcaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaNode::set(self : MlfeaturepcaNode, i : Int, v : Double) -> MlfeaturepcaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaNode::sum(self : MlfeaturepcaNode) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaNode::mean(self : MlfeaturepcaNode) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaNode::scale(self : MlfeaturepcaNode, f : Double) -> MlfeaturepcaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaNode::add(self : MlfeaturepcaNode, other : MlfeaturepcaNode) -> MlfeaturepcaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaNode::copy(self : MlfeaturepcaNode) -> MlfeaturepcaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaNode::fill(self : MlfeaturepcaNode, v : Double) -> MlfeaturepcaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaNode::min(self : MlfeaturepcaNode) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaNode::max(self : MlfeaturepcaNode) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaNode::to_string(self : MlfeaturepcaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_edge_make(size : Int) -> MlfeaturepcaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaEdge::len(self : MlfeaturepcaEdge) -> Int { self.size }

pub fn MlfeaturepcaEdge::get(self : MlfeaturepcaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaEdge::set(self : MlfeaturepcaEdge, i : Int, v : Double) -> MlfeaturepcaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaEdge::sum(self : MlfeaturepcaEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaEdge::mean(self : MlfeaturepcaEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaEdge::scale(self : MlfeaturepcaEdge, f : Double) -> MlfeaturepcaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaEdge::add(self : MlfeaturepcaEdge, other : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaEdge::copy(self : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaEdge::fill(self : MlfeaturepcaEdge, v : Double) -> MlfeaturepcaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaEdge::min(self : MlfeaturepcaEdge) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaEdge::max(self : MlfeaturepcaEdge) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaEdge::to_string(self : MlfeaturepcaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_path_make(size : Int) -> MlfeaturepcaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaPath::len(self : MlfeaturepcaPath) -> Int { self.size }

pub fn MlfeaturepcaPath::get(self : MlfeaturepcaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaPath::set(self : MlfeaturepcaPath, i : Int, v : Double) -> MlfeaturepcaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaPath::sum(self : MlfeaturepcaPath) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaPath::mean(self : MlfeaturepcaPath) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaPath::scale(self : MlfeaturepcaPath, f : Double) -> MlfeaturepcaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaPath::add(self : MlfeaturepcaPath, other : MlfeaturepcaPath) -> MlfeaturepcaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaPath::copy(self : MlfeaturepcaPath) -> MlfeaturepcaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaPath::fill(self : MlfeaturepcaPath, v : Double) -> MlfeaturepcaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaPath::min(self : MlfeaturepcaPath) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaPath::max(self : MlfeaturepcaPath) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaPath::to_string(self : MlfeaturepcaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cluster_make(size : Int) -> MlfeaturepcaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaCluster::len(self : MlfeaturepcaCluster) -> Int { self.size }

pub fn MlfeaturepcaCluster::get(self : MlfeaturepcaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaCluster::set(self : MlfeaturepcaCluster, i : Int, v : Double) -> MlfeaturepcaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCluster::sum(self : MlfeaturepcaCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaCluster::mean(self : MlfeaturepcaCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaCluster::scale(self : MlfeaturepcaCluster, f : Double) -> MlfeaturepcaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCluster::add(self : MlfeaturepcaCluster, other : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaCluster::copy(self : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCluster::fill(self : MlfeaturepcaCluster, v : Double) -> MlfeaturepcaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCluster::min(self : MlfeaturepcaCluster) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaCluster::max(self : MlfeaturepcaCluster) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaCluster::to_string(self : MlfeaturepcaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_model_make(size : Int) -> MlfeaturepcaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaModel::len(self : MlfeaturepcaModel) -> Int { self.size }

pub fn MlfeaturepcaModel::get(self : MlfeaturepcaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaModel::set(self : MlfeaturepcaModel, i : Int, v : Double) -> MlfeaturepcaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaModel::sum(self : MlfeaturepcaModel) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaModel::mean(self : MlfeaturepcaModel) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaModel::scale(self : MlfeaturepcaModel, f : Double) -> MlfeaturepcaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaModel::add(self : MlfeaturepcaModel, other : MlfeaturepcaModel) -> MlfeaturepcaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaModel::copy(self : MlfeaturepcaModel) -> MlfeaturepcaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaModel::fill(self : MlfeaturepcaModel, v : Double) -> MlfeaturepcaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaModel::min(self : MlfeaturepcaModel) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaModel::max(self : MlfeaturepcaModel) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaModel::to_string(self : MlfeaturepcaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_layer_make(size : Int) -> MlfeaturepcaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaLayer::len(self : MlfeaturepcaLayer) -> Int { self.size }

pub fn MlfeaturepcaLayer::get(self : MlfeaturepcaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaLayer::set(self : MlfeaturepcaLayer, i : Int, v : Double) -> MlfeaturepcaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaLayer::sum(self : MlfeaturepcaLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaLayer::mean(self : MlfeaturepcaLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaLayer::scale(self : MlfeaturepcaLayer, f : Double) -> MlfeaturepcaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaLayer::add(self : MlfeaturepcaLayer, other : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaLayer::copy(self : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaLayer::fill(self : MlfeaturepcaLayer, v : Double) -> MlfeaturepcaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaLayer::min(self : MlfeaturepcaLayer) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaLayer::max(self : MlfeaturepcaLayer) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaLayer::to_string(self : MlfeaturepcaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_buffer_make(size : Int) -> MlfeaturepcaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaBuffer::len(self : MlfeaturepcaBuffer) -> Int { self.size }

pub fn MlfeaturepcaBuffer::get(self : MlfeaturepcaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaBuffer::set(self : MlfeaturepcaBuffer, i : Int, v : Double) -> MlfeaturepcaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaBuffer::sum(self : MlfeaturepcaBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaBuffer::mean(self : MlfeaturepcaBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaBuffer::scale(self : MlfeaturepcaBuffer, f : Double) -> MlfeaturepcaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaBuffer::add(self : MlfeaturepcaBuffer, other : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaBuffer::copy(self : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaBuffer::fill(self : MlfeaturepcaBuffer, v : Double) -> MlfeaturepcaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaBuffer::min(self : MlfeaturepcaBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaBuffer::max(self : MlfeaturepcaBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaBuffer::to_string(self : MlfeaturepcaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cursor_make(size : Int) -> MlfeaturepcaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaCursor::len(self : MlfeaturepcaCursor) -> Int { self.size }

pub fn MlfeaturepcaCursor::get(self : MlfeaturepcaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaCursor::set(self : MlfeaturepcaCursor, i : Int, v : Double) -> MlfeaturepcaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCursor::sum(self : MlfeaturepcaCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaCursor::mean(self : MlfeaturepcaCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaCursor::scale(self : MlfeaturepcaCursor, f : Double) -> MlfeaturepcaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCursor::add(self : MlfeaturepcaCursor, other : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaCursor::copy(self : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCursor::fill(self : MlfeaturepcaCursor, v : Double) -> MlfeaturepcaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaCursor::min(self : MlfeaturepcaCursor) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaCursor::max(self : MlfeaturepcaCursor) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaCursor::to_string(self : MlfeaturepcaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_view_make(size : Int) -> MlfeaturepcaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaView::len(self : MlfeaturepcaView) -> Int { self.size }

pub fn MlfeaturepcaView::get(self : MlfeaturepcaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaView::set(self : MlfeaturepcaView, i : Int, v : Double) -> MlfeaturepcaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaView::sum(self : MlfeaturepcaView) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaView::mean(self : MlfeaturepcaView) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaView::scale(self : MlfeaturepcaView, f : Double) -> MlfeaturepcaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaView::add(self : MlfeaturepcaView, other : MlfeaturepcaView) -> MlfeaturepcaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaView::copy(self : MlfeaturepcaView) -> MlfeaturepcaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaView::fill(self : MlfeaturepcaView, v : Double) -> MlfeaturepcaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaView::min(self : MlfeaturepcaView) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaView::max(self : MlfeaturepcaView) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaView::to_string(self : MlfeaturepcaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_range_make(size : Int) -> MlfeaturepcaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaRange::len(self : MlfeaturepcaRange) -> Int { self.size }

pub fn MlfeaturepcaRange::get(self : MlfeaturepcaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaRange::set(self : MlfeaturepcaRange, i : Int, v : Double) -> MlfeaturepcaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaRange::sum(self : MlfeaturepcaRange) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaRange::mean(self : MlfeaturepcaRange) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaRange::scale(self : MlfeaturepcaRange, f : Double) -> MlfeaturepcaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaRange::add(self : MlfeaturepcaRange, other : MlfeaturepcaRange) -> MlfeaturepcaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaRange::copy(self : MlfeaturepcaRange) -> MlfeaturepcaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaRange::fill(self : MlfeaturepcaRange, v : Double) -> MlfeaturepcaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaRange::min(self : MlfeaturepcaRange) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaRange::max(self : MlfeaturepcaRange) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaRange::to_string(self : MlfeaturepcaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_slice_make(size : Int) -> MlfeaturepcaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturepcaSlice::len(self : MlfeaturepcaSlice) -> Int { self.size }

pub fn MlfeaturepcaSlice::get(self : MlfeaturepcaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturepcaSlice::set(self : MlfeaturepcaSlice, i : Int, v : Double) -> MlfeaturepcaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaSlice::sum(self : MlfeaturepcaSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeaturepcaSlice::mean(self : MlfeaturepcaSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeaturepcaSlice::scale(self : MlfeaturepcaSlice, f : Double) -> MlfeaturepcaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaSlice::add(self : MlfeaturepcaSlice, other : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturepcaSlice::copy(self : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaSlice::fill(self : MlfeaturepcaSlice, v : Double) -> MlfeaturepcaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturepcaSlice::min(self : MlfeaturepcaSlice) -> Double { @_common.min(self.data) }

pub fn MlfeaturepcaSlice::max(self : MlfeaturepcaSlice) -> Double { @_common.max(self.data) }

pub fn MlfeaturepcaSlice::to_string(self : MlfeaturepcaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

