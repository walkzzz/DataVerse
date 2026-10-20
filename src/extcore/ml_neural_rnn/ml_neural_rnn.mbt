///===
/// extcore/ml_neural_rnn

pub(all) struct MlneuralrnnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_rnn_make_point(x : Double, y : Double) -> MlneuralrnnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_rnn_make_point3(x : Double, y : Double, z : Double) -> MlneuralrnnPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralrnnPoint::x(self : MlneuralrnnPoint) -> Double { self.x }

pub fn MlneuralrnnPoint::y(self : MlneuralrnnPoint) -> Double { self.y }

pub fn MlneuralrnnPoint::z(self : MlneuralrnnPoint) -> Double { self.z }

pub fn MlneuralrnnPoint::label(self : MlneuralrnnPoint) -> Int { self.label }

pub fn MlneuralrnnPoint::dist(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralrnnPoint::add(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralrnnPoint::sub(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralrnnPoint::scale(self : MlneuralrnnPoint, s : Double) -> MlneuralrnnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralrnnPoint::dot(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralrnnPoint::cross(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralrnnPoint::norm(self : MlneuralrnnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralrnnPoint::normalize(self : MlneuralrnnPoint) -> MlneuralrnnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralrnnPoint::negate(self : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralrnnPoint::mid(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralrnnPoint::lerp(self : MlneuralrnnPoint, other : MlneuralrnnPoint, t : Double) -> MlneuralrnnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralrnnPoint::to_string(self : MlneuralrnnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralrnnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_rnn_make_series(vals : Array[Double], name : String) -> MlneuralrnnSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralrnnSeries::len(self : MlneuralrnnSeries) -> Int { self.vals.length() }

pub fn MlneuralrnnSeries::sum(self : MlneuralrnnSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralrnnSeries::mean(self : MlneuralrnnSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralrnnSeries::min(self : MlneuralrnnSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralrnnSeries::max(self : MlneuralrnnSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralrnnSeries::range(self : MlneuralrnnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralrnnSeries::variance(self : MlneuralrnnSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralrnnSeries::std(self : MlneuralrnnSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralrnnSeries::median(self : MlneuralrnnSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralrnnSeries::scale(self : MlneuralrnnSeries, f : Double) -> MlneuralrnnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralrnnSeries::add(self : MlneuralrnnSeries, other : MlneuralrnnSeries) -> MlneuralrnnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralrnnSeries::sub(self : MlneuralrnnSeries, other : MlneuralrnnSeries) -> MlneuralrnnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralrnnSeries::normalize(self : MlneuralrnnSeries) -> MlneuralrnnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralrnnSeries::cumsum(self : MlneuralrnnSeries) -> MlneuralrnnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralrnnSeries::to_string(self : MlneuralrnnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralrnnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_rnn_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralrnnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_rnn_matrix_identity(n : Int) -> MlneuralrnnMatrix {
  let m = ml_neural_rnn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralrnnMatrix::get(self : MlneuralrnnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralrnnMatrix::transpose(self : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  let result = ml_neural_rnn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralrnnMatrix::add(self : MlneuralrnnMatrix, other : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_rnn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralrnnMatrix::scale(self : MlneuralrnnMatrix, s : Double) -> MlneuralrnnMatrix {
  let result = ml_neural_rnn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralrnnMatrix::multiply(self : MlneuralrnnMatrix, other : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  if self.cols != other.rows { return ml_neural_rnn_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_rnn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlneuralrnnMatrix::trace(self : MlneuralrnnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralrnnMatrix::det(self : MlneuralrnnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralrnnMatrix::norm(self : MlneuralrnnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralrnnMatrix::to_string(self : MlneuralrnnMatrix) -> String {
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

pub(all) struct MlneuralrnnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_rnn_make_vector(comps : Array[Double]) -> MlneuralrnnVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_rnn_vector_zero(dim : Int) -> MlneuralrnnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralrnnVector::add(self : MlneuralrnnVector, other : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralrnnVector::sub(self : MlneuralrnnVector, other : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralrnnVector::scale(self : MlneuralrnnVector, s : Double) -> MlneuralrnnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralrnnVector::dot(self : MlneuralrnnVector, other : MlneuralrnnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralrnnVector::norm(self : MlneuralrnnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralrnnVector::normalize(self : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralrnnVector::dist(self : MlneuralrnnVector, other : MlneuralrnnVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralrnnVector::to_string(self : MlneuralrnnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralrnnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_frame_make(size : Int) -> MlneuralrnnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnFrame::len(self : MlneuralrnnFrame) -> Int { self.size }

pub fn MlneuralrnnFrame::get(self : MlneuralrnnFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnFrame::set(self : MlneuralrnnFrame, i : Int, v : Double) -> MlneuralrnnFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnFrame::sum(self : MlneuralrnnFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnFrame::mean(self : MlneuralrnnFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnFrame::scale(self : MlneuralrnnFrame, f : Double) -> MlneuralrnnFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnFrame::add(self : MlneuralrnnFrame, other : MlneuralrnnFrame) -> MlneuralrnnFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnFrame::copy(self : MlneuralrnnFrame) -> MlneuralrnnFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnFrame::fill(self : MlneuralrnnFrame, v : Double) -> MlneuralrnnFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnFrame::min(self : MlneuralrnnFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnFrame::max(self : MlneuralrnnFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnFrame::to_string(self : MlneuralrnnFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_table_make(size : Int) -> MlneuralrnnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnTable::len(self : MlneuralrnnTable) -> Int { self.size }

pub fn MlneuralrnnTable::get(self : MlneuralrnnTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnTable::set(self : MlneuralrnnTable, i : Int, v : Double) -> MlneuralrnnTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnTable::sum(self : MlneuralrnnTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnTable::mean(self : MlneuralrnnTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnTable::scale(self : MlneuralrnnTable, f : Double) -> MlneuralrnnTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnTable::add(self : MlneuralrnnTable, other : MlneuralrnnTable) -> MlneuralrnnTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnTable::copy(self : MlneuralrnnTable) -> MlneuralrnnTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnTable::fill(self : MlneuralrnnTable, v : Double) -> MlneuralrnnTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnTable::min(self : MlneuralrnnTable) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnTable::max(self : MlneuralrnnTable) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnTable::to_string(self : MlneuralrnnTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_graphn_make(size : Int) -> MlneuralrnnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnGraphN::len(self : MlneuralrnnGraphN) -> Int { self.size }

pub fn MlneuralrnnGraphN::get(self : MlneuralrnnGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnGraphN::set(self : MlneuralrnnGraphN, i : Int, v : Double) -> MlneuralrnnGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnGraphN::sum(self : MlneuralrnnGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnGraphN::mean(self : MlneuralrnnGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnGraphN::scale(self : MlneuralrnnGraphN, f : Double) -> MlneuralrnnGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnGraphN::add(self : MlneuralrnnGraphN, other : MlneuralrnnGraphN) -> MlneuralrnnGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnGraphN::copy(self : MlneuralrnnGraphN) -> MlneuralrnnGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnGraphN::fill(self : MlneuralrnnGraphN, v : Double) -> MlneuralrnnGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnGraphN::min(self : MlneuralrnnGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnGraphN::max(self : MlneuralrnnGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnGraphN::to_string(self : MlneuralrnnGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_node_make(size : Int) -> MlneuralrnnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnNode::len(self : MlneuralrnnNode) -> Int { self.size }

pub fn MlneuralrnnNode::get(self : MlneuralrnnNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnNode::set(self : MlneuralrnnNode, i : Int, v : Double) -> MlneuralrnnNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnNode::sum(self : MlneuralrnnNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnNode::mean(self : MlneuralrnnNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnNode::scale(self : MlneuralrnnNode, f : Double) -> MlneuralrnnNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnNode::add(self : MlneuralrnnNode, other : MlneuralrnnNode) -> MlneuralrnnNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnNode::copy(self : MlneuralrnnNode) -> MlneuralrnnNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnNode::fill(self : MlneuralrnnNode, v : Double) -> MlneuralrnnNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnNode::min(self : MlneuralrnnNode) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnNode::max(self : MlneuralrnnNode) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnNode::to_string(self : MlneuralrnnNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_edge_make(size : Int) -> MlneuralrnnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnEdge::len(self : MlneuralrnnEdge) -> Int { self.size }

pub fn MlneuralrnnEdge::get(self : MlneuralrnnEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnEdge::set(self : MlneuralrnnEdge, i : Int, v : Double) -> MlneuralrnnEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnEdge::sum(self : MlneuralrnnEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnEdge::mean(self : MlneuralrnnEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnEdge::scale(self : MlneuralrnnEdge, f : Double) -> MlneuralrnnEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnEdge::add(self : MlneuralrnnEdge, other : MlneuralrnnEdge) -> MlneuralrnnEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnEdge::copy(self : MlneuralrnnEdge) -> MlneuralrnnEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnEdge::fill(self : MlneuralrnnEdge, v : Double) -> MlneuralrnnEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnEdge::min(self : MlneuralrnnEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnEdge::max(self : MlneuralrnnEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnEdge::to_string(self : MlneuralrnnEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_path_make(size : Int) -> MlneuralrnnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnPath::len(self : MlneuralrnnPath) -> Int { self.size }

pub fn MlneuralrnnPath::get(self : MlneuralrnnPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnPath::set(self : MlneuralrnnPath, i : Int, v : Double) -> MlneuralrnnPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnPath::sum(self : MlneuralrnnPath) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnPath::mean(self : MlneuralrnnPath) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnPath::scale(self : MlneuralrnnPath, f : Double) -> MlneuralrnnPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnPath::add(self : MlneuralrnnPath, other : MlneuralrnnPath) -> MlneuralrnnPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnPath::copy(self : MlneuralrnnPath) -> MlneuralrnnPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnPath::fill(self : MlneuralrnnPath, v : Double) -> MlneuralrnnPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnPath::min(self : MlneuralrnnPath) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnPath::max(self : MlneuralrnnPath) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnPath::to_string(self : MlneuralrnnPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_cluster_make(size : Int) -> MlneuralrnnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnCluster::len(self : MlneuralrnnCluster) -> Int { self.size }

pub fn MlneuralrnnCluster::get(self : MlneuralrnnCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnCluster::set(self : MlneuralrnnCluster, i : Int, v : Double) -> MlneuralrnnCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCluster::sum(self : MlneuralrnnCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnCluster::mean(self : MlneuralrnnCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnCluster::scale(self : MlneuralrnnCluster, f : Double) -> MlneuralrnnCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCluster::add(self : MlneuralrnnCluster, other : MlneuralrnnCluster) -> MlneuralrnnCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnCluster::copy(self : MlneuralrnnCluster) -> MlneuralrnnCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCluster::fill(self : MlneuralrnnCluster, v : Double) -> MlneuralrnnCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCluster::min(self : MlneuralrnnCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnCluster::max(self : MlneuralrnnCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnCluster::to_string(self : MlneuralrnnCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_model_make(size : Int) -> MlneuralrnnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnModel::len(self : MlneuralrnnModel) -> Int { self.size }

pub fn MlneuralrnnModel::get(self : MlneuralrnnModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnModel::set(self : MlneuralrnnModel, i : Int, v : Double) -> MlneuralrnnModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnModel::sum(self : MlneuralrnnModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnModel::mean(self : MlneuralrnnModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnModel::scale(self : MlneuralrnnModel, f : Double) -> MlneuralrnnModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnModel::add(self : MlneuralrnnModel, other : MlneuralrnnModel) -> MlneuralrnnModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnModel::copy(self : MlneuralrnnModel) -> MlneuralrnnModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnModel::fill(self : MlneuralrnnModel, v : Double) -> MlneuralrnnModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnModel::min(self : MlneuralrnnModel) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnModel::max(self : MlneuralrnnModel) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnModel::to_string(self : MlneuralrnnModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_layer_make(size : Int) -> MlneuralrnnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnLayer::len(self : MlneuralrnnLayer) -> Int { self.size }

pub fn MlneuralrnnLayer::get(self : MlneuralrnnLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnLayer::set(self : MlneuralrnnLayer, i : Int, v : Double) -> MlneuralrnnLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnLayer::sum(self : MlneuralrnnLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnLayer::mean(self : MlneuralrnnLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnLayer::scale(self : MlneuralrnnLayer, f : Double) -> MlneuralrnnLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnLayer::add(self : MlneuralrnnLayer, other : MlneuralrnnLayer) -> MlneuralrnnLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnLayer::copy(self : MlneuralrnnLayer) -> MlneuralrnnLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnLayer::fill(self : MlneuralrnnLayer, v : Double) -> MlneuralrnnLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnLayer::min(self : MlneuralrnnLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnLayer::max(self : MlneuralrnnLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnLayer::to_string(self : MlneuralrnnLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_buffer_make(size : Int) -> MlneuralrnnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnBuffer::len(self : MlneuralrnnBuffer) -> Int { self.size }

pub fn MlneuralrnnBuffer::get(self : MlneuralrnnBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnBuffer::set(self : MlneuralrnnBuffer, i : Int, v : Double) -> MlneuralrnnBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnBuffer::sum(self : MlneuralrnnBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnBuffer::mean(self : MlneuralrnnBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnBuffer::scale(self : MlneuralrnnBuffer, f : Double) -> MlneuralrnnBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnBuffer::add(self : MlneuralrnnBuffer, other : MlneuralrnnBuffer) -> MlneuralrnnBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnBuffer::copy(self : MlneuralrnnBuffer) -> MlneuralrnnBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnBuffer::fill(self : MlneuralrnnBuffer, v : Double) -> MlneuralrnnBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnBuffer::min(self : MlneuralrnnBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnBuffer::max(self : MlneuralrnnBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnBuffer::to_string(self : MlneuralrnnBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_cursor_make(size : Int) -> MlneuralrnnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnCursor::len(self : MlneuralrnnCursor) -> Int { self.size }

pub fn MlneuralrnnCursor::get(self : MlneuralrnnCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnCursor::set(self : MlneuralrnnCursor, i : Int, v : Double) -> MlneuralrnnCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCursor::sum(self : MlneuralrnnCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnCursor::mean(self : MlneuralrnnCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnCursor::scale(self : MlneuralrnnCursor, f : Double) -> MlneuralrnnCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCursor::add(self : MlneuralrnnCursor, other : MlneuralrnnCursor) -> MlneuralrnnCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnCursor::copy(self : MlneuralrnnCursor) -> MlneuralrnnCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCursor::fill(self : MlneuralrnnCursor, v : Double) -> MlneuralrnnCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnCursor::min(self : MlneuralrnnCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnCursor::max(self : MlneuralrnnCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnCursor::to_string(self : MlneuralrnnCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_view_make(size : Int) -> MlneuralrnnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnView::len(self : MlneuralrnnView) -> Int { self.size }

pub fn MlneuralrnnView::get(self : MlneuralrnnView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnView::set(self : MlneuralrnnView, i : Int, v : Double) -> MlneuralrnnView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnView::sum(self : MlneuralrnnView) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnView::mean(self : MlneuralrnnView) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnView::scale(self : MlneuralrnnView, f : Double) -> MlneuralrnnView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnView::add(self : MlneuralrnnView, other : MlneuralrnnView) -> MlneuralrnnView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnView::copy(self : MlneuralrnnView) -> MlneuralrnnView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnView::fill(self : MlneuralrnnView, v : Double) -> MlneuralrnnView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnView::min(self : MlneuralrnnView) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnView::max(self : MlneuralrnnView) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnView::to_string(self : MlneuralrnnView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_range_make(size : Int) -> MlneuralrnnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnRange::len(self : MlneuralrnnRange) -> Int { self.size }

pub fn MlneuralrnnRange::get(self : MlneuralrnnRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnRange::set(self : MlneuralrnnRange, i : Int, v : Double) -> MlneuralrnnRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnRange::sum(self : MlneuralrnnRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnRange::mean(self : MlneuralrnnRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnRange::scale(self : MlneuralrnnRange, f : Double) -> MlneuralrnnRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnRange::add(self : MlneuralrnnRange, other : MlneuralrnnRange) -> MlneuralrnnRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnRange::copy(self : MlneuralrnnRange) -> MlneuralrnnRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnRange::fill(self : MlneuralrnnRange, v : Double) -> MlneuralrnnRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnRange::min(self : MlneuralrnnRange) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnRange::max(self : MlneuralrnnRange) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnRange::to_string(self : MlneuralrnnRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_slice_make(size : Int) -> MlneuralrnnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralrnnSlice::len(self : MlneuralrnnSlice) -> Int { self.size }

pub fn MlneuralrnnSlice::get(self : MlneuralrnnSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralrnnSlice::set(self : MlneuralrnnSlice, i : Int, v : Double) -> MlneuralrnnSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralrnnSlice::sum(self : MlneuralrnnSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralrnnSlice::mean(self : MlneuralrnnSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralrnnSlice::scale(self : MlneuralrnnSlice, f : Double) -> MlneuralrnnSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnSlice::add(self : MlneuralrnnSlice, other : MlneuralrnnSlice) -> MlneuralrnnSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralrnnSlice::copy(self : MlneuralrnnSlice) -> MlneuralrnnSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnSlice::fill(self : MlneuralrnnSlice, v : Double) -> MlneuralrnnSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralrnnSlice::min(self : MlneuralrnnSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralrnnSlice::max(self : MlneuralrnnSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralrnnSlice::to_string(self : MlneuralrnnSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

