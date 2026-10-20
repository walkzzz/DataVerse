///===
/// extcore/ml_neural_attention

pub(all) struct MlneuralattentionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_attention_make_point(x : Double, y : Double) -> MlneuralattentionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_attention_make_point3(x : Double, y : Double, z : Double) -> MlneuralattentionPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralattentionPoint::x(self : MlneuralattentionPoint) -> Double { self.x }

pub fn MlneuralattentionPoint::y(self : MlneuralattentionPoint) -> Double { self.y }

pub fn MlneuralattentionPoint::z(self : MlneuralattentionPoint) -> Double { self.z }

pub fn MlneuralattentionPoint::label(self : MlneuralattentionPoint) -> Int { self.label }

pub fn MlneuralattentionPoint::dist(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralattentionPoint::add(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralattentionPoint::sub(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralattentionPoint::scale(self : MlneuralattentionPoint, s : Double) -> MlneuralattentionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralattentionPoint::dot(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralattentionPoint::cross(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralattentionPoint::norm(self : MlneuralattentionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralattentionPoint::normalize(self : MlneuralattentionPoint) -> MlneuralattentionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralattentionPoint::negate(self : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralattentionPoint::mid(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralattentionPoint::lerp(self : MlneuralattentionPoint, other : MlneuralattentionPoint, t : Double) -> MlneuralattentionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralattentionPoint::to_string(self : MlneuralattentionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralattentionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_attention_make_series(vals : Array[Double], name : String) -> MlneuralattentionSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralattentionSeries::len(self : MlneuralattentionSeries) -> Int { self.vals.length() }

pub fn MlneuralattentionSeries::sum(self : MlneuralattentionSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralattentionSeries::mean(self : MlneuralattentionSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralattentionSeries::min(self : MlneuralattentionSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralattentionSeries::max(self : MlneuralattentionSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralattentionSeries::range(self : MlneuralattentionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralattentionSeries::variance(self : MlneuralattentionSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralattentionSeries::std(self : MlneuralattentionSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralattentionSeries::median(self : MlneuralattentionSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralattentionSeries::scale(self : MlneuralattentionSeries, f : Double) -> MlneuralattentionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralattentionSeries::add(self : MlneuralattentionSeries, other : MlneuralattentionSeries) -> MlneuralattentionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralattentionSeries::sub(self : MlneuralattentionSeries, other : MlneuralattentionSeries) -> MlneuralattentionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralattentionSeries::normalize(self : MlneuralattentionSeries) -> MlneuralattentionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralattentionSeries::cumsum(self : MlneuralattentionSeries) -> MlneuralattentionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralattentionSeries::to_string(self : MlneuralattentionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralattentionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_attention_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralattentionMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_neural_attention_matrix_identity(n : Int) -> MlneuralattentionMatrix {
  let m = ml_neural_attention_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralattentionMatrix::get(self : MlneuralattentionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralattentionMatrix::transpose(self : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  let result = ml_neural_attention_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralattentionMatrix::add(self : MlneuralattentionMatrix, other : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_attention_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralattentionMatrix::scale(self : MlneuralattentionMatrix, s : Double) -> MlneuralattentionMatrix {
  let result = ml_neural_attention_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralattentionMatrix::multiply(self : MlneuralattentionMatrix, other : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  if self.cols != other.rows { return ml_neural_attention_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_attention_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlneuralattentionMatrix::trace(self : MlneuralattentionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralattentionMatrix::det(self : MlneuralattentionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralattentionMatrix::norm(self : MlneuralattentionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralattentionMatrix::to_string(self : MlneuralattentionMatrix) -> String {
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

pub(all) struct MlneuralattentionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_attention_make_vector(comps : Array[Double]) -> MlneuralattentionVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_attention_vector_zero(dim : Int) -> MlneuralattentionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralattentionVector::add(self : MlneuralattentionVector, other : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralattentionVector::sub(self : MlneuralattentionVector, other : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralattentionVector::scale(self : MlneuralattentionVector, s : Double) -> MlneuralattentionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralattentionVector::dot(self : MlneuralattentionVector, other : MlneuralattentionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralattentionVector::norm(self : MlneuralattentionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralattentionVector::normalize(self : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralattentionVector::dist(self : MlneuralattentionVector, other : MlneuralattentionVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralattentionVector::to_string(self : MlneuralattentionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralattentionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_frame_make(size : Int) -> MlneuralattentionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionFrame::len(self : MlneuralattentionFrame) -> Int { self.size }

pub fn MlneuralattentionFrame::get(self : MlneuralattentionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionFrame::set(self : MlneuralattentionFrame, i : Int, v : Double) -> MlneuralattentionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionFrame::sum(self : MlneuralattentionFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionFrame::mean(self : MlneuralattentionFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionFrame::scale(self : MlneuralattentionFrame, f : Double) -> MlneuralattentionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionFrame::add(self : MlneuralattentionFrame, other : MlneuralattentionFrame) -> MlneuralattentionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionFrame::copy(self : MlneuralattentionFrame) -> MlneuralattentionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionFrame::fill(self : MlneuralattentionFrame, v : Double) -> MlneuralattentionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionFrame::min(self : MlneuralattentionFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionFrame::max(self : MlneuralattentionFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionFrame::to_string(self : MlneuralattentionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_table_make(size : Int) -> MlneuralattentionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionTable::len(self : MlneuralattentionTable) -> Int { self.size }

pub fn MlneuralattentionTable::get(self : MlneuralattentionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionTable::set(self : MlneuralattentionTable, i : Int, v : Double) -> MlneuralattentionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionTable::sum(self : MlneuralattentionTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionTable::mean(self : MlneuralattentionTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionTable::scale(self : MlneuralattentionTable, f : Double) -> MlneuralattentionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionTable::add(self : MlneuralattentionTable, other : MlneuralattentionTable) -> MlneuralattentionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionTable::copy(self : MlneuralattentionTable) -> MlneuralattentionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionTable::fill(self : MlneuralattentionTable, v : Double) -> MlneuralattentionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionTable::min(self : MlneuralattentionTable) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionTable::max(self : MlneuralattentionTable) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionTable::to_string(self : MlneuralattentionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_graphn_make(size : Int) -> MlneuralattentionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionGraphN::len(self : MlneuralattentionGraphN) -> Int { self.size }

pub fn MlneuralattentionGraphN::get(self : MlneuralattentionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionGraphN::set(self : MlneuralattentionGraphN, i : Int, v : Double) -> MlneuralattentionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionGraphN::sum(self : MlneuralattentionGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionGraphN::mean(self : MlneuralattentionGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionGraphN::scale(self : MlneuralattentionGraphN, f : Double) -> MlneuralattentionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionGraphN::add(self : MlneuralattentionGraphN, other : MlneuralattentionGraphN) -> MlneuralattentionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionGraphN::copy(self : MlneuralattentionGraphN) -> MlneuralattentionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionGraphN::fill(self : MlneuralattentionGraphN, v : Double) -> MlneuralattentionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionGraphN::min(self : MlneuralattentionGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionGraphN::max(self : MlneuralattentionGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionGraphN::to_string(self : MlneuralattentionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_node_make(size : Int) -> MlneuralattentionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionNode::len(self : MlneuralattentionNode) -> Int { self.size }

pub fn MlneuralattentionNode::get(self : MlneuralattentionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionNode::set(self : MlneuralattentionNode, i : Int, v : Double) -> MlneuralattentionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionNode::sum(self : MlneuralattentionNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionNode::mean(self : MlneuralattentionNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionNode::scale(self : MlneuralattentionNode, f : Double) -> MlneuralattentionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionNode::add(self : MlneuralattentionNode, other : MlneuralattentionNode) -> MlneuralattentionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionNode::copy(self : MlneuralattentionNode) -> MlneuralattentionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionNode::fill(self : MlneuralattentionNode, v : Double) -> MlneuralattentionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionNode::min(self : MlneuralattentionNode) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionNode::max(self : MlneuralattentionNode) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionNode::to_string(self : MlneuralattentionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_edge_make(size : Int) -> MlneuralattentionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionEdge::len(self : MlneuralattentionEdge) -> Int { self.size }

pub fn MlneuralattentionEdge::get(self : MlneuralattentionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionEdge::set(self : MlneuralattentionEdge, i : Int, v : Double) -> MlneuralattentionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionEdge::sum(self : MlneuralattentionEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionEdge::mean(self : MlneuralattentionEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionEdge::scale(self : MlneuralattentionEdge, f : Double) -> MlneuralattentionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionEdge::add(self : MlneuralattentionEdge, other : MlneuralattentionEdge) -> MlneuralattentionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionEdge::copy(self : MlneuralattentionEdge) -> MlneuralattentionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionEdge::fill(self : MlneuralattentionEdge, v : Double) -> MlneuralattentionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionEdge::min(self : MlneuralattentionEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionEdge::max(self : MlneuralattentionEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionEdge::to_string(self : MlneuralattentionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_path_make(size : Int) -> MlneuralattentionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionPath::len(self : MlneuralattentionPath) -> Int { self.size }

pub fn MlneuralattentionPath::get(self : MlneuralattentionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionPath::set(self : MlneuralattentionPath, i : Int, v : Double) -> MlneuralattentionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionPath::sum(self : MlneuralattentionPath) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionPath::mean(self : MlneuralattentionPath) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionPath::scale(self : MlneuralattentionPath, f : Double) -> MlneuralattentionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionPath::add(self : MlneuralattentionPath, other : MlneuralattentionPath) -> MlneuralattentionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionPath::copy(self : MlneuralattentionPath) -> MlneuralattentionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionPath::fill(self : MlneuralattentionPath, v : Double) -> MlneuralattentionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionPath::min(self : MlneuralattentionPath) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionPath::max(self : MlneuralattentionPath) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionPath::to_string(self : MlneuralattentionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_cluster_make(size : Int) -> MlneuralattentionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionCluster::len(self : MlneuralattentionCluster) -> Int { self.size }

pub fn MlneuralattentionCluster::get(self : MlneuralattentionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionCluster::set(self : MlneuralattentionCluster, i : Int, v : Double) -> MlneuralattentionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCluster::sum(self : MlneuralattentionCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionCluster::mean(self : MlneuralattentionCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionCluster::scale(self : MlneuralattentionCluster, f : Double) -> MlneuralattentionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCluster::add(self : MlneuralattentionCluster, other : MlneuralattentionCluster) -> MlneuralattentionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionCluster::copy(self : MlneuralattentionCluster) -> MlneuralattentionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCluster::fill(self : MlneuralattentionCluster, v : Double) -> MlneuralattentionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCluster::min(self : MlneuralattentionCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionCluster::max(self : MlneuralattentionCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionCluster::to_string(self : MlneuralattentionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_model_make(size : Int) -> MlneuralattentionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionModel::len(self : MlneuralattentionModel) -> Int { self.size }

pub fn MlneuralattentionModel::get(self : MlneuralattentionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionModel::set(self : MlneuralattentionModel, i : Int, v : Double) -> MlneuralattentionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionModel::sum(self : MlneuralattentionModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionModel::mean(self : MlneuralattentionModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionModel::scale(self : MlneuralattentionModel, f : Double) -> MlneuralattentionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionModel::add(self : MlneuralattentionModel, other : MlneuralattentionModel) -> MlneuralattentionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionModel::copy(self : MlneuralattentionModel) -> MlneuralattentionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionModel::fill(self : MlneuralattentionModel, v : Double) -> MlneuralattentionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionModel::min(self : MlneuralattentionModel) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionModel::max(self : MlneuralattentionModel) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionModel::to_string(self : MlneuralattentionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_layer_make(size : Int) -> MlneuralattentionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionLayer::len(self : MlneuralattentionLayer) -> Int { self.size }

pub fn MlneuralattentionLayer::get(self : MlneuralattentionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionLayer::set(self : MlneuralattentionLayer, i : Int, v : Double) -> MlneuralattentionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionLayer::sum(self : MlneuralattentionLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionLayer::mean(self : MlneuralattentionLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionLayer::scale(self : MlneuralattentionLayer, f : Double) -> MlneuralattentionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionLayer::add(self : MlneuralattentionLayer, other : MlneuralattentionLayer) -> MlneuralattentionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionLayer::copy(self : MlneuralattentionLayer) -> MlneuralattentionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionLayer::fill(self : MlneuralattentionLayer, v : Double) -> MlneuralattentionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionLayer::min(self : MlneuralattentionLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionLayer::max(self : MlneuralattentionLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionLayer::to_string(self : MlneuralattentionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_buffer_make(size : Int) -> MlneuralattentionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionBuffer::len(self : MlneuralattentionBuffer) -> Int { self.size }

pub fn MlneuralattentionBuffer::get(self : MlneuralattentionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionBuffer::set(self : MlneuralattentionBuffer, i : Int, v : Double) -> MlneuralattentionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionBuffer::sum(self : MlneuralattentionBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionBuffer::mean(self : MlneuralattentionBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionBuffer::scale(self : MlneuralattentionBuffer, f : Double) -> MlneuralattentionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionBuffer::add(self : MlneuralattentionBuffer, other : MlneuralattentionBuffer) -> MlneuralattentionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionBuffer::copy(self : MlneuralattentionBuffer) -> MlneuralattentionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionBuffer::fill(self : MlneuralattentionBuffer, v : Double) -> MlneuralattentionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionBuffer::min(self : MlneuralattentionBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionBuffer::max(self : MlneuralattentionBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionBuffer::to_string(self : MlneuralattentionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_cursor_make(size : Int) -> MlneuralattentionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionCursor::len(self : MlneuralattentionCursor) -> Int { self.size }

pub fn MlneuralattentionCursor::get(self : MlneuralattentionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionCursor::set(self : MlneuralattentionCursor, i : Int, v : Double) -> MlneuralattentionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCursor::sum(self : MlneuralattentionCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionCursor::mean(self : MlneuralattentionCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionCursor::scale(self : MlneuralattentionCursor, f : Double) -> MlneuralattentionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCursor::add(self : MlneuralattentionCursor, other : MlneuralattentionCursor) -> MlneuralattentionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionCursor::copy(self : MlneuralattentionCursor) -> MlneuralattentionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCursor::fill(self : MlneuralattentionCursor, v : Double) -> MlneuralattentionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionCursor::min(self : MlneuralattentionCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionCursor::max(self : MlneuralattentionCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionCursor::to_string(self : MlneuralattentionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_view_make(size : Int) -> MlneuralattentionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionView::len(self : MlneuralattentionView) -> Int { self.size }

pub fn MlneuralattentionView::get(self : MlneuralattentionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionView::set(self : MlneuralattentionView, i : Int, v : Double) -> MlneuralattentionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionView::sum(self : MlneuralattentionView) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionView::mean(self : MlneuralattentionView) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionView::scale(self : MlneuralattentionView, f : Double) -> MlneuralattentionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionView::add(self : MlneuralattentionView, other : MlneuralattentionView) -> MlneuralattentionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionView::copy(self : MlneuralattentionView) -> MlneuralattentionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionView::fill(self : MlneuralattentionView, v : Double) -> MlneuralattentionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionView::min(self : MlneuralattentionView) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionView::max(self : MlneuralattentionView) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionView::to_string(self : MlneuralattentionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_range_make(size : Int) -> MlneuralattentionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionRange::len(self : MlneuralattentionRange) -> Int { self.size }

pub fn MlneuralattentionRange::get(self : MlneuralattentionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionRange::set(self : MlneuralattentionRange, i : Int, v : Double) -> MlneuralattentionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionRange::sum(self : MlneuralattentionRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionRange::mean(self : MlneuralattentionRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionRange::scale(self : MlneuralattentionRange, f : Double) -> MlneuralattentionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionRange::add(self : MlneuralattentionRange, other : MlneuralattentionRange) -> MlneuralattentionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionRange::copy(self : MlneuralattentionRange) -> MlneuralattentionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionRange::fill(self : MlneuralattentionRange, v : Double) -> MlneuralattentionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionRange::min(self : MlneuralattentionRange) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionRange::max(self : MlneuralattentionRange) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionRange::to_string(self : MlneuralattentionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_slice_make(size : Int) -> MlneuralattentionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralattentionSlice::len(self : MlneuralattentionSlice) -> Int { self.size }

pub fn MlneuralattentionSlice::get(self : MlneuralattentionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralattentionSlice::set(self : MlneuralattentionSlice, i : Int, v : Double) -> MlneuralattentionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralattentionSlice::sum(self : MlneuralattentionSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralattentionSlice::mean(self : MlneuralattentionSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralattentionSlice::scale(self : MlneuralattentionSlice, f : Double) -> MlneuralattentionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionSlice::add(self : MlneuralattentionSlice, other : MlneuralattentionSlice) -> MlneuralattentionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralattentionSlice::copy(self : MlneuralattentionSlice) -> MlneuralattentionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionSlice::fill(self : MlneuralattentionSlice, v : Double) -> MlneuralattentionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralattentionSlice::min(self : MlneuralattentionSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralattentionSlice::max(self : MlneuralattentionSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralattentionSlice::to_string(self : MlneuralattentionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

