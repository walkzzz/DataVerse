///===
/// extcore/ml_metric_pr

pub(all) struct MlmetricprPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_pr_make_point(x : Double, y : Double) -> MlmetricprPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_pr_make_point3(x : Double, y : Double, z : Double) -> MlmetricprPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricprPoint::x(self : MlmetricprPoint) -> Double { self.x }

pub fn MlmetricprPoint::y(self : MlmetricprPoint) -> Double { self.y }

pub fn MlmetricprPoint::z(self : MlmetricprPoint) -> Double { self.z }

pub fn MlmetricprPoint::label(self : MlmetricprPoint) -> Int { self.label }

pub fn MlmetricprPoint::dist(self : MlmetricprPoint, other : MlmetricprPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricprPoint::add(self : MlmetricprPoint, other : MlmetricprPoint) -> MlmetricprPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricprPoint::sub(self : MlmetricprPoint, other : MlmetricprPoint) -> MlmetricprPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricprPoint::scale(self : MlmetricprPoint, s : Double) -> MlmetricprPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricprPoint::dot(self : MlmetricprPoint, other : MlmetricprPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricprPoint::cross(self : MlmetricprPoint, other : MlmetricprPoint) -> MlmetricprPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricprPoint::norm(self : MlmetricprPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricprPoint::normalize(self : MlmetricprPoint) -> MlmetricprPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricprPoint::negate(self : MlmetricprPoint) -> MlmetricprPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricprPoint::mid(self : MlmetricprPoint, other : MlmetricprPoint) -> MlmetricprPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricprPoint::lerp(self : MlmetricprPoint, other : MlmetricprPoint, t : Double) -> MlmetricprPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricprPoint::to_string(self : MlmetricprPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricprSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_pr_make_series(vals : Array[Double], name : String) -> MlmetricprSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricprSeries::len(self : MlmetricprSeries) -> Int { self.vals.length() }

pub fn MlmetricprSeries::sum(self : MlmetricprSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricprSeries::mean(self : MlmetricprSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricprSeries::min(self : MlmetricprSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricprSeries::max(self : MlmetricprSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricprSeries::range(self : MlmetricprSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricprSeries::variance(self : MlmetricprSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricprSeries::std(self : MlmetricprSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricprSeries::median(self : MlmetricprSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricprSeries::scale(self : MlmetricprSeries, f : Double) -> MlmetricprSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricprSeries::add(self : MlmetricprSeries, other : MlmetricprSeries) -> MlmetricprSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricprSeries::sub(self : MlmetricprSeries, other : MlmetricprSeries) -> MlmetricprSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricprSeries::normalize(self : MlmetricprSeries) -> MlmetricprSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricprSeries::cumsum(self : MlmetricprSeries) -> MlmetricprSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricprSeries::to_string(self : MlmetricprSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricprMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_pr_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricprMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_pr_matrix_identity(n : Int) -> MlmetricprMatrix {
  let m = ml_metric_pr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricprMatrix::get(self : MlmetricprMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricprMatrix::transpose(self : MlmetricprMatrix) -> MlmetricprMatrix {
  let result = ml_metric_pr_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricprMatrix::add(self : MlmetricprMatrix, other : MlmetricprMatrix) -> MlmetricprMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_pr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricprMatrix::scale(self : MlmetricprMatrix, s : Double) -> MlmetricprMatrix {
  let result = ml_metric_pr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricprMatrix::multiply(self : MlmetricprMatrix, other : MlmetricprMatrix) -> MlmetricprMatrix {
  if self.cols != other.rows { return ml_metric_pr_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_pr_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlmetricprMatrix::trace(self : MlmetricprMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricprMatrix::det(self : MlmetricprMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricprMatrix::norm(self : MlmetricprMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricprMatrix::to_string(self : MlmetricprMatrix) -> String {
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

pub(all) struct MlmetricprVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_pr_make_vector(comps : Array[Double]) -> MlmetricprVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_pr_vector_zero(dim : Int) -> MlmetricprVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricprVector::add(self : MlmetricprVector, other : MlmetricprVector) -> MlmetricprVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricprVector::sub(self : MlmetricprVector, other : MlmetricprVector) -> MlmetricprVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricprVector::scale(self : MlmetricprVector, s : Double) -> MlmetricprVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricprVector::dot(self : MlmetricprVector, other : MlmetricprVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricprVector::norm(self : MlmetricprVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricprVector::normalize(self : MlmetricprVector) -> MlmetricprVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricprVector::dist(self : MlmetricprVector, other : MlmetricprVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricprVector::to_string(self : MlmetricprVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricprFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_frame_make(size : Int) -> MlmetricprFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprFrame::len(self : MlmetricprFrame) -> Int { self.size }

pub fn MlmetricprFrame::get(self : MlmetricprFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprFrame::set(self : MlmetricprFrame, i : Int, v : Double) -> MlmetricprFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprFrame::sum(self : MlmetricprFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricprFrame::mean(self : MlmetricprFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricprFrame::scale(self : MlmetricprFrame, f : Double) -> MlmetricprFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprFrame::add(self : MlmetricprFrame, other : MlmetricprFrame) -> MlmetricprFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprFrame::copy(self : MlmetricprFrame) -> MlmetricprFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprFrame::fill(self : MlmetricprFrame, v : Double) -> MlmetricprFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprFrame::min(self : MlmetricprFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricprFrame::max(self : MlmetricprFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricprFrame::to_string(self : MlmetricprFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_table_make(size : Int) -> MlmetricprTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprTable::len(self : MlmetricprTable) -> Int { self.size }

pub fn MlmetricprTable::get(self : MlmetricprTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprTable::set(self : MlmetricprTable, i : Int, v : Double) -> MlmetricprTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprTable::sum(self : MlmetricprTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricprTable::mean(self : MlmetricprTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricprTable::scale(self : MlmetricprTable, f : Double) -> MlmetricprTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprTable::add(self : MlmetricprTable, other : MlmetricprTable) -> MlmetricprTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprTable::copy(self : MlmetricprTable) -> MlmetricprTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprTable::fill(self : MlmetricprTable, v : Double) -> MlmetricprTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprTable::min(self : MlmetricprTable) -> Double { @_common.min(self.data) }

pub fn MlmetricprTable::max(self : MlmetricprTable) -> Double { @_common.max(self.data) }

pub fn MlmetricprTable::to_string(self : MlmetricprTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_graphn_make(size : Int) -> MlmetricprGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprGraphN::len(self : MlmetricprGraphN) -> Int { self.size }

pub fn MlmetricprGraphN::get(self : MlmetricprGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprGraphN::set(self : MlmetricprGraphN, i : Int, v : Double) -> MlmetricprGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprGraphN::sum(self : MlmetricprGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricprGraphN::mean(self : MlmetricprGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricprGraphN::scale(self : MlmetricprGraphN, f : Double) -> MlmetricprGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprGraphN::add(self : MlmetricprGraphN, other : MlmetricprGraphN) -> MlmetricprGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprGraphN::copy(self : MlmetricprGraphN) -> MlmetricprGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprGraphN::fill(self : MlmetricprGraphN, v : Double) -> MlmetricprGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprGraphN::min(self : MlmetricprGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricprGraphN::max(self : MlmetricprGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricprGraphN::to_string(self : MlmetricprGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_node_make(size : Int) -> MlmetricprNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprNode::len(self : MlmetricprNode) -> Int { self.size }

pub fn MlmetricprNode::get(self : MlmetricprNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprNode::set(self : MlmetricprNode, i : Int, v : Double) -> MlmetricprNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprNode::sum(self : MlmetricprNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricprNode::mean(self : MlmetricprNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricprNode::scale(self : MlmetricprNode, f : Double) -> MlmetricprNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprNode::add(self : MlmetricprNode, other : MlmetricprNode) -> MlmetricprNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprNode::copy(self : MlmetricprNode) -> MlmetricprNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprNode::fill(self : MlmetricprNode, v : Double) -> MlmetricprNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprNode::min(self : MlmetricprNode) -> Double { @_common.min(self.data) }

pub fn MlmetricprNode::max(self : MlmetricprNode) -> Double { @_common.max(self.data) }

pub fn MlmetricprNode::to_string(self : MlmetricprNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_edge_make(size : Int) -> MlmetricprEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprEdge::len(self : MlmetricprEdge) -> Int { self.size }

pub fn MlmetricprEdge::get(self : MlmetricprEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprEdge::set(self : MlmetricprEdge, i : Int, v : Double) -> MlmetricprEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprEdge::sum(self : MlmetricprEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricprEdge::mean(self : MlmetricprEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricprEdge::scale(self : MlmetricprEdge, f : Double) -> MlmetricprEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprEdge::add(self : MlmetricprEdge, other : MlmetricprEdge) -> MlmetricprEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprEdge::copy(self : MlmetricprEdge) -> MlmetricprEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprEdge::fill(self : MlmetricprEdge, v : Double) -> MlmetricprEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprEdge::min(self : MlmetricprEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricprEdge::max(self : MlmetricprEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricprEdge::to_string(self : MlmetricprEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_path_make(size : Int) -> MlmetricprPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprPath::len(self : MlmetricprPath) -> Int { self.size }

pub fn MlmetricprPath::get(self : MlmetricprPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprPath::set(self : MlmetricprPath, i : Int, v : Double) -> MlmetricprPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprPath::sum(self : MlmetricprPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricprPath::mean(self : MlmetricprPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricprPath::scale(self : MlmetricprPath, f : Double) -> MlmetricprPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprPath::add(self : MlmetricprPath, other : MlmetricprPath) -> MlmetricprPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprPath::copy(self : MlmetricprPath) -> MlmetricprPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprPath::fill(self : MlmetricprPath, v : Double) -> MlmetricprPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprPath::min(self : MlmetricprPath) -> Double { @_common.min(self.data) }

pub fn MlmetricprPath::max(self : MlmetricprPath) -> Double { @_common.max(self.data) }

pub fn MlmetricprPath::to_string(self : MlmetricprPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_cluster_make(size : Int) -> MlmetricprCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprCluster::len(self : MlmetricprCluster) -> Int { self.size }

pub fn MlmetricprCluster::get(self : MlmetricprCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprCluster::set(self : MlmetricprCluster, i : Int, v : Double) -> MlmetricprCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprCluster::sum(self : MlmetricprCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricprCluster::mean(self : MlmetricprCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricprCluster::scale(self : MlmetricprCluster, f : Double) -> MlmetricprCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprCluster::add(self : MlmetricprCluster, other : MlmetricprCluster) -> MlmetricprCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprCluster::copy(self : MlmetricprCluster) -> MlmetricprCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprCluster::fill(self : MlmetricprCluster, v : Double) -> MlmetricprCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprCluster::min(self : MlmetricprCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricprCluster::max(self : MlmetricprCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricprCluster::to_string(self : MlmetricprCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_model_make(size : Int) -> MlmetricprModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprModel::len(self : MlmetricprModel) -> Int { self.size }

pub fn MlmetricprModel::get(self : MlmetricprModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprModel::set(self : MlmetricprModel, i : Int, v : Double) -> MlmetricprModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprModel::sum(self : MlmetricprModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricprModel::mean(self : MlmetricprModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricprModel::scale(self : MlmetricprModel, f : Double) -> MlmetricprModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprModel::add(self : MlmetricprModel, other : MlmetricprModel) -> MlmetricprModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprModel::copy(self : MlmetricprModel) -> MlmetricprModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprModel::fill(self : MlmetricprModel, v : Double) -> MlmetricprModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprModel::min(self : MlmetricprModel) -> Double { @_common.min(self.data) }

pub fn MlmetricprModel::max(self : MlmetricprModel) -> Double { @_common.max(self.data) }

pub fn MlmetricprModel::to_string(self : MlmetricprModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_layer_make(size : Int) -> MlmetricprLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprLayer::len(self : MlmetricprLayer) -> Int { self.size }

pub fn MlmetricprLayer::get(self : MlmetricprLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprLayer::set(self : MlmetricprLayer, i : Int, v : Double) -> MlmetricprLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprLayer::sum(self : MlmetricprLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricprLayer::mean(self : MlmetricprLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricprLayer::scale(self : MlmetricprLayer, f : Double) -> MlmetricprLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprLayer::add(self : MlmetricprLayer, other : MlmetricprLayer) -> MlmetricprLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprLayer::copy(self : MlmetricprLayer) -> MlmetricprLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprLayer::fill(self : MlmetricprLayer, v : Double) -> MlmetricprLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprLayer::min(self : MlmetricprLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricprLayer::max(self : MlmetricprLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricprLayer::to_string(self : MlmetricprLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_buffer_make(size : Int) -> MlmetricprBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprBuffer::len(self : MlmetricprBuffer) -> Int { self.size }

pub fn MlmetricprBuffer::get(self : MlmetricprBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprBuffer::set(self : MlmetricprBuffer, i : Int, v : Double) -> MlmetricprBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprBuffer::sum(self : MlmetricprBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricprBuffer::mean(self : MlmetricprBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricprBuffer::scale(self : MlmetricprBuffer, f : Double) -> MlmetricprBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprBuffer::add(self : MlmetricprBuffer, other : MlmetricprBuffer) -> MlmetricprBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprBuffer::copy(self : MlmetricprBuffer) -> MlmetricprBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprBuffer::fill(self : MlmetricprBuffer, v : Double) -> MlmetricprBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprBuffer::min(self : MlmetricprBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricprBuffer::max(self : MlmetricprBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricprBuffer::to_string(self : MlmetricprBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_cursor_make(size : Int) -> MlmetricprCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprCursor::len(self : MlmetricprCursor) -> Int { self.size }

pub fn MlmetricprCursor::get(self : MlmetricprCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprCursor::set(self : MlmetricprCursor, i : Int, v : Double) -> MlmetricprCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprCursor::sum(self : MlmetricprCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricprCursor::mean(self : MlmetricprCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricprCursor::scale(self : MlmetricprCursor, f : Double) -> MlmetricprCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprCursor::add(self : MlmetricprCursor, other : MlmetricprCursor) -> MlmetricprCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprCursor::copy(self : MlmetricprCursor) -> MlmetricprCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprCursor::fill(self : MlmetricprCursor, v : Double) -> MlmetricprCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprCursor::min(self : MlmetricprCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricprCursor::max(self : MlmetricprCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricprCursor::to_string(self : MlmetricprCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_view_make(size : Int) -> MlmetricprView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprView::len(self : MlmetricprView) -> Int { self.size }

pub fn MlmetricprView::get(self : MlmetricprView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprView::set(self : MlmetricprView, i : Int, v : Double) -> MlmetricprView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprView::sum(self : MlmetricprView) -> Double { @_common.sum(self.data) }

pub fn MlmetricprView::mean(self : MlmetricprView) -> Double { @_common.mean(self.data) }

pub fn MlmetricprView::scale(self : MlmetricprView, f : Double) -> MlmetricprView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprView::add(self : MlmetricprView, other : MlmetricprView) -> MlmetricprView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprView::copy(self : MlmetricprView) -> MlmetricprView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprView::fill(self : MlmetricprView, v : Double) -> MlmetricprView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprView::min(self : MlmetricprView) -> Double { @_common.min(self.data) }

pub fn MlmetricprView::max(self : MlmetricprView) -> Double { @_common.max(self.data) }

pub fn MlmetricprView::to_string(self : MlmetricprView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_range_make(size : Int) -> MlmetricprRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprRange::len(self : MlmetricprRange) -> Int { self.size }

pub fn MlmetricprRange::get(self : MlmetricprRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprRange::set(self : MlmetricprRange, i : Int, v : Double) -> MlmetricprRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprRange::sum(self : MlmetricprRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricprRange::mean(self : MlmetricprRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricprRange::scale(self : MlmetricprRange, f : Double) -> MlmetricprRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprRange::add(self : MlmetricprRange, other : MlmetricprRange) -> MlmetricprRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprRange::copy(self : MlmetricprRange) -> MlmetricprRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprRange::fill(self : MlmetricprRange, v : Double) -> MlmetricprRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprRange::min(self : MlmetricprRange) -> Double { @_common.min(self.data) }

pub fn MlmetricprRange::max(self : MlmetricprRange) -> Double { @_common.max(self.data) }

pub fn MlmetricprRange::to_string(self : MlmetricprRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricprSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_slice_make(size : Int) -> MlmetricprSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricprSlice::len(self : MlmetricprSlice) -> Int { self.size }

pub fn MlmetricprSlice::get(self : MlmetricprSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricprSlice::set(self : MlmetricprSlice, i : Int, v : Double) -> MlmetricprSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricprSlice::sum(self : MlmetricprSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricprSlice::mean(self : MlmetricprSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricprSlice::scale(self : MlmetricprSlice, f : Double) -> MlmetricprSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricprSlice::add(self : MlmetricprSlice, other : MlmetricprSlice) -> MlmetricprSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricprSlice::copy(self : MlmetricprSlice) -> MlmetricprSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricprSlice::fill(self : MlmetricprSlice, v : Double) -> MlmetricprSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricprSlice::min(self : MlmetricprSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricprSlice::max(self : MlmetricprSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricprSlice::to_string(self : MlmetricprSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

