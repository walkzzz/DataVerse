///===
/// extcore/ml_neural_gru

pub(all) struct MlneuralgruPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_gru_make_point(x : Double, y : Double) -> MlneuralgruPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_gru_make_point3(x : Double, y : Double, z : Double) -> MlneuralgruPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralgruPoint::x(self : MlneuralgruPoint) -> Double { self.x }

pub fn MlneuralgruPoint::y(self : MlneuralgruPoint) -> Double { self.y }

pub fn MlneuralgruPoint::z(self : MlneuralgruPoint) -> Double { self.z }

pub fn MlneuralgruPoint::label(self : MlneuralgruPoint) -> Int { self.label }

pub fn MlneuralgruPoint::dist(self : MlneuralgruPoint, other : MlneuralgruPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralgruPoint::add(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralgruPoint::sub(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralgruPoint::scale(self : MlneuralgruPoint, s : Double) -> MlneuralgruPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralgruPoint::dot(self : MlneuralgruPoint, other : MlneuralgruPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralgruPoint::cross(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralgruPoint::norm(self : MlneuralgruPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralgruPoint::normalize(self : MlneuralgruPoint) -> MlneuralgruPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralgruPoint::negate(self : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralgruPoint::mid(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralgruPoint::lerp(self : MlneuralgruPoint, other : MlneuralgruPoint, t : Double) -> MlneuralgruPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralgruPoint::to_string(self : MlneuralgruPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralgruSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_gru_make_series(vals : Array[Double], name : String) -> MlneuralgruSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralgruSeries::len(self : MlneuralgruSeries) -> Int { self.vals.length() }

pub fn MlneuralgruSeries::sum(self : MlneuralgruSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralgruSeries::mean(self : MlneuralgruSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralgruSeries::min(self : MlneuralgruSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralgruSeries::max(self : MlneuralgruSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralgruSeries::range(self : MlneuralgruSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralgruSeries::variance(self : MlneuralgruSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralgruSeries::std(self : MlneuralgruSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralgruSeries::median(self : MlneuralgruSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralgruSeries::scale(self : MlneuralgruSeries, f : Double) -> MlneuralgruSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralgruSeries::add(self : MlneuralgruSeries, other : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralgruSeries::sub(self : MlneuralgruSeries, other : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralgruSeries::normalize(self : MlneuralgruSeries) -> MlneuralgruSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralgruSeries::cumsum(self : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralgruSeries::to_string(self : MlneuralgruSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralgruMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_gru_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralgruMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_neural_gru_matrix_identity(n : Int) -> MlneuralgruMatrix {
  let m = ml_neural_gru_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralgruMatrix::get(self : MlneuralgruMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralgruMatrix::transpose(self : MlneuralgruMatrix) -> MlneuralgruMatrix {
  let result = ml_neural_gru_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralgruMatrix::add(self : MlneuralgruMatrix, other : MlneuralgruMatrix) -> MlneuralgruMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_gru_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralgruMatrix::scale(self : MlneuralgruMatrix, s : Double) -> MlneuralgruMatrix {
  let result = ml_neural_gru_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralgruMatrix::multiply(self : MlneuralgruMatrix, other : MlneuralgruMatrix) -> MlneuralgruMatrix {
  if self.cols != other.rows { return ml_neural_gru_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_gru_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlneuralgruMatrix::trace(self : MlneuralgruMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralgruMatrix::det(self : MlneuralgruMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralgruMatrix::norm(self : MlneuralgruMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralgruMatrix::to_string(self : MlneuralgruMatrix) -> String {
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

pub(all) struct MlneuralgruVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_gru_make_vector(comps : Array[Double]) -> MlneuralgruVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_gru_vector_zero(dim : Int) -> MlneuralgruVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralgruVector::add(self : MlneuralgruVector, other : MlneuralgruVector) -> MlneuralgruVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralgruVector::sub(self : MlneuralgruVector, other : MlneuralgruVector) -> MlneuralgruVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralgruVector::scale(self : MlneuralgruVector, s : Double) -> MlneuralgruVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralgruVector::dot(self : MlneuralgruVector, other : MlneuralgruVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralgruVector::norm(self : MlneuralgruVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralgruVector::normalize(self : MlneuralgruVector) -> MlneuralgruVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralgruVector::dist(self : MlneuralgruVector, other : MlneuralgruVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralgruVector::to_string(self : MlneuralgruVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralgruFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_frame_make(size : Int) -> MlneuralgruFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruFrame::len(self : MlneuralgruFrame) -> Int { self.size }

pub fn MlneuralgruFrame::get(self : MlneuralgruFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruFrame::set(self : MlneuralgruFrame, i : Int, v : Double) -> MlneuralgruFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruFrame::sum(self : MlneuralgruFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruFrame::mean(self : MlneuralgruFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruFrame::scale(self : MlneuralgruFrame, f : Double) -> MlneuralgruFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruFrame::add(self : MlneuralgruFrame, other : MlneuralgruFrame) -> MlneuralgruFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruFrame::copy(self : MlneuralgruFrame) -> MlneuralgruFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruFrame::fill(self : MlneuralgruFrame, v : Double) -> MlneuralgruFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruFrame::min(self : MlneuralgruFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralgruFrame::max(self : MlneuralgruFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralgruFrame::to_string(self : MlneuralgruFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_table_make(size : Int) -> MlneuralgruTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruTable::len(self : MlneuralgruTable) -> Int { self.size }

pub fn MlneuralgruTable::get(self : MlneuralgruTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruTable::set(self : MlneuralgruTable, i : Int, v : Double) -> MlneuralgruTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruTable::sum(self : MlneuralgruTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruTable::mean(self : MlneuralgruTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruTable::scale(self : MlneuralgruTable, f : Double) -> MlneuralgruTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruTable::add(self : MlneuralgruTable, other : MlneuralgruTable) -> MlneuralgruTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruTable::copy(self : MlneuralgruTable) -> MlneuralgruTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruTable::fill(self : MlneuralgruTable, v : Double) -> MlneuralgruTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruTable::min(self : MlneuralgruTable) -> Double { @_common.min(self.data) }

pub fn MlneuralgruTable::max(self : MlneuralgruTable) -> Double { @_common.max(self.data) }

pub fn MlneuralgruTable::to_string(self : MlneuralgruTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_graphn_make(size : Int) -> MlneuralgruGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruGraphN::len(self : MlneuralgruGraphN) -> Int { self.size }

pub fn MlneuralgruGraphN::get(self : MlneuralgruGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruGraphN::set(self : MlneuralgruGraphN, i : Int, v : Double) -> MlneuralgruGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruGraphN::sum(self : MlneuralgruGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruGraphN::mean(self : MlneuralgruGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruGraphN::scale(self : MlneuralgruGraphN, f : Double) -> MlneuralgruGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruGraphN::add(self : MlneuralgruGraphN, other : MlneuralgruGraphN) -> MlneuralgruGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruGraphN::copy(self : MlneuralgruGraphN) -> MlneuralgruGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruGraphN::fill(self : MlneuralgruGraphN, v : Double) -> MlneuralgruGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruGraphN::min(self : MlneuralgruGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralgruGraphN::max(self : MlneuralgruGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralgruGraphN::to_string(self : MlneuralgruGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_node_make(size : Int) -> MlneuralgruNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruNode::len(self : MlneuralgruNode) -> Int { self.size }

pub fn MlneuralgruNode::get(self : MlneuralgruNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruNode::set(self : MlneuralgruNode, i : Int, v : Double) -> MlneuralgruNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruNode::sum(self : MlneuralgruNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruNode::mean(self : MlneuralgruNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruNode::scale(self : MlneuralgruNode, f : Double) -> MlneuralgruNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruNode::add(self : MlneuralgruNode, other : MlneuralgruNode) -> MlneuralgruNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruNode::copy(self : MlneuralgruNode) -> MlneuralgruNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruNode::fill(self : MlneuralgruNode, v : Double) -> MlneuralgruNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruNode::min(self : MlneuralgruNode) -> Double { @_common.min(self.data) }

pub fn MlneuralgruNode::max(self : MlneuralgruNode) -> Double { @_common.max(self.data) }

pub fn MlneuralgruNode::to_string(self : MlneuralgruNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_edge_make(size : Int) -> MlneuralgruEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruEdge::len(self : MlneuralgruEdge) -> Int { self.size }

pub fn MlneuralgruEdge::get(self : MlneuralgruEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruEdge::set(self : MlneuralgruEdge, i : Int, v : Double) -> MlneuralgruEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruEdge::sum(self : MlneuralgruEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruEdge::mean(self : MlneuralgruEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruEdge::scale(self : MlneuralgruEdge, f : Double) -> MlneuralgruEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruEdge::add(self : MlneuralgruEdge, other : MlneuralgruEdge) -> MlneuralgruEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruEdge::copy(self : MlneuralgruEdge) -> MlneuralgruEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruEdge::fill(self : MlneuralgruEdge, v : Double) -> MlneuralgruEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruEdge::min(self : MlneuralgruEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralgruEdge::max(self : MlneuralgruEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralgruEdge::to_string(self : MlneuralgruEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_path_make(size : Int) -> MlneuralgruPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruPath::len(self : MlneuralgruPath) -> Int { self.size }

pub fn MlneuralgruPath::get(self : MlneuralgruPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruPath::set(self : MlneuralgruPath, i : Int, v : Double) -> MlneuralgruPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruPath::sum(self : MlneuralgruPath) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruPath::mean(self : MlneuralgruPath) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruPath::scale(self : MlneuralgruPath, f : Double) -> MlneuralgruPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruPath::add(self : MlneuralgruPath, other : MlneuralgruPath) -> MlneuralgruPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruPath::copy(self : MlneuralgruPath) -> MlneuralgruPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruPath::fill(self : MlneuralgruPath, v : Double) -> MlneuralgruPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruPath::min(self : MlneuralgruPath) -> Double { @_common.min(self.data) }

pub fn MlneuralgruPath::max(self : MlneuralgruPath) -> Double { @_common.max(self.data) }

pub fn MlneuralgruPath::to_string(self : MlneuralgruPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_cluster_make(size : Int) -> MlneuralgruCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruCluster::len(self : MlneuralgruCluster) -> Int { self.size }

pub fn MlneuralgruCluster::get(self : MlneuralgruCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruCluster::set(self : MlneuralgruCluster, i : Int, v : Double) -> MlneuralgruCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruCluster::sum(self : MlneuralgruCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruCluster::mean(self : MlneuralgruCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruCluster::scale(self : MlneuralgruCluster, f : Double) -> MlneuralgruCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruCluster::add(self : MlneuralgruCluster, other : MlneuralgruCluster) -> MlneuralgruCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruCluster::copy(self : MlneuralgruCluster) -> MlneuralgruCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruCluster::fill(self : MlneuralgruCluster, v : Double) -> MlneuralgruCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruCluster::min(self : MlneuralgruCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralgruCluster::max(self : MlneuralgruCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralgruCluster::to_string(self : MlneuralgruCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_model_make(size : Int) -> MlneuralgruModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruModel::len(self : MlneuralgruModel) -> Int { self.size }

pub fn MlneuralgruModel::get(self : MlneuralgruModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruModel::set(self : MlneuralgruModel, i : Int, v : Double) -> MlneuralgruModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruModel::sum(self : MlneuralgruModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruModel::mean(self : MlneuralgruModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruModel::scale(self : MlneuralgruModel, f : Double) -> MlneuralgruModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruModel::add(self : MlneuralgruModel, other : MlneuralgruModel) -> MlneuralgruModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruModel::copy(self : MlneuralgruModel) -> MlneuralgruModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruModel::fill(self : MlneuralgruModel, v : Double) -> MlneuralgruModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruModel::min(self : MlneuralgruModel) -> Double { @_common.min(self.data) }

pub fn MlneuralgruModel::max(self : MlneuralgruModel) -> Double { @_common.max(self.data) }

pub fn MlneuralgruModel::to_string(self : MlneuralgruModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_layer_make(size : Int) -> MlneuralgruLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruLayer::len(self : MlneuralgruLayer) -> Int { self.size }

pub fn MlneuralgruLayer::get(self : MlneuralgruLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruLayer::set(self : MlneuralgruLayer, i : Int, v : Double) -> MlneuralgruLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruLayer::sum(self : MlneuralgruLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruLayer::mean(self : MlneuralgruLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruLayer::scale(self : MlneuralgruLayer, f : Double) -> MlneuralgruLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruLayer::add(self : MlneuralgruLayer, other : MlneuralgruLayer) -> MlneuralgruLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruLayer::copy(self : MlneuralgruLayer) -> MlneuralgruLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruLayer::fill(self : MlneuralgruLayer, v : Double) -> MlneuralgruLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruLayer::min(self : MlneuralgruLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralgruLayer::max(self : MlneuralgruLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralgruLayer::to_string(self : MlneuralgruLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_buffer_make(size : Int) -> MlneuralgruBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruBuffer::len(self : MlneuralgruBuffer) -> Int { self.size }

pub fn MlneuralgruBuffer::get(self : MlneuralgruBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruBuffer::set(self : MlneuralgruBuffer, i : Int, v : Double) -> MlneuralgruBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruBuffer::sum(self : MlneuralgruBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruBuffer::mean(self : MlneuralgruBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruBuffer::scale(self : MlneuralgruBuffer, f : Double) -> MlneuralgruBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruBuffer::add(self : MlneuralgruBuffer, other : MlneuralgruBuffer) -> MlneuralgruBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruBuffer::copy(self : MlneuralgruBuffer) -> MlneuralgruBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruBuffer::fill(self : MlneuralgruBuffer, v : Double) -> MlneuralgruBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruBuffer::min(self : MlneuralgruBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralgruBuffer::max(self : MlneuralgruBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralgruBuffer::to_string(self : MlneuralgruBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_cursor_make(size : Int) -> MlneuralgruCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruCursor::len(self : MlneuralgruCursor) -> Int { self.size }

pub fn MlneuralgruCursor::get(self : MlneuralgruCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruCursor::set(self : MlneuralgruCursor, i : Int, v : Double) -> MlneuralgruCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruCursor::sum(self : MlneuralgruCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruCursor::mean(self : MlneuralgruCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruCursor::scale(self : MlneuralgruCursor, f : Double) -> MlneuralgruCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruCursor::add(self : MlneuralgruCursor, other : MlneuralgruCursor) -> MlneuralgruCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruCursor::copy(self : MlneuralgruCursor) -> MlneuralgruCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruCursor::fill(self : MlneuralgruCursor, v : Double) -> MlneuralgruCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruCursor::min(self : MlneuralgruCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralgruCursor::max(self : MlneuralgruCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralgruCursor::to_string(self : MlneuralgruCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_view_make(size : Int) -> MlneuralgruView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruView::len(self : MlneuralgruView) -> Int { self.size }

pub fn MlneuralgruView::get(self : MlneuralgruView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruView::set(self : MlneuralgruView, i : Int, v : Double) -> MlneuralgruView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruView::sum(self : MlneuralgruView) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruView::mean(self : MlneuralgruView) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruView::scale(self : MlneuralgruView, f : Double) -> MlneuralgruView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruView::add(self : MlneuralgruView, other : MlneuralgruView) -> MlneuralgruView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruView::copy(self : MlneuralgruView) -> MlneuralgruView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruView::fill(self : MlneuralgruView, v : Double) -> MlneuralgruView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruView::min(self : MlneuralgruView) -> Double { @_common.min(self.data) }

pub fn MlneuralgruView::max(self : MlneuralgruView) -> Double { @_common.max(self.data) }

pub fn MlneuralgruView::to_string(self : MlneuralgruView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_range_make(size : Int) -> MlneuralgruRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruRange::len(self : MlneuralgruRange) -> Int { self.size }

pub fn MlneuralgruRange::get(self : MlneuralgruRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruRange::set(self : MlneuralgruRange, i : Int, v : Double) -> MlneuralgruRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruRange::sum(self : MlneuralgruRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruRange::mean(self : MlneuralgruRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruRange::scale(self : MlneuralgruRange, f : Double) -> MlneuralgruRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruRange::add(self : MlneuralgruRange, other : MlneuralgruRange) -> MlneuralgruRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruRange::copy(self : MlneuralgruRange) -> MlneuralgruRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruRange::fill(self : MlneuralgruRange, v : Double) -> MlneuralgruRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruRange::min(self : MlneuralgruRange) -> Double { @_common.min(self.data) }

pub fn MlneuralgruRange::max(self : MlneuralgruRange) -> Double { @_common.max(self.data) }

pub fn MlneuralgruRange::to_string(self : MlneuralgruRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralgruSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_slice_make(size : Int) -> MlneuralgruSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralgruSlice::len(self : MlneuralgruSlice) -> Int { self.size }

pub fn MlneuralgruSlice::get(self : MlneuralgruSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralgruSlice::set(self : MlneuralgruSlice, i : Int, v : Double) -> MlneuralgruSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralgruSlice::sum(self : MlneuralgruSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralgruSlice::mean(self : MlneuralgruSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralgruSlice::scale(self : MlneuralgruSlice, f : Double) -> MlneuralgruSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralgruSlice::add(self : MlneuralgruSlice, other : MlneuralgruSlice) -> MlneuralgruSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralgruSlice::copy(self : MlneuralgruSlice) -> MlneuralgruSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralgruSlice::fill(self : MlneuralgruSlice, v : Double) -> MlneuralgruSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralgruSlice::min(self : MlneuralgruSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralgruSlice::max(self : MlneuralgruSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralgruSlice::to_string(self : MlneuralgruSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

