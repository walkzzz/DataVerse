///===
/// extcore/ml_metric_clustering

pub(all) struct MlmetricclusteringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_clustering_make_point(x : Double, y : Double) -> MlmetricclusteringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_clustering_make_point3(x : Double, y : Double, z : Double) -> MlmetricclusteringPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricclusteringPoint::x(self : MlmetricclusteringPoint) -> Double { self.x }

pub fn MlmetricclusteringPoint::y(self : MlmetricclusteringPoint) -> Double { self.y }

pub fn MlmetricclusteringPoint::z(self : MlmetricclusteringPoint) -> Double { self.z }

pub fn MlmetricclusteringPoint::label(self : MlmetricclusteringPoint) -> Int { self.label }

pub fn MlmetricclusteringPoint::dist(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricclusteringPoint::add(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricclusteringPoint::sub(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricclusteringPoint::scale(self : MlmetricclusteringPoint, s : Double) -> MlmetricclusteringPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricclusteringPoint::dot(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricclusteringPoint::cross(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricclusteringPoint::norm(self : MlmetricclusteringPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricclusteringPoint::normalize(self : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricclusteringPoint::negate(self : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricclusteringPoint::mid(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricclusteringPoint::lerp(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint, t : Double) -> MlmetricclusteringPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricclusteringPoint::to_string(self : MlmetricclusteringPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricclusteringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_clustering_make_series(vals : Array[Double], name : String) -> MlmetricclusteringSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricclusteringSeries::len(self : MlmetricclusteringSeries) -> Int { self.vals.length() }

pub fn MlmetricclusteringSeries::sum(self : MlmetricclusteringSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricclusteringSeries::mean(self : MlmetricclusteringSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricclusteringSeries::min(self : MlmetricclusteringSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricclusteringSeries::max(self : MlmetricclusteringSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricclusteringSeries::range(self : MlmetricclusteringSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricclusteringSeries::variance(self : MlmetricclusteringSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricclusteringSeries::std(self : MlmetricclusteringSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricclusteringSeries::median(self : MlmetricclusteringSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricclusteringSeries::scale(self : MlmetricclusteringSeries, f : Double) -> MlmetricclusteringSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricclusteringSeries::add(self : MlmetricclusteringSeries, other : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricclusteringSeries::sub(self : MlmetricclusteringSeries, other : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricclusteringSeries::normalize(self : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricclusteringSeries::cumsum(self : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricclusteringSeries::to_string(self : MlmetricclusteringSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricclusteringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_clustering_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricclusteringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_clustering_matrix_identity(n : Int) -> MlmetricclusteringMatrix {
  let m = ml_metric_clustering_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricclusteringMatrix::get(self : MlmetricclusteringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricclusteringMatrix::transpose(self : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  let result = ml_metric_clustering_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricclusteringMatrix::add(self : MlmetricclusteringMatrix, other : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_clustering_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricclusteringMatrix::scale(self : MlmetricclusteringMatrix, s : Double) -> MlmetricclusteringMatrix {
  let result = ml_metric_clustering_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricclusteringMatrix::multiply(self : MlmetricclusteringMatrix, other : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  if self.cols != other.rows { return ml_metric_clustering_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_clustering_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricclusteringMatrix::trace(self : MlmetricclusteringMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricclusteringMatrix::det(self : MlmetricclusteringMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricclusteringMatrix::norm(self : MlmetricclusteringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricclusteringMatrix::to_string(self : MlmetricclusteringMatrix) -> String {
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

pub(all) struct MlmetricclusteringVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_clustering_make_vector(comps : Array[Double]) -> MlmetricclusteringVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_clustering_vector_zero(dim : Int) -> MlmetricclusteringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricclusteringVector::add(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricclusteringVector::sub(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricclusteringVector::scale(self : MlmetricclusteringVector, s : Double) -> MlmetricclusteringVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricclusteringVector::dot(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricclusteringVector::norm(self : MlmetricclusteringVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricclusteringVector::normalize(self : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricclusteringVector::dist(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricclusteringVector::to_string(self : MlmetricclusteringVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricclusteringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_frame_make(size : Int) -> MlmetricclusteringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringFrame::len(self : MlmetricclusteringFrame) -> Int { self.size }

pub fn MlmetricclusteringFrame::get(self : MlmetricclusteringFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringFrame::set(self : MlmetricclusteringFrame, i : Int, v : Double) -> MlmetricclusteringFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringFrame::sum(self : MlmetricclusteringFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringFrame::mean(self : MlmetricclusteringFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringFrame::scale(self : MlmetricclusteringFrame, f : Double) -> MlmetricclusteringFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringFrame::add(self : MlmetricclusteringFrame, other : MlmetricclusteringFrame) -> MlmetricclusteringFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringFrame::copy(self : MlmetricclusteringFrame) -> MlmetricclusteringFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringFrame::fill(self : MlmetricclusteringFrame, v : Double) -> MlmetricclusteringFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringFrame::min(self : MlmetricclusteringFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringFrame::max(self : MlmetricclusteringFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringFrame::to_string(self : MlmetricclusteringFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_table_make(size : Int) -> MlmetricclusteringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringTable::len(self : MlmetricclusteringTable) -> Int { self.size }

pub fn MlmetricclusteringTable::get(self : MlmetricclusteringTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringTable::set(self : MlmetricclusteringTable, i : Int, v : Double) -> MlmetricclusteringTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringTable::sum(self : MlmetricclusteringTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringTable::mean(self : MlmetricclusteringTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringTable::scale(self : MlmetricclusteringTable, f : Double) -> MlmetricclusteringTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringTable::add(self : MlmetricclusteringTable, other : MlmetricclusteringTable) -> MlmetricclusteringTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringTable::copy(self : MlmetricclusteringTable) -> MlmetricclusteringTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringTable::fill(self : MlmetricclusteringTable, v : Double) -> MlmetricclusteringTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringTable::min(self : MlmetricclusteringTable) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringTable::max(self : MlmetricclusteringTable) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringTable::to_string(self : MlmetricclusteringTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_graphn_make(size : Int) -> MlmetricclusteringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringGraphN::len(self : MlmetricclusteringGraphN) -> Int { self.size }

pub fn MlmetricclusteringGraphN::get(self : MlmetricclusteringGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringGraphN::set(self : MlmetricclusteringGraphN, i : Int, v : Double) -> MlmetricclusteringGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringGraphN::sum(self : MlmetricclusteringGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringGraphN::mean(self : MlmetricclusteringGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringGraphN::scale(self : MlmetricclusteringGraphN, f : Double) -> MlmetricclusteringGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringGraphN::add(self : MlmetricclusteringGraphN, other : MlmetricclusteringGraphN) -> MlmetricclusteringGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringGraphN::copy(self : MlmetricclusteringGraphN) -> MlmetricclusteringGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringGraphN::fill(self : MlmetricclusteringGraphN, v : Double) -> MlmetricclusteringGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringGraphN::min(self : MlmetricclusteringGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringGraphN::max(self : MlmetricclusteringGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringGraphN::to_string(self : MlmetricclusteringGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_node_make(size : Int) -> MlmetricclusteringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringNode::len(self : MlmetricclusteringNode) -> Int { self.size }

pub fn MlmetricclusteringNode::get(self : MlmetricclusteringNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringNode::set(self : MlmetricclusteringNode, i : Int, v : Double) -> MlmetricclusteringNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringNode::sum(self : MlmetricclusteringNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringNode::mean(self : MlmetricclusteringNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringNode::scale(self : MlmetricclusteringNode, f : Double) -> MlmetricclusteringNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringNode::add(self : MlmetricclusteringNode, other : MlmetricclusteringNode) -> MlmetricclusteringNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringNode::copy(self : MlmetricclusteringNode) -> MlmetricclusteringNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringNode::fill(self : MlmetricclusteringNode, v : Double) -> MlmetricclusteringNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringNode::min(self : MlmetricclusteringNode) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringNode::max(self : MlmetricclusteringNode) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringNode::to_string(self : MlmetricclusteringNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_edge_make(size : Int) -> MlmetricclusteringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringEdge::len(self : MlmetricclusteringEdge) -> Int { self.size }

pub fn MlmetricclusteringEdge::get(self : MlmetricclusteringEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringEdge::set(self : MlmetricclusteringEdge, i : Int, v : Double) -> MlmetricclusteringEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringEdge::sum(self : MlmetricclusteringEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringEdge::mean(self : MlmetricclusteringEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringEdge::scale(self : MlmetricclusteringEdge, f : Double) -> MlmetricclusteringEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringEdge::add(self : MlmetricclusteringEdge, other : MlmetricclusteringEdge) -> MlmetricclusteringEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringEdge::copy(self : MlmetricclusteringEdge) -> MlmetricclusteringEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringEdge::fill(self : MlmetricclusteringEdge, v : Double) -> MlmetricclusteringEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringEdge::min(self : MlmetricclusteringEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringEdge::max(self : MlmetricclusteringEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringEdge::to_string(self : MlmetricclusteringEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_path_make(size : Int) -> MlmetricclusteringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringPath::len(self : MlmetricclusteringPath) -> Int { self.size }

pub fn MlmetricclusteringPath::get(self : MlmetricclusteringPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringPath::set(self : MlmetricclusteringPath, i : Int, v : Double) -> MlmetricclusteringPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringPath::sum(self : MlmetricclusteringPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringPath::mean(self : MlmetricclusteringPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringPath::scale(self : MlmetricclusteringPath, f : Double) -> MlmetricclusteringPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringPath::add(self : MlmetricclusteringPath, other : MlmetricclusteringPath) -> MlmetricclusteringPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringPath::copy(self : MlmetricclusteringPath) -> MlmetricclusteringPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringPath::fill(self : MlmetricclusteringPath, v : Double) -> MlmetricclusteringPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringPath::min(self : MlmetricclusteringPath) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringPath::max(self : MlmetricclusteringPath) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringPath::to_string(self : MlmetricclusteringPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_cluster_make(size : Int) -> MlmetricclusteringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringCluster::len(self : MlmetricclusteringCluster) -> Int { self.size }

pub fn MlmetricclusteringCluster::get(self : MlmetricclusteringCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringCluster::set(self : MlmetricclusteringCluster, i : Int, v : Double) -> MlmetricclusteringCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCluster::sum(self : MlmetricclusteringCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringCluster::mean(self : MlmetricclusteringCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringCluster::scale(self : MlmetricclusteringCluster, f : Double) -> MlmetricclusteringCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCluster::add(self : MlmetricclusteringCluster, other : MlmetricclusteringCluster) -> MlmetricclusteringCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringCluster::copy(self : MlmetricclusteringCluster) -> MlmetricclusteringCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCluster::fill(self : MlmetricclusteringCluster, v : Double) -> MlmetricclusteringCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCluster::min(self : MlmetricclusteringCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringCluster::max(self : MlmetricclusteringCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringCluster::to_string(self : MlmetricclusteringCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_model_make(size : Int) -> MlmetricclusteringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringModel::len(self : MlmetricclusteringModel) -> Int { self.size }

pub fn MlmetricclusteringModel::get(self : MlmetricclusteringModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringModel::set(self : MlmetricclusteringModel, i : Int, v : Double) -> MlmetricclusteringModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringModel::sum(self : MlmetricclusteringModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringModel::mean(self : MlmetricclusteringModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringModel::scale(self : MlmetricclusteringModel, f : Double) -> MlmetricclusteringModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringModel::add(self : MlmetricclusteringModel, other : MlmetricclusteringModel) -> MlmetricclusteringModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringModel::copy(self : MlmetricclusteringModel) -> MlmetricclusteringModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringModel::fill(self : MlmetricclusteringModel, v : Double) -> MlmetricclusteringModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringModel::min(self : MlmetricclusteringModel) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringModel::max(self : MlmetricclusteringModel) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringModel::to_string(self : MlmetricclusteringModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_layer_make(size : Int) -> MlmetricclusteringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringLayer::len(self : MlmetricclusteringLayer) -> Int { self.size }

pub fn MlmetricclusteringLayer::get(self : MlmetricclusteringLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringLayer::set(self : MlmetricclusteringLayer, i : Int, v : Double) -> MlmetricclusteringLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringLayer::sum(self : MlmetricclusteringLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringLayer::mean(self : MlmetricclusteringLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringLayer::scale(self : MlmetricclusteringLayer, f : Double) -> MlmetricclusteringLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringLayer::add(self : MlmetricclusteringLayer, other : MlmetricclusteringLayer) -> MlmetricclusteringLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringLayer::copy(self : MlmetricclusteringLayer) -> MlmetricclusteringLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringLayer::fill(self : MlmetricclusteringLayer, v : Double) -> MlmetricclusteringLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringLayer::min(self : MlmetricclusteringLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringLayer::max(self : MlmetricclusteringLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringLayer::to_string(self : MlmetricclusteringLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_buffer_make(size : Int) -> MlmetricclusteringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringBuffer::len(self : MlmetricclusteringBuffer) -> Int { self.size }

pub fn MlmetricclusteringBuffer::get(self : MlmetricclusteringBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringBuffer::set(self : MlmetricclusteringBuffer, i : Int, v : Double) -> MlmetricclusteringBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringBuffer::sum(self : MlmetricclusteringBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringBuffer::mean(self : MlmetricclusteringBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringBuffer::scale(self : MlmetricclusteringBuffer, f : Double) -> MlmetricclusteringBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringBuffer::add(self : MlmetricclusteringBuffer, other : MlmetricclusteringBuffer) -> MlmetricclusteringBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringBuffer::copy(self : MlmetricclusteringBuffer) -> MlmetricclusteringBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringBuffer::fill(self : MlmetricclusteringBuffer, v : Double) -> MlmetricclusteringBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringBuffer::min(self : MlmetricclusteringBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringBuffer::max(self : MlmetricclusteringBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringBuffer::to_string(self : MlmetricclusteringBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_cursor_make(size : Int) -> MlmetricclusteringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringCursor::len(self : MlmetricclusteringCursor) -> Int { self.size }

pub fn MlmetricclusteringCursor::get(self : MlmetricclusteringCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringCursor::set(self : MlmetricclusteringCursor, i : Int, v : Double) -> MlmetricclusteringCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCursor::sum(self : MlmetricclusteringCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringCursor::mean(self : MlmetricclusteringCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringCursor::scale(self : MlmetricclusteringCursor, f : Double) -> MlmetricclusteringCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCursor::add(self : MlmetricclusteringCursor, other : MlmetricclusteringCursor) -> MlmetricclusteringCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringCursor::copy(self : MlmetricclusteringCursor) -> MlmetricclusteringCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCursor::fill(self : MlmetricclusteringCursor, v : Double) -> MlmetricclusteringCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringCursor::min(self : MlmetricclusteringCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringCursor::max(self : MlmetricclusteringCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringCursor::to_string(self : MlmetricclusteringCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_view_make(size : Int) -> MlmetricclusteringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringView::len(self : MlmetricclusteringView) -> Int { self.size }

pub fn MlmetricclusteringView::get(self : MlmetricclusteringView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringView::set(self : MlmetricclusteringView, i : Int, v : Double) -> MlmetricclusteringView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringView::sum(self : MlmetricclusteringView) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringView::mean(self : MlmetricclusteringView) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringView::scale(self : MlmetricclusteringView, f : Double) -> MlmetricclusteringView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringView::add(self : MlmetricclusteringView, other : MlmetricclusteringView) -> MlmetricclusteringView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringView::copy(self : MlmetricclusteringView) -> MlmetricclusteringView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringView::fill(self : MlmetricclusteringView, v : Double) -> MlmetricclusteringView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringView::min(self : MlmetricclusteringView) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringView::max(self : MlmetricclusteringView) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringView::to_string(self : MlmetricclusteringView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_range_make(size : Int) -> MlmetricclusteringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringRange::len(self : MlmetricclusteringRange) -> Int { self.size }

pub fn MlmetricclusteringRange::get(self : MlmetricclusteringRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringRange::set(self : MlmetricclusteringRange, i : Int, v : Double) -> MlmetricclusteringRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringRange::sum(self : MlmetricclusteringRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringRange::mean(self : MlmetricclusteringRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringRange::scale(self : MlmetricclusteringRange, f : Double) -> MlmetricclusteringRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringRange::add(self : MlmetricclusteringRange, other : MlmetricclusteringRange) -> MlmetricclusteringRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringRange::copy(self : MlmetricclusteringRange) -> MlmetricclusteringRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringRange::fill(self : MlmetricclusteringRange, v : Double) -> MlmetricclusteringRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringRange::min(self : MlmetricclusteringRange) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringRange::max(self : MlmetricclusteringRange) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringRange::to_string(self : MlmetricclusteringRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_slice_make(size : Int) -> MlmetricclusteringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricclusteringSlice::len(self : MlmetricclusteringSlice) -> Int { self.size }

pub fn MlmetricclusteringSlice::get(self : MlmetricclusteringSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricclusteringSlice::set(self : MlmetricclusteringSlice, i : Int, v : Double) -> MlmetricclusteringSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringSlice::sum(self : MlmetricclusteringSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricclusteringSlice::mean(self : MlmetricclusteringSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricclusteringSlice::scale(self : MlmetricclusteringSlice, f : Double) -> MlmetricclusteringSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringSlice::add(self : MlmetricclusteringSlice, other : MlmetricclusteringSlice) -> MlmetricclusteringSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricclusteringSlice::copy(self : MlmetricclusteringSlice) -> MlmetricclusteringSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringSlice::fill(self : MlmetricclusteringSlice, v : Double) -> MlmetricclusteringSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricclusteringSlice::min(self : MlmetricclusteringSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricclusteringSlice::max(self : MlmetricclusteringSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricclusteringSlice::to_string(self : MlmetricclusteringSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

