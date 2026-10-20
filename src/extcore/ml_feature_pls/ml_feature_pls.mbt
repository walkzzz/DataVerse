///===
/// extcore/ml_feature_pls

pub(all) struct MlfeatureplsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pls_make_point(x : Double, y : Double) -> MlfeatureplsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pls_make_point3(x : Double, y : Double, z : Double) -> MlfeatureplsPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureplsPoint::x(self : MlfeatureplsPoint) -> Double { self.x }

pub fn MlfeatureplsPoint::y(self : MlfeatureplsPoint) -> Double { self.y }

pub fn MlfeatureplsPoint::z(self : MlfeatureplsPoint) -> Double { self.z }

pub fn MlfeatureplsPoint::label(self : MlfeatureplsPoint) -> Int { self.label }

pub fn MlfeatureplsPoint::dist(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureplsPoint::add(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureplsPoint::sub(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureplsPoint::scale(self : MlfeatureplsPoint, s : Double) -> MlfeatureplsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureplsPoint::dot(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureplsPoint::cross(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureplsPoint::norm(self : MlfeatureplsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureplsPoint::normalize(self : MlfeatureplsPoint) -> MlfeatureplsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureplsPoint::negate(self : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureplsPoint::mid(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureplsPoint::lerp(self : MlfeatureplsPoint, other : MlfeatureplsPoint, t : Double) -> MlfeatureplsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureplsPoint::to_string(self : MlfeatureplsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureplsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pls_make_series(vals : Array[Double], name : String) -> MlfeatureplsSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureplsSeries::len(self : MlfeatureplsSeries) -> Int { self.vals.length() }

pub fn MlfeatureplsSeries::sum(self : MlfeatureplsSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureplsSeries::mean(self : MlfeatureplsSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureplsSeries::min(self : MlfeatureplsSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureplsSeries::max(self : MlfeatureplsSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureplsSeries::range(self : MlfeatureplsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureplsSeries::variance(self : MlfeatureplsSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureplsSeries::std(self : MlfeatureplsSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureplsSeries::median(self : MlfeatureplsSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureplsSeries::scale(self : MlfeatureplsSeries, f : Double) -> MlfeatureplsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureplsSeries::add(self : MlfeatureplsSeries, other : MlfeatureplsSeries) -> MlfeatureplsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureplsSeries::sub(self : MlfeatureplsSeries, other : MlfeatureplsSeries) -> MlfeatureplsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureplsSeries::normalize(self : MlfeatureplsSeries) -> MlfeatureplsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureplsSeries::cumsum(self : MlfeatureplsSeries) -> MlfeatureplsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureplsSeries::to_string(self : MlfeatureplsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureplsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pls_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureplsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pls_matrix_identity(n : Int) -> MlfeatureplsMatrix {
  let m = ml_feature_pls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureplsMatrix::get(self : MlfeatureplsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureplsMatrix::transpose(self : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  let result = ml_feature_pls_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureplsMatrix::add(self : MlfeatureplsMatrix, other : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_pls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureplsMatrix::scale(self : MlfeatureplsMatrix, s : Double) -> MlfeatureplsMatrix {
  let result = ml_feature_pls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureplsMatrix::multiply(self : MlfeatureplsMatrix, other : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  if self.cols != other.rows { return ml_feature_pls_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_pls_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureplsMatrix::trace(self : MlfeatureplsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureplsMatrix::det(self : MlfeatureplsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureplsMatrix::norm(self : MlfeatureplsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureplsMatrix::to_string(self : MlfeatureplsMatrix) -> String {
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

pub(all) struct MlfeatureplsVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pls_make_vector(comps : Array[Double]) -> MlfeatureplsVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pls_vector_zero(dim : Int) -> MlfeatureplsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureplsVector::add(self : MlfeatureplsVector, other : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureplsVector::sub(self : MlfeatureplsVector, other : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureplsVector::scale(self : MlfeatureplsVector, s : Double) -> MlfeatureplsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureplsVector::dot(self : MlfeatureplsVector, other : MlfeatureplsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureplsVector::norm(self : MlfeatureplsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureplsVector::normalize(self : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureplsVector::dist(self : MlfeatureplsVector, other : MlfeatureplsVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureplsVector::to_string(self : MlfeatureplsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureplsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_frame_make(size : Int) -> MlfeatureplsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsFrame::len(self : MlfeatureplsFrame) -> Int { self.size }

pub fn MlfeatureplsFrame::get(self : MlfeatureplsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsFrame::set(self : MlfeatureplsFrame, i : Int, v : Double) -> MlfeatureplsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsFrame::sum(self : MlfeatureplsFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsFrame::mean(self : MlfeatureplsFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsFrame::scale(self : MlfeatureplsFrame, f : Double) -> MlfeatureplsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsFrame::add(self : MlfeatureplsFrame, other : MlfeatureplsFrame) -> MlfeatureplsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsFrame::copy(self : MlfeatureplsFrame) -> MlfeatureplsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsFrame::fill(self : MlfeatureplsFrame, v : Double) -> MlfeatureplsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsFrame::min(self : MlfeatureplsFrame) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsFrame::max(self : MlfeatureplsFrame) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsFrame::to_string(self : MlfeatureplsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_table_make(size : Int) -> MlfeatureplsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsTable::len(self : MlfeatureplsTable) -> Int { self.size }

pub fn MlfeatureplsTable::get(self : MlfeatureplsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsTable::set(self : MlfeatureplsTable, i : Int, v : Double) -> MlfeatureplsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsTable::sum(self : MlfeatureplsTable) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsTable::mean(self : MlfeatureplsTable) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsTable::scale(self : MlfeatureplsTable, f : Double) -> MlfeatureplsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsTable::add(self : MlfeatureplsTable, other : MlfeatureplsTable) -> MlfeatureplsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsTable::copy(self : MlfeatureplsTable) -> MlfeatureplsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsTable::fill(self : MlfeatureplsTable, v : Double) -> MlfeatureplsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsTable::min(self : MlfeatureplsTable) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsTable::max(self : MlfeatureplsTable) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsTable::to_string(self : MlfeatureplsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_graphn_make(size : Int) -> MlfeatureplsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsGraphN::len(self : MlfeatureplsGraphN) -> Int { self.size }

pub fn MlfeatureplsGraphN::get(self : MlfeatureplsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsGraphN::set(self : MlfeatureplsGraphN, i : Int, v : Double) -> MlfeatureplsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsGraphN::sum(self : MlfeatureplsGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsGraphN::mean(self : MlfeatureplsGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsGraphN::scale(self : MlfeatureplsGraphN, f : Double) -> MlfeatureplsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsGraphN::add(self : MlfeatureplsGraphN, other : MlfeatureplsGraphN) -> MlfeatureplsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsGraphN::copy(self : MlfeatureplsGraphN) -> MlfeatureplsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsGraphN::fill(self : MlfeatureplsGraphN, v : Double) -> MlfeatureplsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsGraphN::min(self : MlfeatureplsGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsGraphN::max(self : MlfeatureplsGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsGraphN::to_string(self : MlfeatureplsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_node_make(size : Int) -> MlfeatureplsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsNode::len(self : MlfeatureplsNode) -> Int { self.size }

pub fn MlfeatureplsNode::get(self : MlfeatureplsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsNode::set(self : MlfeatureplsNode, i : Int, v : Double) -> MlfeatureplsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsNode::sum(self : MlfeatureplsNode) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsNode::mean(self : MlfeatureplsNode) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsNode::scale(self : MlfeatureplsNode, f : Double) -> MlfeatureplsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsNode::add(self : MlfeatureplsNode, other : MlfeatureplsNode) -> MlfeatureplsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsNode::copy(self : MlfeatureplsNode) -> MlfeatureplsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsNode::fill(self : MlfeatureplsNode, v : Double) -> MlfeatureplsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsNode::min(self : MlfeatureplsNode) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsNode::max(self : MlfeatureplsNode) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsNode::to_string(self : MlfeatureplsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_edge_make(size : Int) -> MlfeatureplsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsEdge::len(self : MlfeatureplsEdge) -> Int { self.size }

pub fn MlfeatureplsEdge::get(self : MlfeatureplsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsEdge::set(self : MlfeatureplsEdge, i : Int, v : Double) -> MlfeatureplsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsEdge::sum(self : MlfeatureplsEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsEdge::mean(self : MlfeatureplsEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsEdge::scale(self : MlfeatureplsEdge, f : Double) -> MlfeatureplsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsEdge::add(self : MlfeatureplsEdge, other : MlfeatureplsEdge) -> MlfeatureplsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsEdge::copy(self : MlfeatureplsEdge) -> MlfeatureplsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsEdge::fill(self : MlfeatureplsEdge, v : Double) -> MlfeatureplsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsEdge::min(self : MlfeatureplsEdge) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsEdge::max(self : MlfeatureplsEdge) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsEdge::to_string(self : MlfeatureplsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_path_make(size : Int) -> MlfeatureplsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsPath::len(self : MlfeatureplsPath) -> Int { self.size }

pub fn MlfeatureplsPath::get(self : MlfeatureplsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsPath::set(self : MlfeatureplsPath, i : Int, v : Double) -> MlfeatureplsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsPath::sum(self : MlfeatureplsPath) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsPath::mean(self : MlfeatureplsPath) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsPath::scale(self : MlfeatureplsPath, f : Double) -> MlfeatureplsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsPath::add(self : MlfeatureplsPath, other : MlfeatureplsPath) -> MlfeatureplsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsPath::copy(self : MlfeatureplsPath) -> MlfeatureplsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsPath::fill(self : MlfeatureplsPath, v : Double) -> MlfeatureplsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsPath::min(self : MlfeatureplsPath) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsPath::max(self : MlfeatureplsPath) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsPath::to_string(self : MlfeatureplsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_cluster_make(size : Int) -> MlfeatureplsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsCluster::len(self : MlfeatureplsCluster) -> Int { self.size }

pub fn MlfeatureplsCluster::get(self : MlfeatureplsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsCluster::set(self : MlfeatureplsCluster, i : Int, v : Double) -> MlfeatureplsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCluster::sum(self : MlfeatureplsCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsCluster::mean(self : MlfeatureplsCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsCluster::scale(self : MlfeatureplsCluster, f : Double) -> MlfeatureplsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCluster::add(self : MlfeatureplsCluster, other : MlfeatureplsCluster) -> MlfeatureplsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsCluster::copy(self : MlfeatureplsCluster) -> MlfeatureplsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCluster::fill(self : MlfeatureplsCluster, v : Double) -> MlfeatureplsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCluster::min(self : MlfeatureplsCluster) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsCluster::max(self : MlfeatureplsCluster) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsCluster::to_string(self : MlfeatureplsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_model_make(size : Int) -> MlfeatureplsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsModel::len(self : MlfeatureplsModel) -> Int { self.size }

pub fn MlfeatureplsModel::get(self : MlfeatureplsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsModel::set(self : MlfeatureplsModel, i : Int, v : Double) -> MlfeatureplsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsModel::sum(self : MlfeatureplsModel) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsModel::mean(self : MlfeatureplsModel) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsModel::scale(self : MlfeatureplsModel, f : Double) -> MlfeatureplsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsModel::add(self : MlfeatureplsModel, other : MlfeatureplsModel) -> MlfeatureplsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsModel::copy(self : MlfeatureplsModel) -> MlfeatureplsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsModel::fill(self : MlfeatureplsModel, v : Double) -> MlfeatureplsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsModel::min(self : MlfeatureplsModel) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsModel::max(self : MlfeatureplsModel) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsModel::to_string(self : MlfeatureplsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_layer_make(size : Int) -> MlfeatureplsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsLayer::len(self : MlfeatureplsLayer) -> Int { self.size }

pub fn MlfeatureplsLayer::get(self : MlfeatureplsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsLayer::set(self : MlfeatureplsLayer, i : Int, v : Double) -> MlfeatureplsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsLayer::sum(self : MlfeatureplsLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsLayer::mean(self : MlfeatureplsLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsLayer::scale(self : MlfeatureplsLayer, f : Double) -> MlfeatureplsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsLayer::add(self : MlfeatureplsLayer, other : MlfeatureplsLayer) -> MlfeatureplsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsLayer::copy(self : MlfeatureplsLayer) -> MlfeatureplsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsLayer::fill(self : MlfeatureplsLayer, v : Double) -> MlfeatureplsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsLayer::min(self : MlfeatureplsLayer) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsLayer::max(self : MlfeatureplsLayer) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsLayer::to_string(self : MlfeatureplsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_buffer_make(size : Int) -> MlfeatureplsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsBuffer::len(self : MlfeatureplsBuffer) -> Int { self.size }

pub fn MlfeatureplsBuffer::get(self : MlfeatureplsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsBuffer::set(self : MlfeatureplsBuffer, i : Int, v : Double) -> MlfeatureplsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsBuffer::sum(self : MlfeatureplsBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsBuffer::mean(self : MlfeatureplsBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsBuffer::scale(self : MlfeatureplsBuffer, f : Double) -> MlfeatureplsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsBuffer::add(self : MlfeatureplsBuffer, other : MlfeatureplsBuffer) -> MlfeatureplsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsBuffer::copy(self : MlfeatureplsBuffer) -> MlfeatureplsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsBuffer::fill(self : MlfeatureplsBuffer, v : Double) -> MlfeatureplsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsBuffer::min(self : MlfeatureplsBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsBuffer::max(self : MlfeatureplsBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsBuffer::to_string(self : MlfeatureplsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_cursor_make(size : Int) -> MlfeatureplsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsCursor::len(self : MlfeatureplsCursor) -> Int { self.size }

pub fn MlfeatureplsCursor::get(self : MlfeatureplsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsCursor::set(self : MlfeatureplsCursor, i : Int, v : Double) -> MlfeatureplsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCursor::sum(self : MlfeatureplsCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsCursor::mean(self : MlfeatureplsCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsCursor::scale(self : MlfeatureplsCursor, f : Double) -> MlfeatureplsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCursor::add(self : MlfeatureplsCursor, other : MlfeatureplsCursor) -> MlfeatureplsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsCursor::copy(self : MlfeatureplsCursor) -> MlfeatureplsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCursor::fill(self : MlfeatureplsCursor, v : Double) -> MlfeatureplsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsCursor::min(self : MlfeatureplsCursor) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsCursor::max(self : MlfeatureplsCursor) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsCursor::to_string(self : MlfeatureplsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_view_make(size : Int) -> MlfeatureplsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsView::len(self : MlfeatureplsView) -> Int { self.size }

pub fn MlfeatureplsView::get(self : MlfeatureplsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsView::set(self : MlfeatureplsView, i : Int, v : Double) -> MlfeatureplsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsView::sum(self : MlfeatureplsView) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsView::mean(self : MlfeatureplsView) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsView::scale(self : MlfeatureplsView, f : Double) -> MlfeatureplsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsView::add(self : MlfeatureplsView, other : MlfeatureplsView) -> MlfeatureplsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsView::copy(self : MlfeatureplsView) -> MlfeatureplsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsView::fill(self : MlfeatureplsView, v : Double) -> MlfeatureplsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsView::min(self : MlfeatureplsView) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsView::max(self : MlfeatureplsView) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsView::to_string(self : MlfeatureplsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_range_make(size : Int) -> MlfeatureplsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsRange::len(self : MlfeatureplsRange) -> Int { self.size }

pub fn MlfeatureplsRange::get(self : MlfeatureplsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsRange::set(self : MlfeatureplsRange, i : Int, v : Double) -> MlfeatureplsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsRange::sum(self : MlfeatureplsRange) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsRange::mean(self : MlfeatureplsRange) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsRange::scale(self : MlfeatureplsRange, f : Double) -> MlfeatureplsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsRange::add(self : MlfeatureplsRange, other : MlfeatureplsRange) -> MlfeatureplsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsRange::copy(self : MlfeatureplsRange) -> MlfeatureplsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsRange::fill(self : MlfeatureplsRange, v : Double) -> MlfeatureplsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsRange::min(self : MlfeatureplsRange) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsRange::max(self : MlfeatureplsRange) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsRange::to_string(self : MlfeatureplsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_slice_make(size : Int) -> MlfeatureplsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeatureplsSlice::len(self : MlfeatureplsSlice) -> Int { self.size }

pub fn MlfeatureplsSlice::get(self : MlfeatureplsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeatureplsSlice::set(self : MlfeatureplsSlice, i : Int, v : Double) -> MlfeatureplsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeatureplsSlice::sum(self : MlfeatureplsSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeatureplsSlice::mean(self : MlfeatureplsSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeatureplsSlice::scale(self : MlfeatureplsSlice, f : Double) -> MlfeatureplsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsSlice::add(self : MlfeatureplsSlice, other : MlfeatureplsSlice) -> MlfeatureplsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeatureplsSlice::copy(self : MlfeatureplsSlice) -> MlfeatureplsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsSlice::fill(self : MlfeatureplsSlice, v : Double) -> MlfeatureplsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeatureplsSlice::min(self : MlfeatureplsSlice) -> Double { @_common.min(self.data) }

pub fn MlfeatureplsSlice::max(self : MlfeatureplsSlice) -> Double { @_common.max(self.data) }

pub fn MlfeatureplsSlice::to_string(self : MlfeatureplsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

