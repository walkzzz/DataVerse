///===
/// extcore/ml_feature_factor

pub(all) struct MlfeaturefactorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_factor_make_point(x : Double, y : Double) -> MlfeaturefactorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_factor_make_point3(x : Double, y : Double, z : Double) -> MlfeaturefactorPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturefactorPoint::x(self : MlfeaturefactorPoint) -> Double { self.x }

pub fn MlfeaturefactorPoint::y(self : MlfeaturefactorPoint) -> Double { self.y }

pub fn MlfeaturefactorPoint::z(self : MlfeaturefactorPoint) -> Double { self.z }

pub fn MlfeaturefactorPoint::label(self : MlfeaturefactorPoint) -> Int { self.label }

pub fn MlfeaturefactorPoint::dist(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturefactorPoint::add(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturefactorPoint::sub(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturefactorPoint::scale(self : MlfeaturefactorPoint, s : Double) -> MlfeaturefactorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturefactorPoint::dot(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturefactorPoint::cross(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturefactorPoint::norm(self : MlfeaturefactorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturefactorPoint::normalize(self : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturefactorPoint::negate(self : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturefactorPoint::mid(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturefactorPoint::lerp(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint, t : Double) -> MlfeaturefactorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturefactorPoint::to_string(self : MlfeaturefactorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturefactorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_factor_make_series(vals : Array[Double], name : String) -> MlfeaturefactorSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturefactorSeries::len(self : MlfeaturefactorSeries) -> Int { self.vals.length() }

pub fn MlfeaturefactorSeries::sum(self : MlfeaturefactorSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturefactorSeries::mean(self : MlfeaturefactorSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturefactorSeries::min(self : MlfeaturefactorSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturefactorSeries::max(self : MlfeaturefactorSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturefactorSeries::range(self : MlfeaturefactorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturefactorSeries::variance(self : MlfeaturefactorSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturefactorSeries::std(self : MlfeaturefactorSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturefactorSeries::median(self : MlfeaturefactorSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturefactorSeries::scale(self : MlfeaturefactorSeries, f : Double) -> MlfeaturefactorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturefactorSeries::add(self : MlfeaturefactorSeries, other : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturefactorSeries::sub(self : MlfeaturefactorSeries, other : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturefactorSeries::normalize(self : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturefactorSeries::cumsum(self : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturefactorSeries::to_string(self : MlfeaturefactorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturefactorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_factor_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturefactorMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_feature_factor_matrix_identity(n : Int) -> MlfeaturefactorMatrix {
  let m = ml_feature_factor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturefactorMatrix::get(self : MlfeaturefactorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturefactorMatrix::transpose(self : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  let result = ml_feature_factor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturefactorMatrix::add(self : MlfeaturefactorMatrix, other : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturefactorMatrix::scale(self : MlfeaturefactorMatrix, s : Double) -> MlfeaturefactorMatrix {
  let result = ml_feature_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturefactorMatrix::multiply(self : MlfeaturefactorMatrix, other : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  if self.cols != other.rows { return ml_feature_factor_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_factor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlfeaturefactorMatrix::trace(self : MlfeaturefactorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturefactorMatrix::det(self : MlfeaturefactorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturefactorMatrix::norm(self : MlfeaturefactorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturefactorMatrix::to_string(self : MlfeaturefactorMatrix) -> String {
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

pub(all) struct MlfeaturefactorVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_factor_make_vector(comps : Array[Double]) -> MlfeaturefactorVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_factor_vector_zero(dim : Int) -> MlfeaturefactorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturefactorVector::add(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturefactorVector::sub(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturefactorVector::scale(self : MlfeaturefactorVector, s : Double) -> MlfeaturefactorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturefactorVector::dot(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturefactorVector::norm(self : MlfeaturefactorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturefactorVector::normalize(self : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturefactorVector::dist(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturefactorVector::to_string(self : MlfeaturefactorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturefactorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_frame_make(size : Int) -> MlfeaturefactorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorFrame::len(self : MlfeaturefactorFrame) -> Int { self.size }

pub fn MlfeaturefactorFrame::get(self : MlfeaturefactorFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorFrame::set(self : MlfeaturefactorFrame, i : Int, v : Double) -> MlfeaturefactorFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorFrame::sum(self : MlfeaturefactorFrame) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorFrame::mean(self : MlfeaturefactorFrame) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorFrame::scale(self : MlfeaturefactorFrame, f : Double) -> MlfeaturefactorFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorFrame::add(self : MlfeaturefactorFrame, other : MlfeaturefactorFrame) -> MlfeaturefactorFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorFrame::copy(self : MlfeaturefactorFrame) -> MlfeaturefactorFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorFrame::fill(self : MlfeaturefactorFrame, v : Double) -> MlfeaturefactorFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorFrame::min(self : MlfeaturefactorFrame) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorFrame::max(self : MlfeaturefactorFrame) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorFrame::to_string(self : MlfeaturefactorFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_table_make(size : Int) -> MlfeaturefactorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorTable::len(self : MlfeaturefactorTable) -> Int { self.size }

pub fn MlfeaturefactorTable::get(self : MlfeaturefactorTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorTable::set(self : MlfeaturefactorTable, i : Int, v : Double) -> MlfeaturefactorTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorTable::sum(self : MlfeaturefactorTable) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorTable::mean(self : MlfeaturefactorTable) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorTable::scale(self : MlfeaturefactorTable, f : Double) -> MlfeaturefactorTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorTable::add(self : MlfeaturefactorTable, other : MlfeaturefactorTable) -> MlfeaturefactorTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorTable::copy(self : MlfeaturefactorTable) -> MlfeaturefactorTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorTable::fill(self : MlfeaturefactorTable, v : Double) -> MlfeaturefactorTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorTable::min(self : MlfeaturefactorTable) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorTable::max(self : MlfeaturefactorTable) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorTable::to_string(self : MlfeaturefactorTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_graphn_make(size : Int) -> MlfeaturefactorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorGraphN::len(self : MlfeaturefactorGraphN) -> Int { self.size }

pub fn MlfeaturefactorGraphN::get(self : MlfeaturefactorGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorGraphN::set(self : MlfeaturefactorGraphN, i : Int, v : Double) -> MlfeaturefactorGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorGraphN::sum(self : MlfeaturefactorGraphN) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorGraphN::mean(self : MlfeaturefactorGraphN) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorGraphN::scale(self : MlfeaturefactorGraphN, f : Double) -> MlfeaturefactorGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorGraphN::add(self : MlfeaturefactorGraphN, other : MlfeaturefactorGraphN) -> MlfeaturefactorGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorGraphN::copy(self : MlfeaturefactorGraphN) -> MlfeaturefactorGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorGraphN::fill(self : MlfeaturefactorGraphN, v : Double) -> MlfeaturefactorGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorGraphN::min(self : MlfeaturefactorGraphN) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorGraphN::max(self : MlfeaturefactorGraphN) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorGraphN::to_string(self : MlfeaturefactorGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_node_make(size : Int) -> MlfeaturefactorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorNode::len(self : MlfeaturefactorNode) -> Int { self.size }

pub fn MlfeaturefactorNode::get(self : MlfeaturefactorNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorNode::set(self : MlfeaturefactorNode, i : Int, v : Double) -> MlfeaturefactorNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorNode::sum(self : MlfeaturefactorNode) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorNode::mean(self : MlfeaturefactorNode) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorNode::scale(self : MlfeaturefactorNode, f : Double) -> MlfeaturefactorNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorNode::add(self : MlfeaturefactorNode, other : MlfeaturefactorNode) -> MlfeaturefactorNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorNode::copy(self : MlfeaturefactorNode) -> MlfeaturefactorNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorNode::fill(self : MlfeaturefactorNode, v : Double) -> MlfeaturefactorNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorNode::min(self : MlfeaturefactorNode) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorNode::max(self : MlfeaturefactorNode) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorNode::to_string(self : MlfeaturefactorNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_edge_make(size : Int) -> MlfeaturefactorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorEdge::len(self : MlfeaturefactorEdge) -> Int { self.size }

pub fn MlfeaturefactorEdge::get(self : MlfeaturefactorEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorEdge::set(self : MlfeaturefactorEdge, i : Int, v : Double) -> MlfeaturefactorEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorEdge::sum(self : MlfeaturefactorEdge) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorEdge::mean(self : MlfeaturefactorEdge) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorEdge::scale(self : MlfeaturefactorEdge, f : Double) -> MlfeaturefactorEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorEdge::add(self : MlfeaturefactorEdge, other : MlfeaturefactorEdge) -> MlfeaturefactorEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorEdge::copy(self : MlfeaturefactorEdge) -> MlfeaturefactorEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorEdge::fill(self : MlfeaturefactorEdge, v : Double) -> MlfeaturefactorEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorEdge::min(self : MlfeaturefactorEdge) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorEdge::max(self : MlfeaturefactorEdge) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorEdge::to_string(self : MlfeaturefactorEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_path_make(size : Int) -> MlfeaturefactorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorPath::len(self : MlfeaturefactorPath) -> Int { self.size }

pub fn MlfeaturefactorPath::get(self : MlfeaturefactorPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorPath::set(self : MlfeaturefactorPath, i : Int, v : Double) -> MlfeaturefactorPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorPath::sum(self : MlfeaturefactorPath) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorPath::mean(self : MlfeaturefactorPath) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorPath::scale(self : MlfeaturefactorPath, f : Double) -> MlfeaturefactorPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorPath::add(self : MlfeaturefactorPath, other : MlfeaturefactorPath) -> MlfeaturefactorPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorPath::copy(self : MlfeaturefactorPath) -> MlfeaturefactorPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorPath::fill(self : MlfeaturefactorPath, v : Double) -> MlfeaturefactorPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorPath::min(self : MlfeaturefactorPath) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorPath::max(self : MlfeaturefactorPath) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorPath::to_string(self : MlfeaturefactorPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_cluster_make(size : Int) -> MlfeaturefactorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorCluster::len(self : MlfeaturefactorCluster) -> Int { self.size }

pub fn MlfeaturefactorCluster::get(self : MlfeaturefactorCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorCluster::set(self : MlfeaturefactorCluster, i : Int, v : Double) -> MlfeaturefactorCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCluster::sum(self : MlfeaturefactorCluster) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorCluster::mean(self : MlfeaturefactorCluster) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorCluster::scale(self : MlfeaturefactorCluster, f : Double) -> MlfeaturefactorCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCluster::add(self : MlfeaturefactorCluster, other : MlfeaturefactorCluster) -> MlfeaturefactorCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorCluster::copy(self : MlfeaturefactorCluster) -> MlfeaturefactorCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCluster::fill(self : MlfeaturefactorCluster, v : Double) -> MlfeaturefactorCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCluster::min(self : MlfeaturefactorCluster) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorCluster::max(self : MlfeaturefactorCluster) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorCluster::to_string(self : MlfeaturefactorCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_model_make(size : Int) -> MlfeaturefactorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorModel::len(self : MlfeaturefactorModel) -> Int { self.size }

pub fn MlfeaturefactorModel::get(self : MlfeaturefactorModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorModel::set(self : MlfeaturefactorModel, i : Int, v : Double) -> MlfeaturefactorModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorModel::sum(self : MlfeaturefactorModel) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorModel::mean(self : MlfeaturefactorModel) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorModel::scale(self : MlfeaturefactorModel, f : Double) -> MlfeaturefactorModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorModel::add(self : MlfeaturefactorModel, other : MlfeaturefactorModel) -> MlfeaturefactorModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorModel::copy(self : MlfeaturefactorModel) -> MlfeaturefactorModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorModel::fill(self : MlfeaturefactorModel, v : Double) -> MlfeaturefactorModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorModel::min(self : MlfeaturefactorModel) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorModel::max(self : MlfeaturefactorModel) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorModel::to_string(self : MlfeaturefactorModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_layer_make(size : Int) -> MlfeaturefactorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorLayer::len(self : MlfeaturefactorLayer) -> Int { self.size }

pub fn MlfeaturefactorLayer::get(self : MlfeaturefactorLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorLayer::set(self : MlfeaturefactorLayer, i : Int, v : Double) -> MlfeaturefactorLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorLayer::sum(self : MlfeaturefactorLayer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorLayer::mean(self : MlfeaturefactorLayer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorLayer::scale(self : MlfeaturefactorLayer, f : Double) -> MlfeaturefactorLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorLayer::add(self : MlfeaturefactorLayer, other : MlfeaturefactorLayer) -> MlfeaturefactorLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorLayer::copy(self : MlfeaturefactorLayer) -> MlfeaturefactorLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorLayer::fill(self : MlfeaturefactorLayer, v : Double) -> MlfeaturefactorLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorLayer::min(self : MlfeaturefactorLayer) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorLayer::max(self : MlfeaturefactorLayer) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorLayer::to_string(self : MlfeaturefactorLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_buffer_make(size : Int) -> MlfeaturefactorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorBuffer::len(self : MlfeaturefactorBuffer) -> Int { self.size }

pub fn MlfeaturefactorBuffer::get(self : MlfeaturefactorBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorBuffer::set(self : MlfeaturefactorBuffer, i : Int, v : Double) -> MlfeaturefactorBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorBuffer::sum(self : MlfeaturefactorBuffer) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorBuffer::mean(self : MlfeaturefactorBuffer) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorBuffer::scale(self : MlfeaturefactorBuffer, f : Double) -> MlfeaturefactorBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorBuffer::add(self : MlfeaturefactorBuffer, other : MlfeaturefactorBuffer) -> MlfeaturefactorBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorBuffer::copy(self : MlfeaturefactorBuffer) -> MlfeaturefactorBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorBuffer::fill(self : MlfeaturefactorBuffer, v : Double) -> MlfeaturefactorBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorBuffer::min(self : MlfeaturefactorBuffer) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorBuffer::max(self : MlfeaturefactorBuffer) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorBuffer::to_string(self : MlfeaturefactorBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_cursor_make(size : Int) -> MlfeaturefactorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorCursor::len(self : MlfeaturefactorCursor) -> Int { self.size }

pub fn MlfeaturefactorCursor::get(self : MlfeaturefactorCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorCursor::set(self : MlfeaturefactorCursor, i : Int, v : Double) -> MlfeaturefactorCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCursor::sum(self : MlfeaturefactorCursor) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorCursor::mean(self : MlfeaturefactorCursor) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorCursor::scale(self : MlfeaturefactorCursor, f : Double) -> MlfeaturefactorCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCursor::add(self : MlfeaturefactorCursor, other : MlfeaturefactorCursor) -> MlfeaturefactorCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorCursor::copy(self : MlfeaturefactorCursor) -> MlfeaturefactorCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCursor::fill(self : MlfeaturefactorCursor, v : Double) -> MlfeaturefactorCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorCursor::min(self : MlfeaturefactorCursor) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorCursor::max(self : MlfeaturefactorCursor) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorCursor::to_string(self : MlfeaturefactorCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_view_make(size : Int) -> MlfeaturefactorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorView::len(self : MlfeaturefactorView) -> Int { self.size }

pub fn MlfeaturefactorView::get(self : MlfeaturefactorView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorView::set(self : MlfeaturefactorView, i : Int, v : Double) -> MlfeaturefactorView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorView::sum(self : MlfeaturefactorView) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorView::mean(self : MlfeaturefactorView) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorView::scale(self : MlfeaturefactorView, f : Double) -> MlfeaturefactorView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorView::add(self : MlfeaturefactorView, other : MlfeaturefactorView) -> MlfeaturefactorView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorView::copy(self : MlfeaturefactorView) -> MlfeaturefactorView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorView::fill(self : MlfeaturefactorView, v : Double) -> MlfeaturefactorView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorView::min(self : MlfeaturefactorView) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorView::max(self : MlfeaturefactorView) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorView::to_string(self : MlfeaturefactorView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_range_make(size : Int) -> MlfeaturefactorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorRange::len(self : MlfeaturefactorRange) -> Int { self.size }

pub fn MlfeaturefactorRange::get(self : MlfeaturefactorRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorRange::set(self : MlfeaturefactorRange, i : Int, v : Double) -> MlfeaturefactorRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorRange::sum(self : MlfeaturefactorRange) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorRange::mean(self : MlfeaturefactorRange) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorRange::scale(self : MlfeaturefactorRange, f : Double) -> MlfeaturefactorRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorRange::add(self : MlfeaturefactorRange, other : MlfeaturefactorRange) -> MlfeaturefactorRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorRange::copy(self : MlfeaturefactorRange) -> MlfeaturefactorRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorRange::fill(self : MlfeaturefactorRange, v : Double) -> MlfeaturefactorRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorRange::min(self : MlfeaturefactorRange) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorRange::max(self : MlfeaturefactorRange) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorRange::to_string(self : MlfeaturefactorRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_slice_make(size : Int) -> MlfeaturefactorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlfeaturefactorSlice::len(self : MlfeaturefactorSlice) -> Int { self.size }

pub fn MlfeaturefactorSlice::get(self : MlfeaturefactorSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlfeaturefactorSlice::set(self : MlfeaturefactorSlice, i : Int, v : Double) -> MlfeaturefactorSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorSlice::sum(self : MlfeaturefactorSlice) -> Double { @_common.sum(self.data) }

pub fn MlfeaturefactorSlice::mean(self : MlfeaturefactorSlice) -> Double { @_common.mean(self.data) }

pub fn MlfeaturefactorSlice::scale(self : MlfeaturefactorSlice, f : Double) -> MlfeaturefactorSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorSlice::add(self : MlfeaturefactorSlice, other : MlfeaturefactorSlice) -> MlfeaturefactorSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlfeaturefactorSlice::copy(self : MlfeaturefactorSlice) -> MlfeaturefactorSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorSlice::fill(self : MlfeaturefactorSlice, v : Double) -> MlfeaturefactorSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlfeaturefactorSlice::min(self : MlfeaturefactorSlice) -> Double { @_common.min(self.data) }

pub fn MlfeaturefactorSlice::max(self : MlfeaturefactorSlice) -> Double { @_common.max(self.data) }

pub fn MlfeaturefactorSlice::to_string(self : MlfeaturefactorSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

