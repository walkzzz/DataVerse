///===
/// extcore/ml_classify_forest

pub(all) struct MlclassifyforestPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_forest_make_point(x : Double, y : Double) -> MlclassifyforestPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_forest_make_point3(x : Double, y : Double, z : Double) -> MlclassifyforestPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyforestPoint::x(self : MlclassifyforestPoint) -> Double { self.x }

pub fn MlclassifyforestPoint::y(self : MlclassifyforestPoint) -> Double { self.y }

pub fn MlclassifyforestPoint::z(self : MlclassifyforestPoint) -> Double { self.z }

pub fn MlclassifyforestPoint::label(self : MlclassifyforestPoint) -> Int { self.label }

pub fn MlclassifyforestPoint::dist(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyforestPoint::add(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyforestPoint::sub(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyforestPoint::scale(self : MlclassifyforestPoint, s : Double) -> MlclassifyforestPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyforestPoint::dot(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyforestPoint::cross(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyforestPoint::norm(self : MlclassifyforestPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyforestPoint::normalize(self : MlclassifyforestPoint) -> MlclassifyforestPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyforestPoint::negate(self : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyforestPoint::mid(self : MlclassifyforestPoint, other : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyforestPoint::lerp(self : MlclassifyforestPoint, other : MlclassifyforestPoint, t : Double) -> MlclassifyforestPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyforestPoint::to_string(self : MlclassifyforestPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyforestSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_forest_make_series(vals : Array[Double], name : String) -> MlclassifyforestSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyforestSeries::len(self : MlclassifyforestSeries) -> Int { self.vals.length() }

pub fn MlclassifyforestSeries::sum(self : MlclassifyforestSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyforestSeries::mean(self : MlclassifyforestSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyforestSeries::min(self : MlclassifyforestSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyforestSeries::max(self : MlclassifyforestSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyforestSeries::range(self : MlclassifyforestSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyforestSeries::variance(self : MlclassifyforestSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyforestSeries::std(self : MlclassifyforestSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyforestSeries::median(self : MlclassifyforestSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyforestSeries::scale(self : MlclassifyforestSeries, f : Double) -> MlclassifyforestSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyforestSeries::add(self : MlclassifyforestSeries, other : MlclassifyforestSeries) -> MlclassifyforestSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyforestSeries::sub(self : MlclassifyforestSeries, other : MlclassifyforestSeries) -> MlclassifyforestSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyforestSeries::normalize(self : MlclassifyforestSeries) -> MlclassifyforestSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyforestSeries::cumsum(self : MlclassifyforestSeries) -> MlclassifyforestSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyforestSeries::to_string(self : MlclassifyforestSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyforestMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_forest_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyforestMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_forest_matrix_identity(n : Int) -> MlclassifyforestMatrix {
  let m = ml_classify_forest_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyforestMatrix::get(self : MlclassifyforestMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyforestMatrix::transpose(self : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  let result = ml_classify_forest_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyforestMatrix::add(self : MlclassifyforestMatrix, other : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_forest_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyforestMatrix::scale(self : MlclassifyforestMatrix, s : Double) -> MlclassifyforestMatrix {
  let result = ml_classify_forest_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyforestMatrix::multiply(self : MlclassifyforestMatrix, other : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  if self.cols != other.rows { return ml_classify_forest_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_forest_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlclassifyforestMatrix::trace(self : MlclassifyforestMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyforestMatrix::det(self : MlclassifyforestMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyforestMatrix::norm(self : MlclassifyforestMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyforestMatrix::to_string(self : MlclassifyforestMatrix) -> String {
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

pub(all) struct MlclassifyforestVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_forest_make_vector(comps : Array[Double]) -> MlclassifyforestVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_forest_vector_zero(dim : Int) -> MlclassifyforestVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyforestVector::add(self : MlclassifyforestVector, other : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyforestVector::sub(self : MlclassifyforestVector, other : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyforestVector::scale(self : MlclassifyforestVector, s : Double) -> MlclassifyforestVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyforestVector::dot(self : MlclassifyforestVector, other : MlclassifyforestVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyforestVector::norm(self : MlclassifyforestVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyforestVector::normalize(self : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyforestVector::dist(self : MlclassifyforestVector, other : MlclassifyforestVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyforestVector::to_string(self : MlclassifyforestVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyforestFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_frame_make(size : Int) -> MlclassifyforestFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestFrame::len(self : MlclassifyforestFrame) -> Int { self.size }

pub fn MlclassifyforestFrame::get(self : MlclassifyforestFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestFrame::set(self : MlclassifyforestFrame, i : Int, v : Double) -> MlclassifyforestFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestFrame::sum(self : MlclassifyforestFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestFrame::mean(self : MlclassifyforestFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestFrame::scale(self : MlclassifyforestFrame, f : Double) -> MlclassifyforestFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestFrame::add(self : MlclassifyforestFrame, other : MlclassifyforestFrame) -> MlclassifyforestFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestFrame::copy(self : MlclassifyforestFrame) -> MlclassifyforestFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestFrame::fill(self : MlclassifyforestFrame, v : Double) -> MlclassifyforestFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestFrame::min(self : MlclassifyforestFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestFrame::max(self : MlclassifyforestFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestFrame::to_string(self : MlclassifyforestFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_table_make(size : Int) -> MlclassifyforestTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestTable::len(self : MlclassifyforestTable) -> Int { self.size }

pub fn MlclassifyforestTable::get(self : MlclassifyforestTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestTable::set(self : MlclassifyforestTable, i : Int, v : Double) -> MlclassifyforestTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestTable::sum(self : MlclassifyforestTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestTable::mean(self : MlclassifyforestTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestTable::scale(self : MlclassifyforestTable, f : Double) -> MlclassifyforestTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestTable::add(self : MlclassifyforestTable, other : MlclassifyforestTable) -> MlclassifyforestTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestTable::copy(self : MlclassifyforestTable) -> MlclassifyforestTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestTable::fill(self : MlclassifyforestTable, v : Double) -> MlclassifyforestTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestTable::min(self : MlclassifyforestTable) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestTable::max(self : MlclassifyforestTable) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestTable::to_string(self : MlclassifyforestTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_graphn_make(size : Int) -> MlclassifyforestGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestGraphN::len(self : MlclassifyforestGraphN) -> Int { self.size }

pub fn MlclassifyforestGraphN::get(self : MlclassifyforestGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestGraphN::set(self : MlclassifyforestGraphN, i : Int, v : Double) -> MlclassifyforestGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestGraphN::sum(self : MlclassifyforestGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestGraphN::mean(self : MlclassifyforestGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestGraphN::scale(self : MlclassifyforestGraphN, f : Double) -> MlclassifyforestGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestGraphN::add(self : MlclassifyforestGraphN, other : MlclassifyforestGraphN) -> MlclassifyforestGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestGraphN::copy(self : MlclassifyforestGraphN) -> MlclassifyforestGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestGraphN::fill(self : MlclassifyforestGraphN, v : Double) -> MlclassifyforestGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestGraphN::min(self : MlclassifyforestGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestGraphN::max(self : MlclassifyforestGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestGraphN::to_string(self : MlclassifyforestGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_node_make(size : Int) -> MlclassifyforestNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestNode::len(self : MlclassifyforestNode) -> Int { self.size }

pub fn MlclassifyforestNode::get(self : MlclassifyforestNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestNode::set(self : MlclassifyforestNode, i : Int, v : Double) -> MlclassifyforestNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestNode::sum(self : MlclassifyforestNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestNode::mean(self : MlclassifyforestNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestNode::scale(self : MlclassifyforestNode, f : Double) -> MlclassifyforestNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestNode::add(self : MlclassifyforestNode, other : MlclassifyforestNode) -> MlclassifyforestNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestNode::copy(self : MlclassifyforestNode) -> MlclassifyforestNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestNode::fill(self : MlclassifyforestNode, v : Double) -> MlclassifyforestNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestNode::min(self : MlclassifyforestNode) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestNode::max(self : MlclassifyforestNode) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestNode::to_string(self : MlclassifyforestNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_edge_make(size : Int) -> MlclassifyforestEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestEdge::len(self : MlclassifyforestEdge) -> Int { self.size }

pub fn MlclassifyforestEdge::get(self : MlclassifyforestEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestEdge::set(self : MlclassifyforestEdge, i : Int, v : Double) -> MlclassifyforestEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestEdge::sum(self : MlclassifyforestEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestEdge::mean(self : MlclassifyforestEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestEdge::scale(self : MlclassifyforestEdge, f : Double) -> MlclassifyforestEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestEdge::add(self : MlclassifyforestEdge, other : MlclassifyforestEdge) -> MlclassifyforestEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestEdge::copy(self : MlclassifyforestEdge) -> MlclassifyforestEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestEdge::fill(self : MlclassifyforestEdge, v : Double) -> MlclassifyforestEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestEdge::min(self : MlclassifyforestEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestEdge::max(self : MlclassifyforestEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestEdge::to_string(self : MlclassifyforestEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_path_make(size : Int) -> MlclassifyforestPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestPath::len(self : MlclassifyforestPath) -> Int { self.size }

pub fn MlclassifyforestPath::get(self : MlclassifyforestPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestPath::set(self : MlclassifyforestPath, i : Int, v : Double) -> MlclassifyforestPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestPath::sum(self : MlclassifyforestPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestPath::mean(self : MlclassifyforestPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestPath::scale(self : MlclassifyforestPath, f : Double) -> MlclassifyforestPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestPath::add(self : MlclassifyforestPath, other : MlclassifyforestPath) -> MlclassifyforestPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestPath::copy(self : MlclassifyforestPath) -> MlclassifyforestPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestPath::fill(self : MlclassifyforestPath, v : Double) -> MlclassifyforestPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestPath::min(self : MlclassifyforestPath) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestPath::max(self : MlclassifyforestPath) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestPath::to_string(self : MlclassifyforestPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_cluster_make(size : Int) -> MlclassifyforestCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestCluster::len(self : MlclassifyforestCluster) -> Int { self.size }

pub fn MlclassifyforestCluster::get(self : MlclassifyforestCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestCluster::set(self : MlclassifyforestCluster, i : Int, v : Double) -> MlclassifyforestCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCluster::sum(self : MlclassifyforestCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestCluster::mean(self : MlclassifyforestCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestCluster::scale(self : MlclassifyforestCluster, f : Double) -> MlclassifyforestCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCluster::add(self : MlclassifyforestCluster, other : MlclassifyforestCluster) -> MlclassifyforestCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestCluster::copy(self : MlclassifyforestCluster) -> MlclassifyforestCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCluster::fill(self : MlclassifyforestCluster, v : Double) -> MlclassifyforestCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCluster::min(self : MlclassifyforestCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestCluster::max(self : MlclassifyforestCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestCluster::to_string(self : MlclassifyforestCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_model_make(size : Int) -> MlclassifyforestModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestModel::len(self : MlclassifyforestModel) -> Int { self.size }

pub fn MlclassifyforestModel::get(self : MlclassifyforestModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestModel::set(self : MlclassifyforestModel, i : Int, v : Double) -> MlclassifyforestModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestModel::sum(self : MlclassifyforestModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestModel::mean(self : MlclassifyforestModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestModel::scale(self : MlclassifyforestModel, f : Double) -> MlclassifyforestModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestModel::add(self : MlclassifyforestModel, other : MlclassifyforestModel) -> MlclassifyforestModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestModel::copy(self : MlclassifyforestModel) -> MlclassifyforestModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestModel::fill(self : MlclassifyforestModel, v : Double) -> MlclassifyforestModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestModel::min(self : MlclassifyforestModel) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestModel::max(self : MlclassifyforestModel) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestModel::to_string(self : MlclassifyforestModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_layer_make(size : Int) -> MlclassifyforestLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestLayer::len(self : MlclassifyforestLayer) -> Int { self.size }

pub fn MlclassifyforestLayer::get(self : MlclassifyforestLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestLayer::set(self : MlclassifyforestLayer, i : Int, v : Double) -> MlclassifyforestLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestLayer::sum(self : MlclassifyforestLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestLayer::mean(self : MlclassifyforestLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestLayer::scale(self : MlclassifyforestLayer, f : Double) -> MlclassifyforestLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestLayer::add(self : MlclassifyforestLayer, other : MlclassifyforestLayer) -> MlclassifyforestLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestLayer::copy(self : MlclassifyforestLayer) -> MlclassifyforestLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestLayer::fill(self : MlclassifyforestLayer, v : Double) -> MlclassifyforestLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestLayer::min(self : MlclassifyforestLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestLayer::max(self : MlclassifyforestLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestLayer::to_string(self : MlclassifyforestLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_buffer_make(size : Int) -> MlclassifyforestBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestBuffer::len(self : MlclassifyforestBuffer) -> Int { self.size }

pub fn MlclassifyforestBuffer::get(self : MlclassifyforestBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestBuffer::set(self : MlclassifyforestBuffer, i : Int, v : Double) -> MlclassifyforestBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestBuffer::sum(self : MlclassifyforestBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestBuffer::mean(self : MlclassifyforestBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestBuffer::scale(self : MlclassifyforestBuffer, f : Double) -> MlclassifyforestBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestBuffer::add(self : MlclassifyforestBuffer, other : MlclassifyforestBuffer) -> MlclassifyforestBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestBuffer::copy(self : MlclassifyforestBuffer) -> MlclassifyforestBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestBuffer::fill(self : MlclassifyforestBuffer, v : Double) -> MlclassifyforestBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestBuffer::min(self : MlclassifyforestBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestBuffer::max(self : MlclassifyforestBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestBuffer::to_string(self : MlclassifyforestBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_cursor_make(size : Int) -> MlclassifyforestCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestCursor::len(self : MlclassifyforestCursor) -> Int { self.size }

pub fn MlclassifyforestCursor::get(self : MlclassifyforestCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestCursor::set(self : MlclassifyforestCursor, i : Int, v : Double) -> MlclassifyforestCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCursor::sum(self : MlclassifyforestCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestCursor::mean(self : MlclassifyforestCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestCursor::scale(self : MlclassifyforestCursor, f : Double) -> MlclassifyforestCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCursor::add(self : MlclassifyforestCursor, other : MlclassifyforestCursor) -> MlclassifyforestCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestCursor::copy(self : MlclassifyforestCursor) -> MlclassifyforestCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCursor::fill(self : MlclassifyforestCursor, v : Double) -> MlclassifyforestCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestCursor::min(self : MlclassifyforestCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestCursor::max(self : MlclassifyforestCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestCursor::to_string(self : MlclassifyforestCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_view_make(size : Int) -> MlclassifyforestView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestView::len(self : MlclassifyforestView) -> Int { self.size }

pub fn MlclassifyforestView::get(self : MlclassifyforestView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestView::set(self : MlclassifyforestView, i : Int, v : Double) -> MlclassifyforestView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestView::sum(self : MlclassifyforestView) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestView::mean(self : MlclassifyforestView) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestView::scale(self : MlclassifyforestView, f : Double) -> MlclassifyforestView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestView::add(self : MlclassifyforestView, other : MlclassifyforestView) -> MlclassifyforestView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestView::copy(self : MlclassifyforestView) -> MlclassifyforestView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestView::fill(self : MlclassifyforestView, v : Double) -> MlclassifyforestView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestView::min(self : MlclassifyforestView) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestView::max(self : MlclassifyforestView) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestView::to_string(self : MlclassifyforestView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_range_make(size : Int) -> MlclassifyforestRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestRange::len(self : MlclassifyforestRange) -> Int { self.size }

pub fn MlclassifyforestRange::get(self : MlclassifyforestRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestRange::set(self : MlclassifyforestRange, i : Int, v : Double) -> MlclassifyforestRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestRange::sum(self : MlclassifyforestRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestRange::mean(self : MlclassifyforestRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestRange::scale(self : MlclassifyforestRange, f : Double) -> MlclassifyforestRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestRange::add(self : MlclassifyforestRange, other : MlclassifyforestRange) -> MlclassifyforestRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestRange::copy(self : MlclassifyforestRange) -> MlclassifyforestRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestRange::fill(self : MlclassifyforestRange, v : Double) -> MlclassifyforestRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestRange::min(self : MlclassifyforestRange) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestRange::max(self : MlclassifyforestRange) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestRange::to_string(self : MlclassifyforestRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_slice_make(size : Int) -> MlclassifyforestSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyforestSlice::len(self : MlclassifyforestSlice) -> Int { self.size }

pub fn MlclassifyforestSlice::get(self : MlclassifyforestSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyforestSlice::set(self : MlclassifyforestSlice, i : Int, v : Double) -> MlclassifyforestSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyforestSlice::sum(self : MlclassifyforestSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifyforestSlice::mean(self : MlclassifyforestSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifyforestSlice::scale(self : MlclassifyforestSlice, f : Double) -> MlclassifyforestSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestSlice::add(self : MlclassifyforestSlice, other : MlclassifyforestSlice) -> MlclassifyforestSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyforestSlice::copy(self : MlclassifyforestSlice) -> MlclassifyforestSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestSlice::fill(self : MlclassifyforestSlice, v : Double) -> MlclassifyforestSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyforestSlice::min(self : MlclassifyforestSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifyforestSlice::max(self : MlclassifyforestSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifyforestSlice::to_string(self : MlclassifyforestSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

