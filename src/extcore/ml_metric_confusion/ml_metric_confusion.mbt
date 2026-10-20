///===
/// extcore/ml_metric_confusion

pub(all) struct MlmetricconfusionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_confusion_make_point(x : Double, y : Double) -> MlmetricconfusionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_confusion_make_point3(x : Double, y : Double, z : Double) -> MlmetricconfusionPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricconfusionPoint::x(self : MlmetricconfusionPoint) -> Double { self.x }

pub fn MlmetricconfusionPoint::y(self : MlmetricconfusionPoint) -> Double { self.y }

pub fn MlmetricconfusionPoint::z(self : MlmetricconfusionPoint) -> Double { self.z }

pub fn MlmetricconfusionPoint::label(self : MlmetricconfusionPoint) -> Int { self.label }

pub fn MlmetricconfusionPoint::dist(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricconfusionPoint::add(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricconfusionPoint::sub(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricconfusionPoint::scale(self : MlmetricconfusionPoint, s : Double) -> MlmetricconfusionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricconfusionPoint::dot(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricconfusionPoint::cross(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricconfusionPoint::norm(self : MlmetricconfusionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricconfusionPoint::normalize(self : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricconfusionPoint::negate(self : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricconfusionPoint::mid(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricconfusionPoint::lerp(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint, t : Double) -> MlmetricconfusionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricconfusionPoint::to_string(self : MlmetricconfusionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricconfusionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_confusion_make_series(vals : Array[Double], name : String) -> MlmetricconfusionSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricconfusionSeries::len(self : MlmetricconfusionSeries) -> Int { self.vals.length() }

pub fn MlmetricconfusionSeries::sum(self : MlmetricconfusionSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricconfusionSeries::mean(self : MlmetricconfusionSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricconfusionSeries::min(self : MlmetricconfusionSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricconfusionSeries::max(self : MlmetricconfusionSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricconfusionSeries::range(self : MlmetricconfusionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricconfusionSeries::variance(self : MlmetricconfusionSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricconfusionSeries::std(self : MlmetricconfusionSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricconfusionSeries::median(self : MlmetricconfusionSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricconfusionSeries::scale(self : MlmetricconfusionSeries, f : Double) -> MlmetricconfusionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricconfusionSeries::add(self : MlmetricconfusionSeries, other : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricconfusionSeries::sub(self : MlmetricconfusionSeries, other : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricconfusionSeries::normalize(self : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricconfusionSeries::cumsum(self : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricconfusionSeries::to_string(self : MlmetricconfusionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricconfusionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_confusion_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricconfusionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_confusion_matrix_identity(n : Int) -> MlmetricconfusionMatrix {
  let m = ml_metric_confusion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricconfusionMatrix::get(self : MlmetricconfusionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricconfusionMatrix::transpose(self : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  let result = ml_metric_confusion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricconfusionMatrix::add(self : MlmetricconfusionMatrix, other : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_confusion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricconfusionMatrix::scale(self : MlmetricconfusionMatrix, s : Double) -> MlmetricconfusionMatrix {
  let result = ml_metric_confusion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricconfusionMatrix::multiply(self : MlmetricconfusionMatrix, other : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  if self.cols != other.rows { return ml_metric_confusion_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_confusion_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricconfusionMatrix::trace(self : MlmetricconfusionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricconfusionMatrix::det(self : MlmetricconfusionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricconfusionMatrix::norm(self : MlmetricconfusionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricconfusionMatrix::to_string(self : MlmetricconfusionMatrix) -> String {
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

pub(all) struct MlmetricconfusionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_confusion_make_vector(comps : Array[Double]) -> MlmetricconfusionVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_confusion_vector_zero(dim : Int) -> MlmetricconfusionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricconfusionVector::add(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricconfusionVector::sub(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricconfusionVector::scale(self : MlmetricconfusionVector, s : Double) -> MlmetricconfusionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricconfusionVector::dot(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricconfusionVector::norm(self : MlmetricconfusionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricconfusionVector::normalize(self : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricconfusionVector::dist(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricconfusionVector::to_string(self : MlmetricconfusionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricconfusionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_frame_make(size : Int) -> MlmetricconfusionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionFrame::len(self : MlmetricconfusionFrame) -> Int { self.size }

pub fn MlmetricconfusionFrame::get(self : MlmetricconfusionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionFrame::set(self : MlmetricconfusionFrame, i : Int, v : Double) -> MlmetricconfusionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionFrame::sum(self : MlmetricconfusionFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionFrame::mean(self : MlmetricconfusionFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionFrame::scale(self : MlmetricconfusionFrame, f : Double) -> MlmetricconfusionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionFrame::add(self : MlmetricconfusionFrame, other : MlmetricconfusionFrame) -> MlmetricconfusionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionFrame::copy(self : MlmetricconfusionFrame) -> MlmetricconfusionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionFrame::fill(self : MlmetricconfusionFrame, v : Double) -> MlmetricconfusionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionFrame::min(self : MlmetricconfusionFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionFrame::max(self : MlmetricconfusionFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionFrame::to_string(self : MlmetricconfusionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_table_make(size : Int) -> MlmetricconfusionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionTable::len(self : MlmetricconfusionTable) -> Int { self.size }

pub fn MlmetricconfusionTable::get(self : MlmetricconfusionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionTable::set(self : MlmetricconfusionTable, i : Int, v : Double) -> MlmetricconfusionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionTable::sum(self : MlmetricconfusionTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionTable::mean(self : MlmetricconfusionTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionTable::scale(self : MlmetricconfusionTable, f : Double) -> MlmetricconfusionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionTable::add(self : MlmetricconfusionTable, other : MlmetricconfusionTable) -> MlmetricconfusionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionTable::copy(self : MlmetricconfusionTable) -> MlmetricconfusionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionTable::fill(self : MlmetricconfusionTable, v : Double) -> MlmetricconfusionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionTable::min(self : MlmetricconfusionTable) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionTable::max(self : MlmetricconfusionTable) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionTable::to_string(self : MlmetricconfusionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_graphn_make(size : Int) -> MlmetricconfusionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionGraphN::len(self : MlmetricconfusionGraphN) -> Int { self.size }

pub fn MlmetricconfusionGraphN::get(self : MlmetricconfusionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionGraphN::set(self : MlmetricconfusionGraphN, i : Int, v : Double) -> MlmetricconfusionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionGraphN::sum(self : MlmetricconfusionGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionGraphN::mean(self : MlmetricconfusionGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionGraphN::scale(self : MlmetricconfusionGraphN, f : Double) -> MlmetricconfusionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionGraphN::add(self : MlmetricconfusionGraphN, other : MlmetricconfusionGraphN) -> MlmetricconfusionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionGraphN::copy(self : MlmetricconfusionGraphN) -> MlmetricconfusionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionGraphN::fill(self : MlmetricconfusionGraphN, v : Double) -> MlmetricconfusionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionGraphN::min(self : MlmetricconfusionGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionGraphN::max(self : MlmetricconfusionGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionGraphN::to_string(self : MlmetricconfusionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_node_make(size : Int) -> MlmetricconfusionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionNode::len(self : MlmetricconfusionNode) -> Int { self.size }

pub fn MlmetricconfusionNode::get(self : MlmetricconfusionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionNode::set(self : MlmetricconfusionNode, i : Int, v : Double) -> MlmetricconfusionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionNode::sum(self : MlmetricconfusionNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionNode::mean(self : MlmetricconfusionNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionNode::scale(self : MlmetricconfusionNode, f : Double) -> MlmetricconfusionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionNode::add(self : MlmetricconfusionNode, other : MlmetricconfusionNode) -> MlmetricconfusionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionNode::copy(self : MlmetricconfusionNode) -> MlmetricconfusionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionNode::fill(self : MlmetricconfusionNode, v : Double) -> MlmetricconfusionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionNode::min(self : MlmetricconfusionNode) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionNode::max(self : MlmetricconfusionNode) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionNode::to_string(self : MlmetricconfusionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_edge_make(size : Int) -> MlmetricconfusionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionEdge::len(self : MlmetricconfusionEdge) -> Int { self.size }

pub fn MlmetricconfusionEdge::get(self : MlmetricconfusionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionEdge::set(self : MlmetricconfusionEdge, i : Int, v : Double) -> MlmetricconfusionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionEdge::sum(self : MlmetricconfusionEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionEdge::mean(self : MlmetricconfusionEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionEdge::scale(self : MlmetricconfusionEdge, f : Double) -> MlmetricconfusionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionEdge::add(self : MlmetricconfusionEdge, other : MlmetricconfusionEdge) -> MlmetricconfusionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionEdge::copy(self : MlmetricconfusionEdge) -> MlmetricconfusionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionEdge::fill(self : MlmetricconfusionEdge, v : Double) -> MlmetricconfusionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionEdge::min(self : MlmetricconfusionEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionEdge::max(self : MlmetricconfusionEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionEdge::to_string(self : MlmetricconfusionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_path_make(size : Int) -> MlmetricconfusionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionPath::len(self : MlmetricconfusionPath) -> Int { self.size }

pub fn MlmetricconfusionPath::get(self : MlmetricconfusionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionPath::set(self : MlmetricconfusionPath, i : Int, v : Double) -> MlmetricconfusionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionPath::sum(self : MlmetricconfusionPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionPath::mean(self : MlmetricconfusionPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionPath::scale(self : MlmetricconfusionPath, f : Double) -> MlmetricconfusionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionPath::add(self : MlmetricconfusionPath, other : MlmetricconfusionPath) -> MlmetricconfusionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionPath::copy(self : MlmetricconfusionPath) -> MlmetricconfusionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionPath::fill(self : MlmetricconfusionPath, v : Double) -> MlmetricconfusionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionPath::min(self : MlmetricconfusionPath) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionPath::max(self : MlmetricconfusionPath) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionPath::to_string(self : MlmetricconfusionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_cluster_make(size : Int) -> MlmetricconfusionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionCluster::len(self : MlmetricconfusionCluster) -> Int { self.size }

pub fn MlmetricconfusionCluster::get(self : MlmetricconfusionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionCluster::set(self : MlmetricconfusionCluster, i : Int, v : Double) -> MlmetricconfusionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCluster::sum(self : MlmetricconfusionCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionCluster::mean(self : MlmetricconfusionCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionCluster::scale(self : MlmetricconfusionCluster, f : Double) -> MlmetricconfusionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCluster::add(self : MlmetricconfusionCluster, other : MlmetricconfusionCluster) -> MlmetricconfusionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionCluster::copy(self : MlmetricconfusionCluster) -> MlmetricconfusionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCluster::fill(self : MlmetricconfusionCluster, v : Double) -> MlmetricconfusionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCluster::min(self : MlmetricconfusionCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionCluster::max(self : MlmetricconfusionCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionCluster::to_string(self : MlmetricconfusionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_model_make(size : Int) -> MlmetricconfusionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionModel::len(self : MlmetricconfusionModel) -> Int { self.size }

pub fn MlmetricconfusionModel::get(self : MlmetricconfusionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionModel::set(self : MlmetricconfusionModel, i : Int, v : Double) -> MlmetricconfusionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionModel::sum(self : MlmetricconfusionModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionModel::mean(self : MlmetricconfusionModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionModel::scale(self : MlmetricconfusionModel, f : Double) -> MlmetricconfusionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionModel::add(self : MlmetricconfusionModel, other : MlmetricconfusionModel) -> MlmetricconfusionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionModel::copy(self : MlmetricconfusionModel) -> MlmetricconfusionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionModel::fill(self : MlmetricconfusionModel, v : Double) -> MlmetricconfusionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionModel::min(self : MlmetricconfusionModel) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionModel::max(self : MlmetricconfusionModel) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionModel::to_string(self : MlmetricconfusionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_layer_make(size : Int) -> MlmetricconfusionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionLayer::len(self : MlmetricconfusionLayer) -> Int { self.size }

pub fn MlmetricconfusionLayer::get(self : MlmetricconfusionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionLayer::set(self : MlmetricconfusionLayer, i : Int, v : Double) -> MlmetricconfusionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionLayer::sum(self : MlmetricconfusionLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionLayer::mean(self : MlmetricconfusionLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionLayer::scale(self : MlmetricconfusionLayer, f : Double) -> MlmetricconfusionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionLayer::add(self : MlmetricconfusionLayer, other : MlmetricconfusionLayer) -> MlmetricconfusionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionLayer::copy(self : MlmetricconfusionLayer) -> MlmetricconfusionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionLayer::fill(self : MlmetricconfusionLayer, v : Double) -> MlmetricconfusionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionLayer::min(self : MlmetricconfusionLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionLayer::max(self : MlmetricconfusionLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionLayer::to_string(self : MlmetricconfusionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_buffer_make(size : Int) -> MlmetricconfusionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionBuffer::len(self : MlmetricconfusionBuffer) -> Int { self.size }

pub fn MlmetricconfusionBuffer::get(self : MlmetricconfusionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionBuffer::set(self : MlmetricconfusionBuffer, i : Int, v : Double) -> MlmetricconfusionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionBuffer::sum(self : MlmetricconfusionBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionBuffer::mean(self : MlmetricconfusionBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionBuffer::scale(self : MlmetricconfusionBuffer, f : Double) -> MlmetricconfusionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionBuffer::add(self : MlmetricconfusionBuffer, other : MlmetricconfusionBuffer) -> MlmetricconfusionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionBuffer::copy(self : MlmetricconfusionBuffer) -> MlmetricconfusionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionBuffer::fill(self : MlmetricconfusionBuffer, v : Double) -> MlmetricconfusionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionBuffer::min(self : MlmetricconfusionBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionBuffer::max(self : MlmetricconfusionBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionBuffer::to_string(self : MlmetricconfusionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_cursor_make(size : Int) -> MlmetricconfusionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionCursor::len(self : MlmetricconfusionCursor) -> Int { self.size }

pub fn MlmetricconfusionCursor::get(self : MlmetricconfusionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionCursor::set(self : MlmetricconfusionCursor, i : Int, v : Double) -> MlmetricconfusionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCursor::sum(self : MlmetricconfusionCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionCursor::mean(self : MlmetricconfusionCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionCursor::scale(self : MlmetricconfusionCursor, f : Double) -> MlmetricconfusionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCursor::add(self : MlmetricconfusionCursor, other : MlmetricconfusionCursor) -> MlmetricconfusionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionCursor::copy(self : MlmetricconfusionCursor) -> MlmetricconfusionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCursor::fill(self : MlmetricconfusionCursor, v : Double) -> MlmetricconfusionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionCursor::min(self : MlmetricconfusionCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionCursor::max(self : MlmetricconfusionCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionCursor::to_string(self : MlmetricconfusionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_view_make(size : Int) -> MlmetricconfusionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionView::len(self : MlmetricconfusionView) -> Int { self.size }

pub fn MlmetricconfusionView::get(self : MlmetricconfusionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionView::set(self : MlmetricconfusionView, i : Int, v : Double) -> MlmetricconfusionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionView::sum(self : MlmetricconfusionView) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionView::mean(self : MlmetricconfusionView) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionView::scale(self : MlmetricconfusionView, f : Double) -> MlmetricconfusionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionView::add(self : MlmetricconfusionView, other : MlmetricconfusionView) -> MlmetricconfusionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionView::copy(self : MlmetricconfusionView) -> MlmetricconfusionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionView::fill(self : MlmetricconfusionView, v : Double) -> MlmetricconfusionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionView::min(self : MlmetricconfusionView) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionView::max(self : MlmetricconfusionView) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionView::to_string(self : MlmetricconfusionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_range_make(size : Int) -> MlmetricconfusionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionRange::len(self : MlmetricconfusionRange) -> Int { self.size }

pub fn MlmetricconfusionRange::get(self : MlmetricconfusionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionRange::set(self : MlmetricconfusionRange, i : Int, v : Double) -> MlmetricconfusionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionRange::sum(self : MlmetricconfusionRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionRange::mean(self : MlmetricconfusionRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionRange::scale(self : MlmetricconfusionRange, f : Double) -> MlmetricconfusionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionRange::add(self : MlmetricconfusionRange, other : MlmetricconfusionRange) -> MlmetricconfusionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionRange::copy(self : MlmetricconfusionRange) -> MlmetricconfusionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionRange::fill(self : MlmetricconfusionRange, v : Double) -> MlmetricconfusionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionRange::min(self : MlmetricconfusionRange) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionRange::max(self : MlmetricconfusionRange) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionRange::to_string(self : MlmetricconfusionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_slice_make(size : Int) -> MlmetricconfusionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricconfusionSlice::len(self : MlmetricconfusionSlice) -> Int { self.size }

pub fn MlmetricconfusionSlice::get(self : MlmetricconfusionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricconfusionSlice::set(self : MlmetricconfusionSlice, i : Int, v : Double) -> MlmetricconfusionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionSlice::sum(self : MlmetricconfusionSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricconfusionSlice::mean(self : MlmetricconfusionSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricconfusionSlice::scale(self : MlmetricconfusionSlice, f : Double) -> MlmetricconfusionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionSlice::add(self : MlmetricconfusionSlice, other : MlmetricconfusionSlice) -> MlmetricconfusionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricconfusionSlice::copy(self : MlmetricconfusionSlice) -> MlmetricconfusionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionSlice::fill(self : MlmetricconfusionSlice, v : Double) -> MlmetricconfusionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricconfusionSlice::min(self : MlmetricconfusionSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricconfusionSlice::max(self : MlmetricconfusionSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricconfusionSlice::to_string(self : MlmetricconfusionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

