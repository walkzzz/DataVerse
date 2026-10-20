///===
/// extcore/ml_classify_lda

pub(all) struct MlclassifyldaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_lda_make_point(x : Double, y : Double) -> MlclassifyldaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_lda_make_point3(x : Double, y : Double, z : Double) -> MlclassifyldaPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyldaPoint::x(self : MlclassifyldaPoint) -> Double { self.x }

pub fn MlclassifyldaPoint::y(self : MlclassifyldaPoint) -> Double { self.y }

pub fn MlclassifyldaPoint::z(self : MlclassifyldaPoint) -> Double { self.z }

pub fn MlclassifyldaPoint::label(self : MlclassifyldaPoint) -> Int { self.label }

pub fn MlclassifyldaPoint::dist(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyldaPoint::add(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyldaPoint::sub(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyldaPoint::scale(self : MlclassifyldaPoint, s : Double) -> MlclassifyldaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyldaPoint::dot(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyldaPoint::cross(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyldaPoint::norm(self : MlclassifyldaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyldaPoint::normalize(self : MlclassifyldaPoint) -> MlclassifyldaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyldaPoint::negate(self : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyldaPoint::mid(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyldaPoint::lerp(self : MlclassifyldaPoint, other : MlclassifyldaPoint, t : Double) -> MlclassifyldaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyldaPoint::to_string(self : MlclassifyldaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyldaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_lda_make_series(vals : Array[Double], name : String) -> MlclassifyldaSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyldaSeries::len(self : MlclassifyldaSeries) -> Int { self.vals.length() }

pub fn MlclassifyldaSeries::sum(self : MlclassifyldaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyldaSeries::mean(self : MlclassifyldaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyldaSeries::min(self : MlclassifyldaSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyldaSeries::max(self : MlclassifyldaSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyldaSeries::range(self : MlclassifyldaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyldaSeries::variance(self : MlclassifyldaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyldaSeries::std(self : MlclassifyldaSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyldaSeries::median(self : MlclassifyldaSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyldaSeries::scale(self : MlclassifyldaSeries, f : Double) -> MlclassifyldaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyldaSeries::add(self : MlclassifyldaSeries, other : MlclassifyldaSeries) -> MlclassifyldaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyldaSeries::sub(self : MlclassifyldaSeries, other : MlclassifyldaSeries) -> MlclassifyldaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyldaSeries::normalize(self : MlclassifyldaSeries) -> MlclassifyldaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyldaSeries::cumsum(self : MlclassifyldaSeries) -> MlclassifyldaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyldaSeries::to_string(self : MlclassifyldaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyldaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_lda_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyldaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_lda_matrix_identity(n : Int) -> MlclassifyldaMatrix {
  let m = ml_classify_lda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyldaMatrix::get(self : MlclassifyldaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyldaMatrix::transpose(self : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  let result = ml_classify_lda_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyldaMatrix::add(self : MlclassifyldaMatrix, other : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyldaMatrix::scale(self : MlclassifyldaMatrix, s : Double) -> MlclassifyldaMatrix {
  let result = ml_classify_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyldaMatrix::multiply(self : MlclassifyldaMatrix, other : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  if self.cols != other.rows { return ml_classify_lda_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_lda_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlclassifyldaMatrix::trace(self : MlclassifyldaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyldaMatrix::det(self : MlclassifyldaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyldaMatrix::norm(self : MlclassifyldaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyldaMatrix::to_string(self : MlclassifyldaMatrix) -> String {
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

pub(all) struct MlclassifyldaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_lda_make_vector(comps : Array[Double]) -> MlclassifyldaVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_lda_vector_zero(dim : Int) -> MlclassifyldaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyldaVector::add(self : MlclassifyldaVector, other : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyldaVector::sub(self : MlclassifyldaVector, other : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyldaVector::scale(self : MlclassifyldaVector, s : Double) -> MlclassifyldaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyldaVector::dot(self : MlclassifyldaVector, other : MlclassifyldaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyldaVector::norm(self : MlclassifyldaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyldaVector::normalize(self : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyldaVector::dist(self : MlclassifyldaVector, other : MlclassifyldaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyldaVector::to_string(self : MlclassifyldaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyldaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_frame_make(size : Int) -> MlclassifyldaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaFrame::len(self : MlclassifyldaFrame) -> Int { self.size }

pub fn MlclassifyldaFrame::get(self : MlclassifyldaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaFrame::set(self : MlclassifyldaFrame, i : Int, v : Double) -> MlclassifyldaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaFrame::sum(self : MlclassifyldaFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaFrame::mean(self : MlclassifyldaFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaFrame::scale(self : MlclassifyldaFrame, f : Double) -> MlclassifyldaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaFrame::add(self : MlclassifyldaFrame, other : MlclassifyldaFrame) -> MlclassifyldaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaFrame::copy(self : MlclassifyldaFrame) -> MlclassifyldaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaFrame::fill(self : MlclassifyldaFrame, v : Double) -> MlclassifyldaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaFrame::min(self : MlclassifyldaFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaFrame::max(self : MlclassifyldaFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaFrame::to_string(self : MlclassifyldaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_table_make(size : Int) -> MlclassifyldaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaTable::len(self : MlclassifyldaTable) -> Int { self.size }

pub fn MlclassifyldaTable::get(self : MlclassifyldaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaTable::set(self : MlclassifyldaTable, i : Int, v : Double) -> MlclassifyldaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaTable::sum(self : MlclassifyldaTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaTable::mean(self : MlclassifyldaTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaTable::scale(self : MlclassifyldaTable, f : Double) -> MlclassifyldaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaTable::add(self : MlclassifyldaTable, other : MlclassifyldaTable) -> MlclassifyldaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaTable::copy(self : MlclassifyldaTable) -> MlclassifyldaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaTable::fill(self : MlclassifyldaTable, v : Double) -> MlclassifyldaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaTable::min(self : MlclassifyldaTable) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaTable::max(self : MlclassifyldaTable) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaTable::to_string(self : MlclassifyldaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_graphn_make(size : Int) -> MlclassifyldaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaGraphN::len(self : MlclassifyldaGraphN) -> Int { self.size }

pub fn MlclassifyldaGraphN::get(self : MlclassifyldaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaGraphN::set(self : MlclassifyldaGraphN, i : Int, v : Double) -> MlclassifyldaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaGraphN::sum(self : MlclassifyldaGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaGraphN::mean(self : MlclassifyldaGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaGraphN::scale(self : MlclassifyldaGraphN, f : Double) -> MlclassifyldaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaGraphN::add(self : MlclassifyldaGraphN, other : MlclassifyldaGraphN) -> MlclassifyldaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaGraphN::copy(self : MlclassifyldaGraphN) -> MlclassifyldaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaGraphN::fill(self : MlclassifyldaGraphN, v : Double) -> MlclassifyldaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaGraphN::min(self : MlclassifyldaGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaGraphN::max(self : MlclassifyldaGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaGraphN::to_string(self : MlclassifyldaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_node_make(size : Int) -> MlclassifyldaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaNode::len(self : MlclassifyldaNode) -> Int { self.size }

pub fn MlclassifyldaNode::get(self : MlclassifyldaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaNode::set(self : MlclassifyldaNode, i : Int, v : Double) -> MlclassifyldaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaNode::sum(self : MlclassifyldaNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaNode::mean(self : MlclassifyldaNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaNode::scale(self : MlclassifyldaNode, f : Double) -> MlclassifyldaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaNode::add(self : MlclassifyldaNode, other : MlclassifyldaNode) -> MlclassifyldaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaNode::copy(self : MlclassifyldaNode) -> MlclassifyldaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaNode::fill(self : MlclassifyldaNode, v : Double) -> MlclassifyldaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaNode::min(self : MlclassifyldaNode) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaNode::max(self : MlclassifyldaNode) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaNode::to_string(self : MlclassifyldaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_edge_make(size : Int) -> MlclassifyldaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaEdge::len(self : MlclassifyldaEdge) -> Int { self.size }

pub fn MlclassifyldaEdge::get(self : MlclassifyldaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaEdge::set(self : MlclassifyldaEdge, i : Int, v : Double) -> MlclassifyldaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaEdge::sum(self : MlclassifyldaEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaEdge::mean(self : MlclassifyldaEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaEdge::scale(self : MlclassifyldaEdge, f : Double) -> MlclassifyldaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaEdge::add(self : MlclassifyldaEdge, other : MlclassifyldaEdge) -> MlclassifyldaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaEdge::copy(self : MlclassifyldaEdge) -> MlclassifyldaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaEdge::fill(self : MlclassifyldaEdge, v : Double) -> MlclassifyldaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaEdge::min(self : MlclassifyldaEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaEdge::max(self : MlclassifyldaEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaEdge::to_string(self : MlclassifyldaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_path_make(size : Int) -> MlclassifyldaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaPath::len(self : MlclassifyldaPath) -> Int { self.size }

pub fn MlclassifyldaPath::get(self : MlclassifyldaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaPath::set(self : MlclassifyldaPath, i : Int, v : Double) -> MlclassifyldaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaPath::sum(self : MlclassifyldaPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaPath::mean(self : MlclassifyldaPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaPath::scale(self : MlclassifyldaPath, f : Double) -> MlclassifyldaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaPath::add(self : MlclassifyldaPath, other : MlclassifyldaPath) -> MlclassifyldaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaPath::copy(self : MlclassifyldaPath) -> MlclassifyldaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaPath::fill(self : MlclassifyldaPath, v : Double) -> MlclassifyldaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaPath::min(self : MlclassifyldaPath) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaPath::max(self : MlclassifyldaPath) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaPath::to_string(self : MlclassifyldaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_cluster_make(size : Int) -> MlclassifyldaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaCluster::len(self : MlclassifyldaCluster) -> Int { self.size }

pub fn MlclassifyldaCluster::get(self : MlclassifyldaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaCluster::set(self : MlclassifyldaCluster, i : Int, v : Double) -> MlclassifyldaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCluster::sum(self : MlclassifyldaCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaCluster::mean(self : MlclassifyldaCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaCluster::scale(self : MlclassifyldaCluster, f : Double) -> MlclassifyldaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCluster::add(self : MlclassifyldaCluster, other : MlclassifyldaCluster) -> MlclassifyldaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaCluster::copy(self : MlclassifyldaCluster) -> MlclassifyldaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCluster::fill(self : MlclassifyldaCluster, v : Double) -> MlclassifyldaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCluster::min(self : MlclassifyldaCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaCluster::max(self : MlclassifyldaCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaCluster::to_string(self : MlclassifyldaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_model_make(size : Int) -> MlclassifyldaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaModel::len(self : MlclassifyldaModel) -> Int { self.size }

pub fn MlclassifyldaModel::get(self : MlclassifyldaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaModel::set(self : MlclassifyldaModel, i : Int, v : Double) -> MlclassifyldaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaModel::sum(self : MlclassifyldaModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaModel::mean(self : MlclassifyldaModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaModel::scale(self : MlclassifyldaModel, f : Double) -> MlclassifyldaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaModel::add(self : MlclassifyldaModel, other : MlclassifyldaModel) -> MlclassifyldaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaModel::copy(self : MlclassifyldaModel) -> MlclassifyldaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaModel::fill(self : MlclassifyldaModel, v : Double) -> MlclassifyldaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaModel::min(self : MlclassifyldaModel) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaModel::max(self : MlclassifyldaModel) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaModel::to_string(self : MlclassifyldaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_layer_make(size : Int) -> MlclassifyldaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaLayer::len(self : MlclassifyldaLayer) -> Int { self.size }

pub fn MlclassifyldaLayer::get(self : MlclassifyldaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaLayer::set(self : MlclassifyldaLayer, i : Int, v : Double) -> MlclassifyldaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaLayer::sum(self : MlclassifyldaLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaLayer::mean(self : MlclassifyldaLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaLayer::scale(self : MlclassifyldaLayer, f : Double) -> MlclassifyldaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaLayer::add(self : MlclassifyldaLayer, other : MlclassifyldaLayer) -> MlclassifyldaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaLayer::copy(self : MlclassifyldaLayer) -> MlclassifyldaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaLayer::fill(self : MlclassifyldaLayer, v : Double) -> MlclassifyldaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaLayer::min(self : MlclassifyldaLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaLayer::max(self : MlclassifyldaLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaLayer::to_string(self : MlclassifyldaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_buffer_make(size : Int) -> MlclassifyldaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaBuffer::len(self : MlclassifyldaBuffer) -> Int { self.size }

pub fn MlclassifyldaBuffer::get(self : MlclassifyldaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaBuffer::set(self : MlclassifyldaBuffer, i : Int, v : Double) -> MlclassifyldaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaBuffer::sum(self : MlclassifyldaBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaBuffer::mean(self : MlclassifyldaBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaBuffer::scale(self : MlclassifyldaBuffer, f : Double) -> MlclassifyldaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaBuffer::add(self : MlclassifyldaBuffer, other : MlclassifyldaBuffer) -> MlclassifyldaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaBuffer::copy(self : MlclassifyldaBuffer) -> MlclassifyldaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaBuffer::fill(self : MlclassifyldaBuffer, v : Double) -> MlclassifyldaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaBuffer::min(self : MlclassifyldaBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaBuffer::max(self : MlclassifyldaBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaBuffer::to_string(self : MlclassifyldaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_cursor_make(size : Int) -> MlclassifyldaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaCursor::len(self : MlclassifyldaCursor) -> Int { self.size }

pub fn MlclassifyldaCursor::get(self : MlclassifyldaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaCursor::set(self : MlclassifyldaCursor, i : Int, v : Double) -> MlclassifyldaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCursor::sum(self : MlclassifyldaCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaCursor::mean(self : MlclassifyldaCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaCursor::scale(self : MlclassifyldaCursor, f : Double) -> MlclassifyldaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCursor::add(self : MlclassifyldaCursor, other : MlclassifyldaCursor) -> MlclassifyldaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaCursor::copy(self : MlclassifyldaCursor) -> MlclassifyldaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCursor::fill(self : MlclassifyldaCursor, v : Double) -> MlclassifyldaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaCursor::min(self : MlclassifyldaCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaCursor::max(self : MlclassifyldaCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaCursor::to_string(self : MlclassifyldaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_view_make(size : Int) -> MlclassifyldaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaView::len(self : MlclassifyldaView) -> Int { self.size }

pub fn MlclassifyldaView::get(self : MlclassifyldaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaView::set(self : MlclassifyldaView, i : Int, v : Double) -> MlclassifyldaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaView::sum(self : MlclassifyldaView) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaView::mean(self : MlclassifyldaView) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaView::scale(self : MlclassifyldaView, f : Double) -> MlclassifyldaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaView::add(self : MlclassifyldaView, other : MlclassifyldaView) -> MlclassifyldaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaView::copy(self : MlclassifyldaView) -> MlclassifyldaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaView::fill(self : MlclassifyldaView, v : Double) -> MlclassifyldaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaView::min(self : MlclassifyldaView) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaView::max(self : MlclassifyldaView) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaView::to_string(self : MlclassifyldaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_range_make(size : Int) -> MlclassifyldaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaRange::len(self : MlclassifyldaRange) -> Int { self.size }

pub fn MlclassifyldaRange::get(self : MlclassifyldaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaRange::set(self : MlclassifyldaRange, i : Int, v : Double) -> MlclassifyldaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaRange::sum(self : MlclassifyldaRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaRange::mean(self : MlclassifyldaRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaRange::scale(self : MlclassifyldaRange, f : Double) -> MlclassifyldaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaRange::add(self : MlclassifyldaRange, other : MlclassifyldaRange) -> MlclassifyldaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaRange::copy(self : MlclassifyldaRange) -> MlclassifyldaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaRange::fill(self : MlclassifyldaRange, v : Double) -> MlclassifyldaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaRange::min(self : MlclassifyldaRange) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaRange::max(self : MlclassifyldaRange) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaRange::to_string(self : MlclassifyldaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_slice_make(size : Int) -> MlclassifyldaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyldaSlice::len(self : MlclassifyldaSlice) -> Int { self.size }

pub fn MlclassifyldaSlice::get(self : MlclassifyldaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyldaSlice::set(self : MlclassifyldaSlice, i : Int, v : Double) -> MlclassifyldaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyldaSlice::sum(self : MlclassifyldaSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifyldaSlice::mean(self : MlclassifyldaSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifyldaSlice::scale(self : MlclassifyldaSlice, f : Double) -> MlclassifyldaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaSlice::add(self : MlclassifyldaSlice, other : MlclassifyldaSlice) -> MlclassifyldaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyldaSlice::copy(self : MlclassifyldaSlice) -> MlclassifyldaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaSlice::fill(self : MlclassifyldaSlice, v : Double) -> MlclassifyldaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyldaSlice::min(self : MlclassifyldaSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifyldaSlice::max(self : MlclassifyldaSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifyldaSlice::to_string(self : MlclassifyldaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

