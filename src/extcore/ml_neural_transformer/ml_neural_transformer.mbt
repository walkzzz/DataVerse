///===
/// extcore/ml_neural_transformer

pub(all) struct MlneuraltransformerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_transformer_make_point(x : Double, y : Double) -> MlneuraltransformerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_transformer_make_point3(x : Double, y : Double, z : Double) -> MlneuraltransformerPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuraltransformerPoint::x(self : MlneuraltransformerPoint) -> Double { self.x }

pub fn MlneuraltransformerPoint::y(self : MlneuraltransformerPoint) -> Double { self.y }

pub fn MlneuraltransformerPoint::z(self : MlneuraltransformerPoint) -> Double { self.z }

pub fn MlneuraltransformerPoint::label(self : MlneuraltransformerPoint) -> Int { self.label }

pub fn MlneuraltransformerPoint::dist(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuraltransformerPoint::add(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuraltransformerPoint::sub(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuraltransformerPoint::scale(self : MlneuraltransformerPoint, s : Double) -> MlneuraltransformerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuraltransformerPoint::dot(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuraltransformerPoint::cross(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuraltransformerPoint::norm(self : MlneuraltransformerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuraltransformerPoint::normalize(self : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuraltransformerPoint::negate(self : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuraltransformerPoint::mid(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuraltransformerPoint::lerp(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint, t : Double) -> MlneuraltransformerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuraltransformerPoint::to_string(self : MlneuraltransformerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuraltransformerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_transformer_make_series(vals : Array[Double], name : String) -> MlneuraltransformerSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuraltransformerSeries::len(self : MlneuraltransformerSeries) -> Int { self.vals.length() }

pub fn MlneuraltransformerSeries::sum(self : MlneuraltransformerSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuraltransformerSeries::mean(self : MlneuraltransformerSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuraltransformerSeries::min(self : MlneuraltransformerSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuraltransformerSeries::max(self : MlneuraltransformerSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuraltransformerSeries::range(self : MlneuraltransformerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuraltransformerSeries::variance(self : MlneuraltransformerSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuraltransformerSeries::std(self : MlneuraltransformerSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuraltransformerSeries::median(self : MlneuraltransformerSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuraltransformerSeries::scale(self : MlneuraltransformerSeries, f : Double) -> MlneuraltransformerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuraltransformerSeries::add(self : MlneuraltransformerSeries, other : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuraltransformerSeries::sub(self : MlneuraltransformerSeries, other : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuraltransformerSeries::normalize(self : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuraltransformerSeries::cumsum(self : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuraltransformerSeries::to_string(self : MlneuraltransformerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuraltransformerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_transformer_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuraltransformerMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_neural_transformer_matrix_identity(n : Int) -> MlneuraltransformerMatrix {
  let m = ml_neural_transformer_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuraltransformerMatrix::get(self : MlneuraltransformerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuraltransformerMatrix::transpose(self : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  let result = ml_neural_transformer_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuraltransformerMatrix::add(self : MlneuraltransformerMatrix, other : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuraltransformerMatrix::scale(self : MlneuraltransformerMatrix, s : Double) -> MlneuraltransformerMatrix {
  let result = ml_neural_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuraltransformerMatrix::multiply(self : MlneuraltransformerMatrix, other : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  if self.cols != other.rows { return ml_neural_transformer_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_transformer_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlneuraltransformerMatrix::trace(self : MlneuraltransformerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuraltransformerMatrix::det(self : MlneuraltransformerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuraltransformerMatrix::norm(self : MlneuraltransformerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuraltransformerMatrix::to_string(self : MlneuraltransformerMatrix) -> String {
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

pub(all) struct MlneuraltransformerVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_transformer_make_vector(comps : Array[Double]) -> MlneuraltransformerVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_transformer_vector_zero(dim : Int) -> MlneuraltransformerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuraltransformerVector::add(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuraltransformerVector::sub(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuraltransformerVector::scale(self : MlneuraltransformerVector, s : Double) -> MlneuraltransformerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuraltransformerVector::dot(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuraltransformerVector::norm(self : MlneuraltransformerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuraltransformerVector::normalize(self : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuraltransformerVector::dist(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuraltransformerVector::to_string(self : MlneuraltransformerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuraltransformerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_frame_make(size : Int) -> MlneuraltransformerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerFrame::len(self : MlneuraltransformerFrame) -> Int { self.size }

pub fn MlneuraltransformerFrame::get(self : MlneuraltransformerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerFrame::set(self : MlneuraltransformerFrame, i : Int, v : Double) -> MlneuraltransformerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerFrame::sum(self : MlneuraltransformerFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerFrame::mean(self : MlneuraltransformerFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerFrame::scale(self : MlneuraltransformerFrame, f : Double) -> MlneuraltransformerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerFrame::add(self : MlneuraltransformerFrame, other : MlneuraltransformerFrame) -> MlneuraltransformerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerFrame::copy(self : MlneuraltransformerFrame) -> MlneuraltransformerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerFrame::fill(self : MlneuraltransformerFrame, v : Double) -> MlneuraltransformerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerFrame::min(self : MlneuraltransformerFrame) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerFrame::max(self : MlneuraltransformerFrame) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerFrame::to_string(self : MlneuraltransformerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_table_make(size : Int) -> MlneuraltransformerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerTable::len(self : MlneuraltransformerTable) -> Int { self.size }

pub fn MlneuraltransformerTable::get(self : MlneuraltransformerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerTable::set(self : MlneuraltransformerTable, i : Int, v : Double) -> MlneuraltransformerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerTable::sum(self : MlneuraltransformerTable) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerTable::mean(self : MlneuraltransformerTable) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerTable::scale(self : MlneuraltransformerTable, f : Double) -> MlneuraltransformerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerTable::add(self : MlneuraltransformerTable, other : MlneuraltransformerTable) -> MlneuraltransformerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerTable::copy(self : MlneuraltransformerTable) -> MlneuraltransformerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerTable::fill(self : MlneuraltransformerTable, v : Double) -> MlneuraltransformerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerTable::min(self : MlneuraltransformerTable) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerTable::max(self : MlneuraltransformerTable) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerTable::to_string(self : MlneuraltransformerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_graphn_make(size : Int) -> MlneuraltransformerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerGraphN::len(self : MlneuraltransformerGraphN) -> Int { self.size }

pub fn MlneuraltransformerGraphN::get(self : MlneuraltransformerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerGraphN::set(self : MlneuraltransformerGraphN, i : Int, v : Double) -> MlneuraltransformerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerGraphN::sum(self : MlneuraltransformerGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerGraphN::mean(self : MlneuraltransformerGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerGraphN::scale(self : MlneuraltransformerGraphN, f : Double) -> MlneuraltransformerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerGraphN::add(self : MlneuraltransformerGraphN, other : MlneuraltransformerGraphN) -> MlneuraltransformerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerGraphN::copy(self : MlneuraltransformerGraphN) -> MlneuraltransformerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerGraphN::fill(self : MlneuraltransformerGraphN, v : Double) -> MlneuraltransformerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerGraphN::min(self : MlneuraltransformerGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerGraphN::max(self : MlneuraltransformerGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerGraphN::to_string(self : MlneuraltransformerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_node_make(size : Int) -> MlneuraltransformerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerNode::len(self : MlneuraltransformerNode) -> Int { self.size }

pub fn MlneuraltransformerNode::get(self : MlneuraltransformerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerNode::set(self : MlneuraltransformerNode, i : Int, v : Double) -> MlneuraltransformerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerNode::sum(self : MlneuraltransformerNode) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerNode::mean(self : MlneuraltransformerNode) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerNode::scale(self : MlneuraltransformerNode, f : Double) -> MlneuraltransformerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerNode::add(self : MlneuraltransformerNode, other : MlneuraltransformerNode) -> MlneuraltransformerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerNode::copy(self : MlneuraltransformerNode) -> MlneuraltransformerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerNode::fill(self : MlneuraltransformerNode, v : Double) -> MlneuraltransformerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerNode::min(self : MlneuraltransformerNode) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerNode::max(self : MlneuraltransformerNode) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerNode::to_string(self : MlneuraltransformerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_edge_make(size : Int) -> MlneuraltransformerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerEdge::len(self : MlneuraltransformerEdge) -> Int { self.size }

pub fn MlneuraltransformerEdge::get(self : MlneuraltransformerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerEdge::set(self : MlneuraltransformerEdge, i : Int, v : Double) -> MlneuraltransformerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerEdge::sum(self : MlneuraltransformerEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerEdge::mean(self : MlneuraltransformerEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerEdge::scale(self : MlneuraltransformerEdge, f : Double) -> MlneuraltransformerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerEdge::add(self : MlneuraltransformerEdge, other : MlneuraltransformerEdge) -> MlneuraltransformerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerEdge::copy(self : MlneuraltransformerEdge) -> MlneuraltransformerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerEdge::fill(self : MlneuraltransformerEdge, v : Double) -> MlneuraltransformerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerEdge::min(self : MlneuraltransformerEdge) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerEdge::max(self : MlneuraltransformerEdge) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerEdge::to_string(self : MlneuraltransformerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_path_make(size : Int) -> MlneuraltransformerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerPath::len(self : MlneuraltransformerPath) -> Int { self.size }

pub fn MlneuraltransformerPath::get(self : MlneuraltransformerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerPath::set(self : MlneuraltransformerPath, i : Int, v : Double) -> MlneuraltransformerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerPath::sum(self : MlneuraltransformerPath) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerPath::mean(self : MlneuraltransformerPath) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerPath::scale(self : MlneuraltransformerPath, f : Double) -> MlneuraltransformerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerPath::add(self : MlneuraltransformerPath, other : MlneuraltransformerPath) -> MlneuraltransformerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerPath::copy(self : MlneuraltransformerPath) -> MlneuraltransformerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerPath::fill(self : MlneuraltransformerPath, v : Double) -> MlneuraltransformerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerPath::min(self : MlneuraltransformerPath) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerPath::max(self : MlneuraltransformerPath) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerPath::to_string(self : MlneuraltransformerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_cluster_make(size : Int) -> MlneuraltransformerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerCluster::len(self : MlneuraltransformerCluster) -> Int { self.size }

pub fn MlneuraltransformerCluster::get(self : MlneuraltransformerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerCluster::set(self : MlneuraltransformerCluster, i : Int, v : Double) -> MlneuraltransformerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCluster::sum(self : MlneuraltransformerCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerCluster::mean(self : MlneuraltransformerCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerCluster::scale(self : MlneuraltransformerCluster, f : Double) -> MlneuraltransformerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCluster::add(self : MlneuraltransformerCluster, other : MlneuraltransformerCluster) -> MlneuraltransformerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerCluster::copy(self : MlneuraltransformerCluster) -> MlneuraltransformerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCluster::fill(self : MlneuraltransformerCluster, v : Double) -> MlneuraltransformerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCluster::min(self : MlneuraltransformerCluster) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerCluster::max(self : MlneuraltransformerCluster) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerCluster::to_string(self : MlneuraltransformerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_model_make(size : Int) -> MlneuraltransformerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerModel::len(self : MlneuraltransformerModel) -> Int { self.size }

pub fn MlneuraltransformerModel::get(self : MlneuraltransformerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerModel::set(self : MlneuraltransformerModel, i : Int, v : Double) -> MlneuraltransformerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerModel::sum(self : MlneuraltransformerModel) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerModel::mean(self : MlneuraltransformerModel) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerModel::scale(self : MlneuraltransformerModel, f : Double) -> MlneuraltransformerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerModel::add(self : MlneuraltransformerModel, other : MlneuraltransformerModel) -> MlneuraltransformerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerModel::copy(self : MlneuraltransformerModel) -> MlneuraltransformerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerModel::fill(self : MlneuraltransformerModel, v : Double) -> MlneuraltransformerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerModel::min(self : MlneuraltransformerModel) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerModel::max(self : MlneuraltransformerModel) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerModel::to_string(self : MlneuraltransformerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_layer_make(size : Int) -> MlneuraltransformerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerLayer::len(self : MlneuraltransformerLayer) -> Int { self.size }

pub fn MlneuraltransformerLayer::get(self : MlneuraltransformerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerLayer::set(self : MlneuraltransformerLayer, i : Int, v : Double) -> MlneuraltransformerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerLayer::sum(self : MlneuraltransformerLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerLayer::mean(self : MlneuraltransformerLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerLayer::scale(self : MlneuraltransformerLayer, f : Double) -> MlneuraltransformerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerLayer::add(self : MlneuraltransformerLayer, other : MlneuraltransformerLayer) -> MlneuraltransformerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerLayer::copy(self : MlneuraltransformerLayer) -> MlneuraltransformerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerLayer::fill(self : MlneuraltransformerLayer, v : Double) -> MlneuraltransformerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerLayer::min(self : MlneuraltransformerLayer) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerLayer::max(self : MlneuraltransformerLayer) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerLayer::to_string(self : MlneuraltransformerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_buffer_make(size : Int) -> MlneuraltransformerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerBuffer::len(self : MlneuraltransformerBuffer) -> Int { self.size }

pub fn MlneuraltransformerBuffer::get(self : MlneuraltransformerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerBuffer::set(self : MlneuraltransformerBuffer, i : Int, v : Double) -> MlneuraltransformerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerBuffer::sum(self : MlneuraltransformerBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerBuffer::mean(self : MlneuraltransformerBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerBuffer::scale(self : MlneuraltransformerBuffer, f : Double) -> MlneuraltransformerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerBuffer::add(self : MlneuraltransformerBuffer, other : MlneuraltransformerBuffer) -> MlneuraltransformerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerBuffer::copy(self : MlneuraltransformerBuffer) -> MlneuraltransformerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerBuffer::fill(self : MlneuraltransformerBuffer, v : Double) -> MlneuraltransformerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerBuffer::min(self : MlneuraltransformerBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerBuffer::max(self : MlneuraltransformerBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerBuffer::to_string(self : MlneuraltransformerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_cursor_make(size : Int) -> MlneuraltransformerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerCursor::len(self : MlneuraltransformerCursor) -> Int { self.size }

pub fn MlneuraltransformerCursor::get(self : MlneuraltransformerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerCursor::set(self : MlneuraltransformerCursor, i : Int, v : Double) -> MlneuraltransformerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCursor::sum(self : MlneuraltransformerCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerCursor::mean(self : MlneuraltransformerCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerCursor::scale(self : MlneuraltransformerCursor, f : Double) -> MlneuraltransformerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCursor::add(self : MlneuraltransformerCursor, other : MlneuraltransformerCursor) -> MlneuraltransformerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerCursor::copy(self : MlneuraltransformerCursor) -> MlneuraltransformerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCursor::fill(self : MlneuraltransformerCursor, v : Double) -> MlneuraltransformerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerCursor::min(self : MlneuraltransformerCursor) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerCursor::max(self : MlneuraltransformerCursor) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerCursor::to_string(self : MlneuraltransformerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_view_make(size : Int) -> MlneuraltransformerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerView::len(self : MlneuraltransformerView) -> Int { self.size }

pub fn MlneuraltransformerView::get(self : MlneuraltransformerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerView::set(self : MlneuraltransformerView, i : Int, v : Double) -> MlneuraltransformerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerView::sum(self : MlneuraltransformerView) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerView::mean(self : MlneuraltransformerView) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerView::scale(self : MlneuraltransformerView, f : Double) -> MlneuraltransformerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerView::add(self : MlneuraltransformerView, other : MlneuraltransformerView) -> MlneuraltransformerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerView::copy(self : MlneuraltransformerView) -> MlneuraltransformerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerView::fill(self : MlneuraltransformerView, v : Double) -> MlneuraltransformerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerView::min(self : MlneuraltransformerView) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerView::max(self : MlneuraltransformerView) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerView::to_string(self : MlneuraltransformerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_range_make(size : Int) -> MlneuraltransformerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerRange::len(self : MlneuraltransformerRange) -> Int { self.size }

pub fn MlneuraltransformerRange::get(self : MlneuraltransformerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerRange::set(self : MlneuraltransformerRange, i : Int, v : Double) -> MlneuraltransformerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerRange::sum(self : MlneuraltransformerRange) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerRange::mean(self : MlneuraltransformerRange) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerRange::scale(self : MlneuraltransformerRange, f : Double) -> MlneuraltransformerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerRange::add(self : MlneuraltransformerRange, other : MlneuraltransformerRange) -> MlneuraltransformerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerRange::copy(self : MlneuraltransformerRange) -> MlneuraltransformerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerRange::fill(self : MlneuraltransformerRange, v : Double) -> MlneuraltransformerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerRange::min(self : MlneuraltransformerRange) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerRange::max(self : MlneuraltransformerRange) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerRange::to_string(self : MlneuraltransformerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_slice_make(size : Int) -> MlneuraltransformerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuraltransformerSlice::len(self : MlneuraltransformerSlice) -> Int { self.size }

pub fn MlneuraltransformerSlice::get(self : MlneuraltransformerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuraltransformerSlice::set(self : MlneuraltransformerSlice, i : Int, v : Double) -> MlneuraltransformerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerSlice::sum(self : MlneuraltransformerSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuraltransformerSlice::mean(self : MlneuraltransformerSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuraltransformerSlice::scale(self : MlneuraltransformerSlice, f : Double) -> MlneuraltransformerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerSlice::add(self : MlneuraltransformerSlice, other : MlneuraltransformerSlice) -> MlneuraltransformerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuraltransformerSlice::copy(self : MlneuraltransformerSlice) -> MlneuraltransformerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerSlice::fill(self : MlneuraltransformerSlice, v : Double) -> MlneuraltransformerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuraltransformerSlice::min(self : MlneuraltransformerSlice) -> Double { @_common.min(self.data) }

pub fn MlneuraltransformerSlice::max(self : MlneuraltransformerSlice) -> Double { @_common.max(self.data) }

pub fn MlneuraltransformerSlice::to_string(self : MlneuraltransformerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

