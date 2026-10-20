///===
/// extcore/ml_classify_tree

pub(all) struct MlclassifytreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_tree_make_point(x : Double, y : Double) -> MlclassifytreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_tree_make_point3(x : Double, y : Double, z : Double) -> MlclassifytreePoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifytreePoint::x(self : MlclassifytreePoint) -> Double { self.x }

pub fn MlclassifytreePoint::y(self : MlclassifytreePoint) -> Double { self.y }

pub fn MlclassifytreePoint::z(self : MlclassifytreePoint) -> Double { self.z }

pub fn MlclassifytreePoint::label(self : MlclassifytreePoint) -> Int { self.label }

pub fn MlclassifytreePoint::dist(self : MlclassifytreePoint, other : MlclassifytreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifytreePoint::add(self : MlclassifytreePoint, other : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifytreePoint::sub(self : MlclassifytreePoint, other : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifytreePoint::scale(self : MlclassifytreePoint, s : Double) -> MlclassifytreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifytreePoint::dot(self : MlclassifytreePoint, other : MlclassifytreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifytreePoint::cross(self : MlclassifytreePoint, other : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifytreePoint::norm(self : MlclassifytreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifytreePoint::normalize(self : MlclassifytreePoint) -> MlclassifytreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifytreePoint::negate(self : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifytreePoint::mid(self : MlclassifytreePoint, other : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifytreePoint::lerp(self : MlclassifytreePoint, other : MlclassifytreePoint, t : Double) -> MlclassifytreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifytreePoint::to_string(self : MlclassifytreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifytreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_tree_make_series(vals : Array[Double], name : String) -> MlclassifytreeSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifytreeSeries::len(self : MlclassifytreeSeries) -> Int { self.vals.length() }

pub fn MlclassifytreeSeries::sum(self : MlclassifytreeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifytreeSeries::mean(self : MlclassifytreeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifytreeSeries::min(self : MlclassifytreeSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifytreeSeries::max(self : MlclassifytreeSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifytreeSeries::range(self : MlclassifytreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifytreeSeries::variance(self : MlclassifytreeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifytreeSeries::std(self : MlclassifytreeSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifytreeSeries::median(self : MlclassifytreeSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifytreeSeries::scale(self : MlclassifytreeSeries, f : Double) -> MlclassifytreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifytreeSeries::add(self : MlclassifytreeSeries, other : MlclassifytreeSeries) -> MlclassifytreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifytreeSeries::sub(self : MlclassifytreeSeries, other : MlclassifytreeSeries) -> MlclassifytreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifytreeSeries::normalize(self : MlclassifytreeSeries) -> MlclassifytreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifytreeSeries::cumsum(self : MlclassifytreeSeries) -> MlclassifytreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifytreeSeries::to_string(self : MlclassifytreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifytreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_tree_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifytreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_tree_matrix_identity(n : Int) -> MlclassifytreeMatrix {
  let m = ml_classify_tree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifytreeMatrix::get(self : MlclassifytreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifytreeMatrix::transpose(self : MlclassifytreeMatrix) -> MlclassifytreeMatrix {
  let result = ml_classify_tree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifytreeMatrix::add(self : MlclassifytreeMatrix, other : MlclassifytreeMatrix) -> MlclassifytreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_tree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifytreeMatrix::scale(self : MlclassifytreeMatrix, s : Double) -> MlclassifytreeMatrix {
  let result = ml_classify_tree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifytreeMatrix::multiply(self : MlclassifytreeMatrix, other : MlclassifytreeMatrix) -> MlclassifytreeMatrix {
  if self.cols != other.rows { return ml_classify_tree_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_tree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlclassifytreeMatrix::trace(self : MlclassifytreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifytreeMatrix::det(self : MlclassifytreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifytreeMatrix::norm(self : MlclassifytreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifytreeMatrix::to_string(self : MlclassifytreeMatrix) -> String {
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

pub(all) struct MlclassifytreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_tree_make_vector(comps : Array[Double]) -> MlclassifytreeVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_tree_vector_zero(dim : Int) -> MlclassifytreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifytreeVector::add(self : MlclassifytreeVector, other : MlclassifytreeVector) -> MlclassifytreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifytreeVector::sub(self : MlclassifytreeVector, other : MlclassifytreeVector) -> MlclassifytreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifytreeVector::scale(self : MlclassifytreeVector, s : Double) -> MlclassifytreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifytreeVector::dot(self : MlclassifytreeVector, other : MlclassifytreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifytreeVector::norm(self : MlclassifytreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifytreeVector::normalize(self : MlclassifytreeVector) -> MlclassifytreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifytreeVector::dist(self : MlclassifytreeVector, other : MlclassifytreeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifytreeVector::to_string(self : MlclassifytreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifytreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_frame_make(size : Int) -> MlclassifytreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeFrame::len(self : MlclassifytreeFrame) -> Int { self.size }

pub fn MlclassifytreeFrame::get(self : MlclassifytreeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeFrame::set(self : MlclassifytreeFrame, i : Int, v : Double) -> MlclassifytreeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeFrame::sum(self : MlclassifytreeFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeFrame::mean(self : MlclassifytreeFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeFrame::scale(self : MlclassifytreeFrame, f : Double) -> MlclassifytreeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeFrame::add(self : MlclassifytreeFrame, other : MlclassifytreeFrame) -> MlclassifytreeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeFrame::copy(self : MlclassifytreeFrame) -> MlclassifytreeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeFrame::fill(self : MlclassifytreeFrame, v : Double) -> MlclassifytreeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeFrame::min(self : MlclassifytreeFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeFrame::max(self : MlclassifytreeFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeFrame::to_string(self : MlclassifytreeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_table_make(size : Int) -> MlclassifytreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeTable::len(self : MlclassifytreeTable) -> Int { self.size }

pub fn MlclassifytreeTable::get(self : MlclassifytreeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeTable::set(self : MlclassifytreeTable, i : Int, v : Double) -> MlclassifytreeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeTable::sum(self : MlclassifytreeTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeTable::mean(self : MlclassifytreeTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeTable::scale(self : MlclassifytreeTable, f : Double) -> MlclassifytreeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeTable::add(self : MlclassifytreeTable, other : MlclassifytreeTable) -> MlclassifytreeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeTable::copy(self : MlclassifytreeTable) -> MlclassifytreeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeTable::fill(self : MlclassifytreeTable, v : Double) -> MlclassifytreeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeTable::min(self : MlclassifytreeTable) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeTable::max(self : MlclassifytreeTable) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeTable::to_string(self : MlclassifytreeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_graphn_make(size : Int) -> MlclassifytreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeGraphN::len(self : MlclassifytreeGraphN) -> Int { self.size }

pub fn MlclassifytreeGraphN::get(self : MlclassifytreeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeGraphN::set(self : MlclassifytreeGraphN, i : Int, v : Double) -> MlclassifytreeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeGraphN::sum(self : MlclassifytreeGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeGraphN::mean(self : MlclassifytreeGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeGraphN::scale(self : MlclassifytreeGraphN, f : Double) -> MlclassifytreeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeGraphN::add(self : MlclassifytreeGraphN, other : MlclassifytreeGraphN) -> MlclassifytreeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeGraphN::copy(self : MlclassifytreeGraphN) -> MlclassifytreeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeGraphN::fill(self : MlclassifytreeGraphN, v : Double) -> MlclassifytreeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeGraphN::min(self : MlclassifytreeGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeGraphN::max(self : MlclassifytreeGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeGraphN::to_string(self : MlclassifytreeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_node_make(size : Int) -> MlclassifytreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeNode::len(self : MlclassifytreeNode) -> Int { self.size }

pub fn MlclassifytreeNode::get(self : MlclassifytreeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeNode::set(self : MlclassifytreeNode, i : Int, v : Double) -> MlclassifytreeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeNode::sum(self : MlclassifytreeNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeNode::mean(self : MlclassifytreeNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeNode::scale(self : MlclassifytreeNode, f : Double) -> MlclassifytreeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeNode::add(self : MlclassifytreeNode, other : MlclassifytreeNode) -> MlclassifytreeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeNode::copy(self : MlclassifytreeNode) -> MlclassifytreeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeNode::fill(self : MlclassifytreeNode, v : Double) -> MlclassifytreeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeNode::min(self : MlclassifytreeNode) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeNode::max(self : MlclassifytreeNode) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeNode::to_string(self : MlclassifytreeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_edge_make(size : Int) -> MlclassifytreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeEdge::len(self : MlclassifytreeEdge) -> Int { self.size }

pub fn MlclassifytreeEdge::get(self : MlclassifytreeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeEdge::set(self : MlclassifytreeEdge, i : Int, v : Double) -> MlclassifytreeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeEdge::sum(self : MlclassifytreeEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeEdge::mean(self : MlclassifytreeEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeEdge::scale(self : MlclassifytreeEdge, f : Double) -> MlclassifytreeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeEdge::add(self : MlclassifytreeEdge, other : MlclassifytreeEdge) -> MlclassifytreeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeEdge::copy(self : MlclassifytreeEdge) -> MlclassifytreeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeEdge::fill(self : MlclassifytreeEdge, v : Double) -> MlclassifytreeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeEdge::min(self : MlclassifytreeEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeEdge::max(self : MlclassifytreeEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeEdge::to_string(self : MlclassifytreeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_path_make(size : Int) -> MlclassifytreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreePath::len(self : MlclassifytreePath) -> Int { self.size }

pub fn MlclassifytreePath::get(self : MlclassifytreePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreePath::set(self : MlclassifytreePath, i : Int, v : Double) -> MlclassifytreePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreePath::sum(self : MlclassifytreePath) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreePath::mean(self : MlclassifytreePath) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreePath::scale(self : MlclassifytreePath, f : Double) -> MlclassifytreePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreePath::add(self : MlclassifytreePath, other : MlclassifytreePath) -> MlclassifytreePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreePath::copy(self : MlclassifytreePath) -> MlclassifytreePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreePath::fill(self : MlclassifytreePath, v : Double) -> MlclassifytreePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreePath::min(self : MlclassifytreePath) -> Double { @_common.min(self.data) }

pub fn MlclassifytreePath::max(self : MlclassifytreePath) -> Double { @_common.max(self.data) }

pub fn MlclassifytreePath::to_string(self : MlclassifytreePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_cluster_make(size : Int) -> MlclassifytreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeCluster::len(self : MlclassifytreeCluster) -> Int { self.size }

pub fn MlclassifytreeCluster::get(self : MlclassifytreeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeCluster::set(self : MlclassifytreeCluster, i : Int, v : Double) -> MlclassifytreeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCluster::sum(self : MlclassifytreeCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeCluster::mean(self : MlclassifytreeCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeCluster::scale(self : MlclassifytreeCluster, f : Double) -> MlclassifytreeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCluster::add(self : MlclassifytreeCluster, other : MlclassifytreeCluster) -> MlclassifytreeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeCluster::copy(self : MlclassifytreeCluster) -> MlclassifytreeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCluster::fill(self : MlclassifytreeCluster, v : Double) -> MlclassifytreeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCluster::min(self : MlclassifytreeCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeCluster::max(self : MlclassifytreeCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeCluster::to_string(self : MlclassifytreeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_model_make(size : Int) -> MlclassifytreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeModel::len(self : MlclassifytreeModel) -> Int { self.size }

pub fn MlclassifytreeModel::get(self : MlclassifytreeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeModel::set(self : MlclassifytreeModel, i : Int, v : Double) -> MlclassifytreeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeModel::sum(self : MlclassifytreeModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeModel::mean(self : MlclassifytreeModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeModel::scale(self : MlclassifytreeModel, f : Double) -> MlclassifytreeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeModel::add(self : MlclassifytreeModel, other : MlclassifytreeModel) -> MlclassifytreeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeModel::copy(self : MlclassifytreeModel) -> MlclassifytreeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeModel::fill(self : MlclassifytreeModel, v : Double) -> MlclassifytreeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeModel::min(self : MlclassifytreeModel) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeModel::max(self : MlclassifytreeModel) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeModel::to_string(self : MlclassifytreeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_layer_make(size : Int) -> MlclassifytreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeLayer::len(self : MlclassifytreeLayer) -> Int { self.size }

pub fn MlclassifytreeLayer::get(self : MlclassifytreeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeLayer::set(self : MlclassifytreeLayer, i : Int, v : Double) -> MlclassifytreeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeLayer::sum(self : MlclassifytreeLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeLayer::mean(self : MlclassifytreeLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeLayer::scale(self : MlclassifytreeLayer, f : Double) -> MlclassifytreeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeLayer::add(self : MlclassifytreeLayer, other : MlclassifytreeLayer) -> MlclassifytreeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeLayer::copy(self : MlclassifytreeLayer) -> MlclassifytreeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeLayer::fill(self : MlclassifytreeLayer, v : Double) -> MlclassifytreeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeLayer::min(self : MlclassifytreeLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeLayer::max(self : MlclassifytreeLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeLayer::to_string(self : MlclassifytreeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_buffer_make(size : Int) -> MlclassifytreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeBuffer::len(self : MlclassifytreeBuffer) -> Int { self.size }

pub fn MlclassifytreeBuffer::get(self : MlclassifytreeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeBuffer::set(self : MlclassifytreeBuffer, i : Int, v : Double) -> MlclassifytreeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeBuffer::sum(self : MlclassifytreeBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeBuffer::mean(self : MlclassifytreeBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeBuffer::scale(self : MlclassifytreeBuffer, f : Double) -> MlclassifytreeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeBuffer::add(self : MlclassifytreeBuffer, other : MlclassifytreeBuffer) -> MlclassifytreeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeBuffer::copy(self : MlclassifytreeBuffer) -> MlclassifytreeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeBuffer::fill(self : MlclassifytreeBuffer, v : Double) -> MlclassifytreeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeBuffer::min(self : MlclassifytreeBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeBuffer::max(self : MlclassifytreeBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeBuffer::to_string(self : MlclassifytreeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_cursor_make(size : Int) -> MlclassifytreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeCursor::len(self : MlclassifytreeCursor) -> Int { self.size }

pub fn MlclassifytreeCursor::get(self : MlclassifytreeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeCursor::set(self : MlclassifytreeCursor, i : Int, v : Double) -> MlclassifytreeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCursor::sum(self : MlclassifytreeCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeCursor::mean(self : MlclassifytreeCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeCursor::scale(self : MlclassifytreeCursor, f : Double) -> MlclassifytreeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCursor::add(self : MlclassifytreeCursor, other : MlclassifytreeCursor) -> MlclassifytreeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeCursor::copy(self : MlclassifytreeCursor) -> MlclassifytreeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCursor::fill(self : MlclassifytreeCursor, v : Double) -> MlclassifytreeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeCursor::min(self : MlclassifytreeCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeCursor::max(self : MlclassifytreeCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeCursor::to_string(self : MlclassifytreeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_view_make(size : Int) -> MlclassifytreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeView::len(self : MlclassifytreeView) -> Int { self.size }

pub fn MlclassifytreeView::get(self : MlclassifytreeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeView::set(self : MlclassifytreeView, i : Int, v : Double) -> MlclassifytreeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeView::sum(self : MlclassifytreeView) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeView::mean(self : MlclassifytreeView) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeView::scale(self : MlclassifytreeView, f : Double) -> MlclassifytreeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeView::add(self : MlclassifytreeView, other : MlclassifytreeView) -> MlclassifytreeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeView::copy(self : MlclassifytreeView) -> MlclassifytreeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeView::fill(self : MlclassifytreeView, v : Double) -> MlclassifytreeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeView::min(self : MlclassifytreeView) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeView::max(self : MlclassifytreeView) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeView::to_string(self : MlclassifytreeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_range_make(size : Int) -> MlclassifytreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeRange::len(self : MlclassifytreeRange) -> Int { self.size }

pub fn MlclassifytreeRange::get(self : MlclassifytreeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeRange::set(self : MlclassifytreeRange, i : Int, v : Double) -> MlclassifytreeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeRange::sum(self : MlclassifytreeRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeRange::mean(self : MlclassifytreeRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeRange::scale(self : MlclassifytreeRange, f : Double) -> MlclassifytreeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeRange::add(self : MlclassifytreeRange, other : MlclassifytreeRange) -> MlclassifytreeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeRange::copy(self : MlclassifytreeRange) -> MlclassifytreeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeRange::fill(self : MlclassifytreeRange, v : Double) -> MlclassifytreeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeRange::min(self : MlclassifytreeRange) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeRange::max(self : MlclassifytreeRange) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeRange::to_string(self : MlclassifytreeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_slice_make(size : Int) -> MlclassifytreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifytreeSlice::len(self : MlclassifytreeSlice) -> Int { self.size }

pub fn MlclassifytreeSlice::get(self : MlclassifytreeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifytreeSlice::set(self : MlclassifytreeSlice, i : Int, v : Double) -> MlclassifytreeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifytreeSlice::sum(self : MlclassifytreeSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifytreeSlice::mean(self : MlclassifytreeSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifytreeSlice::scale(self : MlclassifytreeSlice, f : Double) -> MlclassifytreeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeSlice::add(self : MlclassifytreeSlice, other : MlclassifytreeSlice) -> MlclassifytreeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifytreeSlice::copy(self : MlclassifytreeSlice) -> MlclassifytreeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeSlice::fill(self : MlclassifytreeSlice, v : Double) -> MlclassifytreeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifytreeSlice::min(self : MlclassifytreeSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifytreeSlice::max(self : MlclassifytreeSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifytreeSlice::to_string(self : MlclassifytreeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

