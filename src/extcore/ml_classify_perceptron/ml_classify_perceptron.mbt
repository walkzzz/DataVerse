///===
/// extcore/ml_classify_perceptron

pub(all) struct MlclassifyperceptronPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_perceptron_make_point(x : Double, y : Double) -> MlclassifyperceptronPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_perceptron_make_point3(x : Double, y : Double, z : Double) -> MlclassifyperceptronPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyperceptronPoint::x(self : MlclassifyperceptronPoint) -> Double { self.x }

pub fn MlclassifyperceptronPoint::y(self : MlclassifyperceptronPoint) -> Double { self.y }

pub fn MlclassifyperceptronPoint::z(self : MlclassifyperceptronPoint) -> Double { self.z }

pub fn MlclassifyperceptronPoint::label(self : MlclassifyperceptronPoint) -> Int { self.label }

pub fn MlclassifyperceptronPoint::dist(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyperceptronPoint::add(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyperceptronPoint::sub(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyperceptronPoint::scale(self : MlclassifyperceptronPoint, s : Double) -> MlclassifyperceptronPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyperceptronPoint::dot(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyperceptronPoint::cross(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyperceptronPoint::norm(self : MlclassifyperceptronPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyperceptronPoint::normalize(self : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyperceptronPoint::negate(self : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyperceptronPoint::mid(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyperceptronPoint::lerp(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint, t : Double) -> MlclassifyperceptronPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyperceptronPoint::to_string(self : MlclassifyperceptronPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyperceptronSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_perceptron_make_series(vals : Array[Double], name : String) -> MlclassifyperceptronSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyperceptronSeries::len(self : MlclassifyperceptronSeries) -> Int { self.vals.length() }

pub fn MlclassifyperceptronSeries::sum(self : MlclassifyperceptronSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyperceptronSeries::mean(self : MlclassifyperceptronSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyperceptronSeries::min(self : MlclassifyperceptronSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyperceptronSeries::max(self : MlclassifyperceptronSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyperceptronSeries::range(self : MlclassifyperceptronSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyperceptronSeries::variance(self : MlclassifyperceptronSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyperceptronSeries::std(self : MlclassifyperceptronSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyperceptronSeries::median(self : MlclassifyperceptronSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyperceptronSeries::scale(self : MlclassifyperceptronSeries, f : Double) -> MlclassifyperceptronSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyperceptronSeries::add(self : MlclassifyperceptronSeries, other : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyperceptronSeries::sub(self : MlclassifyperceptronSeries, other : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyperceptronSeries::normalize(self : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyperceptronSeries::cumsum(self : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyperceptronSeries::to_string(self : MlclassifyperceptronSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyperceptronMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_perceptron_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyperceptronMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_perceptron_matrix_identity(n : Int) -> MlclassifyperceptronMatrix {
  let m = ml_classify_perceptron_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyperceptronMatrix::get(self : MlclassifyperceptronMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyperceptronMatrix::transpose(self : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  let result = ml_classify_perceptron_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyperceptronMatrix::add(self : MlclassifyperceptronMatrix, other : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyperceptronMatrix::scale(self : MlclassifyperceptronMatrix, s : Double) -> MlclassifyperceptronMatrix {
  let result = ml_classify_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyperceptronMatrix::multiply(self : MlclassifyperceptronMatrix, other : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  if self.cols != other.rows { return ml_classify_perceptron_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_perceptron_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlclassifyperceptronMatrix::trace(self : MlclassifyperceptronMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyperceptronMatrix::det(self : MlclassifyperceptronMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyperceptronMatrix::norm(self : MlclassifyperceptronMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyperceptronMatrix::to_string(self : MlclassifyperceptronMatrix) -> String {
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

pub(all) struct MlclassifyperceptronVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_perceptron_make_vector(comps : Array[Double]) -> MlclassifyperceptronVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_perceptron_vector_zero(dim : Int) -> MlclassifyperceptronVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyperceptronVector::add(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyperceptronVector::sub(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyperceptronVector::scale(self : MlclassifyperceptronVector, s : Double) -> MlclassifyperceptronVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyperceptronVector::dot(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyperceptronVector::norm(self : MlclassifyperceptronVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyperceptronVector::normalize(self : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyperceptronVector::dist(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyperceptronVector::to_string(self : MlclassifyperceptronVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyperceptronFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_frame_make(size : Int) -> MlclassifyperceptronFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronFrame::len(self : MlclassifyperceptronFrame) -> Int { self.size }

pub fn MlclassifyperceptronFrame::get(self : MlclassifyperceptronFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronFrame::set(self : MlclassifyperceptronFrame, i : Int, v : Double) -> MlclassifyperceptronFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronFrame::sum(self : MlclassifyperceptronFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronFrame::mean(self : MlclassifyperceptronFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronFrame::scale(self : MlclassifyperceptronFrame, f : Double) -> MlclassifyperceptronFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronFrame::add(self : MlclassifyperceptronFrame, other : MlclassifyperceptronFrame) -> MlclassifyperceptronFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronFrame::copy(self : MlclassifyperceptronFrame) -> MlclassifyperceptronFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronFrame::fill(self : MlclassifyperceptronFrame, v : Double) -> MlclassifyperceptronFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronFrame::min(self : MlclassifyperceptronFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronFrame::max(self : MlclassifyperceptronFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronFrame::to_string(self : MlclassifyperceptronFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_table_make(size : Int) -> MlclassifyperceptronTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronTable::len(self : MlclassifyperceptronTable) -> Int { self.size }

pub fn MlclassifyperceptronTable::get(self : MlclassifyperceptronTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronTable::set(self : MlclassifyperceptronTable, i : Int, v : Double) -> MlclassifyperceptronTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronTable::sum(self : MlclassifyperceptronTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronTable::mean(self : MlclassifyperceptronTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronTable::scale(self : MlclassifyperceptronTable, f : Double) -> MlclassifyperceptronTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronTable::add(self : MlclassifyperceptronTable, other : MlclassifyperceptronTable) -> MlclassifyperceptronTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronTable::copy(self : MlclassifyperceptronTable) -> MlclassifyperceptronTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronTable::fill(self : MlclassifyperceptronTable, v : Double) -> MlclassifyperceptronTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronTable::min(self : MlclassifyperceptronTable) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronTable::max(self : MlclassifyperceptronTable) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronTable::to_string(self : MlclassifyperceptronTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_graphn_make(size : Int) -> MlclassifyperceptronGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronGraphN::len(self : MlclassifyperceptronGraphN) -> Int { self.size }

pub fn MlclassifyperceptronGraphN::get(self : MlclassifyperceptronGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronGraphN::set(self : MlclassifyperceptronGraphN, i : Int, v : Double) -> MlclassifyperceptronGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronGraphN::sum(self : MlclassifyperceptronGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronGraphN::mean(self : MlclassifyperceptronGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronGraphN::scale(self : MlclassifyperceptronGraphN, f : Double) -> MlclassifyperceptronGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronGraphN::add(self : MlclassifyperceptronGraphN, other : MlclassifyperceptronGraphN) -> MlclassifyperceptronGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronGraphN::copy(self : MlclassifyperceptronGraphN) -> MlclassifyperceptronGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronGraphN::fill(self : MlclassifyperceptronGraphN, v : Double) -> MlclassifyperceptronGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronGraphN::min(self : MlclassifyperceptronGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronGraphN::max(self : MlclassifyperceptronGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronGraphN::to_string(self : MlclassifyperceptronGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_node_make(size : Int) -> MlclassifyperceptronNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronNode::len(self : MlclassifyperceptronNode) -> Int { self.size }

pub fn MlclassifyperceptronNode::get(self : MlclassifyperceptronNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronNode::set(self : MlclassifyperceptronNode, i : Int, v : Double) -> MlclassifyperceptronNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronNode::sum(self : MlclassifyperceptronNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronNode::mean(self : MlclassifyperceptronNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronNode::scale(self : MlclassifyperceptronNode, f : Double) -> MlclassifyperceptronNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronNode::add(self : MlclassifyperceptronNode, other : MlclassifyperceptronNode) -> MlclassifyperceptronNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronNode::copy(self : MlclassifyperceptronNode) -> MlclassifyperceptronNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronNode::fill(self : MlclassifyperceptronNode, v : Double) -> MlclassifyperceptronNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronNode::min(self : MlclassifyperceptronNode) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronNode::max(self : MlclassifyperceptronNode) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronNode::to_string(self : MlclassifyperceptronNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_edge_make(size : Int) -> MlclassifyperceptronEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronEdge::len(self : MlclassifyperceptronEdge) -> Int { self.size }

pub fn MlclassifyperceptronEdge::get(self : MlclassifyperceptronEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronEdge::set(self : MlclassifyperceptronEdge, i : Int, v : Double) -> MlclassifyperceptronEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronEdge::sum(self : MlclassifyperceptronEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronEdge::mean(self : MlclassifyperceptronEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronEdge::scale(self : MlclassifyperceptronEdge, f : Double) -> MlclassifyperceptronEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronEdge::add(self : MlclassifyperceptronEdge, other : MlclassifyperceptronEdge) -> MlclassifyperceptronEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronEdge::copy(self : MlclassifyperceptronEdge) -> MlclassifyperceptronEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronEdge::fill(self : MlclassifyperceptronEdge, v : Double) -> MlclassifyperceptronEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronEdge::min(self : MlclassifyperceptronEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronEdge::max(self : MlclassifyperceptronEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronEdge::to_string(self : MlclassifyperceptronEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_path_make(size : Int) -> MlclassifyperceptronPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronPath::len(self : MlclassifyperceptronPath) -> Int { self.size }

pub fn MlclassifyperceptronPath::get(self : MlclassifyperceptronPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronPath::set(self : MlclassifyperceptronPath, i : Int, v : Double) -> MlclassifyperceptronPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronPath::sum(self : MlclassifyperceptronPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronPath::mean(self : MlclassifyperceptronPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronPath::scale(self : MlclassifyperceptronPath, f : Double) -> MlclassifyperceptronPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronPath::add(self : MlclassifyperceptronPath, other : MlclassifyperceptronPath) -> MlclassifyperceptronPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronPath::copy(self : MlclassifyperceptronPath) -> MlclassifyperceptronPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronPath::fill(self : MlclassifyperceptronPath, v : Double) -> MlclassifyperceptronPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronPath::min(self : MlclassifyperceptronPath) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronPath::max(self : MlclassifyperceptronPath) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronPath::to_string(self : MlclassifyperceptronPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_cluster_make(size : Int) -> MlclassifyperceptronCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronCluster::len(self : MlclassifyperceptronCluster) -> Int { self.size }

pub fn MlclassifyperceptronCluster::get(self : MlclassifyperceptronCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronCluster::set(self : MlclassifyperceptronCluster, i : Int, v : Double) -> MlclassifyperceptronCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCluster::sum(self : MlclassifyperceptronCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronCluster::mean(self : MlclassifyperceptronCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronCluster::scale(self : MlclassifyperceptronCluster, f : Double) -> MlclassifyperceptronCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCluster::add(self : MlclassifyperceptronCluster, other : MlclassifyperceptronCluster) -> MlclassifyperceptronCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronCluster::copy(self : MlclassifyperceptronCluster) -> MlclassifyperceptronCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCluster::fill(self : MlclassifyperceptronCluster, v : Double) -> MlclassifyperceptronCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCluster::min(self : MlclassifyperceptronCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronCluster::max(self : MlclassifyperceptronCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronCluster::to_string(self : MlclassifyperceptronCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_model_make(size : Int) -> MlclassifyperceptronModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronModel::len(self : MlclassifyperceptronModel) -> Int { self.size }

pub fn MlclassifyperceptronModel::get(self : MlclassifyperceptronModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronModel::set(self : MlclassifyperceptronModel, i : Int, v : Double) -> MlclassifyperceptronModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronModel::sum(self : MlclassifyperceptronModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronModel::mean(self : MlclassifyperceptronModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronModel::scale(self : MlclassifyperceptronModel, f : Double) -> MlclassifyperceptronModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronModel::add(self : MlclassifyperceptronModel, other : MlclassifyperceptronModel) -> MlclassifyperceptronModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronModel::copy(self : MlclassifyperceptronModel) -> MlclassifyperceptronModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronModel::fill(self : MlclassifyperceptronModel, v : Double) -> MlclassifyperceptronModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronModel::min(self : MlclassifyperceptronModel) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronModel::max(self : MlclassifyperceptronModel) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronModel::to_string(self : MlclassifyperceptronModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_layer_make(size : Int) -> MlclassifyperceptronLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronLayer::len(self : MlclassifyperceptronLayer) -> Int { self.size }

pub fn MlclassifyperceptronLayer::get(self : MlclassifyperceptronLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronLayer::set(self : MlclassifyperceptronLayer, i : Int, v : Double) -> MlclassifyperceptronLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronLayer::sum(self : MlclassifyperceptronLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronLayer::mean(self : MlclassifyperceptronLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronLayer::scale(self : MlclassifyperceptronLayer, f : Double) -> MlclassifyperceptronLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronLayer::add(self : MlclassifyperceptronLayer, other : MlclassifyperceptronLayer) -> MlclassifyperceptronLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronLayer::copy(self : MlclassifyperceptronLayer) -> MlclassifyperceptronLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronLayer::fill(self : MlclassifyperceptronLayer, v : Double) -> MlclassifyperceptronLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronLayer::min(self : MlclassifyperceptronLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronLayer::max(self : MlclassifyperceptronLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronLayer::to_string(self : MlclassifyperceptronLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_buffer_make(size : Int) -> MlclassifyperceptronBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronBuffer::len(self : MlclassifyperceptronBuffer) -> Int { self.size }

pub fn MlclassifyperceptronBuffer::get(self : MlclassifyperceptronBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronBuffer::set(self : MlclassifyperceptronBuffer, i : Int, v : Double) -> MlclassifyperceptronBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronBuffer::sum(self : MlclassifyperceptronBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronBuffer::mean(self : MlclassifyperceptronBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronBuffer::scale(self : MlclassifyperceptronBuffer, f : Double) -> MlclassifyperceptronBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronBuffer::add(self : MlclassifyperceptronBuffer, other : MlclassifyperceptronBuffer) -> MlclassifyperceptronBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronBuffer::copy(self : MlclassifyperceptronBuffer) -> MlclassifyperceptronBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronBuffer::fill(self : MlclassifyperceptronBuffer, v : Double) -> MlclassifyperceptronBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronBuffer::min(self : MlclassifyperceptronBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronBuffer::max(self : MlclassifyperceptronBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronBuffer::to_string(self : MlclassifyperceptronBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_cursor_make(size : Int) -> MlclassifyperceptronCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronCursor::len(self : MlclassifyperceptronCursor) -> Int { self.size }

pub fn MlclassifyperceptronCursor::get(self : MlclassifyperceptronCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronCursor::set(self : MlclassifyperceptronCursor, i : Int, v : Double) -> MlclassifyperceptronCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCursor::sum(self : MlclassifyperceptronCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronCursor::mean(self : MlclassifyperceptronCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronCursor::scale(self : MlclassifyperceptronCursor, f : Double) -> MlclassifyperceptronCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCursor::add(self : MlclassifyperceptronCursor, other : MlclassifyperceptronCursor) -> MlclassifyperceptronCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronCursor::copy(self : MlclassifyperceptronCursor) -> MlclassifyperceptronCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCursor::fill(self : MlclassifyperceptronCursor, v : Double) -> MlclassifyperceptronCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronCursor::min(self : MlclassifyperceptronCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronCursor::max(self : MlclassifyperceptronCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronCursor::to_string(self : MlclassifyperceptronCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_view_make(size : Int) -> MlclassifyperceptronView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronView::len(self : MlclassifyperceptronView) -> Int { self.size }

pub fn MlclassifyperceptronView::get(self : MlclassifyperceptronView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronView::set(self : MlclassifyperceptronView, i : Int, v : Double) -> MlclassifyperceptronView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronView::sum(self : MlclassifyperceptronView) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronView::mean(self : MlclassifyperceptronView) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronView::scale(self : MlclassifyperceptronView, f : Double) -> MlclassifyperceptronView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronView::add(self : MlclassifyperceptronView, other : MlclassifyperceptronView) -> MlclassifyperceptronView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronView::copy(self : MlclassifyperceptronView) -> MlclassifyperceptronView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronView::fill(self : MlclassifyperceptronView, v : Double) -> MlclassifyperceptronView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronView::min(self : MlclassifyperceptronView) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronView::max(self : MlclassifyperceptronView) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronView::to_string(self : MlclassifyperceptronView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_range_make(size : Int) -> MlclassifyperceptronRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronRange::len(self : MlclassifyperceptronRange) -> Int { self.size }

pub fn MlclassifyperceptronRange::get(self : MlclassifyperceptronRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronRange::set(self : MlclassifyperceptronRange, i : Int, v : Double) -> MlclassifyperceptronRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronRange::sum(self : MlclassifyperceptronRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronRange::mean(self : MlclassifyperceptronRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronRange::scale(self : MlclassifyperceptronRange, f : Double) -> MlclassifyperceptronRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronRange::add(self : MlclassifyperceptronRange, other : MlclassifyperceptronRange) -> MlclassifyperceptronRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronRange::copy(self : MlclassifyperceptronRange) -> MlclassifyperceptronRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronRange::fill(self : MlclassifyperceptronRange, v : Double) -> MlclassifyperceptronRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronRange::min(self : MlclassifyperceptronRange) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronRange::max(self : MlclassifyperceptronRange) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronRange::to_string(self : MlclassifyperceptronRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_slice_make(size : Int) -> MlclassifyperceptronSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyperceptronSlice::len(self : MlclassifyperceptronSlice) -> Int { self.size }

pub fn MlclassifyperceptronSlice::get(self : MlclassifyperceptronSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyperceptronSlice::set(self : MlclassifyperceptronSlice, i : Int, v : Double) -> MlclassifyperceptronSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronSlice::sum(self : MlclassifyperceptronSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifyperceptronSlice::mean(self : MlclassifyperceptronSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifyperceptronSlice::scale(self : MlclassifyperceptronSlice, f : Double) -> MlclassifyperceptronSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronSlice::add(self : MlclassifyperceptronSlice, other : MlclassifyperceptronSlice) -> MlclassifyperceptronSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyperceptronSlice::copy(self : MlclassifyperceptronSlice) -> MlclassifyperceptronSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronSlice::fill(self : MlclassifyperceptronSlice, v : Double) -> MlclassifyperceptronSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyperceptronSlice::min(self : MlclassifyperceptronSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifyperceptronSlice::max(self : MlclassifyperceptronSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifyperceptronSlice::to_string(self : MlclassifyperceptronSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

