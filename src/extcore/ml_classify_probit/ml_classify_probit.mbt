///===
/// extcore/ml_classify_probit

pub(all) struct MlclassifyprobitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_probit_make_point(x : Double, y : Double) -> MlclassifyprobitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_probit_make_point3(x : Double, y : Double, z : Double) -> MlclassifyprobitPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyprobitPoint::x(self : MlclassifyprobitPoint) -> Double { self.x }

pub fn MlclassifyprobitPoint::y(self : MlclassifyprobitPoint) -> Double { self.y }

pub fn MlclassifyprobitPoint::z(self : MlclassifyprobitPoint) -> Double { self.z }

pub fn MlclassifyprobitPoint::label(self : MlclassifyprobitPoint) -> Int { self.label }

pub fn MlclassifyprobitPoint::dist(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyprobitPoint::add(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyprobitPoint::sub(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyprobitPoint::scale(self : MlclassifyprobitPoint, s : Double) -> MlclassifyprobitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyprobitPoint::dot(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyprobitPoint::cross(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyprobitPoint::norm(self : MlclassifyprobitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyprobitPoint::normalize(self : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyprobitPoint::negate(self : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyprobitPoint::mid(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyprobitPoint::lerp(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint, t : Double) -> MlclassifyprobitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyprobitPoint::to_string(self : MlclassifyprobitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyprobitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_probit_make_series(vals : Array[Double], name : String) -> MlclassifyprobitSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyprobitSeries::len(self : MlclassifyprobitSeries) -> Int { self.vals.length() }

pub fn MlclassifyprobitSeries::sum(self : MlclassifyprobitSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyprobitSeries::mean(self : MlclassifyprobitSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyprobitSeries::min(self : MlclassifyprobitSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyprobitSeries::max(self : MlclassifyprobitSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyprobitSeries::range(self : MlclassifyprobitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyprobitSeries::variance(self : MlclassifyprobitSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyprobitSeries::std(self : MlclassifyprobitSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyprobitSeries::median(self : MlclassifyprobitSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyprobitSeries::scale(self : MlclassifyprobitSeries, f : Double) -> MlclassifyprobitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyprobitSeries::add(self : MlclassifyprobitSeries, other : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyprobitSeries::sub(self : MlclassifyprobitSeries, other : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyprobitSeries::normalize(self : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyprobitSeries::cumsum(self : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyprobitSeries::to_string(self : MlclassifyprobitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyprobitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_probit_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyprobitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_probit_matrix_identity(n : Int) -> MlclassifyprobitMatrix {
  let m = ml_classify_probit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyprobitMatrix::get(self : MlclassifyprobitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyprobitMatrix::transpose(self : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  let result = ml_classify_probit_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyprobitMatrix::add(self : MlclassifyprobitMatrix, other : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_probit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyprobitMatrix::scale(self : MlclassifyprobitMatrix, s : Double) -> MlclassifyprobitMatrix {
  let result = ml_classify_probit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyprobitMatrix::multiply(self : MlclassifyprobitMatrix, other : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  if self.cols != other.rows { return ml_classify_probit_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_probit_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyprobitMatrix::trace(self : MlclassifyprobitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyprobitMatrix::det(self : MlclassifyprobitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyprobitMatrix::norm(self : MlclassifyprobitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyprobitMatrix::to_string(self : MlclassifyprobitMatrix) -> String {
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

pub(all) struct MlclassifyprobitVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_probit_make_vector(comps : Array[Double]) -> MlclassifyprobitVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_probit_vector_zero(dim : Int) -> MlclassifyprobitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyprobitVector::add(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyprobitVector::sub(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyprobitVector::scale(self : MlclassifyprobitVector, s : Double) -> MlclassifyprobitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyprobitVector::dot(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyprobitVector::norm(self : MlclassifyprobitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyprobitVector::normalize(self : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyprobitVector::dist(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyprobitVector::to_string(self : MlclassifyprobitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyprobitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_frame_make(size : Int) -> MlclassifyprobitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitFrame::len(self : MlclassifyprobitFrame) -> Int { self.size }

pub fn MlclassifyprobitFrame::get(self : MlclassifyprobitFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitFrame::set(self : MlclassifyprobitFrame, i : Int, v : Double) -> MlclassifyprobitFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitFrame::sum(self : MlclassifyprobitFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitFrame::mean(self : MlclassifyprobitFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitFrame::scale(self : MlclassifyprobitFrame, f : Double) -> MlclassifyprobitFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitFrame::add(self : MlclassifyprobitFrame, other : MlclassifyprobitFrame) -> MlclassifyprobitFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitFrame::copy(self : MlclassifyprobitFrame) -> MlclassifyprobitFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitFrame::fill(self : MlclassifyprobitFrame, v : Double) -> MlclassifyprobitFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitFrame::min(self : MlclassifyprobitFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitFrame::max(self : MlclassifyprobitFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitFrame::to_string(self : MlclassifyprobitFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_table_make(size : Int) -> MlclassifyprobitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitTable::len(self : MlclassifyprobitTable) -> Int { self.size }

pub fn MlclassifyprobitTable::get(self : MlclassifyprobitTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitTable::set(self : MlclassifyprobitTable, i : Int, v : Double) -> MlclassifyprobitTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitTable::sum(self : MlclassifyprobitTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitTable::mean(self : MlclassifyprobitTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitTable::scale(self : MlclassifyprobitTable, f : Double) -> MlclassifyprobitTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitTable::add(self : MlclassifyprobitTable, other : MlclassifyprobitTable) -> MlclassifyprobitTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitTable::copy(self : MlclassifyprobitTable) -> MlclassifyprobitTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitTable::fill(self : MlclassifyprobitTable, v : Double) -> MlclassifyprobitTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitTable::min(self : MlclassifyprobitTable) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitTable::max(self : MlclassifyprobitTable) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitTable::to_string(self : MlclassifyprobitTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_graphn_make(size : Int) -> MlclassifyprobitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitGraphN::len(self : MlclassifyprobitGraphN) -> Int { self.size }

pub fn MlclassifyprobitGraphN::get(self : MlclassifyprobitGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitGraphN::set(self : MlclassifyprobitGraphN, i : Int, v : Double) -> MlclassifyprobitGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitGraphN::sum(self : MlclassifyprobitGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitGraphN::mean(self : MlclassifyprobitGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitGraphN::scale(self : MlclassifyprobitGraphN, f : Double) -> MlclassifyprobitGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitGraphN::add(self : MlclassifyprobitGraphN, other : MlclassifyprobitGraphN) -> MlclassifyprobitGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitGraphN::copy(self : MlclassifyprobitGraphN) -> MlclassifyprobitGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitGraphN::fill(self : MlclassifyprobitGraphN, v : Double) -> MlclassifyprobitGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitGraphN::min(self : MlclassifyprobitGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitGraphN::max(self : MlclassifyprobitGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitGraphN::to_string(self : MlclassifyprobitGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_node_make(size : Int) -> MlclassifyprobitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitNode::len(self : MlclassifyprobitNode) -> Int { self.size }

pub fn MlclassifyprobitNode::get(self : MlclassifyprobitNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitNode::set(self : MlclassifyprobitNode, i : Int, v : Double) -> MlclassifyprobitNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitNode::sum(self : MlclassifyprobitNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitNode::mean(self : MlclassifyprobitNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitNode::scale(self : MlclassifyprobitNode, f : Double) -> MlclassifyprobitNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitNode::add(self : MlclassifyprobitNode, other : MlclassifyprobitNode) -> MlclassifyprobitNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitNode::copy(self : MlclassifyprobitNode) -> MlclassifyprobitNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitNode::fill(self : MlclassifyprobitNode, v : Double) -> MlclassifyprobitNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitNode::min(self : MlclassifyprobitNode) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitNode::max(self : MlclassifyprobitNode) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitNode::to_string(self : MlclassifyprobitNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_edge_make(size : Int) -> MlclassifyprobitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitEdge::len(self : MlclassifyprobitEdge) -> Int { self.size }

pub fn MlclassifyprobitEdge::get(self : MlclassifyprobitEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitEdge::set(self : MlclassifyprobitEdge, i : Int, v : Double) -> MlclassifyprobitEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitEdge::sum(self : MlclassifyprobitEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitEdge::mean(self : MlclassifyprobitEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitEdge::scale(self : MlclassifyprobitEdge, f : Double) -> MlclassifyprobitEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitEdge::add(self : MlclassifyprobitEdge, other : MlclassifyprobitEdge) -> MlclassifyprobitEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitEdge::copy(self : MlclassifyprobitEdge) -> MlclassifyprobitEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitEdge::fill(self : MlclassifyprobitEdge, v : Double) -> MlclassifyprobitEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitEdge::min(self : MlclassifyprobitEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitEdge::max(self : MlclassifyprobitEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitEdge::to_string(self : MlclassifyprobitEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_path_make(size : Int) -> MlclassifyprobitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitPath::len(self : MlclassifyprobitPath) -> Int { self.size }

pub fn MlclassifyprobitPath::get(self : MlclassifyprobitPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitPath::set(self : MlclassifyprobitPath, i : Int, v : Double) -> MlclassifyprobitPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitPath::sum(self : MlclassifyprobitPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitPath::mean(self : MlclassifyprobitPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitPath::scale(self : MlclassifyprobitPath, f : Double) -> MlclassifyprobitPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitPath::add(self : MlclassifyprobitPath, other : MlclassifyprobitPath) -> MlclassifyprobitPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitPath::copy(self : MlclassifyprobitPath) -> MlclassifyprobitPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitPath::fill(self : MlclassifyprobitPath, v : Double) -> MlclassifyprobitPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitPath::min(self : MlclassifyprobitPath) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitPath::max(self : MlclassifyprobitPath) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitPath::to_string(self : MlclassifyprobitPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_cluster_make(size : Int) -> MlclassifyprobitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitCluster::len(self : MlclassifyprobitCluster) -> Int { self.size }

pub fn MlclassifyprobitCluster::get(self : MlclassifyprobitCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitCluster::set(self : MlclassifyprobitCluster, i : Int, v : Double) -> MlclassifyprobitCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCluster::sum(self : MlclassifyprobitCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitCluster::mean(self : MlclassifyprobitCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitCluster::scale(self : MlclassifyprobitCluster, f : Double) -> MlclassifyprobitCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCluster::add(self : MlclassifyprobitCluster, other : MlclassifyprobitCluster) -> MlclassifyprobitCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitCluster::copy(self : MlclassifyprobitCluster) -> MlclassifyprobitCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCluster::fill(self : MlclassifyprobitCluster, v : Double) -> MlclassifyprobitCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCluster::min(self : MlclassifyprobitCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitCluster::max(self : MlclassifyprobitCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitCluster::to_string(self : MlclassifyprobitCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_model_make(size : Int) -> MlclassifyprobitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitModel::len(self : MlclassifyprobitModel) -> Int { self.size }

pub fn MlclassifyprobitModel::get(self : MlclassifyprobitModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitModel::set(self : MlclassifyprobitModel, i : Int, v : Double) -> MlclassifyprobitModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitModel::sum(self : MlclassifyprobitModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitModel::mean(self : MlclassifyprobitModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitModel::scale(self : MlclassifyprobitModel, f : Double) -> MlclassifyprobitModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitModel::add(self : MlclassifyprobitModel, other : MlclassifyprobitModel) -> MlclassifyprobitModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitModel::copy(self : MlclassifyprobitModel) -> MlclassifyprobitModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitModel::fill(self : MlclassifyprobitModel, v : Double) -> MlclassifyprobitModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitModel::min(self : MlclassifyprobitModel) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitModel::max(self : MlclassifyprobitModel) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitModel::to_string(self : MlclassifyprobitModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_layer_make(size : Int) -> MlclassifyprobitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitLayer::len(self : MlclassifyprobitLayer) -> Int { self.size }

pub fn MlclassifyprobitLayer::get(self : MlclassifyprobitLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitLayer::set(self : MlclassifyprobitLayer, i : Int, v : Double) -> MlclassifyprobitLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitLayer::sum(self : MlclassifyprobitLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitLayer::mean(self : MlclassifyprobitLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitLayer::scale(self : MlclassifyprobitLayer, f : Double) -> MlclassifyprobitLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitLayer::add(self : MlclassifyprobitLayer, other : MlclassifyprobitLayer) -> MlclassifyprobitLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitLayer::copy(self : MlclassifyprobitLayer) -> MlclassifyprobitLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitLayer::fill(self : MlclassifyprobitLayer, v : Double) -> MlclassifyprobitLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitLayer::min(self : MlclassifyprobitLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitLayer::max(self : MlclassifyprobitLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitLayer::to_string(self : MlclassifyprobitLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_buffer_make(size : Int) -> MlclassifyprobitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitBuffer::len(self : MlclassifyprobitBuffer) -> Int { self.size }

pub fn MlclassifyprobitBuffer::get(self : MlclassifyprobitBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitBuffer::set(self : MlclassifyprobitBuffer, i : Int, v : Double) -> MlclassifyprobitBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitBuffer::sum(self : MlclassifyprobitBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitBuffer::mean(self : MlclassifyprobitBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitBuffer::scale(self : MlclassifyprobitBuffer, f : Double) -> MlclassifyprobitBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitBuffer::add(self : MlclassifyprobitBuffer, other : MlclassifyprobitBuffer) -> MlclassifyprobitBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitBuffer::copy(self : MlclassifyprobitBuffer) -> MlclassifyprobitBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitBuffer::fill(self : MlclassifyprobitBuffer, v : Double) -> MlclassifyprobitBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitBuffer::min(self : MlclassifyprobitBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitBuffer::max(self : MlclassifyprobitBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitBuffer::to_string(self : MlclassifyprobitBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_cursor_make(size : Int) -> MlclassifyprobitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitCursor::len(self : MlclassifyprobitCursor) -> Int { self.size }

pub fn MlclassifyprobitCursor::get(self : MlclassifyprobitCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitCursor::set(self : MlclassifyprobitCursor, i : Int, v : Double) -> MlclassifyprobitCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCursor::sum(self : MlclassifyprobitCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitCursor::mean(self : MlclassifyprobitCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitCursor::scale(self : MlclassifyprobitCursor, f : Double) -> MlclassifyprobitCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCursor::add(self : MlclassifyprobitCursor, other : MlclassifyprobitCursor) -> MlclassifyprobitCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitCursor::copy(self : MlclassifyprobitCursor) -> MlclassifyprobitCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCursor::fill(self : MlclassifyprobitCursor, v : Double) -> MlclassifyprobitCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitCursor::min(self : MlclassifyprobitCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitCursor::max(self : MlclassifyprobitCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitCursor::to_string(self : MlclassifyprobitCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_view_make(size : Int) -> MlclassifyprobitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitView::len(self : MlclassifyprobitView) -> Int { self.size }

pub fn MlclassifyprobitView::get(self : MlclassifyprobitView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitView::set(self : MlclassifyprobitView, i : Int, v : Double) -> MlclassifyprobitView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitView::sum(self : MlclassifyprobitView) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitView::mean(self : MlclassifyprobitView) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitView::scale(self : MlclassifyprobitView, f : Double) -> MlclassifyprobitView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitView::add(self : MlclassifyprobitView, other : MlclassifyprobitView) -> MlclassifyprobitView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitView::copy(self : MlclassifyprobitView) -> MlclassifyprobitView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitView::fill(self : MlclassifyprobitView, v : Double) -> MlclassifyprobitView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitView::min(self : MlclassifyprobitView) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitView::max(self : MlclassifyprobitView) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitView::to_string(self : MlclassifyprobitView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_range_make(size : Int) -> MlclassifyprobitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitRange::len(self : MlclassifyprobitRange) -> Int { self.size }

pub fn MlclassifyprobitRange::get(self : MlclassifyprobitRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitRange::set(self : MlclassifyprobitRange, i : Int, v : Double) -> MlclassifyprobitRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitRange::sum(self : MlclassifyprobitRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitRange::mean(self : MlclassifyprobitRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitRange::scale(self : MlclassifyprobitRange, f : Double) -> MlclassifyprobitRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitRange::add(self : MlclassifyprobitRange, other : MlclassifyprobitRange) -> MlclassifyprobitRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitRange::copy(self : MlclassifyprobitRange) -> MlclassifyprobitRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitRange::fill(self : MlclassifyprobitRange, v : Double) -> MlclassifyprobitRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitRange::min(self : MlclassifyprobitRange) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitRange::max(self : MlclassifyprobitRange) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitRange::to_string(self : MlclassifyprobitRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_slice_make(size : Int) -> MlclassifyprobitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyprobitSlice::len(self : MlclassifyprobitSlice) -> Int { self.size }

pub fn MlclassifyprobitSlice::get(self : MlclassifyprobitSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyprobitSlice::set(self : MlclassifyprobitSlice, i : Int, v : Double) -> MlclassifyprobitSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitSlice::sum(self : MlclassifyprobitSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifyprobitSlice::mean(self : MlclassifyprobitSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifyprobitSlice::scale(self : MlclassifyprobitSlice, f : Double) -> MlclassifyprobitSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitSlice::add(self : MlclassifyprobitSlice, other : MlclassifyprobitSlice) -> MlclassifyprobitSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyprobitSlice::copy(self : MlclassifyprobitSlice) -> MlclassifyprobitSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitSlice::fill(self : MlclassifyprobitSlice, v : Double) -> MlclassifyprobitSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyprobitSlice::min(self : MlclassifyprobitSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifyprobitSlice::max(self : MlclassifyprobitSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifyprobitSlice::to_string(self : MlclassifyprobitSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

