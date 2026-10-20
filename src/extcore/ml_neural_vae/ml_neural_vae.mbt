///===
/// extcore/ml_neural_vae

pub(all) struct MlneuralvaePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_vae_make_point(x : Double, y : Double) -> MlneuralvaePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_vae_make_point3(x : Double, y : Double, z : Double) -> MlneuralvaePoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralvaePoint::x(self : MlneuralvaePoint) -> Double { self.x }

pub fn MlneuralvaePoint::y(self : MlneuralvaePoint) -> Double { self.y }

pub fn MlneuralvaePoint::z(self : MlneuralvaePoint) -> Double { self.z }

pub fn MlneuralvaePoint::label(self : MlneuralvaePoint) -> Int { self.label }

pub fn MlneuralvaePoint::dist(self : MlneuralvaePoint, other : MlneuralvaePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralvaePoint::add(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralvaePoint::sub(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralvaePoint::scale(self : MlneuralvaePoint, s : Double) -> MlneuralvaePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralvaePoint::dot(self : MlneuralvaePoint, other : MlneuralvaePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralvaePoint::cross(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralvaePoint::norm(self : MlneuralvaePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralvaePoint::normalize(self : MlneuralvaePoint) -> MlneuralvaePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralvaePoint::negate(self : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralvaePoint::mid(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralvaePoint::lerp(self : MlneuralvaePoint, other : MlneuralvaePoint, t : Double) -> MlneuralvaePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralvaePoint::to_string(self : MlneuralvaePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralvaeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_vae_make_series(vals : Array[Double], name : String) -> MlneuralvaeSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralvaeSeries::len(self : MlneuralvaeSeries) -> Int { self.vals.length() }

pub fn MlneuralvaeSeries::sum(self : MlneuralvaeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralvaeSeries::mean(self : MlneuralvaeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralvaeSeries::min(self : MlneuralvaeSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralvaeSeries::max(self : MlneuralvaeSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralvaeSeries::range(self : MlneuralvaeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralvaeSeries::variance(self : MlneuralvaeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralvaeSeries::std(self : MlneuralvaeSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralvaeSeries::median(self : MlneuralvaeSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralvaeSeries::scale(self : MlneuralvaeSeries, f : Double) -> MlneuralvaeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralvaeSeries::add(self : MlneuralvaeSeries, other : MlneuralvaeSeries) -> MlneuralvaeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralvaeSeries::sub(self : MlneuralvaeSeries, other : MlneuralvaeSeries) -> MlneuralvaeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralvaeSeries::normalize(self : MlneuralvaeSeries) -> MlneuralvaeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralvaeSeries::cumsum(self : MlneuralvaeSeries) -> MlneuralvaeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralvaeSeries::to_string(self : MlneuralvaeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralvaeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_vae_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralvaeMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_neural_vae_matrix_identity(n : Int) -> MlneuralvaeMatrix {
  let m = ml_neural_vae_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralvaeMatrix::get(self : MlneuralvaeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralvaeMatrix::transpose(self : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  let result = ml_neural_vae_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralvaeMatrix::add(self : MlneuralvaeMatrix, other : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_vae_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralvaeMatrix::scale(self : MlneuralvaeMatrix, s : Double) -> MlneuralvaeMatrix {
  let result = ml_neural_vae_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralvaeMatrix::multiply(self : MlneuralvaeMatrix, other : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  if self.cols != other.rows { return ml_neural_vae_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_vae_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlneuralvaeMatrix::trace(self : MlneuralvaeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralvaeMatrix::det(self : MlneuralvaeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralvaeMatrix::norm(self : MlneuralvaeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralvaeMatrix::to_string(self : MlneuralvaeMatrix) -> String {
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

pub(all) struct MlneuralvaeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_vae_make_vector(comps : Array[Double]) -> MlneuralvaeVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_vae_vector_zero(dim : Int) -> MlneuralvaeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralvaeVector::add(self : MlneuralvaeVector, other : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralvaeVector::sub(self : MlneuralvaeVector, other : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralvaeVector::scale(self : MlneuralvaeVector, s : Double) -> MlneuralvaeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralvaeVector::dot(self : MlneuralvaeVector, other : MlneuralvaeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralvaeVector::norm(self : MlneuralvaeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralvaeVector::normalize(self : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralvaeVector::dist(self : MlneuralvaeVector, other : MlneuralvaeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralvaeVector::to_string(self : MlneuralvaeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralvaeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_frame_make(size : Int) -> MlneuralvaeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeFrame::len(self : MlneuralvaeFrame) -> Int { self.size }

pub fn MlneuralvaeFrame::get(self : MlneuralvaeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeFrame::set(self : MlneuralvaeFrame, i : Int, v : Double) -> MlneuralvaeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeFrame::sum(self : MlneuralvaeFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeFrame::mean(self : MlneuralvaeFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeFrame::scale(self : MlneuralvaeFrame, f : Double) -> MlneuralvaeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeFrame::add(self : MlneuralvaeFrame, other : MlneuralvaeFrame) -> MlneuralvaeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeFrame::copy(self : MlneuralvaeFrame) -> MlneuralvaeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeFrame::fill(self : MlneuralvaeFrame, v : Double) -> MlneuralvaeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeFrame::min(self : MlneuralvaeFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeFrame::max(self : MlneuralvaeFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeFrame::to_string(self : MlneuralvaeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_table_make(size : Int) -> MlneuralvaeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeTable::len(self : MlneuralvaeTable) -> Int { self.size }

pub fn MlneuralvaeTable::get(self : MlneuralvaeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeTable::set(self : MlneuralvaeTable, i : Int, v : Double) -> MlneuralvaeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeTable::sum(self : MlneuralvaeTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeTable::mean(self : MlneuralvaeTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeTable::scale(self : MlneuralvaeTable, f : Double) -> MlneuralvaeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeTable::add(self : MlneuralvaeTable, other : MlneuralvaeTable) -> MlneuralvaeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeTable::copy(self : MlneuralvaeTable) -> MlneuralvaeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeTable::fill(self : MlneuralvaeTable, v : Double) -> MlneuralvaeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeTable::min(self : MlneuralvaeTable) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeTable::max(self : MlneuralvaeTable) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeTable::to_string(self : MlneuralvaeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_graphn_make(size : Int) -> MlneuralvaeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeGraphN::len(self : MlneuralvaeGraphN) -> Int { self.size }

pub fn MlneuralvaeGraphN::get(self : MlneuralvaeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeGraphN::set(self : MlneuralvaeGraphN, i : Int, v : Double) -> MlneuralvaeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeGraphN::sum(self : MlneuralvaeGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeGraphN::mean(self : MlneuralvaeGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeGraphN::scale(self : MlneuralvaeGraphN, f : Double) -> MlneuralvaeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeGraphN::add(self : MlneuralvaeGraphN, other : MlneuralvaeGraphN) -> MlneuralvaeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeGraphN::copy(self : MlneuralvaeGraphN) -> MlneuralvaeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeGraphN::fill(self : MlneuralvaeGraphN, v : Double) -> MlneuralvaeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeGraphN::min(self : MlneuralvaeGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeGraphN::max(self : MlneuralvaeGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeGraphN::to_string(self : MlneuralvaeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_node_make(size : Int) -> MlneuralvaeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeNode::len(self : MlneuralvaeNode) -> Int { self.size }

pub fn MlneuralvaeNode::get(self : MlneuralvaeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeNode::set(self : MlneuralvaeNode, i : Int, v : Double) -> MlneuralvaeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeNode::sum(self : MlneuralvaeNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeNode::mean(self : MlneuralvaeNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeNode::scale(self : MlneuralvaeNode, f : Double) -> MlneuralvaeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeNode::add(self : MlneuralvaeNode, other : MlneuralvaeNode) -> MlneuralvaeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeNode::copy(self : MlneuralvaeNode) -> MlneuralvaeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeNode::fill(self : MlneuralvaeNode, v : Double) -> MlneuralvaeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeNode::min(self : MlneuralvaeNode) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeNode::max(self : MlneuralvaeNode) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeNode::to_string(self : MlneuralvaeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_edge_make(size : Int) -> MlneuralvaeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeEdge::len(self : MlneuralvaeEdge) -> Int { self.size }

pub fn MlneuralvaeEdge::get(self : MlneuralvaeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeEdge::set(self : MlneuralvaeEdge, i : Int, v : Double) -> MlneuralvaeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeEdge::sum(self : MlneuralvaeEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeEdge::mean(self : MlneuralvaeEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeEdge::scale(self : MlneuralvaeEdge, f : Double) -> MlneuralvaeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeEdge::add(self : MlneuralvaeEdge, other : MlneuralvaeEdge) -> MlneuralvaeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeEdge::copy(self : MlneuralvaeEdge) -> MlneuralvaeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeEdge::fill(self : MlneuralvaeEdge, v : Double) -> MlneuralvaeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeEdge::min(self : MlneuralvaeEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeEdge::max(self : MlneuralvaeEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeEdge::to_string(self : MlneuralvaeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_path_make(size : Int) -> MlneuralvaePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaePath::len(self : MlneuralvaePath) -> Int { self.size }

pub fn MlneuralvaePath::get(self : MlneuralvaePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaePath::set(self : MlneuralvaePath, i : Int, v : Double) -> MlneuralvaePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaePath::sum(self : MlneuralvaePath) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaePath::mean(self : MlneuralvaePath) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaePath::scale(self : MlneuralvaePath, f : Double) -> MlneuralvaePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaePath::add(self : MlneuralvaePath, other : MlneuralvaePath) -> MlneuralvaePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaePath::copy(self : MlneuralvaePath) -> MlneuralvaePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaePath::fill(self : MlneuralvaePath, v : Double) -> MlneuralvaePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaePath::min(self : MlneuralvaePath) -> Double { @_common.min(self.data) }

pub fn MlneuralvaePath::max(self : MlneuralvaePath) -> Double { @_common.max(self.data) }

pub fn MlneuralvaePath::to_string(self : MlneuralvaePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_cluster_make(size : Int) -> MlneuralvaeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeCluster::len(self : MlneuralvaeCluster) -> Int { self.size }

pub fn MlneuralvaeCluster::get(self : MlneuralvaeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeCluster::set(self : MlneuralvaeCluster, i : Int, v : Double) -> MlneuralvaeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCluster::sum(self : MlneuralvaeCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeCluster::mean(self : MlneuralvaeCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeCluster::scale(self : MlneuralvaeCluster, f : Double) -> MlneuralvaeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCluster::add(self : MlneuralvaeCluster, other : MlneuralvaeCluster) -> MlneuralvaeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeCluster::copy(self : MlneuralvaeCluster) -> MlneuralvaeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCluster::fill(self : MlneuralvaeCluster, v : Double) -> MlneuralvaeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCluster::min(self : MlneuralvaeCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeCluster::max(self : MlneuralvaeCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeCluster::to_string(self : MlneuralvaeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_model_make(size : Int) -> MlneuralvaeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeModel::len(self : MlneuralvaeModel) -> Int { self.size }

pub fn MlneuralvaeModel::get(self : MlneuralvaeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeModel::set(self : MlneuralvaeModel, i : Int, v : Double) -> MlneuralvaeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeModel::sum(self : MlneuralvaeModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeModel::mean(self : MlneuralvaeModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeModel::scale(self : MlneuralvaeModel, f : Double) -> MlneuralvaeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeModel::add(self : MlneuralvaeModel, other : MlneuralvaeModel) -> MlneuralvaeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeModel::copy(self : MlneuralvaeModel) -> MlneuralvaeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeModel::fill(self : MlneuralvaeModel, v : Double) -> MlneuralvaeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeModel::min(self : MlneuralvaeModel) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeModel::max(self : MlneuralvaeModel) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeModel::to_string(self : MlneuralvaeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_layer_make(size : Int) -> MlneuralvaeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeLayer::len(self : MlneuralvaeLayer) -> Int { self.size }

pub fn MlneuralvaeLayer::get(self : MlneuralvaeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeLayer::set(self : MlneuralvaeLayer, i : Int, v : Double) -> MlneuralvaeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeLayer::sum(self : MlneuralvaeLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeLayer::mean(self : MlneuralvaeLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeLayer::scale(self : MlneuralvaeLayer, f : Double) -> MlneuralvaeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeLayer::add(self : MlneuralvaeLayer, other : MlneuralvaeLayer) -> MlneuralvaeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeLayer::copy(self : MlneuralvaeLayer) -> MlneuralvaeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeLayer::fill(self : MlneuralvaeLayer, v : Double) -> MlneuralvaeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeLayer::min(self : MlneuralvaeLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeLayer::max(self : MlneuralvaeLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeLayer::to_string(self : MlneuralvaeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_buffer_make(size : Int) -> MlneuralvaeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeBuffer::len(self : MlneuralvaeBuffer) -> Int { self.size }

pub fn MlneuralvaeBuffer::get(self : MlneuralvaeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeBuffer::set(self : MlneuralvaeBuffer, i : Int, v : Double) -> MlneuralvaeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeBuffer::sum(self : MlneuralvaeBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeBuffer::mean(self : MlneuralvaeBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeBuffer::scale(self : MlneuralvaeBuffer, f : Double) -> MlneuralvaeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeBuffer::add(self : MlneuralvaeBuffer, other : MlneuralvaeBuffer) -> MlneuralvaeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeBuffer::copy(self : MlneuralvaeBuffer) -> MlneuralvaeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeBuffer::fill(self : MlneuralvaeBuffer, v : Double) -> MlneuralvaeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeBuffer::min(self : MlneuralvaeBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeBuffer::max(self : MlneuralvaeBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeBuffer::to_string(self : MlneuralvaeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_cursor_make(size : Int) -> MlneuralvaeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeCursor::len(self : MlneuralvaeCursor) -> Int { self.size }

pub fn MlneuralvaeCursor::get(self : MlneuralvaeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeCursor::set(self : MlneuralvaeCursor, i : Int, v : Double) -> MlneuralvaeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCursor::sum(self : MlneuralvaeCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeCursor::mean(self : MlneuralvaeCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeCursor::scale(self : MlneuralvaeCursor, f : Double) -> MlneuralvaeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCursor::add(self : MlneuralvaeCursor, other : MlneuralvaeCursor) -> MlneuralvaeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeCursor::copy(self : MlneuralvaeCursor) -> MlneuralvaeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCursor::fill(self : MlneuralvaeCursor, v : Double) -> MlneuralvaeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeCursor::min(self : MlneuralvaeCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeCursor::max(self : MlneuralvaeCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeCursor::to_string(self : MlneuralvaeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_view_make(size : Int) -> MlneuralvaeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeView::len(self : MlneuralvaeView) -> Int { self.size }

pub fn MlneuralvaeView::get(self : MlneuralvaeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeView::set(self : MlneuralvaeView, i : Int, v : Double) -> MlneuralvaeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeView::sum(self : MlneuralvaeView) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeView::mean(self : MlneuralvaeView) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeView::scale(self : MlneuralvaeView, f : Double) -> MlneuralvaeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeView::add(self : MlneuralvaeView, other : MlneuralvaeView) -> MlneuralvaeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeView::copy(self : MlneuralvaeView) -> MlneuralvaeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeView::fill(self : MlneuralvaeView, v : Double) -> MlneuralvaeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeView::min(self : MlneuralvaeView) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeView::max(self : MlneuralvaeView) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeView::to_string(self : MlneuralvaeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_range_make(size : Int) -> MlneuralvaeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeRange::len(self : MlneuralvaeRange) -> Int { self.size }

pub fn MlneuralvaeRange::get(self : MlneuralvaeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeRange::set(self : MlneuralvaeRange, i : Int, v : Double) -> MlneuralvaeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeRange::sum(self : MlneuralvaeRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeRange::mean(self : MlneuralvaeRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeRange::scale(self : MlneuralvaeRange, f : Double) -> MlneuralvaeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeRange::add(self : MlneuralvaeRange, other : MlneuralvaeRange) -> MlneuralvaeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeRange::copy(self : MlneuralvaeRange) -> MlneuralvaeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeRange::fill(self : MlneuralvaeRange, v : Double) -> MlneuralvaeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeRange::min(self : MlneuralvaeRange) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeRange::max(self : MlneuralvaeRange) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeRange::to_string(self : MlneuralvaeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_slice_make(size : Int) -> MlneuralvaeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralvaeSlice::len(self : MlneuralvaeSlice) -> Int { self.size }

pub fn MlneuralvaeSlice::get(self : MlneuralvaeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralvaeSlice::set(self : MlneuralvaeSlice, i : Int, v : Double) -> MlneuralvaeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralvaeSlice::sum(self : MlneuralvaeSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralvaeSlice::mean(self : MlneuralvaeSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralvaeSlice::scale(self : MlneuralvaeSlice, f : Double) -> MlneuralvaeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeSlice::add(self : MlneuralvaeSlice, other : MlneuralvaeSlice) -> MlneuralvaeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralvaeSlice::copy(self : MlneuralvaeSlice) -> MlneuralvaeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeSlice::fill(self : MlneuralvaeSlice, v : Double) -> MlneuralvaeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralvaeSlice::min(self : MlneuralvaeSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralvaeSlice::max(self : MlneuralvaeSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralvaeSlice::to_string(self : MlneuralvaeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

