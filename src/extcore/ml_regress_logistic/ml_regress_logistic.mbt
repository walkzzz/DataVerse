///===
/// extcore/ml_regress_logistic

pub(all) struct MlregresslogisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_logistic_make_point(x : Double, y : Double) -> MlregresslogisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_logistic_make_point3(x : Double, y : Double, z : Double) -> MlregresslogisticPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresslogisticPoint::x(self : MlregresslogisticPoint) -> Double { self.x }

pub fn MlregresslogisticPoint::y(self : MlregresslogisticPoint) -> Double { self.y }

pub fn MlregresslogisticPoint::z(self : MlregresslogisticPoint) -> Double { self.z }

pub fn MlregresslogisticPoint::label(self : MlregresslogisticPoint) -> Int { self.label }

pub fn MlregresslogisticPoint::dist(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresslogisticPoint::add(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresslogisticPoint::sub(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresslogisticPoint::scale(self : MlregresslogisticPoint, s : Double) -> MlregresslogisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresslogisticPoint::dot(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresslogisticPoint::cross(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresslogisticPoint::norm(self : MlregresslogisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresslogisticPoint::normalize(self : MlregresslogisticPoint) -> MlregresslogisticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslogisticPoint::negate(self : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresslogisticPoint::mid(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresslogisticPoint::lerp(self : MlregresslogisticPoint, other : MlregresslogisticPoint, t : Double) -> MlregresslogisticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresslogisticPoint::to_string(self : MlregresslogisticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresslogisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_logistic_make_series(vals : Array[Double], name : String) -> MlregresslogisticSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresslogisticSeries::len(self : MlregresslogisticSeries) -> Int { self.vals.length() }

pub fn MlregresslogisticSeries::sum(self : MlregresslogisticSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresslogisticSeries::mean(self : MlregresslogisticSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresslogisticSeries::min(self : MlregresslogisticSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresslogisticSeries::max(self : MlregresslogisticSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresslogisticSeries::range(self : MlregresslogisticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresslogisticSeries::variance(self : MlregresslogisticSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresslogisticSeries::std(self : MlregresslogisticSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresslogisticSeries::median(self : MlregresslogisticSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresslogisticSeries::scale(self : MlregresslogisticSeries, f : Double) -> MlregresslogisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresslogisticSeries::add(self : MlregresslogisticSeries, other : MlregresslogisticSeries) -> MlregresslogisticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresslogisticSeries::sub(self : MlregresslogisticSeries, other : MlregresslogisticSeries) -> MlregresslogisticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresslogisticSeries::normalize(self : MlregresslogisticSeries) -> MlregresslogisticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresslogisticSeries::cumsum(self : MlregresslogisticSeries) -> MlregresslogisticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresslogisticSeries::to_string(self : MlregresslogisticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslogisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_logistic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslogisticMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_regress_logistic_matrix_identity(n : Int) -> MlregresslogisticMatrix {
  let m = ml_regress_logistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresslogisticMatrix::get(self : MlregresslogisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresslogisticMatrix::transpose(self : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  let result = ml_regress_logistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresslogisticMatrix::add(self : MlregresslogisticMatrix, other : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresslogisticMatrix::scale(self : MlregresslogisticMatrix, s : Double) -> MlregresslogisticMatrix {
  let result = ml_regress_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresslogisticMatrix::multiply(self : MlregresslogisticMatrix, other : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  if self.cols != other.rows { return ml_regress_logistic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_logistic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlregresslogisticMatrix::trace(self : MlregresslogisticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresslogisticMatrix::det(self : MlregresslogisticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresslogisticMatrix::norm(self : MlregresslogisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresslogisticMatrix::to_string(self : MlregresslogisticMatrix) -> String {
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

pub(all) struct MlregresslogisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_logistic_make_vector(comps : Array[Double]) -> MlregresslogisticVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_logistic_vector_zero(dim : Int) -> MlregresslogisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresslogisticVector::add(self : MlregresslogisticVector, other : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslogisticVector::sub(self : MlregresslogisticVector, other : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslogisticVector::scale(self : MlregresslogisticVector, s : Double) -> MlregresslogisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresslogisticVector::dot(self : MlregresslogisticVector, other : MlregresslogisticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresslogisticVector::norm(self : MlregresslogisticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresslogisticVector::normalize(self : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslogisticVector::dist(self : MlregresslogisticVector, other : MlregresslogisticVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresslogisticVector::to_string(self : MlregresslogisticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslogisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_frame_make(size : Int) -> MlregresslogisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticFrame::len(self : MlregresslogisticFrame) -> Int { self.size }

pub fn MlregresslogisticFrame::get(self : MlregresslogisticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticFrame::set(self : MlregresslogisticFrame, i : Int, v : Double) -> MlregresslogisticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticFrame::sum(self : MlregresslogisticFrame) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticFrame::mean(self : MlregresslogisticFrame) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticFrame::scale(self : MlregresslogisticFrame, f : Double) -> MlregresslogisticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticFrame::add(self : MlregresslogisticFrame, other : MlregresslogisticFrame) -> MlregresslogisticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticFrame::copy(self : MlregresslogisticFrame) -> MlregresslogisticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticFrame::fill(self : MlregresslogisticFrame, v : Double) -> MlregresslogisticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticFrame::min(self : MlregresslogisticFrame) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticFrame::max(self : MlregresslogisticFrame) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticFrame::to_string(self : MlregresslogisticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_table_make(size : Int) -> MlregresslogisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticTable::len(self : MlregresslogisticTable) -> Int { self.size }

pub fn MlregresslogisticTable::get(self : MlregresslogisticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticTable::set(self : MlregresslogisticTable, i : Int, v : Double) -> MlregresslogisticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticTable::sum(self : MlregresslogisticTable) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticTable::mean(self : MlregresslogisticTable) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticTable::scale(self : MlregresslogisticTable, f : Double) -> MlregresslogisticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticTable::add(self : MlregresslogisticTable, other : MlregresslogisticTable) -> MlregresslogisticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticTable::copy(self : MlregresslogisticTable) -> MlregresslogisticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticTable::fill(self : MlregresslogisticTable, v : Double) -> MlregresslogisticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticTable::min(self : MlregresslogisticTable) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticTable::max(self : MlregresslogisticTable) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticTable::to_string(self : MlregresslogisticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_graphn_make(size : Int) -> MlregresslogisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticGraphN::len(self : MlregresslogisticGraphN) -> Int { self.size }

pub fn MlregresslogisticGraphN::get(self : MlregresslogisticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticGraphN::set(self : MlregresslogisticGraphN, i : Int, v : Double) -> MlregresslogisticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticGraphN::sum(self : MlregresslogisticGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticGraphN::mean(self : MlregresslogisticGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticGraphN::scale(self : MlregresslogisticGraphN, f : Double) -> MlregresslogisticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticGraphN::add(self : MlregresslogisticGraphN, other : MlregresslogisticGraphN) -> MlregresslogisticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticGraphN::copy(self : MlregresslogisticGraphN) -> MlregresslogisticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticGraphN::fill(self : MlregresslogisticGraphN, v : Double) -> MlregresslogisticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticGraphN::min(self : MlregresslogisticGraphN) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticGraphN::max(self : MlregresslogisticGraphN) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticGraphN::to_string(self : MlregresslogisticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_node_make(size : Int) -> MlregresslogisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticNode::len(self : MlregresslogisticNode) -> Int { self.size }

pub fn MlregresslogisticNode::get(self : MlregresslogisticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticNode::set(self : MlregresslogisticNode, i : Int, v : Double) -> MlregresslogisticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticNode::sum(self : MlregresslogisticNode) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticNode::mean(self : MlregresslogisticNode) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticNode::scale(self : MlregresslogisticNode, f : Double) -> MlregresslogisticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticNode::add(self : MlregresslogisticNode, other : MlregresslogisticNode) -> MlregresslogisticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticNode::copy(self : MlregresslogisticNode) -> MlregresslogisticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticNode::fill(self : MlregresslogisticNode, v : Double) -> MlregresslogisticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticNode::min(self : MlregresslogisticNode) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticNode::max(self : MlregresslogisticNode) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticNode::to_string(self : MlregresslogisticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_edge_make(size : Int) -> MlregresslogisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticEdge::len(self : MlregresslogisticEdge) -> Int { self.size }

pub fn MlregresslogisticEdge::get(self : MlregresslogisticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticEdge::set(self : MlregresslogisticEdge, i : Int, v : Double) -> MlregresslogisticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticEdge::sum(self : MlregresslogisticEdge) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticEdge::mean(self : MlregresslogisticEdge) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticEdge::scale(self : MlregresslogisticEdge, f : Double) -> MlregresslogisticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticEdge::add(self : MlregresslogisticEdge, other : MlregresslogisticEdge) -> MlregresslogisticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticEdge::copy(self : MlregresslogisticEdge) -> MlregresslogisticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticEdge::fill(self : MlregresslogisticEdge, v : Double) -> MlregresslogisticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticEdge::min(self : MlregresslogisticEdge) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticEdge::max(self : MlregresslogisticEdge) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticEdge::to_string(self : MlregresslogisticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_path_make(size : Int) -> MlregresslogisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticPath::len(self : MlregresslogisticPath) -> Int { self.size }

pub fn MlregresslogisticPath::get(self : MlregresslogisticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticPath::set(self : MlregresslogisticPath, i : Int, v : Double) -> MlregresslogisticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticPath::sum(self : MlregresslogisticPath) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticPath::mean(self : MlregresslogisticPath) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticPath::scale(self : MlregresslogisticPath, f : Double) -> MlregresslogisticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticPath::add(self : MlregresslogisticPath, other : MlregresslogisticPath) -> MlregresslogisticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticPath::copy(self : MlregresslogisticPath) -> MlregresslogisticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticPath::fill(self : MlregresslogisticPath, v : Double) -> MlregresslogisticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticPath::min(self : MlregresslogisticPath) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticPath::max(self : MlregresslogisticPath) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticPath::to_string(self : MlregresslogisticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_cluster_make(size : Int) -> MlregresslogisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticCluster::len(self : MlregresslogisticCluster) -> Int { self.size }

pub fn MlregresslogisticCluster::get(self : MlregresslogisticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticCluster::set(self : MlregresslogisticCluster, i : Int, v : Double) -> MlregresslogisticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCluster::sum(self : MlregresslogisticCluster) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticCluster::mean(self : MlregresslogisticCluster) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticCluster::scale(self : MlregresslogisticCluster, f : Double) -> MlregresslogisticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCluster::add(self : MlregresslogisticCluster, other : MlregresslogisticCluster) -> MlregresslogisticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticCluster::copy(self : MlregresslogisticCluster) -> MlregresslogisticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCluster::fill(self : MlregresslogisticCluster, v : Double) -> MlregresslogisticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCluster::min(self : MlregresslogisticCluster) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticCluster::max(self : MlregresslogisticCluster) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticCluster::to_string(self : MlregresslogisticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_model_make(size : Int) -> MlregresslogisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticModel::len(self : MlregresslogisticModel) -> Int { self.size }

pub fn MlregresslogisticModel::get(self : MlregresslogisticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticModel::set(self : MlregresslogisticModel, i : Int, v : Double) -> MlregresslogisticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticModel::sum(self : MlregresslogisticModel) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticModel::mean(self : MlregresslogisticModel) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticModel::scale(self : MlregresslogisticModel, f : Double) -> MlregresslogisticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticModel::add(self : MlregresslogisticModel, other : MlregresslogisticModel) -> MlregresslogisticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticModel::copy(self : MlregresslogisticModel) -> MlregresslogisticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticModel::fill(self : MlregresslogisticModel, v : Double) -> MlregresslogisticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticModel::min(self : MlregresslogisticModel) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticModel::max(self : MlregresslogisticModel) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticModel::to_string(self : MlregresslogisticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_layer_make(size : Int) -> MlregresslogisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticLayer::len(self : MlregresslogisticLayer) -> Int { self.size }

pub fn MlregresslogisticLayer::get(self : MlregresslogisticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticLayer::set(self : MlregresslogisticLayer, i : Int, v : Double) -> MlregresslogisticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticLayer::sum(self : MlregresslogisticLayer) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticLayer::mean(self : MlregresslogisticLayer) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticLayer::scale(self : MlregresslogisticLayer, f : Double) -> MlregresslogisticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticLayer::add(self : MlregresslogisticLayer, other : MlregresslogisticLayer) -> MlregresslogisticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticLayer::copy(self : MlregresslogisticLayer) -> MlregresslogisticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticLayer::fill(self : MlregresslogisticLayer, v : Double) -> MlregresslogisticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticLayer::min(self : MlregresslogisticLayer) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticLayer::max(self : MlregresslogisticLayer) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticLayer::to_string(self : MlregresslogisticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_buffer_make(size : Int) -> MlregresslogisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticBuffer::len(self : MlregresslogisticBuffer) -> Int { self.size }

pub fn MlregresslogisticBuffer::get(self : MlregresslogisticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticBuffer::set(self : MlregresslogisticBuffer, i : Int, v : Double) -> MlregresslogisticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticBuffer::sum(self : MlregresslogisticBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticBuffer::mean(self : MlregresslogisticBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticBuffer::scale(self : MlregresslogisticBuffer, f : Double) -> MlregresslogisticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticBuffer::add(self : MlregresslogisticBuffer, other : MlregresslogisticBuffer) -> MlregresslogisticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticBuffer::copy(self : MlregresslogisticBuffer) -> MlregresslogisticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticBuffer::fill(self : MlregresslogisticBuffer, v : Double) -> MlregresslogisticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticBuffer::min(self : MlregresslogisticBuffer) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticBuffer::max(self : MlregresslogisticBuffer) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticBuffer::to_string(self : MlregresslogisticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_cursor_make(size : Int) -> MlregresslogisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticCursor::len(self : MlregresslogisticCursor) -> Int { self.size }

pub fn MlregresslogisticCursor::get(self : MlregresslogisticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticCursor::set(self : MlregresslogisticCursor, i : Int, v : Double) -> MlregresslogisticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCursor::sum(self : MlregresslogisticCursor) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticCursor::mean(self : MlregresslogisticCursor) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticCursor::scale(self : MlregresslogisticCursor, f : Double) -> MlregresslogisticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCursor::add(self : MlregresslogisticCursor, other : MlregresslogisticCursor) -> MlregresslogisticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticCursor::copy(self : MlregresslogisticCursor) -> MlregresslogisticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCursor::fill(self : MlregresslogisticCursor, v : Double) -> MlregresslogisticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticCursor::min(self : MlregresslogisticCursor) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticCursor::max(self : MlregresslogisticCursor) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticCursor::to_string(self : MlregresslogisticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_view_make(size : Int) -> MlregresslogisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticView::len(self : MlregresslogisticView) -> Int { self.size }

pub fn MlregresslogisticView::get(self : MlregresslogisticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticView::set(self : MlregresslogisticView, i : Int, v : Double) -> MlregresslogisticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticView::sum(self : MlregresslogisticView) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticView::mean(self : MlregresslogisticView) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticView::scale(self : MlregresslogisticView, f : Double) -> MlregresslogisticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticView::add(self : MlregresslogisticView, other : MlregresslogisticView) -> MlregresslogisticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticView::copy(self : MlregresslogisticView) -> MlregresslogisticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticView::fill(self : MlregresslogisticView, v : Double) -> MlregresslogisticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticView::min(self : MlregresslogisticView) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticView::max(self : MlregresslogisticView) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticView::to_string(self : MlregresslogisticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_range_make(size : Int) -> MlregresslogisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticRange::len(self : MlregresslogisticRange) -> Int { self.size }

pub fn MlregresslogisticRange::get(self : MlregresslogisticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticRange::set(self : MlregresslogisticRange, i : Int, v : Double) -> MlregresslogisticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticRange::sum(self : MlregresslogisticRange) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticRange::mean(self : MlregresslogisticRange) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticRange::scale(self : MlregresslogisticRange, f : Double) -> MlregresslogisticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticRange::add(self : MlregresslogisticRange, other : MlregresslogisticRange) -> MlregresslogisticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticRange::copy(self : MlregresslogisticRange) -> MlregresslogisticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticRange::fill(self : MlregresslogisticRange, v : Double) -> MlregresslogisticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticRange::min(self : MlregresslogisticRange) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticRange::max(self : MlregresslogisticRange) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticRange::to_string(self : MlregresslogisticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_slice_make(size : Int) -> MlregresslogisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresslogisticSlice::len(self : MlregresslogisticSlice) -> Int { self.size }

pub fn MlregresslogisticSlice::get(self : MlregresslogisticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresslogisticSlice::set(self : MlregresslogisticSlice, i : Int, v : Double) -> MlregresslogisticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresslogisticSlice::sum(self : MlregresslogisticSlice) -> Double { @_common.sum(self.data) }

pub fn MlregresslogisticSlice::mean(self : MlregresslogisticSlice) -> Double { @_common.mean(self.data) }

pub fn MlregresslogisticSlice::scale(self : MlregresslogisticSlice, f : Double) -> MlregresslogisticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticSlice::add(self : MlregresslogisticSlice, other : MlregresslogisticSlice) -> MlregresslogisticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresslogisticSlice::copy(self : MlregresslogisticSlice) -> MlregresslogisticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticSlice::fill(self : MlregresslogisticSlice, v : Double) -> MlregresslogisticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresslogisticSlice::min(self : MlregresslogisticSlice) -> Double { @_common.min(self.data) }

pub fn MlregresslogisticSlice::max(self : MlregresslogisticSlice) -> Double { @_common.max(self.data) }

pub fn MlregresslogisticSlice::to_string(self : MlregresslogisticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

