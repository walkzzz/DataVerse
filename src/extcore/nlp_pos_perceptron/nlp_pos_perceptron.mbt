///===
/// extcore/nlp_pos_perceptron

pub(all) struct NlpposperceptronPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_perceptron_make_point(x : Double, y : Double) -> NlpposperceptronPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_perceptron_make_point3(x : Double, y : Double, z : Double) -> NlpposperceptronPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposperceptronPoint::x(self : NlpposperceptronPoint) -> Double { self.x }

pub fn NlpposperceptronPoint::y(self : NlpposperceptronPoint) -> Double { self.y }

pub fn NlpposperceptronPoint::z(self : NlpposperceptronPoint) -> Double { self.z }

pub fn NlpposperceptronPoint::label(self : NlpposperceptronPoint) -> Int { self.label }

pub fn NlpposperceptronPoint::dist(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposperceptronPoint::add(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposperceptronPoint::sub(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposperceptronPoint::scale(self : NlpposperceptronPoint, s : Double) -> NlpposperceptronPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposperceptronPoint::dot(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposperceptronPoint::cross(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposperceptronPoint::norm(self : NlpposperceptronPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposperceptronPoint::normalize(self : NlpposperceptronPoint) -> NlpposperceptronPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposperceptronPoint::negate(self : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposperceptronPoint::mid(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposperceptronPoint::lerp(self : NlpposperceptronPoint, other : NlpposperceptronPoint, t : Double) -> NlpposperceptronPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposperceptronPoint::to_string(self : NlpposperceptronPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposperceptronSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_perceptron_make_series(vals : Array[Double], name : String) -> NlpposperceptronSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposperceptronSeries::len(self : NlpposperceptronSeries) -> Int { self.vals.length() }

pub fn NlpposperceptronSeries::sum(self : NlpposperceptronSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposperceptronSeries::mean(self : NlpposperceptronSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposperceptronSeries::min(self : NlpposperceptronSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposperceptronSeries::max(self : NlpposperceptronSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposperceptronSeries::range(self : NlpposperceptronSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposperceptronSeries::variance(self : NlpposperceptronSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposperceptronSeries::std(self : NlpposperceptronSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposperceptronSeries::median(self : NlpposperceptronSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposperceptronSeries::scale(self : NlpposperceptronSeries, f : Double) -> NlpposperceptronSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposperceptronSeries::add(self : NlpposperceptronSeries, other : NlpposperceptronSeries) -> NlpposperceptronSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposperceptronSeries::sub(self : NlpposperceptronSeries, other : NlpposperceptronSeries) -> NlpposperceptronSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposperceptronSeries::normalize(self : NlpposperceptronSeries) -> NlpposperceptronSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposperceptronSeries::cumsum(self : NlpposperceptronSeries) -> NlpposperceptronSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposperceptronSeries::to_string(self : NlpposperceptronSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposperceptronMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_perceptron_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposperceptronMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_pos_perceptron_matrix_identity(n : Int) -> NlpposperceptronMatrix {
  let m = nlp_pos_perceptron_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposperceptronMatrix::get(self : NlpposperceptronMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposperceptronMatrix::transpose(self : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  let result = nlp_pos_perceptron_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposperceptronMatrix::add(self : NlpposperceptronMatrix, other : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposperceptronMatrix::scale(self : NlpposperceptronMatrix, s : Double) -> NlpposperceptronMatrix {
  let result = nlp_pos_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposperceptronMatrix::multiply(self : NlpposperceptronMatrix, other : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  if self.cols != other.rows { return nlp_pos_perceptron_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_perceptron_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpposperceptronMatrix::trace(self : NlpposperceptronMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposperceptronMatrix::det(self : NlpposperceptronMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposperceptronMatrix::norm(self : NlpposperceptronMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposperceptronMatrix::to_string(self : NlpposperceptronMatrix) -> String {
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

pub(all) struct NlpposperceptronVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_perceptron_make_vector(comps : Array[Double]) -> NlpposperceptronVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_perceptron_vector_zero(dim : Int) -> NlpposperceptronVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposperceptronVector::add(self : NlpposperceptronVector, other : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposperceptronVector::sub(self : NlpposperceptronVector, other : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposperceptronVector::scale(self : NlpposperceptronVector, s : Double) -> NlpposperceptronVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposperceptronVector::dot(self : NlpposperceptronVector, other : NlpposperceptronVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposperceptronVector::norm(self : NlpposperceptronVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposperceptronVector::normalize(self : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposperceptronVector::dist(self : NlpposperceptronVector, other : NlpposperceptronVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposperceptronVector::to_string(self : NlpposperceptronVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposperceptronFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_frame_make(size : Int) -> NlpposperceptronFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronFrame::len(self : NlpposperceptronFrame) -> Int { self.size }

pub fn NlpposperceptronFrame::get(self : NlpposperceptronFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronFrame::set(self : NlpposperceptronFrame, i : Int, v : Double) -> NlpposperceptronFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronFrame::sum(self : NlpposperceptronFrame) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronFrame::mean(self : NlpposperceptronFrame) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronFrame::scale(self : NlpposperceptronFrame, f : Double) -> NlpposperceptronFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronFrame::add(self : NlpposperceptronFrame, other : NlpposperceptronFrame) -> NlpposperceptronFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronFrame::copy(self : NlpposperceptronFrame) -> NlpposperceptronFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronFrame::fill(self : NlpposperceptronFrame, v : Double) -> NlpposperceptronFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronFrame::min(self : NlpposperceptronFrame) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronFrame::max(self : NlpposperceptronFrame) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronFrame::to_string(self : NlpposperceptronFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_table_make(size : Int) -> NlpposperceptronTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronTable::len(self : NlpposperceptronTable) -> Int { self.size }

pub fn NlpposperceptronTable::get(self : NlpposperceptronTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronTable::set(self : NlpposperceptronTable, i : Int, v : Double) -> NlpposperceptronTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronTable::sum(self : NlpposperceptronTable) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronTable::mean(self : NlpposperceptronTable) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronTable::scale(self : NlpposperceptronTable, f : Double) -> NlpposperceptronTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronTable::add(self : NlpposperceptronTable, other : NlpposperceptronTable) -> NlpposperceptronTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronTable::copy(self : NlpposperceptronTable) -> NlpposperceptronTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronTable::fill(self : NlpposperceptronTable, v : Double) -> NlpposperceptronTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronTable::min(self : NlpposperceptronTable) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronTable::max(self : NlpposperceptronTable) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronTable::to_string(self : NlpposperceptronTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_graphn_make(size : Int) -> NlpposperceptronGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronGraphN::len(self : NlpposperceptronGraphN) -> Int { self.size }

pub fn NlpposperceptronGraphN::get(self : NlpposperceptronGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronGraphN::set(self : NlpposperceptronGraphN, i : Int, v : Double) -> NlpposperceptronGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronGraphN::sum(self : NlpposperceptronGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronGraphN::mean(self : NlpposperceptronGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronGraphN::scale(self : NlpposperceptronGraphN, f : Double) -> NlpposperceptronGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronGraphN::add(self : NlpposperceptronGraphN, other : NlpposperceptronGraphN) -> NlpposperceptronGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronGraphN::copy(self : NlpposperceptronGraphN) -> NlpposperceptronGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronGraphN::fill(self : NlpposperceptronGraphN, v : Double) -> NlpposperceptronGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronGraphN::min(self : NlpposperceptronGraphN) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronGraphN::max(self : NlpposperceptronGraphN) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronGraphN::to_string(self : NlpposperceptronGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_node_make(size : Int) -> NlpposperceptronNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronNode::len(self : NlpposperceptronNode) -> Int { self.size }

pub fn NlpposperceptronNode::get(self : NlpposperceptronNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronNode::set(self : NlpposperceptronNode, i : Int, v : Double) -> NlpposperceptronNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronNode::sum(self : NlpposperceptronNode) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronNode::mean(self : NlpposperceptronNode) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronNode::scale(self : NlpposperceptronNode, f : Double) -> NlpposperceptronNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronNode::add(self : NlpposperceptronNode, other : NlpposperceptronNode) -> NlpposperceptronNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronNode::copy(self : NlpposperceptronNode) -> NlpposperceptronNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronNode::fill(self : NlpposperceptronNode, v : Double) -> NlpposperceptronNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronNode::min(self : NlpposperceptronNode) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronNode::max(self : NlpposperceptronNode) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronNode::to_string(self : NlpposperceptronNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_edge_make(size : Int) -> NlpposperceptronEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronEdge::len(self : NlpposperceptronEdge) -> Int { self.size }

pub fn NlpposperceptronEdge::get(self : NlpposperceptronEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronEdge::set(self : NlpposperceptronEdge, i : Int, v : Double) -> NlpposperceptronEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronEdge::sum(self : NlpposperceptronEdge) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronEdge::mean(self : NlpposperceptronEdge) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronEdge::scale(self : NlpposperceptronEdge, f : Double) -> NlpposperceptronEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronEdge::add(self : NlpposperceptronEdge, other : NlpposperceptronEdge) -> NlpposperceptronEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronEdge::copy(self : NlpposperceptronEdge) -> NlpposperceptronEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronEdge::fill(self : NlpposperceptronEdge, v : Double) -> NlpposperceptronEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronEdge::min(self : NlpposperceptronEdge) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronEdge::max(self : NlpposperceptronEdge) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronEdge::to_string(self : NlpposperceptronEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_path_make(size : Int) -> NlpposperceptronPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronPath::len(self : NlpposperceptronPath) -> Int { self.size }

pub fn NlpposperceptronPath::get(self : NlpposperceptronPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronPath::set(self : NlpposperceptronPath, i : Int, v : Double) -> NlpposperceptronPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronPath::sum(self : NlpposperceptronPath) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronPath::mean(self : NlpposperceptronPath) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronPath::scale(self : NlpposperceptronPath, f : Double) -> NlpposperceptronPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronPath::add(self : NlpposperceptronPath, other : NlpposperceptronPath) -> NlpposperceptronPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronPath::copy(self : NlpposperceptronPath) -> NlpposperceptronPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronPath::fill(self : NlpposperceptronPath, v : Double) -> NlpposperceptronPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronPath::min(self : NlpposperceptronPath) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronPath::max(self : NlpposperceptronPath) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronPath::to_string(self : NlpposperceptronPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_cluster_make(size : Int) -> NlpposperceptronCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronCluster::len(self : NlpposperceptronCluster) -> Int { self.size }

pub fn NlpposperceptronCluster::get(self : NlpposperceptronCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronCluster::set(self : NlpposperceptronCluster, i : Int, v : Double) -> NlpposperceptronCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCluster::sum(self : NlpposperceptronCluster) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronCluster::mean(self : NlpposperceptronCluster) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronCluster::scale(self : NlpposperceptronCluster, f : Double) -> NlpposperceptronCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCluster::add(self : NlpposperceptronCluster, other : NlpposperceptronCluster) -> NlpposperceptronCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronCluster::copy(self : NlpposperceptronCluster) -> NlpposperceptronCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCluster::fill(self : NlpposperceptronCluster, v : Double) -> NlpposperceptronCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCluster::min(self : NlpposperceptronCluster) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronCluster::max(self : NlpposperceptronCluster) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronCluster::to_string(self : NlpposperceptronCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_model_make(size : Int) -> NlpposperceptronModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronModel::len(self : NlpposperceptronModel) -> Int { self.size }

pub fn NlpposperceptronModel::get(self : NlpposperceptronModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronModel::set(self : NlpposperceptronModel, i : Int, v : Double) -> NlpposperceptronModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronModel::sum(self : NlpposperceptronModel) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronModel::mean(self : NlpposperceptronModel) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronModel::scale(self : NlpposperceptronModel, f : Double) -> NlpposperceptronModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronModel::add(self : NlpposperceptronModel, other : NlpposperceptronModel) -> NlpposperceptronModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronModel::copy(self : NlpposperceptronModel) -> NlpposperceptronModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronModel::fill(self : NlpposperceptronModel, v : Double) -> NlpposperceptronModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronModel::min(self : NlpposperceptronModel) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronModel::max(self : NlpposperceptronModel) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronModel::to_string(self : NlpposperceptronModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_layer_make(size : Int) -> NlpposperceptronLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronLayer::len(self : NlpposperceptronLayer) -> Int { self.size }

pub fn NlpposperceptronLayer::get(self : NlpposperceptronLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronLayer::set(self : NlpposperceptronLayer, i : Int, v : Double) -> NlpposperceptronLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronLayer::sum(self : NlpposperceptronLayer) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronLayer::mean(self : NlpposperceptronLayer) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronLayer::scale(self : NlpposperceptronLayer, f : Double) -> NlpposperceptronLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronLayer::add(self : NlpposperceptronLayer, other : NlpposperceptronLayer) -> NlpposperceptronLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronLayer::copy(self : NlpposperceptronLayer) -> NlpposperceptronLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronLayer::fill(self : NlpposperceptronLayer, v : Double) -> NlpposperceptronLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronLayer::min(self : NlpposperceptronLayer) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronLayer::max(self : NlpposperceptronLayer) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronLayer::to_string(self : NlpposperceptronLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_buffer_make(size : Int) -> NlpposperceptronBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronBuffer::len(self : NlpposperceptronBuffer) -> Int { self.size }

pub fn NlpposperceptronBuffer::get(self : NlpposperceptronBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronBuffer::set(self : NlpposperceptronBuffer, i : Int, v : Double) -> NlpposperceptronBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronBuffer::sum(self : NlpposperceptronBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronBuffer::mean(self : NlpposperceptronBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronBuffer::scale(self : NlpposperceptronBuffer, f : Double) -> NlpposperceptronBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronBuffer::add(self : NlpposperceptronBuffer, other : NlpposperceptronBuffer) -> NlpposperceptronBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronBuffer::copy(self : NlpposperceptronBuffer) -> NlpposperceptronBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronBuffer::fill(self : NlpposperceptronBuffer, v : Double) -> NlpposperceptronBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronBuffer::min(self : NlpposperceptronBuffer) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronBuffer::max(self : NlpposperceptronBuffer) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronBuffer::to_string(self : NlpposperceptronBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_cursor_make(size : Int) -> NlpposperceptronCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronCursor::len(self : NlpposperceptronCursor) -> Int { self.size }

pub fn NlpposperceptronCursor::get(self : NlpposperceptronCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronCursor::set(self : NlpposperceptronCursor, i : Int, v : Double) -> NlpposperceptronCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCursor::sum(self : NlpposperceptronCursor) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronCursor::mean(self : NlpposperceptronCursor) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronCursor::scale(self : NlpposperceptronCursor, f : Double) -> NlpposperceptronCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCursor::add(self : NlpposperceptronCursor, other : NlpposperceptronCursor) -> NlpposperceptronCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronCursor::copy(self : NlpposperceptronCursor) -> NlpposperceptronCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCursor::fill(self : NlpposperceptronCursor, v : Double) -> NlpposperceptronCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronCursor::min(self : NlpposperceptronCursor) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronCursor::max(self : NlpposperceptronCursor) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronCursor::to_string(self : NlpposperceptronCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_view_make(size : Int) -> NlpposperceptronView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronView::len(self : NlpposperceptronView) -> Int { self.size }

pub fn NlpposperceptronView::get(self : NlpposperceptronView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronView::set(self : NlpposperceptronView, i : Int, v : Double) -> NlpposperceptronView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronView::sum(self : NlpposperceptronView) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronView::mean(self : NlpposperceptronView) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronView::scale(self : NlpposperceptronView, f : Double) -> NlpposperceptronView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronView::add(self : NlpposperceptronView, other : NlpposperceptronView) -> NlpposperceptronView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronView::copy(self : NlpposperceptronView) -> NlpposperceptronView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronView::fill(self : NlpposperceptronView, v : Double) -> NlpposperceptronView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronView::min(self : NlpposperceptronView) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronView::max(self : NlpposperceptronView) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronView::to_string(self : NlpposperceptronView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_range_make(size : Int) -> NlpposperceptronRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronRange::len(self : NlpposperceptronRange) -> Int { self.size }

pub fn NlpposperceptronRange::get(self : NlpposperceptronRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronRange::set(self : NlpposperceptronRange, i : Int, v : Double) -> NlpposperceptronRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronRange::sum(self : NlpposperceptronRange) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronRange::mean(self : NlpposperceptronRange) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronRange::scale(self : NlpposperceptronRange, f : Double) -> NlpposperceptronRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronRange::add(self : NlpposperceptronRange, other : NlpposperceptronRange) -> NlpposperceptronRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronRange::copy(self : NlpposperceptronRange) -> NlpposperceptronRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronRange::fill(self : NlpposperceptronRange, v : Double) -> NlpposperceptronRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronRange::min(self : NlpposperceptronRange) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronRange::max(self : NlpposperceptronRange) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronRange::to_string(self : NlpposperceptronRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_slice_make(size : Int) -> NlpposperceptronSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposperceptronSlice::len(self : NlpposperceptronSlice) -> Int { self.size }

pub fn NlpposperceptronSlice::get(self : NlpposperceptronSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposperceptronSlice::set(self : NlpposperceptronSlice, i : Int, v : Double) -> NlpposperceptronSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposperceptronSlice::sum(self : NlpposperceptronSlice) -> Double { @_common.sum(self.data) }

pub fn NlpposperceptronSlice::mean(self : NlpposperceptronSlice) -> Double { @_common.mean(self.data) }

pub fn NlpposperceptronSlice::scale(self : NlpposperceptronSlice, f : Double) -> NlpposperceptronSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronSlice::add(self : NlpposperceptronSlice, other : NlpposperceptronSlice) -> NlpposperceptronSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposperceptronSlice::copy(self : NlpposperceptronSlice) -> NlpposperceptronSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronSlice::fill(self : NlpposperceptronSlice, v : Double) -> NlpposperceptronSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposperceptronSlice::min(self : NlpposperceptronSlice) -> Double { @_common.min(self.data) }

pub fn NlpposperceptronSlice::max(self : NlpposperceptronSlice) -> Double { @_common.max(self.data) }

pub fn NlpposperceptronSlice::to_string(self : NlpposperceptronSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

