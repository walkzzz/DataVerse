///===
/// extcore/ml_ensemble_boosting

pub(all) struct MlensembleboostingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_boosting_make_point(x : Double, y : Double) -> MlensembleboostingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_boosting_make_point3(x : Double, y : Double, z : Double) -> MlensembleboostingPoint {
  { x, y, z, label: 0 }
}

pub fn MlensembleboostingPoint::x(self : MlensembleboostingPoint) -> Double { self.x }

pub fn MlensembleboostingPoint::y(self : MlensembleboostingPoint) -> Double { self.y }

pub fn MlensembleboostingPoint::z(self : MlensembleboostingPoint) -> Double { self.z }

pub fn MlensembleboostingPoint::label(self : MlensembleboostingPoint) -> Int { self.label }

pub fn MlensembleboostingPoint::dist(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensembleboostingPoint::add(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensembleboostingPoint::sub(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensembleboostingPoint::scale(self : MlensembleboostingPoint, s : Double) -> MlensembleboostingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensembleboostingPoint::dot(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensembleboostingPoint::cross(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensembleboostingPoint::norm(self : MlensembleboostingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensembleboostingPoint::normalize(self : MlensembleboostingPoint) -> MlensembleboostingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleboostingPoint::negate(self : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensembleboostingPoint::mid(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensembleboostingPoint::lerp(self : MlensembleboostingPoint, other : MlensembleboostingPoint, t : Double) -> MlensembleboostingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensembleboostingPoint::to_string(self : MlensembleboostingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensembleboostingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_boosting_make_series(vals : Array[Double], name : String) -> MlensembleboostingSeries {
  { vals, name, meta: 0 }
}

pub fn MlensembleboostingSeries::len(self : MlensembleboostingSeries) -> Int { self.vals.length() }

pub fn MlensembleboostingSeries::sum(self : MlensembleboostingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensembleboostingSeries::mean(self : MlensembleboostingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensembleboostingSeries::min(self : MlensembleboostingSeries) -> Double { @_common.min(self.vals) }

pub fn MlensembleboostingSeries::max(self : MlensembleboostingSeries) -> Double { @_common.max(self.vals) }

pub fn MlensembleboostingSeries::range(self : MlensembleboostingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensembleboostingSeries::variance(self : MlensembleboostingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensembleboostingSeries::std(self : MlensembleboostingSeries) -> Double { @_common.std(self.vals) }

pub fn MlensembleboostingSeries::median(self : MlensembleboostingSeries) -> Double { @_common.median(self.vals) }

pub fn MlensembleboostingSeries::scale(self : MlensembleboostingSeries, f : Double) -> MlensembleboostingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensembleboostingSeries::add(self : MlensembleboostingSeries, other : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensembleboostingSeries::sub(self : MlensembleboostingSeries, other : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensembleboostingSeries::normalize(self : MlensembleboostingSeries) -> MlensembleboostingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensembleboostingSeries::cumsum(self : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensembleboostingSeries::to_string(self : MlensembleboostingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleboostingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_boosting_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleboostingMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_ensemble_boosting_matrix_identity(n : Int) -> MlensembleboostingMatrix {
  let m = ml_ensemble_boosting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensembleboostingMatrix::get(self : MlensembleboostingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensembleboostingMatrix::transpose(self : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  let result = ml_ensemble_boosting_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensembleboostingMatrix::add(self : MlensembleboostingMatrix, other : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_boosting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensembleboostingMatrix::scale(self : MlensembleboostingMatrix, s : Double) -> MlensembleboostingMatrix {
  let result = ml_ensemble_boosting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensembleboostingMatrix::multiply(self : MlensembleboostingMatrix, other : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  if self.cols != other.rows { return ml_ensemble_boosting_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_boosting_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlensembleboostingMatrix::trace(self : MlensembleboostingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensembleboostingMatrix::det(self : MlensembleboostingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensembleboostingMatrix::norm(self : MlensembleboostingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensembleboostingMatrix::to_string(self : MlensembleboostingMatrix) -> String {
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

pub(all) struct MlensembleboostingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_boosting_make_vector(comps : Array[Double]) -> MlensembleboostingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_boosting_vector_zero(dim : Int) -> MlensembleboostingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensembleboostingVector::add(self : MlensembleboostingVector, other : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleboostingVector::sub(self : MlensembleboostingVector, other : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleboostingVector::scale(self : MlensembleboostingVector, s : Double) -> MlensembleboostingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensembleboostingVector::dot(self : MlensembleboostingVector, other : MlensembleboostingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensembleboostingVector::norm(self : MlensembleboostingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensembleboostingVector::normalize(self : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleboostingVector::dist(self : MlensembleboostingVector, other : MlensembleboostingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensembleboostingVector::to_string(self : MlensembleboostingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleboostingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_frame_make(size : Int) -> MlensembleboostingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingFrame::len(self : MlensembleboostingFrame) -> Int { self.size }

pub fn MlensembleboostingFrame::get(self : MlensembleboostingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingFrame::set(self : MlensembleboostingFrame, i : Int, v : Double) -> MlensembleboostingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingFrame::sum(self : MlensembleboostingFrame) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingFrame::mean(self : MlensembleboostingFrame) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingFrame::scale(self : MlensembleboostingFrame, f : Double) -> MlensembleboostingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingFrame::add(self : MlensembleboostingFrame, other : MlensembleboostingFrame) -> MlensembleboostingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingFrame::copy(self : MlensembleboostingFrame) -> MlensembleboostingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingFrame::fill(self : MlensembleboostingFrame, v : Double) -> MlensembleboostingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingFrame::min(self : MlensembleboostingFrame) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingFrame::max(self : MlensembleboostingFrame) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingFrame::to_string(self : MlensembleboostingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_table_make(size : Int) -> MlensembleboostingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingTable::len(self : MlensembleboostingTable) -> Int { self.size }

pub fn MlensembleboostingTable::get(self : MlensembleboostingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingTable::set(self : MlensembleboostingTable, i : Int, v : Double) -> MlensembleboostingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingTable::sum(self : MlensembleboostingTable) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingTable::mean(self : MlensembleboostingTable) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingTable::scale(self : MlensembleboostingTable, f : Double) -> MlensembleboostingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingTable::add(self : MlensembleboostingTable, other : MlensembleboostingTable) -> MlensembleboostingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingTable::copy(self : MlensembleboostingTable) -> MlensembleboostingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingTable::fill(self : MlensembleboostingTable, v : Double) -> MlensembleboostingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingTable::min(self : MlensembleboostingTable) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingTable::max(self : MlensembleboostingTable) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingTable::to_string(self : MlensembleboostingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_graphn_make(size : Int) -> MlensembleboostingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingGraphN::len(self : MlensembleboostingGraphN) -> Int { self.size }

pub fn MlensembleboostingGraphN::get(self : MlensembleboostingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingGraphN::set(self : MlensembleboostingGraphN, i : Int, v : Double) -> MlensembleboostingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingGraphN::sum(self : MlensembleboostingGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingGraphN::mean(self : MlensembleboostingGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingGraphN::scale(self : MlensembleboostingGraphN, f : Double) -> MlensembleboostingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingGraphN::add(self : MlensembleboostingGraphN, other : MlensembleboostingGraphN) -> MlensembleboostingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingGraphN::copy(self : MlensembleboostingGraphN) -> MlensembleboostingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingGraphN::fill(self : MlensembleboostingGraphN, v : Double) -> MlensembleboostingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingGraphN::min(self : MlensembleboostingGraphN) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingGraphN::max(self : MlensembleboostingGraphN) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingGraphN::to_string(self : MlensembleboostingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_node_make(size : Int) -> MlensembleboostingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingNode::len(self : MlensembleboostingNode) -> Int { self.size }

pub fn MlensembleboostingNode::get(self : MlensembleboostingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingNode::set(self : MlensembleboostingNode, i : Int, v : Double) -> MlensembleboostingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingNode::sum(self : MlensembleboostingNode) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingNode::mean(self : MlensembleboostingNode) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingNode::scale(self : MlensembleboostingNode, f : Double) -> MlensembleboostingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingNode::add(self : MlensembleboostingNode, other : MlensembleboostingNode) -> MlensembleboostingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingNode::copy(self : MlensembleboostingNode) -> MlensembleboostingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingNode::fill(self : MlensembleboostingNode, v : Double) -> MlensembleboostingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingNode::min(self : MlensembleboostingNode) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingNode::max(self : MlensembleboostingNode) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingNode::to_string(self : MlensembleboostingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_edge_make(size : Int) -> MlensembleboostingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingEdge::len(self : MlensembleboostingEdge) -> Int { self.size }

pub fn MlensembleboostingEdge::get(self : MlensembleboostingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingEdge::set(self : MlensembleboostingEdge, i : Int, v : Double) -> MlensembleboostingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingEdge::sum(self : MlensembleboostingEdge) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingEdge::mean(self : MlensembleboostingEdge) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingEdge::scale(self : MlensembleboostingEdge, f : Double) -> MlensembleboostingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingEdge::add(self : MlensembleboostingEdge, other : MlensembleboostingEdge) -> MlensembleboostingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingEdge::copy(self : MlensembleboostingEdge) -> MlensembleboostingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingEdge::fill(self : MlensembleboostingEdge, v : Double) -> MlensembleboostingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingEdge::min(self : MlensembleboostingEdge) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingEdge::max(self : MlensembleboostingEdge) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingEdge::to_string(self : MlensembleboostingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_path_make(size : Int) -> MlensembleboostingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingPath::len(self : MlensembleboostingPath) -> Int { self.size }

pub fn MlensembleboostingPath::get(self : MlensembleboostingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingPath::set(self : MlensembleboostingPath, i : Int, v : Double) -> MlensembleboostingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingPath::sum(self : MlensembleboostingPath) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingPath::mean(self : MlensembleboostingPath) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingPath::scale(self : MlensembleboostingPath, f : Double) -> MlensembleboostingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingPath::add(self : MlensembleboostingPath, other : MlensembleboostingPath) -> MlensembleboostingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingPath::copy(self : MlensembleboostingPath) -> MlensembleboostingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingPath::fill(self : MlensembleboostingPath, v : Double) -> MlensembleboostingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingPath::min(self : MlensembleboostingPath) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingPath::max(self : MlensembleboostingPath) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingPath::to_string(self : MlensembleboostingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_cluster_make(size : Int) -> MlensembleboostingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingCluster::len(self : MlensembleboostingCluster) -> Int { self.size }

pub fn MlensembleboostingCluster::get(self : MlensembleboostingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingCluster::set(self : MlensembleboostingCluster, i : Int, v : Double) -> MlensembleboostingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCluster::sum(self : MlensembleboostingCluster) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingCluster::mean(self : MlensembleboostingCluster) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingCluster::scale(self : MlensembleboostingCluster, f : Double) -> MlensembleboostingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCluster::add(self : MlensembleboostingCluster, other : MlensembleboostingCluster) -> MlensembleboostingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingCluster::copy(self : MlensembleboostingCluster) -> MlensembleboostingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCluster::fill(self : MlensembleboostingCluster, v : Double) -> MlensembleboostingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCluster::min(self : MlensembleboostingCluster) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingCluster::max(self : MlensembleboostingCluster) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingCluster::to_string(self : MlensembleboostingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_model_make(size : Int) -> MlensembleboostingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingModel::len(self : MlensembleboostingModel) -> Int { self.size }

pub fn MlensembleboostingModel::get(self : MlensembleboostingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingModel::set(self : MlensembleboostingModel, i : Int, v : Double) -> MlensembleboostingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingModel::sum(self : MlensembleboostingModel) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingModel::mean(self : MlensembleboostingModel) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingModel::scale(self : MlensembleboostingModel, f : Double) -> MlensembleboostingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingModel::add(self : MlensembleboostingModel, other : MlensembleboostingModel) -> MlensembleboostingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingModel::copy(self : MlensembleboostingModel) -> MlensembleboostingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingModel::fill(self : MlensembleboostingModel, v : Double) -> MlensembleboostingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingModel::min(self : MlensembleboostingModel) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingModel::max(self : MlensembleboostingModel) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingModel::to_string(self : MlensembleboostingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_layer_make(size : Int) -> MlensembleboostingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingLayer::len(self : MlensembleboostingLayer) -> Int { self.size }

pub fn MlensembleboostingLayer::get(self : MlensembleboostingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingLayer::set(self : MlensembleboostingLayer, i : Int, v : Double) -> MlensembleboostingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingLayer::sum(self : MlensembleboostingLayer) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingLayer::mean(self : MlensembleboostingLayer) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingLayer::scale(self : MlensembleboostingLayer, f : Double) -> MlensembleboostingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingLayer::add(self : MlensembleboostingLayer, other : MlensembleboostingLayer) -> MlensembleboostingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingLayer::copy(self : MlensembleboostingLayer) -> MlensembleboostingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingLayer::fill(self : MlensembleboostingLayer, v : Double) -> MlensembleboostingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingLayer::min(self : MlensembleboostingLayer) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingLayer::max(self : MlensembleboostingLayer) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingLayer::to_string(self : MlensembleboostingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_buffer_make(size : Int) -> MlensembleboostingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingBuffer::len(self : MlensembleboostingBuffer) -> Int { self.size }

pub fn MlensembleboostingBuffer::get(self : MlensembleboostingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingBuffer::set(self : MlensembleboostingBuffer, i : Int, v : Double) -> MlensembleboostingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingBuffer::sum(self : MlensembleboostingBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingBuffer::mean(self : MlensembleboostingBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingBuffer::scale(self : MlensembleboostingBuffer, f : Double) -> MlensembleboostingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingBuffer::add(self : MlensembleboostingBuffer, other : MlensembleboostingBuffer) -> MlensembleboostingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingBuffer::copy(self : MlensembleboostingBuffer) -> MlensembleboostingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingBuffer::fill(self : MlensembleboostingBuffer, v : Double) -> MlensembleboostingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingBuffer::min(self : MlensembleboostingBuffer) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingBuffer::max(self : MlensembleboostingBuffer) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingBuffer::to_string(self : MlensembleboostingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_cursor_make(size : Int) -> MlensembleboostingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingCursor::len(self : MlensembleboostingCursor) -> Int { self.size }

pub fn MlensembleboostingCursor::get(self : MlensembleboostingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingCursor::set(self : MlensembleboostingCursor, i : Int, v : Double) -> MlensembleboostingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCursor::sum(self : MlensembleboostingCursor) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingCursor::mean(self : MlensembleboostingCursor) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingCursor::scale(self : MlensembleboostingCursor, f : Double) -> MlensembleboostingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCursor::add(self : MlensembleboostingCursor, other : MlensembleboostingCursor) -> MlensembleboostingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingCursor::copy(self : MlensembleboostingCursor) -> MlensembleboostingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCursor::fill(self : MlensembleboostingCursor, v : Double) -> MlensembleboostingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingCursor::min(self : MlensembleboostingCursor) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingCursor::max(self : MlensembleboostingCursor) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingCursor::to_string(self : MlensembleboostingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_view_make(size : Int) -> MlensembleboostingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingView::len(self : MlensembleboostingView) -> Int { self.size }

pub fn MlensembleboostingView::get(self : MlensembleboostingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingView::set(self : MlensembleboostingView, i : Int, v : Double) -> MlensembleboostingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingView::sum(self : MlensembleboostingView) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingView::mean(self : MlensembleboostingView) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingView::scale(self : MlensembleboostingView, f : Double) -> MlensembleboostingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingView::add(self : MlensembleboostingView, other : MlensembleboostingView) -> MlensembleboostingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingView::copy(self : MlensembleboostingView) -> MlensembleboostingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingView::fill(self : MlensembleboostingView, v : Double) -> MlensembleboostingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingView::min(self : MlensembleboostingView) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingView::max(self : MlensembleboostingView) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingView::to_string(self : MlensembleboostingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_range_make(size : Int) -> MlensembleboostingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingRange::len(self : MlensembleboostingRange) -> Int { self.size }

pub fn MlensembleboostingRange::get(self : MlensembleboostingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingRange::set(self : MlensembleboostingRange, i : Int, v : Double) -> MlensembleboostingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingRange::sum(self : MlensembleboostingRange) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingRange::mean(self : MlensembleboostingRange) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingRange::scale(self : MlensembleboostingRange, f : Double) -> MlensembleboostingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingRange::add(self : MlensembleboostingRange, other : MlensembleboostingRange) -> MlensembleboostingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingRange::copy(self : MlensembleboostingRange) -> MlensembleboostingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingRange::fill(self : MlensembleboostingRange, v : Double) -> MlensembleboostingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingRange::min(self : MlensembleboostingRange) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingRange::max(self : MlensembleboostingRange) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingRange::to_string(self : MlensembleboostingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_slice_make(size : Int) -> MlensembleboostingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensembleboostingSlice::len(self : MlensembleboostingSlice) -> Int { self.size }

pub fn MlensembleboostingSlice::get(self : MlensembleboostingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensembleboostingSlice::set(self : MlensembleboostingSlice, i : Int, v : Double) -> MlensembleboostingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensembleboostingSlice::sum(self : MlensembleboostingSlice) -> Double { @_common.sum(self.data) }

pub fn MlensembleboostingSlice::mean(self : MlensembleboostingSlice) -> Double { @_common.mean(self.data) }

pub fn MlensembleboostingSlice::scale(self : MlensembleboostingSlice, f : Double) -> MlensembleboostingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingSlice::add(self : MlensembleboostingSlice, other : MlensembleboostingSlice) -> MlensembleboostingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensembleboostingSlice::copy(self : MlensembleboostingSlice) -> MlensembleboostingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingSlice::fill(self : MlensembleboostingSlice, v : Double) -> MlensembleboostingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensembleboostingSlice::min(self : MlensembleboostingSlice) -> Double { @_common.min(self.data) }

pub fn MlensembleboostingSlice::max(self : MlensembleboostingSlice) -> Double { @_common.max(self.data) }

pub fn MlensembleboostingSlice::to_string(self : MlensembleboostingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

