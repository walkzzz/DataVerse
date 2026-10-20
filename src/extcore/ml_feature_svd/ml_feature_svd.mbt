///===
/// extcore/ml_feature_svd

pub(all) struct MlfeaturesvdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_svd_make_point(x : Double, y : Double) -> MlfeaturesvdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_svd_make_point3(x : Double, y : Double, z : Double) -> MlfeaturesvdPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturesvdPoint::x(self : MlfeaturesvdPoint) -> Double { self.x }

pub fn MlfeaturesvdPoint::y(self : MlfeaturesvdPoint) -> Double { self.y }

pub fn MlfeaturesvdPoint::z(self : MlfeaturesvdPoint) -> Double { self.z }

pub fn MlfeaturesvdPoint::label(self : MlfeaturesvdPoint) -> Int { self.label }

pub fn MlfeaturesvdPoint::dist(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturesvdPoint::add(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturesvdPoint::sub(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturesvdPoint::scale(self : MlfeaturesvdPoint, s : Double) -> MlfeaturesvdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturesvdPoint::dot(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturesvdPoint::cross(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturesvdPoint::norm(self : MlfeaturesvdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturesvdPoint::normalize(self : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturesvdPoint::negate(self : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturesvdPoint::mid(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturesvdPoint::lerp(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint, t : Double) -> MlfeaturesvdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturesvdPoint::to_string(self : MlfeaturesvdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturesvdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_svd_make_series(vals : Array[Double], name : String) -> MlfeaturesvdSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturesvdSeries::len(self : MlfeaturesvdSeries) -> Int { self.vals.length() }

pub fn MlfeaturesvdSeries::sum(self : MlfeaturesvdSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturesvdSeries::mean(self : MlfeaturesvdSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturesvdSeries::min(self : MlfeaturesvdSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturesvdSeries::max(self : MlfeaturesvdSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturesvdSeries::range(self : MlfeaturesvdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturesvdSeries::variance(self : MlfeaturesvdSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturesvdSeries::std(self : MlfeaturesvdSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturesvdSeries::median(self : MlfeaturesvdSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturesvdSeries::scale(self : MlfeaturesvdSeries, f : Double) -> MlfeaturesvdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturesvdSeries::add(self : MlfeaturesvdSeries, other : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturesvdSeries::sub(self : MlfeaturesvdSeries, other : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturesvdSeries::normalize(self : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturesvdSeries::cumsum(self : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturesvdSeries::to_string(self : MlfeaturesvdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturesvdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_svd_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturesvdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_svd_matrix_identity(n : Int) -> MlfeaturesvdMatrix {
  let m = ml_feature_svd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturesvdMatrix::get(self : MlfeaturesvdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturesvdMatrix::transpose(self : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  let result = ml_feature_svd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturesvdMatrix::add(self : MlfeaturesvdMatrix, other : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturesvdMatrix::scale(self : MlfeaturesvdMatrix, s : Double) -> MlfeaturesvdMatrix {
  let result = ml_feature_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturesvdMatrix::multiply(self : MlfeaturesvdMatrix, other : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  if self.cols != other.rows { return ml_feature_svd_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_svd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlfeaturesvdMatrix::trace(self : MlfeaturesvdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturesvdMatrix::det(self : MlfeaturesvdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturesvdMatrix::norm(self : MlfeaturesvdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturesvdMatrix::to_string(self : MlfeaturesvdMatrix) -> String {
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

pub(all) struct MlfeaturesvdVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_svd_make_vector(comps : Array[Double]) -> MlfeaturesvdVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_svd_vector_zero(dim : Int) -> MlfeaturesvdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturesvdVector::add(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturesvdVector::sub(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturesvdVector::scale(self : MlfeaturesvdVector, s : Double) -> MlfeaturesvdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturesvdVector::dot(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturesvdVector::norm(self : MlfeaturesvdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturesvdVector::normalize(self : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturesvdVector::dist(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturesvdVector::to_string(self : MlfeaturesvdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturesvdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_frame_make(size : Int) -> MlfeaturesvdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdFrame::len(self : MlfeaturesvdFrame) -> Int { self.size }

pub fn MlfeaturesvdFrame::get(self : MlfeaturesvdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdFrame::set(self : MlfeaturesvdFrame, i : Int, v : Double) -> MlfeaturesvdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdFrame::sum(self : MlfeaturesvdFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdFrame::mean(self : MlfeaturesvdFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdFrame::scale(self : MlfeaturesvdFrame, f : Double) -> MlfeaturesvdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdFrame::add(self : MlfeaturesvdFrame, other : MlfeaturesvdFrame) -> MlfeaturesvdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdFrame::copy(self : MlfeaturesvdFrame) -> MlfeaturesvdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdFrame::fill(self : MlfeaturesvdFrame, v : Double) -> MlfeaturesvdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdFrame::min(self : MlfeaturesvdFrame) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdFrame::max(self : MlfeaturesvdFrame) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdFrame::to_string(self : MlfeaturesvdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_table_make(size : Int) -> MlfeaturesvdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdTable::len(self : MlfeaturesvdTable) -> Int { self.size }

pub fn MlfeaturesvdTable::get(self : MlfeaturesvdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdTable::set(self : MlfeaturesvdTable, i : Int, v : Double) -> MlfeaturesvdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdTable::sum(self : MlfeaturesvdTable) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdTable::mean(self : MlfeaturesvdTable) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdTable::scale(self : MlfeaturesvdTable, f : Double) -> MlfeaturesvdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdTable::add(self : MlfeaturesvdTable, other : MlfeaturesvdTable) -> MlfeaturesvdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdTable::copy(self : MlfeaturesvdTable) -> MlfeaturesvdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdTable::fill(self : MlfeaturesvdTable, v : Double) -> MlfeaturesvdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdTable::min(self : MlfeaturesvdTable) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdTable::max(self : MlfeaturesvdTable) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdTable::to_string(self : MlfeaturesvdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_graphn_make(size : Int) -> MlfeaturesvdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdGraphN::len(self : MlfeaturesvdGraphN) -> Int { self.size }

pub fn MlfeaturesvdGraphN::get(self : MlfeaturesvdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdGraphN::set(self : MlfeaturesvdGraphN, i : Int, v : Double) -> MlfeaturesvdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdGraphN::sum(self : MlfeaturesvdGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdGraphN::mean(self : MlfeaturesvdGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdGraphN::scale(self : MlfeaturesvdGraphN, f : Double) -> MlfeaturesvdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdGraphN::add(self : MlfeaturesvdGraphN, other : MlfeaturesvdGraphN) -> MlfeaturesvdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdGraphN::copy(self : MlfeaturesvdGraphN) -> MlfeaturesvdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdGraphN::fill(self : MlfeaturesvdGraphN, v : Double) -> MlfeaturesvdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdGraphN::min(self : MlfeaturesvdGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdGraphN::max(self : MlfeaturesvdGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdGraphN::to_string(self : MlfeaturesvdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_node_make(size : Int) -> MlfeaturesvdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdNode::len(self : MlfeaturesvdNode) -> Int { self.size }

pub fn MlfeaturesvdNode::get(self : MlfeaturesvdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdNode::set(self : MlfeaturesvdNode, i : Int, v : Double) -> MlfeaturesvdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdNode::sum(self : MlfeaturesvdNode) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdNode::mean(self : MlfeaturesvdNode) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdNode::scale(self : MlfeaturesvdNode, f : Double) -> MlfeaturesvdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdNode::add(self : MlfeaturesvdNode, other : MlfeaturesvdNode) -> MlfeaturesvdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdNode::copy(self : MlfeaturesvdNode) -> MlfeaturesvdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdNode::fill(self : MlfeaturesvdNode, v : Double) -> MlfeaturesvdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdNode::min(self : MlfeaturesvdNode) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdNode::max(self : MlfeaturesvdNode) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdNode::to_string(self : MlfeaturesvdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_edge_make(size : Int) -> MlfeaturesvdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdEdge::len(self : MlfeaturesvdEdge) -> Int { self.size }

pub fn MlfeaturesvdEdge::get(self : MlfeaturesvdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdEdge::set(self : MlfeaturesvdEdge, i : Int, v : Double) -> MlfeaturesvdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdEdge::sum(self : MlfeaturesvdEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdEdge::mean(self : MlfeaturesvdEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdEdge::scale(self : MlfeaturesvdEdge, f : Double) -> MlfeaturesvdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdEdge::add(self : MlfeaturesvdEdge, other : MlfeaturesvdEdge) -> MlfeaturesvdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdEdge::copy(self : MlfeaturesvdEdge) -> MlfeaturesvdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdEdge::fill(self : MlfeaturesvdEdge, v : Double) -> MlfeaturesvdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdEdge::min(self : MlfeaturesvdEdge) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdEdge::max(self : MlfeaturesvdEdge) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdEdge::to_string(self : MlfeaturesvdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_path_make(size : Int) -> MlfeaturesvdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdPath::len(self : MlfeaturesvdPath) -> Int { self.size }

pub fn MlfeaturesvdPath::get(self : MlfeaturesvdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdPath::set(self : MlfeaturesvdPath, i : Int, v : Double) -> MlfeaturesvdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdPath::sum(self : MlfeaturesvdPath) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdPath::mean(self : MlfeaturesvdPath) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdPath::scale(self : MlfeaturesvdPath, f : Double) -> MlfeaturesvdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdPath::add(self : MlfeaturesvdPath, other : MlfeaturesvdPath) -> MlfeaturesvdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdPath::copy(self : MlfeaturesvdPath) -> MlfeaturesvdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdPath::fill(self : MlfeaturesvdPath, v : Double) -> MlfeaturesvdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdPath::min(self : MlfeaturesvdPath) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdPath::max(self : MlfeaturesvdPath) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdPath::to_string(self : MlfeaturesvdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_cluster_make(size : Int) -> MlfeaturesvdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdCluster::len(self : MlfeaturesvdCluster) -> Int { self.size }

pub fn MlfeaturesvdCluster::get(self : MlfeaturesvdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdCluster::set(self : MlfeaturesvdCluster, i : Int, v : Double) -> MlfeaturesvdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCluster::sum(self : MlfeaturesvdCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdCluster::mean(self : MlfeaturesvdCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdCluster::scale(self : MlfeaturesvdCluster, f : Double) -> MlfeaturesvdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCluster::add(self : MlfeaturesvdCluster, other : MlfeaturesvdCluster) -> MlfeaturesvdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdCluster::copy(self : MlfeaturesvdCluster) -> MlfeaturesvdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCluster::fill(self : MlfeaturesvdCluster, v : Double) -> MlfeaturesvdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCluster::min(self : MlfeaturesvdCluster) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdCluster::max(self : MlfeaturesvdCluster) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdCluster::to_string(self : MlfeaturesvdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_model_make(size : Int) -> MlfeaturesvdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdModel::len(self : MlfeaturesvdModel) -> Int { self.size }

pub fn MlfeaturesvdModel::get(self : MlfeaturesvdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdModel::set(self : MlfeaturesvdModel, i : Int, v : Double) -> MlfeaturesvdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdModel::sum(self : MlfeaturesvdModel) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdModel::mean(self : MlfeaturesvdModel) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdModel::scale(self : MlfeaturesvdModel, f : Double) -> MlfeaturesvdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdModel::add(self : MlfeaturesvdModel, other : MlfeaturesvdModel) -> MlfeaturesvdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdModel::copy(self : MlfeaturesvdModel) -> MlfeaturesvdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdModel::fill(self : MlfeaturesvdModel, v : Double) -> MlfeaturesvdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdModel::min(self : MlfeaturesvdModel) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdModel::max(self : MlfeaturesvdModel) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdModel::to_string(self : MlfeaturesvdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_layer_make(size : Int) -> MlfeaturesvdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdLayer::len(self : MlfeaturesvdLayer) -> Int { self.size }

pub fn MlfeaturesvdLayer::get(self : MlfeaturesvdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdLayer::set(self : MlfeaturesvdLayer, i : Int, v : Double) -> MlfeaturesvdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdLayer::sum(self : MlfeaturesvdLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdLayer::mean(self : MlfeaturesvdLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdLayer::scale(self : MlfeaturesvdLayer, f : Double) -> MlfeaturesvdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdLayer::add(self : MlfeaturesvdLayer, other : MlfeaturesvdLayer) -> MlfeaturesvdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdLayer::copy(self : MlfeaturesvdLayer) -> MlfeaturesvdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdLayer::fill(self : MlfeaturesvdLayer, v : Double) -> MlfeaturesvdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdLayer::min(self : MlfeaturesvdLayer) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdLayer::max(self : MlfeaturesvdLayer) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdLayer::to_string(self : MlfeaturesvdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_buffer_make(size : Int) -> MlfeaturesvdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdBuffer::len(self : MlfeaturesvdBuffer) -> Int { self.size }

pub fn MlfeaturesvdBuffer::get(self : MlfeaturesvdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdBuffer::set(self : MlfeaturesvdBuffer, i : Int, v : Double) -> MlfeaturesvdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdBuffer::sum(self : MlfeaturesvdBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdBuffer::mean(self : MlfeaturesvdBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdBuffer::scale(self : MlfeaturesvdBuffer, f : Double) -> MlfeaturesvdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdBuffer::add(self : MlfeaturesvdBuffer, other : MlfeaturesvdBuffer) -> MlfeaturesvdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdBuffer::copy(self : MlfeaturesvdBuffer) -> MlfeaturesvdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdBuffer::fill(self : MlfeaturesvdBuffer, v : Double) -> MlfeaturesvdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdBuffer::min(self : MlfeaturesvdBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdBuffer::max(self : MlfeaturesvdBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdBuffer::to_string(self : MlfeaturesvdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_cursor_make(size : Int) -> MlfeaturesvdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdCursor::len(self : MlfeaturesvdCursor) -> Int { self.size }

pub fn MlfeaturesvdCursor::get(self : MlfeaturesvdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdCursor::set(self : MlfeaturesvdCursor, i : Int, v : Double) -> MlfeaturesvdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCursor::sum(self : MlfeaturesvdCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdCursor::mean(self : MlfeaturesvdCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdCursor::scale(self : MlfeaturesvdCursor, f : Double) -> MlfeaturesvdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCursor::add(self : MlfeaturesvdCursor, other : MlfeaturesvdCursor) -> MlfeaturesvdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdCursor::copy(self : MlfeaturesvdCursor) -> MlfeaturesvdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCursor::fill(self : MlfeaturesvdCursor, v : Double) -> MlfeaturesvdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdCursor::min(self : MlfeaturesvdCursor) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdCursor::max(self : MlfeaturesvdCursor) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdCursor::to_string(self : MlfeaturesvdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_view_make(size : Int) -> MlfeaturesvdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdView::len(self : MlfeaturesvdView) -> Int { self.size }

pub fn MlfeaturesvdView::get(self : MlfeaturesvdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdView::set(self : MlfeaturesvdView, i : Int, v : Double) -> MlfeaturesvdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdView::sum(self : MlfeaturesvdView) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdView::mean(self : MlfeaturesvdView) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdView::scale(self : MlfeaturesvdView, f : Double) -> MlfeaturesvdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdView::add(self : MlfeaturesvdView, other : MlfeaturesvdView) -> MlfeaturesvdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdView::copy(self : MlfeaturesvdView) -> MlfeaturesvdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdView::fill(self : MlfeaturesvdView, v : Double) -> MlfeaturesvdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdView::min(self : MlfeaturesvdView) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdView::max(self : MlfeaturesvdView) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdView::to_string(self : MlfeaturesvdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_range_make(size : Int) -> MlfeaturesvdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdRange::len(self : MlfeaturesvdRange) -> Int { self.size }

pub fn MlfeaturesvdRange::get(self : MlfeaturesvdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdRange::set(self : MlfeaturesvdRange, i : Int, v : Double) -> MlfeaturesvdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdRange::sum(self : MlfeaturesvdRange) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdRange::mean(self : MlfeaturesvdRange) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdRange::scale(self : MlfeaturesvdRange, f : Double) -> MlfeaturesvdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdRange::add(self : MlfeaturesvdRange, other : MlfeaturesvdRange) -> MlfeaturesvdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdRange::copy(self : MlfeaturesvdRange) -> MlfeaturesvdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdRange::fill(self : MlfeaturesvdRange, v : Double) -> MlfeaturesvdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdRange::min(self : MlfeaturesvdRange) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdRange::max(self : MlfeaturesvdRange) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdRange::to_string(self : MlfeaturesvdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_slice_make(size : Int) -> MlfeaturesvdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturesvdSlice::len(self : MlfeaturesvdSlice) -> Int { self.size }

pub fn MlfeaturesvdSlice::get(self : MlfeaturesvdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturesvdSlice::set(self : MlfeaturesvdSlice, i : Int, v : Double) -> MlfeaturesvdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdSlice::sum(self : MlfeaturesvdSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeaturesvdSlice::mean(self : MlfeaturesvdSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeaturesvdSlice::scale(self : MlfeaturesvdSlice, f : Double) -> MlfeaturesvdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdSlice::add(self : MlfeaturesvdSlice, other : MlfeaturesvdSlice) -> MlfeaturesvdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturesvdSlice::copy(self : MlfeaturesvdSlice) -> MlfeaturesvdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdSlice::fill(self : MlfeaturesvdSlice, v : Double) -> MlfeaturesvdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturesvdSlice::min(self : MlfeaturesvdSlice) -> Double { @_common.min(self.data) }

pub fn MlfeaturesvdSlice::max(self : MlfeaturesvdSlice) -> Double { @_common.max(self.data) }

pub fn MlfeaturesvdSlice::to_string(self : MlfeaturesvdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

