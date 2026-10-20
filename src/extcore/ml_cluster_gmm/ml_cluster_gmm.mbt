///===
/// extcore/ml_cluster_gmm

pub(all) struct MlclustergmmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_gmm_make_point(x : Double, y : Double) -> MlclustergmmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_gmm_make_point3(x : Double, y : Double, z : Double) -> MlclustergmmPoint {
  { x, y, z, label: 0 }
}

pub fn MlclustergmmPoint::x(self : MlclustergmmPoint) -> Double { self.x }

pub fn MlclustergmmPoint::y(self : MlclustergmmPoint) -> Double { self.y }

pub fn MlclustergmmPoint::z(self : MlclustergmmPoint) -> Double { self.z }

pub fn MlclustergmmPoint::label(self : MlclustergmmPoint) -> Int { self.label }

pub fn MlclustergmmPoint::dist(self : MlclustergmmPoint, other : MlclustergmmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclustergmmPoint::add(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclustergmmPoint::sub(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclustergmmPoint::scale(self : MlclustergmmPoint, s : Double) -> MlclustergmmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclustergmmPoint::dot(self : MlclustergmmPoint, other : MlclustergmmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclustergmmPoint::cross(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclustergmmPoint::norm(self : MlclustergmmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclustergmmPoint::normalize(self : MlclustergmmPoint) -> MlclustergmmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustergmmPoint::negate(self : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclustergmmPoint::mid(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclustergmmPoint::lerp(self : MlclustergmmPoint, other : MlclustergmmPoint, t : Double) -> MlclustergmmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclustergmmPoint::to_string(self : MlclustergmmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclustergmmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_gmm_make_series(vals : Array[Double], name : String) -> MlclustergmmSeries {
  { vals, name, meta: 0 }
}

pub fn MlclustergmmSeries::len(self : MlclustergmmSeries) -> Int { self.vals.length() }

pub fn MlclustergmmSeries::sum(self : MlclustergmmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclustergmmSeries::mean(self : MlclustergmmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclustergmmSeries::min(self : MlclustergmmSeries) -> Double { @_common.min(self.vals) }

pub fn MlclustergmmSeries::max(self : MlclustergmmSeries) -> Double { @_common.max(self.vals) }

pub fn MlclustergmmSeries::range(self : MlclustergmmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclustergmmSeries::variance(self : MlclustergmmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclustergmmSeries::std(self : MlclustergmmSeries) -> Double { @_common.std(self.vals) }

pub fn MlclustergmmSeries::median(self : MlclustergmmSeries) -> Double { @_common.median(self.vals) }

pub fn MlclustergmmSeries::scale(self : MlclustergmmSeries, f : Double) -> MlclustergmmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclustergmmSeries::add(self : MlclustergmmSeries, other : MlclustergmmSeries) -> MlclustergmmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclustergmmSeries::sub(self : MlclustergmmSeries, other : MlclustergmmSeries) -> MlclustergmmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclustergmmSeries::normalize(self : MlclustergmmSeries) -> MlclustergmmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclustergmmSeries::cumsum(self : MlclustergmmSeries) -> MlclustergmmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclustergmmSeries::to_string(self : MlclustergmmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustergmmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_gmm_make_matrix(rows : Int, cols : Int, val : Double) -> MlclustergmmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_gmm_matrix_identity(n : Int) -> MlclustergmmMatrix {
  let m = ml_cluster_gmm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclustergmmMatrix::get(self : MlclustergmmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclustergmmMatrix::transpose(self : MlclustergmmMatrix) -> MlclustergmmMatrix {
  let result = ml_cluster_gmm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclustergmmMatrix::add(self : MlclustergmmMatrix, other : MlclustergmmMatrix) -> MlclustergmmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_gmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclustergmmMatrix::scale(self : MlclustergmmMatrix, s : Double) -> MlclustergmmMatrix {
  let result = ml_cluster_gmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclustergmmMatrix::multiply(self : MlclustergmmMatrix, other : MlclustergmmMatrix) -> MlclustergmmMatrix {
  if self.cols != other.rows { return ml_cluster_gmm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_gmm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclustergmmMatrix::trace(self : MlclustergmmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclustergmmMatrix::det(self : MlclustergmmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclustergmmMatrix::norm(self : MlclustergmmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclustergmmMatrix::to_string(self : MlclustergmmMatrix) -> String {
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

pub(all) struct MlclustergmmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_gmm_make_vector(comps : Array[Double]) -> MlclustergmmVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_gmm_vector_zero(dim : Int) -> MlclustergmmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclustergmmVector::add(self : MlclustergmmVector, other : MlclustergmmVector) -> MlclustergmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustergmmVector::sub(self : MlclustergmmVector, other : MlclustergmmVector) -> MlclustergmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustergmmVector::scale(self : MlclustergmmVector, s : Double) -> MlclustergmmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclustergmmVector::dot(self : MlclustergmmVector, other : MlclustergmmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclustergmmVector::norm(self : MlclustergmmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclustergmmVector::normalize(self : MlclustergmmVector) -> MlclustergmmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustergmmVector::dist(self : MlclustergmmVector, other : MlclustergmmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclustergmmVector::to_string(self : MlclustergmmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustergmmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_frame_make(size : Int) -> MlclustergmmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmFrame::len(self : MlclustergmmFrame) -> Int { self.size }

pub fn MlclustergmmFrame::get(self : MlclustergmmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmFrame::set(self : MlclustergmmFrame, i : Int, v : Double) -> MlclustergmmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmFrame::sum(self : MlclustergmmFrame) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmFrame::mean(self : MlclustergmmFrame) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmFrame::scale(self : MlclustergmmFrame, f : Double) -> MlclustergmmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmFrame::add(self : MlclustergmmFrame, other : MlclustergmmFrame) -> MlclustergmmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmFrame::copy(self : MlclustergmmFrame) -> MlclustergmmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmFrame::fill(self : MlclustergmmFrame, v : Double) -> MlclustergmmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmFrame::min(self : MlclustergmmFrame) -> Double { @_common.min(self.data) }

pub fn MlclustergmmFrame::max(self : MlclustergmmFrame) -> Double { @_common.max(self.data) }

pub fn MlclustergmmFrame::to_string(self : MlclustergmmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_table_make(size : Int) -> MlclustergmmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmTable::len(self : MlclustergmmTable) -> Int { self.size }

pub fn MlclustergmmTable::get(self : MlclustergmmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmTable::set(self : MlclustergmmTable, i : Int, v : Double) -> MlclustergmmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmTable::sum(self : MlclustergmmTable) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmTable::mean(self : MlclustergmmTable) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmTable::scale(self : MlclustergmmTable, f : Double) -> MlclustergmmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmTable::add(self : MlclustergmmTable, other : MlclustergmmTable) -> MlclustergmmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmTable::copy(self : MlclustergmmTable) -> MlclustergmmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmTable::fill(self : MlclustergmmTable, v : Double) -> MlclustergmmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmTable::min(self : MlclustergmmTable) -> Double { @_common.min(self.data) }

pub fn MlclustergmmTable::max(self : MlclustergmmTable) -> Double { @_common.max(self.data) }

pub fn MlclustergmmTable::to_string(self : MlclustergmmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_graphn_make(size : Int) -> MlclustergmmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmGraphN::len(self : MlclustergmmGraphN) -> Int { self.size }

pub fn MlclustergmmGraphN::get(self : MlclustergmmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmGraphN::set(self : MlclustergmmGraphN, i : Int, v : Double) -> MlclustergmmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmGraphN::sum(self : MlclustergmmGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmGraphN::mean(self : MlclustergmmGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmGraphN::scale(self : MlclustergmmGraphN, f : Double) -> MlclustergmmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmGraphN::add(self : MlclustergmmGraphN, other : MlclustergmmGraphN) -> MlclustergmmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmGraphN::copy(self : MlclustergmmGraphN) -> MlclustergmmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmGraphN::fill(self : MlclustergmmGraphN, v : Double) -> MlclustergmmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmGraphN::min(self : MlclustergmmGraphN) -> Double { @_common.min(self.data) }

pub fn MlclustergmmGraphN::max(self : MlclustergmmGraphN) -> Double { @_common.max(self.data) }

pub fn MlclustergmmGraphN::to_string(self : MlclustergmmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_node_make(size : Int) -> MlclustergmmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmNode::len(self : MlclustergmmNode) -> Int { self.size }

pub fn MlclustergmmNode::get(self : MlclustergmmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmNode::set(self : MlclustergmmNode, i : Int, v : Double) -> MlclustergmmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmNode::sum(self : MlclustergmmNode) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmNode::mean(self : MlclustergmmNode) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmNode::scale(self : MlclustergmmNode, f : Double) -> MlclustergmmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmNode::add(self : MlclustergmmNode, other : MlclustergmmNode) -> MlclustergmmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmNode::copy(self : MlclustergmmNode) -> MlclustergmmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmNode::fill(self : MlclustergmmNode, v : Double) -> MlclustergmmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmNode::min(self : MlclustergmmNode) -> Double { @_common.min(self.data) }

pub fn MlclustergmmNode::max(self : MlclustergmmNode) -> Double { @_common.max(self.data) }

pub fn MlclustergmmNode::to_string(self : MlclustergmmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_edge_make(size : Int) -> MlclustergmmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmEdge::len(self : MlclustergmmEdge) -> Int { self.size }

pub fn MlclustergmmEdge::get(self : MlclustergmmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmEdge::set(self : MlclustergmmEdge, i : Int, v : Double) -> MlclustergmmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmEdge::sum(self : MlclustergmmEdge) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmEdge::mean(self : MlclustergmmEdge) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmEdge::scale(self : MlclustergmmEdge, f : Double) -> MlclustergmmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmEdge::add(self : MlclustergmmEdge, other : MlclustergmmEdge) -> MlclustergmmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmEdge::copy(self : MlclustergmmEdge) -> MlclustergmmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmEdge::fill(self : MlclustergmmEdge, v : Double) -> MlclustergmmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmEdge::min(self : MlclustergmmEdge) -> Double { @_common.min(self.data) }

pub fn MlclustergmmEdge::max(self : MlclustergmmEdge) -> Double { @_common.max(self.data) }

pub fn MlclustergmmEdge::to_string(self : MlclustergmmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_path_make(size : Int) -> MlclustergmmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmPath::len(self : MlclustergmmPath) -> Int { self.size }

pub fn MlclustergmmPath::get(self : MlclustergmmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmPath::set(self : MlclustergmmPath, i : Int, v : Double) -> MlclustergmmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmPath::sum(self : MlclustergmmPath) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmPath::mean(self : MlclustergmmPath) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmPath::scale(self : MlclustergmmPath, f : Double) -> MlclustergmmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmPath::add(self : MlclustergmmPath, other : MlclustergmmPath) -> MlclustergmmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmPath::copy(self : MlclustergmmPath) -> MlclustergmmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmPath::fill(self : MlclustergmmPath, v : Double) -> MlclustergmmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmPath::min(self : MlclustergmmPath) -> Double { @_common.min(self.data) }

pub fn MlclustergmmPath::max(self : MlclustergmmPath) -> Double { @_common.max(self.data) }

pub fn MlclustergmmPath::to_string(self : MlclustergmmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_cluster_make(size : Int) -> MlclustergmmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmCluster::len(self : MlclustergmmCluster) -> Int { self.size }

pub fn MlclustergmmCluster::get(self : MlclustergmmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmCluster::set(self : MlclustergmmCluster, i : Int, v : Double) -> MlclustergmmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmCluster::sum(self : MlclustergmmCluster) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmCluster::mean(self : MlclustergmmCluster) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmCluster::scale(self : MlclustergmmCluster, f : Double) -> MlclustergmmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmCluster::add(self : MlclustergmmCluster, other : MlclustergmmCluster) -> MlclustergmmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmCluster::copy(self : MlclustergmmCluster) -> MlclustergmmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmCluster::fill(self : MlclustergmmCluster, v : Double) -> MlclustergmmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmCluster::min(self : MlclustergmmCluster) -> Double { @_common.min(self.data) }

pub fn MlclustergmmCluster::max(self : MlclustergmmCluster) -> Double { @_common.max(self.data) }

pub fn MlclustergmmCluster::to_string(self : MlclustergmmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_model_make(size : Int) -> MlclustergmmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmModel::len(self : MlclustergmmModel) -> Int { self.size }

pub fn MlclustergmmModel::get(self : MlclustergmmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmModel::set(self : MlclustergmmModel, i : Int, v : Double) -> MlclustergmmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmModel::sum(self : MlclustergmmModel) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmModel::mean(self : MlclustergmmModel) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmModel::scale(self : MlclustergmmModel, f : Double) -> MlclustergmmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmModel::add(self : MlclustergmmModel, other : MlclustergmmModel) -> MlclustergmmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmModel::copy(self : MlclustergmmModel) -> MlclustergmmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmModel::fill(self : MlclustergmmModel, v : Double) -> MlclustergmmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmModel::min(self : MlclustergmmModel) -> Double { @_common.min(self.data) }

pub fn MlclustergmmModel::max(self : MlclustergmmModel) -> Double { @_common.max(self.data) }

pub fn MlclustergmmModel::to_string(self : MlclustergmmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_layer_make(size : Int) -> MlclustergmmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmLayer::len(self : MlclustergmmLayer) -> Int { self.size }

pub fn MlclustergmmLayer::get(self : MlclustergmmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmLayer::set(self : MlclustergmmLayer, i : Int, v : Double) -> MlclustergmmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmLayer::sum(self : MlclustergmmLayer) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmLayer::mean(self : MlclustergmmLayer) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmLayer::scale(self : MlclustergmmLayer, f : Double) -> MlclustergmmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmLayer::add(self : MlclustergmmLayer, other : MlclustergmmLayer) -> MlclustergmmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmLayer::copy(self : MlclustergmmLayer) -> MlclustergmmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmLayer::fill(self : MlclustergmmLayer, v : Double) -> MlclustergmmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmLayer::min(self : MlclustergmmLayer) -> Double { @_common.min(self.data) }

pub fn MlclustergmmLayer::max(self : MlclustergmmLayer) -> Double { @_common.max(self.data) }

pub fn MlclustergmmLayer::to_string(self : MlclustergmmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_buffer_make(size : Int) -> MlclustergmmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmBuffer::len(self : MlclustergmmBuffer) -> Int { self.size }

pub fn MlclustergmmBuffer::get(self : MlclustergmmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmBuffer::set(self : MlclustergmmBuffer, i : Int, v : Double) -> MlclustergmmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmBuffer::sum(self : MlclustergmmBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmBuffer::mean(self : MlclustergmmBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmBuffer::scale(self : MlclustergmmBuffer, f : Double) -> MlclustergmmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmBuffer::add(self : MlclustergmmBuffer, other : MlclustergmmBuffer) -> MlclustergmmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmBuffer::copy(self : MlclustergmmBuffer) -> MlclustergmmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmBuffer::fill(self : MlclustergmmBuffer, v : Double) -> MlclustergmmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmBuffer::min(self : MlclustergmmBuffer) -> Double { @_common.min(self.data) }

pub fn MlclustergmmBuffer::max(self : MlclustergmmBuffer) -> Double { @_common.max(self.data) }

pub fn MlclustergmmBuffer::to_string(self : MlclustergmmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_cursor_make(size : Int) -> MlclustergmmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmCursor::len(self : MlclustergmmCursor) -> Int { self.size }

pub fn MlclustergmmCursor::get(self : MlclustergmmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmCursor::set(self : MlclustergmmCursor, i : Int, v : Double) -> MlclustergmmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmCursor::sum(self : MlclustergmmCursor) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmCursor::mean(self : MlclustergmmCursor) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmCursor::scale(self : MlclustergmmCursor, f : Double) -> MlclustergmmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmCursor::add(self : MlclustergmmCursor, other : MlclustergmmCursor) -> MlclustergmmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmCursor::copy(self : MlclustergmmCursor) -> MlclustergmmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmCursor::fill(self : MlclustergmmCursor, v : Double) -> MlclustergmmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmCursor::min(self : MlclustergmmCursor) -> Double { @_common.min(self.data) }

pub fn MlclustergmmCursor::max(self : MlclustergmmCursor) -> Double { @_common.max(self.data) }

pub fn MlclustergmmCursor::to_string(self : MlclustergmmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_view_make(size : Int) -> MlclustergmmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmView::len(self : MlclustergmmView) -> Int { self.size }

pub fn MlclustergmmView::get(self : MlclustergmmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmView::set(self : MlclustergmmView, i : Int, v : Double) -> MlclustergmmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmView::sum(self : MlclustergmmView) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmView::mean(self : MlclustergmmView) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmView::scale(self : MlclustergmmView, f : Double) -> MlclustergmmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmView::add(self : MlclustergmmView, other : MlclustergmmView) -> MlclustergmmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmView::copy(self : MlclustergmmView) -> MlclustergmmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmView::fill(self : MlclustergmmView, v : Double) -> MlclustergmmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmView::min(self : MlclustergmmView) -> Double { @_common.min(self.data) }

pub fn MlclustergmmView::max(self : MlclustergmmView) -> Double { @_common.max(self.data) }

pub fn MlclustergmmView::to_string(self : MlclustergmmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_range_make(size : Int) -> MlclustergmmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmRange::len(self : MlclustergmmRange) -> Int { self.size }

pub fn MlclustergmmRange::get(self : MlclustergmmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmRange::set(self : MlclustergmmRange, i : Int, v : Double) -> MlclustergmmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmRange::sum(self : MlclustergmmRange) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmRange::mean(self : MlclustergmmRange) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmRange::scale(self : MlclustergmmRange, f : Double) -> MlclustergmmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmRange::add(self : MlclustergmmRange, other : MlclustergmmRange) -> MlclustergmmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmRange::copy(self : MlclustergmmRange) -> MlclustergmmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmRange::fill(self : MlclustergmmRange, v : Double) -> MlclustergmmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmRange::min(self : MlclustergmmRange) -> Double { @_common.min(self.data) }

pub fn MlclustergmmRange::max(self : MlclustergmmRange) -> Double { @_common.max(self.data) }

pub fn MlclustergmmRange::to_string(self : MlclustergmmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclustergmmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_slice_make(size : Int) -> MlclustergmmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclustergmmSlice::len(self : MlclustergmmSlice) -> Int { self.size }

pub fn MlclustergmmSlice::get(self : MlclustergmmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclustergmmSlice::set(self : MlclustergmmSlice, i : Int, v : Double) -> MlclustergmmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclustergmmSlice::sum(self : MlclustergmmSlice) -> Double { @_common.sum(self.data) }

pub fn MlclustergmmSlice::mean(self : MlclustergmmSlice) -> Double { @_common.mean(self.data) }

pub fn MlclustergmmSlice::scale(self : MlclustergmmSlice, f : Double) -> MlclustergmmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclustergmmSlice::add(self : MlclustergmmSlice, other : MlclustergmmSlice) -> MlclustergmmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclustergmmSlice::copy(self : MlclustergmmSlice) -> MlclustergmmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclustergmmSlice::fill(self : MlclustergmmSlice, v : Double) -> MlclustergmmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclustergmmSlice::min(self : MlclustergmmSlice) -> Double { @_common.min(self.data) }

pub fn MlclustergmmSlice::max(self : MlclustergmmSlice) -> Double { @_common.max(self.data) }

pub fn MlclustergmmSlice::to_string(self : MlclustergmmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

