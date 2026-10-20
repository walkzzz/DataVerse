///===
/// extcore/ml_neural_lstm

pub(all) struct MlneurallstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_lstm_make_point(x : Double, y : Double) -> MlneurallstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_lstm_make_point3(x : Double, y : Double, z : Double) -> MlneurallstmPoint {
  { x, y, z, label: 0 }
}

pub fn MlneurallstmPoint::x(self : MlneurallstmPoint) -> Double { self.x }

pub fn MlneurallstmPoint::y(self : MlneurallstmPoint) -> Double { self.y }

pub fn MlneurallstmPoint::z(self : MlneurallstmPoint) -> Double { self.z }

pub fn MlneurallstmPoint::label(self : MlneurallstmPoint) -> Int { self.label }

pub fn MlneurallstmPoint::dist(self : MlneurallstmPoint, other : MlneurallstmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneurallstmPoint::add(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneurallstmPoint::sub(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneurallstmPoint::scale(self : MlneurallstmPoint, s : Double) -> MlneurallstmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneurallstmPoint::dot(self : MlneurallstmPoint, other : MlneurallstmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneurallstmPoint::cross(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneurallstmPoint::norm(self : MlneurallstmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneurallstmPoint::normalize(self : MlneurallstmPoint) -> MlneurallstmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneurallstmPoint::negate(self : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneurallstmPoint::mid(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneurallstmPoint::lerp(self : MlneurallstmPoint, other : MlneurallstmPoint, t : Double) -> MlneurallstmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneurallstmPoint::to_string(self : MlneurallstmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneurallstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_lstm_make_series(vals : Array[Double], name : String) -> MlneurallstmSeries {
  { vals, name, meta: 0 }
}

pub fn MlneurallstmSeries::len(self : MlneurallstmSeries) -> Int { self.vals.length() }

pub fn MlneurallstmSeries::sum(self : MlneurallstmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneurallstmSeries::mean(self : MlneurallstmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneurallstmSeries::min(self : MlneurallstmSeries) -> Double { @_common.min(self.vals) }

pub fn MlneurallstmSeries::max(self : MlneurallstmSeries) -> Double { @_common.max(self.vals) }

pub fn MlneurallstmSeries::range(self : MlneurallstmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneurallstmSeries::variance(self : MlneurallstmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneurallstmSeries::std(self : MlneurallstmSeries) -> Double { @_common.std(self.vals) }

pub fn MlneurallstmSeries::median(self : MlneurallstmSeries) -> Double { @_common.median(self.vals) }

pub fn MlneurallstmSeries::scale(self : MlneurallstmSeries, f : Double) -> MlneurallstmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneurallstmSeries::add(self : MlneurallstmSeries, other : MlneurallstmSeries) -> MlneurallstmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneurallstmSeries::sub(self : MlneurallstmSeries, other : MlneurallstmSeries) -> MlneurallstmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneurallstmSeries::normalize(self : MlneurallstmSeries) -> MlneurallstmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneurallstmSeries::cumsum(self : MlneurallstmSeries) -> MlneurallstmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneurallstmSeries::to_string(self : MlneurallstmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneurallstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_lstm_make_matrix(rows : Int, cols : Int, val : Double) -> MlneurallstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_lstm_matrix_identity(n : Int) -> MlneurallstmMatrix {
  let m = ml_neural_lstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneurallstmMatrix::get(self : MlneurallstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneurallstmMatrix::transpose(self : MlneurallstmMatrix) -> MlneurallstmMatrix {
  let result = ml_neural_lstm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneurallstmMatrix::add(self : MlneurallstmMatrix, other : MlneurallstmMatrix) -> MlneurallstmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneurallstmMatrix::scale(self : MlneurallstmMatrix, s : Double) -> MlneurallstmMatrix {
  let result = ml_neural_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneurallstmMatrix::multiply(self : MlneurallstmMatrix, other : MlneurallstmMatrix) -> MlneurallstmMatrix {
  if self.cols != other.rows { return ml_neural_lstm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_lstm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlneurallstmMatrix::trace(self : MlneurallstmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneurallstmMatrix::det(self : MlneurallstmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneurallstmMatrix::norm(self : MlneurallstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneurallstmMatrix::to_string(self : MlneurallstmMatrix) -> String {
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

pub(all) struct MlneurallstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_lstm_make_vector(comps : Array[Double]) -> MlneurallstmVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_lstm_vector_zero(dim : Int) -> MlneurallstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneurallstmVector::add(self : MlneurallstmVector, other : MlneurallstmVector) -> MlneurallstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneurallstmVector::sub(self : MlneurallstmVector, other : MlneurallstmVector) -> MlneurallstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneurallstmVector::scale(self : MlneurallstmVector, s : Double) -> MlneurallstmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneurallstmVector::dot(self : MlneurallstmVector, other : MlneurallstmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneurallstmVector::norm(self : MlneurallstmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneurallstmVector::normalize(self : MlneurallstmVector) -> MlneurallstmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneurallstmVector::dist(self : MlneurallstmVector, other : MlneurallstmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneurallstmVector::to_string(self : MlneurallstmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneurallstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_frame_make(size : Int) -> MlneurallstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmFrame::len(self : MlneurallstmFrame) -> Int { self.size }

pub fn MlneurallstmFrame::get(self : MlneurallstmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmFrame::set(self : MlneurallstmFrame, i : Int, v : Double) -> MlneurallstmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmFrame::sum(self : MlneurallstmFrame) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmFrame::mean(self : MlneurallstmFrame) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmFrame::scale(self : MlneurallstmFrame, f : Double) -> MlneurallstmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmFrame::add(self : MlneurallstmFrame, other : MlneurallstmFrame) -> MlneurallstmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmFrame::copy(self : MlneurallstmFrame) -> MlneurallstmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmFrame::fill(self : MlneurallstmFrame, v : Double) -> MlneurallstmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmFrame::min(self : MlneurallstmFrame) -> Double { @_common.min(self.data) }

pub fn MlneurallstmFrame::max(self : MlneurallstmFrame) -> Double { @_common.max(self.data) }

pub fn MlneurallstmFrame::to_string(self : MlneurallstmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_table_make(size : Int) -> MlneurallstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmTable::len(self : MlneurallstmTable) -> Int { self.size }

pub fn MlneurallstmTable::get(self : MlneurallstmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmTable::set(self : MlneurallstmTable, i : Int, v : Double) -> MlneurallstmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmTable::sum(self : MlneurallstmTable) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmTable::mean(self : MlneurallstmTable) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmTable::scale(self : MlneurallstmTable, f : Double) -> MlneurallstmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmTable::add(self : MlneurallstmTable, other : MlneurallstmTable) -> MlneurallstmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmTable::copy(self : MlneurallstmTable) -> MlneurallstmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmTable::fill(self : MlneurallstmTable, v : Double) -> MlneurallstmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmTable::min(self : MlneurallstmTable) -> Double { @_common.min(self.data) }

pub fn MlneurallstmTable::max(self : MlneurallstmTable) -> Double { @_common.max(self.data) }

pub fn MlneurallstmTable::to_string(self : MlneurallstmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_graphn_make(size : Int) -> MlneurallstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmGraphN::len(self : MlneurallstmGraphN) -> Int { self.size }

pub fn MlneurallstmGraphN::get(self : MlneurallstmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmGraphN::set(self : MlneurallstmGraphN, i : Int, v : Double) -> MlneurallstmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmGraphN::sum(self : MlneurallstmGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmGraphN::mean(self : MlneurallstmGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmGraphN::scale(self : MlneurallstmGraphN, f : Double) -> MlneurallstmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmGraphN::add(self : MlneurallstmGraphN, other : MlneurallstmGraphN) -> MlneurallstmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmGraphN::copy(self : MlneurallstmGraphN) -> MlneurallstmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmGraphN::fill(self : MlneurallstmGraphN, v : Double) -> MlneurallstmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmGraphN::min(self : MlneurallstmGraphN) -> Double { @_common.min(self.data) }

pub fn MlneurallstmGraphN::max(self : MlneurallstmGraphN) -> Double { @_common.max(self.data) }

pub fn MlneurallstmGraphN::to_string(self : MlneurallstmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_node_make(size : Int) -> MlneurallstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmNode::len(self : MlneurallstmNode) -> Int { self.size }

pub fn MlneurallstmNode::get(self : MlneurallstmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmNode::set(self : MlneurallstmNode, i : Int, v : Double) -> MlneurallstmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmNode::sum(self : MlneurallstmNode) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmNode::mean(self : MlneurallstmNode) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmNode::scale(self : MlneurallstmNode, f : Double) -> MlneurallstmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmNode::add(self : MlneurallstmNode, other : MlneurallstmNode) -> MlneurallstmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmNode::copy(self : MlneurallstmNode) -> MlneurallstmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmNode::fill(self : MlneurallstmNode, v : Double) -> MlneurallstmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmNode::min(self : MlneurallstmNode) -> Double { @_common.min(self.data) }

pub fn MlneurallstmNode::max(self : MlneurallstmNode) -> Double { @_common.max(self.data) }

pub fn MlneurallstmNode::to_string(self : MlneurallstmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_edge_make(size : Int) -> MlneurallstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmEdge::len(self : MlneurallstmEdge) -> Int { self.size }

pub fn MlneurallstmEdge::get(self : MlneurallstmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmEdge::set(self : MlneurallstmEdge, i : Int, v : Double) -> MlneurallstmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmEdge::sum(self : MlneurallstmEdge) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmEdge::mean(self : MlneurallstmEdge) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmEdge::scale(self : MlneurallstmEdge, f : Double) -> MlneurallstmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmEdge::add(self : MlneurallstmEdge, other : MlneurallstmEdge) -> MlneurallstmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmEdge::copy(self : MlneurallstmEdge) -> MlneurallstmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmEdge::fill(self : MlneurallstmEdge, v : Double) -> MlneurallstmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmEdge::min(self : MlneurallstmEdge) -> Double { @_common.min(self.data) }

pub fn MlneurallstmEdge::max(self : MlneurallstmEdge) -> Double { @_common.max(self.data) }

pub fn MlneurallstmEdge::to_string(self : MlneurallstmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_path_make(size : Int) -> MlneurallstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmPath::len(self : MlneurallstmPath) -> Int { self.size }

pub fn MlneurallstmPath::get(self : MlneurallstmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmPath::set(self : MlneurallstmPath, i : Int, v : Double) -> MlneurallstmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmPath::sum(self : MlneurallstmPath) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmPath::mean(self : MlneurallstmPath) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmPath::scale(self : MlneurallstmPath, f : Double) -> MlneurallstmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmPath::add(self : MlneurallstmPath, other : MlneurallstmPath) -> MlneurallstmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmPath::copy(self : MlneurallstmPath) -> MlneurallstmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmPath::fill(self : MlneurallstmPath, v : Double) -> MlneurallstmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmPath::min(self : MlneurallstmPath) -> Double { @_common.min(self.data) }

pub fn MlneurallstmPath::max(self : MlneurallstmPath) -> Double { @_common.max(self.data) }

pub fn MlneurallstmPath::to_string(self : MlneurallstmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_cluster_make(size : Int) -> MlneurallstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmCluster::len(self : MlneurallstmCluster) -> Int { self.size }

pub fn MlneurallstmCluster::get(self : MlneurallstmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmCluster::set(self : MlneurallstmCluster, i : Int, v : Double) -> MlneurallstmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmCluster::sum(self : MlneurallstmCluster) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmCluster::mean(self : MlneurallstmCluster) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmCluster::scale(self : MlneurallstmCluster, f : Double) -> MlneurallstmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmCluster::add(self : MlneurallstmCluster, other : MlneurallstmCluster) -> MlneurallstmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmCluster::copy(self : MlneurallstmCluster) -> MlneurallstmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmCluster::fill(self : MlneurallstmCluster, v : Double) -> MlneurallstmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmCluster::min(self : MlneurallstmCluster) -> Double { @_common.min(self.data) }

pub fn MlneurallstmCluster::max(self : MlneurallstmCluster) -> Double { @_common.max(self.data) }

pub fn MlneurallstmCluster::to_string(self : MlneurallstmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_model_make(size : Int) -> MlneurallstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmModel::len(self : MlneurallstmModel) -> Int { self.size }

pub fn MlneurallstmModel::get(self : MlneurallstmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmModel::set(self : MlneurallstmModel, i : Int, v : Double) -> MlneurallstmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmModel::sum(self : MlneurallstmModel) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmModel::mean(self : MlneurallstmModel) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmModel::scale(self : MlneurallstmModel, f : Double) -> MlneurallstmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmModel::add(self : MlneurallstmModel, other : MlneurallstmModel) -> MlneurallstmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmModel::copy(self : MlneurallstmModel) -> MlneurallstmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmModel::fill(self : MlneurallstmModel, v : Double) -> MlneurallstmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmModel::min(self : MlneurallstmModel) -> Double { @_common.min(self.data) }

pub fn MlneurallstmModel::max(self : MlneurallstmModel) -> Double { @_common.max(self.data) }

pub fn MlneurallstmModel::to_string(self : MlneurallstmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_layer_make(size : Int) -> MlneurallstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmLayer::len(self : MlneurallstmLayer) -> Int { self.size }

pub fn MlneurallstmLayer::get(self : MlneurallstmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmLayer::set(self : MlneurallstmLayer, i : Int, v : Double) -> MlneurallstmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmLayer::sum(self : MlneurallstmLayer) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmLayer::mean(self : MlneurallstmLayer) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmLayer::scale(self : MlneurallstmLayer, f : Double) -> MlneurallstmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmLayer::add(self : MlneurallstmLayer, other : MlneurallstmLayer) -> MlneurallstmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmLayer::copy(self : MlneurallstmLayer) -> MlneurallstmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmLayer::fill(self : MlneurallstmLayer, v : Double) -> MlneurallstmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmLayer::min(self : MlneurallstmLayer) -> Double { @_common.min(self.data) }

pub fn MlneurallstmLayer::max(self : MlneurallstmLayer) -> Double { @_common.max(self.data) }

pub fn MlneurallstmLayer::to_string(self : MlneurallstmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_buffer_make(size : Int) -> MlneurallstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmBuffer::len(self : MlneurallstmBuffer) -> Int { self.size }

pub fn MlneurallstmBuffer::get(self : MlneurallstmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmBuffer::set(self : MlneurallstmBuffer, i : Int, v : Double) -> MlneurallstmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmBuffer::sum(self : MlneurallstmBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmBuffer::mean(self : MlneurallstmBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmBuffer::scale(self : MlneurallstmBuffer, f : Double) -> MlneurallstmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmBuffer::add(self : MlneurallstmBuffer, other : MlneurallstmBuffer) -> MlneurallstmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmBuffer::copy(self : MlneurallstmBuffer) -> MlneurallstmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmBuffer::fill(self : MlneurallstmBuffer, v : Double) -> MlneurallstmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmBuffer::min(self : MlneurallstmBuffer) -> Double { @_common.min(self.data) }

pub fn MlneurallstmBuffer::max(self : MlneurallstmBuffer) -> Double { @_common.max(self.data) }

pub fn MlneurallstmBuffer::to_string(self : MlneurallstmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_cursor_make(size : Int) -> MlneurallstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmCursor::len(self : MlneurallstmCursor) -> Int { self.size }

pub fn MlneurallstmCursor::get(self : MlneurallstmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmCursor::set(self : MlneurallstmCursor, i : Int, v : Double) -> MlneurallstmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmCursor::sum(self : MlneurallstmCursor) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmCursor::mean(self : MlneurallstmCursor) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmCursor::scale(self : MlneurallstmCursor, f : Double) -> MlneurallstmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmCursor::add(self : MlneurallstmCursor, other : MlneurallstmCursor) -> MlneurallstmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmCursor::copy(self : MlneurallstmCursor) -> MlneurallstmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmCursor::fill(self : MlneurallstmCursor, v : Double) -> MlneurallstmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmCursor::min(self : MlneurallstmCursor) -> Double { @_common.min(self.data) }

pub fn MlneurallstmCursor::max(self : MlneurallstmCursor) -> Double { @_common.max(self.data) }

pub fn MlneurallstmCursor::to_string(self : MlneurallstmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_view_make(size : Int) -> MlneurallstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmView::len(self : MlneurallstmView) -> Int { self.size }

pub fn MlneurallstmView::get(self : MlneurallstmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmView::set(self : MlneurallstmView, i : Int, v : Double) -> MlneurallstmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmView::sum(self : MlneurallstmView) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmView::mean(self : MlneurallstmView) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmView::scale(self : MlneurallstmView, f : Double) -> MlneurallstmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmView::add(self : MlneurallstmView, other : MlneurallstmView) -> MlneurallstmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmView::copy(self : MlneurallstmView) -> MlneurallstmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmView::fill(self : MlneurallstmView, v : Double) -> MlneurallstmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmView::min(self : MlneurallstmView) -> Double { @_common.min(self.data) }

pub fn MlneurallstmView::max(self : MlneurallstmView) -> Double { @_common.max(self.data) }

pub fn MlneurallstmView::to_string(self : MlneurallstmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_range_make(size : Int) -> MlneurallstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmRange::len(self : MlneurallstmRange) -> Int { self.size }

pub fn MlneurallstmRange::get(self : MlneurallstmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmRange::set(self : MlneurallstmRange, i : Int, v : Double) -> MlneurallstmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmRange::sum(self : MlneurallstmRange) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmRange::mean(self : MlneurallstmRange) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmRange::scale(self : MlneurallstmRange, f : Double) -> MlneurallstmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmRange::add(self : MlneurallstmRange, other : MlneurallstmRange) -> MlneurallstmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmRange::copy(self : MlneurallstmRange) -> MlneurallstmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmRange::fill(self : MlneurallstmRange, v : Double) -> MlneurallstmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmRange::min(self : MlneurallstmRange) -> Double { @_common.min(self.data) }

pub fn MlneurallstmRange::max(self : MlneurallstmRange) -> Double { @_common.max(self.data) }

pub fn MlneurallstmRange::to_string(self : MlneurallstmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneurallstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_slice_make(size : Int) -> MlneurallstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneurallstmSlice::len(self : MlneurallstmSlice) -> Int { self.size }

pub fn MlneurallstmSlice::get(self : MlneurallstmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneurallstmSlice::set(self : MlneurallstmSlice, i : Int, v : Double) -> MlneurallstmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneurallstmSlice::sum(self : MlneurallstmSlice) -> Double { @_common.sum(self.data) }

pub fn MlneurallstmSlice::mean(self : MlneurallstmSlice) -> Double { @_common.mean(self.data) }

pub fn MlneurallstmSlice::scale(self : MlneurallstmSlice, f : Double) -> MlneurallstmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneurallstmSlice::add(self : MlneurallstmSlice, other : MlneurallstmSlice) -> MlneurallstmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneurallstmSlice::copy(self : MlneurallstmSlice) -> MlneurallstmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneurallstmSlice::fill(self : MlneurallstmSlice, v : Double) -> MlneurallstmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneurallstmSlice::min(self : MlneurallstmSlice) -> Double { @_common.min(self.data) }

pub fn MlneurallstmSlice::max(self : MlneurallstmSlice) -> Double { @_common.max(self.data) }

pub fn MlneurallstmSlice::to_string(self : MlneurallstmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

