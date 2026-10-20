///===
/// extcore/ml_metric_regress

pub(all) struct MlmetricregressPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_regress_make_point(x : Double, y : Double) -> MlmetricregressPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_regress_make_point3(x : Double, y : Double, z : Double) -> MlmetricregressPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricregressPoint::x(self : MlmetricregressPoint) -> Double { self.x }

pub fn MlmetricregressPoint::y(self : MlmetricregressPoint) -> Double { self.y }

pub fn MlmetricregressPoint::z(self : MlmetricregressPoint) -> Double { self.z }

pub fn MlmetricregressPoint::label(self : MlmetricregressPoint) -> Int { self.label }

pub fn MlmetricregressPoint::dist(self : MlmetricregressPoint, other : MlmetricregressPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricregressPoint::add(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricregressPoint::sub(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricregressPoint::scale(self : MlmetricregressPoint, s : Double) -> MlmetricregressPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricregressPoint::dot(self : MlmetricregressPoint, other : MlmetricregressPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricregressPoint::cross(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricregressPoint::norm(self : MlmetricregressPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricregressPoint::normalize(self : MlmetricregressPoint) -> MlmetricregressPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricregressPoint::negate(self : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricregressPoint::mid(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricregressPoint::lerp(self : MlmetricregressPoint, other : MlmetricregressPoint, t : Double) -> MlmetricregressPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricregressPoint::to_string(self : MlmetricregressPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricregressSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_regress_make_series(vals : Array[Double], name : String) -> MlmetricregressSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricregressSeries::len(self : MlmetricregressSeries) -> Int { self.vals.length() }

pub fn MlmetricregressSeries::sum(self : MlmetricregressSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricregressSeries::mean(self : MlmetricregressSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricregressSeries::min(self : MlmetricregressSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricregressSeries::max(self : MlmetricregressSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricregressSeries::range(self : MlmetricregressSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricregressSeries::variance(self : MlmetricregressSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricregressSeries::std(self : MlmetricregressSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricregressSeries::median(self : MlmetricregressSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricregressSeries::scale(self : MlmetricregressSeries, f : Double) -> MlmetricregressSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricregressSeries::add(self : MlmetricregressSeries, other : MlmetricregressSeries) -> MlmetricregressSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricregressSeries::sub(self : MlmetricregressSeries, other : MlmetricregressSeries) -> MlmetricregressSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricregressSeries::normalize(self : MlmetricregressSeries) -> MlmetricregressSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricregressSeries::cumsum(self : MlmetricregressSeries) -> MlmetricregressSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricregressSeries::to_string(self : MlmetricregressSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricregressMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_regress_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricregressMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_regress_matrix_identity(n : Int) -> MlmetricregressMatrix {
  let m = ml_metric_regress_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricregressMatrix::get(self : MlmetricregressMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricregressMatrix::transpose(self : MlmetricregressMatrix) -> MlmetricregressMatrix {
  let result = ml_metric_regress_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricregressMatrix::add(self : MlmetricregressMatrix, other : MlmetricregressMatrix) -> MlmetricregressMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_regress_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricregressMatrix::scale(self : MlmetricregressMatrix, s : Double) -> MlmetricregressMatrix {
  let result = ml_metric_regress_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricregressMatrix::multiply(self : MlmetricregressMatrix, other : MlmetricregressMatrix) -> MlmetricregressMatrix {
  if self.cols != other.rows { return ml_metric_regress_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_regress_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlmetricregressMatrix::trace(self : MlmetricregressMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricregressMatrix::det(self : MlmetricregressMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricregressMatrix::norm(self : MlmetricregressMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricregressMatrix::to_string(self : MlmetricregressMatrix) -> String {
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

pub(all) struct MlmetricregressVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_regress_make_vector(comps : Array[Double]) -> MlmetricregressVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_regress_vector_zero(dim : Int) -> MlmetricregressVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricregressVector::add(self : MlmetricregressVector, other : MlmetricregressVector) -> MlmetricregressVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricregressVector::sub(self : MlmetricregressVector, other : MlmetricregressVector) -> MlmetricregressVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricregressVector::scale(self : MlmetricregressVector, s : Double) -> MlmetricregressVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricregressVector::dot(self : MlmetricregressVector, other : MlmetricregressVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricregressVector::norm(self : MlmetricregressVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricregressVector::normalize(self : MlmetricregressVector) -> MlmetricregressVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricregressVector::dist(self : MlmetricregressVector, other : MlmetricregressVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricregressVector::to_string(self : MlmetricregressVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricregressFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_frame_make(size : Int) -> MlmetricregressFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressFrame::len(self : MlmetricregressFrame) -> Int { self.size }

pub fn MlmetricregressFrame::get(self : MlmetricregressFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressFrame::set(self : MlmetricregressFrame, i : Int, v : Double) -> MlmetricregressFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressFrame::sum(self : MlmetricregressFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressFrame::mean(self : MlmetricregressFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressFrame::scale(self : MlmetricregressFrame, f : Double) -> MlmetricregressFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressFrame::add(self : MlmetricregressFrame, other : MlmetricregressFrame) -> MlmetricregressFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressFrame::copy(self : MlmetricregressFrame) -> MlmetricregressFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressFrame::fill(self : MlmetricregressFrame, v : Double) -> MlmetricregressFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressFrame::min(self : MlmetricregressFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricregressFrame::max(self : MlmetricregressFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricregressFrame::to_string(self : MlmetricregressFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_table_make(size : Int) -> MlmetricregressTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressTable::len(self : MlmetricregressTable) -> Int { self.size }

pub fn MlmetricregressTable::get(self : MlmetricregressTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressTable::set(self : MlmetricregressTable, i : Int, v : Double) -> MlmetricregressTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressTable::sum(self : MlmetricregressTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressTable::mean(self : MlmetricregressTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressTable::scale(self : MlmetricregressTable, f : Double) -> MlmetricregressTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressTable::add(self : MlmetricregressTable, other : MlmetricregressTable) -> MlmetricregressTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressTable::copy(self : MlmetricregressTable) -> MlmetricregressTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressTable::fill(self : MlmetricregressTable, v : Double) -> MlmetricregressTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressTable::min(self : MlmetricregressTable) -> Double { @_common.min(self.data) }

pub fn MlmetricregressTable::max(self : MlmetricregressTable) -> Double { @_common.max(self.data) }

pub fn MlmetricregressTable::to_string(self : MlmetricregressTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_graphn_make(size : Int) -> MlmetricregressGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressGraphN::len(self : MlmetricregressGraphN) -> Int { self.size }

pub fn MlmetricregressGraphN::get(self : MlmetricregressGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressGraphN::set(self : MlmetricregressGraphN, i : Int, v : Double) -> MlmetricregressGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressGraphN::sum(self : MlmetricregressGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressGraphN::mean(self : MlmetricregressGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressGraphN::scale(self : MlmetricregressGraphN, f : Double) -> MlmetricregressGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressGraphN::add(self : MlmetricregressGraphN, other : MlmetricregressGraphN) -> MlmetricregressGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressGraphN::copy(self : MlmetricregressGraphN) -> MlmetricregressGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressGraphN::fill(self : MlmetricregressGraphN, v : Double) -> MlmetricregressGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressGraphN::min(self : MlmetricregressGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricregressGraphN::max(self : MlmetricregressGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricregressGraphN::to_string(self : MlmetricregressGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_node_make(size : Int) -> MlmetricregressNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressNode::len(self : MlmetricregressNode) -> Int { self.size }

pub fn MlmetricregressNode::get(self : MlmetricregressNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressNode::set(self : MlmetricregressNode, i : Int, v : Double) -> MlmetricregressNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressNode::sum(self : MlmetricregressNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressNode::mean(self : MlmetricregressNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressNode::scale(self : MlmetricregressNode, f : Double) -> MlmetricregressNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressNode::add(self : MlmetricregressNode, other : MlmetricregressNode) -> MlmetricregressNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressNode::copy(self : MlmetricregressNode) -> MlmetricregressNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressNode::fill(self : MlmetricregressNode, v : Double) -> MlmetricregressNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressNode::min(self : MlmetricregressNode) -> Double { @_common.min(self.data) }

pub fn MlmetricregressNode::max(self : MlmetricregressNode) -> Double { @_common.max(self.data) }

pub fn MlmetricregressNode::to_string(self : MlmetricregressNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_edge_make(size : Int) -> MlmetricregressEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressEdge::len(self : MlmetricregressEdge) -> Int { self.size }

pub fn MlmetricregressEdge::get(self : MlmetricregressEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressEdge::set(self : MlmetricregressEdge, i : Int, v : Double) -> MlmetricregressEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressEdge::sum(self : MlmetricregressEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressEdge::mean(self : MlmetricregressEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressEdge::scale(self : MlmetricregressEdge, f : Double) -> MlmetricregressEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressEdge::add(self : MlmetricregressEdge, other : MlmetricregressEdge) -> MlmetricregressEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressEdge::copy(self : MlmetricregressEdge) -> MlmetricregressEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressEdge::fill(self : MlmetricregressEdge, v : Double) -> MlmetricregressEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressEdge::min(self : MlmetricregressEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricregressEdge::max(self : MlmetricregressEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricregressEdge::to_string(self : MlmetricregressEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_path_make(size : Int) -> MlmetricregressPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressPath::len(self : MlmetricregressPath) -> Int { self.size }

pub fn MlmetricregressPath::get(self : MlmetricregressPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressPath::set(self : MlmetricregressPath, i : Int, v : Double) -> MlmetricregressPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressPath::sum(self : MlmetricregressPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressPath::mean(self : MlmetricregressPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressPath::scale(self : MlmetricregressPath, f : Double) -> MlmetricregressPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressPath::add(self : MlmetricregressPath, other : MlmetricregressPath) -> MlmetricregressPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressPath::copy(self : MlmetricregressPath) -> MlmetricregressPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressPath::fill(self : MlmetricregressPath, v : Double) -> MlmetricregressPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressPath::min(self : MlmetricregressPath) -> Double { @_common.min(self.data) }

pub fn MlmetricregressPath::max(self : MlmetricregressPath) -> Double { @_common.max(self.data) }

pub fn MlmetricregressPath::to_string(self : MlmetricregressPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_cluster_make(size : Int) -> MlmetricregressCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressCluster::len(self : MlmetricregressCluster) -> Int { self.size }

pub fn MlmetricregressCluster::get(self : MlmetricregressCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressCluster::set(self : MlmetricregressCluster, i : Int, v : Double) -> MlmetricregressCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressCluster::sum(self : MlmetricregressCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressCluster::mean(self : MlmetricregressCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressCluster::scale(self : MlmetricregressCluster, f : Double) -> MlmetricregressCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressCluster::add(self : MlmetricregressCluster, other : MlmetricregressCluster) -> MlmetricregressCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressCluster::copy(self : MlmetricregressCluster) -> MlmetricregressCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressCluster::fill(self : MlmetricregressCluster, v : Double) -> MlmetricregressCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressCluster::min(self : MlmetricregressCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricregressCluster::max(self : MlmetricregressCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricregressCluster::to_string(self : MlmetricregressCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_model_make(size : Int) -> MlmetricregressModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressModel::len(self : MlmetricregressModel) -> Int { self.size }

pub fn MlmetricregressModel::get(self : MlmetricregressModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressModel::set(self : MlmetricregressModel, i : Int, v : Double) -> MlmetricregressModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressModel::sum(self : MlmetricregressModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressModel::mean(self : MlmetricregressModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressModel::scale(self : MlmetricregressModel, f : Double) -> MlmetricregressModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressModel::add(self : MlmetricregressModel, other : MlmetricregressModel) -> MlmetricregressModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressModel::copy(self : MlmetricregressModel) -> MlmetricregressModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressModel::fill(self : MlmetricregressModel, v : Double) -> MlmetricregressModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressModel::min(self : MlmetricregressModel) -> Double { @_common.min(self.data) }

pub fn MlmetricregressModel::max(self : MlmetricregressModel) -> Double { @_common.max(self.data) }

pub fn MlmetricregressModel::to_string(self : MlmetricregressModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_layer_make(size : Int) -> MlmetricregressLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressLayer::len(self : MlmetricregressLayer) -> Int { self.size }

pub fn MlmetricregressLayer::get(self : MlmetricregressLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressLayer::set(self : MlmetricregressLayer, i : Int, v : Double) -> MlmetricregressLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressLayer::sum(self : MlmetricregressLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressLayer::mean(self : MlmetricregressLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressLayer::scale(self : MlmetricregressLayer, f : Double) -> MlmetricregressLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressLayer::add(self : MlmetricregressLayer, other : MlmetricregressLayer) -> MlmetricregressLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressLayer::copy(self : MlmetricregressLayer) -> MlmetricregressLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressLayer::fill(self : MlmetricregressLayer, v : Double) -> MlmetricregressLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressLayer::min(self : MlmetricregressLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricregressLayer::max(self : MlmetricregressLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricregressLayer::to_string(self : MlmetricregressLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_buffer_make(size : Int) -> MlmetricregressBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressBuffer::len(self : MlmetricregressBuffer) -> Int { self.size }

pub fn MlmetricregressBuffer::get(self : MlmetricregressBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressBuffer::set(self : MlmetricregressBuffer, i : Int, v : Double) -> MlmetricregressBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressBuffer::sum(self : MlmetricregressBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressBuffer::mean(self : MlmetricregressBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressBuffer::scale(self : MlmetricregressBuffer, f : Double) -> MlmetricregressBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressBuffer::add(self : MlmetricregressBuffer, other : MlmetricregressBuffer) -> MlmetricregressBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressBuffer::copy(self : MlmetricregressBuffer) -> MlmetricregressBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressBuffer::fill(self : MlmetricregressBuffer, v : Double) -> MlmetricregressBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressBuffer::min(self : MlmetricregressBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricregressBuffer::max(self : MlmetricregressBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricregressBuffer::to_string(self : MlmetricregressBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_cursor_make(size : Int) -> MlmetricregressCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressCursor::len(self : MlmetricregressCursor) -> Int { self.size }

pub fn MlmetricregressCursor::get(self : MlmetricregressCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressCursor::set(self : MlmetricregressCursor, i : Int, v : Double) -> MlmetricregressCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressCursor::sum(self : MlmetricregressCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressCursor::mean(self : MlmetricregressCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressCursor::scale(self : MlmetricregressCursor, f : Double) -> MlmetricregressCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressCursor::add(self : MlmetricregressCursor, other : MlmetricregressCursor) -> MlmetricregressCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressCursor::copy(self : MlmetricregressCursor) -> MlmetricregressCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressCursor::fill(self : MlmetricregressCursor, v : Double) -> MlmetricregressCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressCursor::min(self : MlmetricregressCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricregressCursor::max(self : MlmetricregressCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricregressCursor::to_string(self : MlmetricregressCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_view_make(size : Int) -> MlmetricregressView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressView::len(self : MlmetricregressView) -> Int { self.size }

pub fn MlmetricregressView::get(self : MlmetricregressView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressView::set(self : MlmetricregressView, i : Int, v : Double) -> MlmetricregressView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressView::sum(self : MlmetricregressView) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressView::mean(self : MlmetricregressView) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressView::scale(self : MlmetricregressView, f : Double) -> MlmetricregressView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressView::add(self : MlmetricregressView, other : MlmetricregressView) -> MlmetricregressView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressView::copy(self : MlmetricregressView) -> MlmetricregressView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressView::fill(self : MlmetricregressView, v : Double) -> MlmetricregressView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressView::min(self : MlmetricregressView) -> Double { @_common.min(self.data) }

pub fn MlmetricregressView::max(self : MlmetricregressView) -> Double { @_common.max(self.data) }

pub fn MlmetricregressView::to_string(self : MlmetricregressView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_range_make(size : Int) -> MlmetricregressRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressRange::len(self : MlmetricregressRange) -> Int { self.size }

pub fn MlmetricregressRange::get(self : MlmetricregressRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressRange::set(self : MlmetricregressRange, i : Int, v : Double) -> MlmetricregressRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressRange::sum(self : MlmetricregressRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressRange::mean(self : MlmetricregressRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressRange::scale(self : MlmetricregressRange, f : Double) -> MlmetricregressRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressRange::add(self : MlmetricregressRange, other : MlmetricregressRange) -> MlmetricregressRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressRange::copy(self : MlmetricregressRange) -> MlmetricregressRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressRange::fill(self : MlmetricregressRange, v : Double) -> MlmetricregressRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressRange::min(self : MlmetricregressRange) -> Double { @_common.min(self.data) }

pub fn MlmetricregressRange::max(self : MlmetricregressRange) -> Double { @_common.max(self.data) }

pub fn MlmetricregressRange::to_string(self : MlmetricregressRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricregressSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_slice_make(size : Int) -> MlmetricregressSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricregressSlice::len(self : MlmetricregressSlice) -> Int { self.size }

pub fn MlmetricregressSlice::get(self : MlmetricregressSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricregressSlice::set(self : MlmetricregressSlice, i : Int, v : Double) -> MlmetricregressSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricregressSlice::sum(self : MlmetricregressSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricregressSlice::mean(self : MlmetricregressSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricregressSlice::scale(self : MlmetricregressSlice, f : Double) -> MlmetricregressSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricregressSlice::add(self : MlmetricregressSlice, other : MlmetricregressSlice) -> MlmetricregressSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricregressSlice::copy(self : MlmetricregressSlice) -> MlmetricregressSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricregressSlice::fill(self : MlmetricregressSlice, v : Double) -> MlmetricregressSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricregressSlice::min(self : MlmetricregressSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricregressSlice::max(self : MlmetricregressSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricregressSlice::to_string(self : MlmetricregressSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

