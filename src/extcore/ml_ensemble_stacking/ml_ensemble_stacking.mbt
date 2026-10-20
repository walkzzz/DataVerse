///===
/// extcore/ml_ensemble_stacking

pub(all) struct MlensemblestackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_stacking_make_point(x : Double, y : Double) -> MlensemblestackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_stacking_make_point3(x : Double, y : Double, z : Double) -> MlensemblestackingPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblestackingPoint::x(self : MlensemblestackingPoint) -> Double { self.x }

pub fn MlensemblestackingPoint::y(self : MlensemblestackingPoint) -> Double { self.y }

pub fn MlensemblestackingPoint::z(self : MlensemblestackingPoint) -> Double { self.z }

pub fn MlensemblestackingPoint::label(self : MlensemblestackingPoint) -> Int { self.label }

pub fn MlensemblestackingPoint::dist(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblestackingPoint::add(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblestackingPoint::sub(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblestackingPoint::scale(self : MlensemblestackingPoint, s : Double) -> MlensemblestackingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblestackingPoint::dot(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblestackingPoint::cross(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblestackingPoint::norm(self : MlensemblestackingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblestackingPoint::normalize(self : MlensemblestackingPoint) -> MlensemblestackingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblestackingPoint::negate(self : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblestackingPoint::mid(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblestackingPoint::lerp(self : MlensemblestackingPoint, other : MlensemblestackingPoint, t : Double) -> MlensemblestackingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblestackingPoint::to_string(self : MlensemblestackingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblestackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_stacking_make_series(vals : Array[Double], name : String) -> MlensemblestackingSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblestackingSeries::len(self : MlensemblestackingSeries) -> Int { self.vals.length() }

pub fn MlensemblestackingSeries::sum(self : MlensemblestackingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblestackingSeries::mean(self : MlensemblestackingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblestackingSeries::min(self : MlensemblestackingSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblestackingSeries::max(self : MlensemblestackingSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblestackingSeries::range(self : MlensemblestackingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblestackingSeries::variance(self : MlensemblestackingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblestackingSeries::std(self : MlensemblestackingSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblestackingSeries::median(self : MlensemblestackingSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblestackingSeries::scale(self : MlensemblestackingSeries, f : Double) -> MlensemblestackingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblestackingSeries::add(self : MlensemblestackingSeries, other : MlensemblestackingSeries) -> MlensemblestackingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblestackingSeries::sub(self : MlensemblestackingSeries, other : MlensemblestackingSeries) -> MlensemblestackingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblestackingSeries::normalize(self : MlensemblestackingSeries) -> MlensemblestackingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblestackingSeries::cumsum(self : MlensemblestackingSeries) -> MlensemblestackingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblestackingSeries::to_string(self : MlensemblestackingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblestackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblestackingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_stacking_matrix_identity(n : Int) -> MlensemblestackingMatrix {
  let m = ml_ensemble_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblestackingMatrix::get(self : MlensemblestackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblestackingMatrix::transpose(self : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  let result = ml_ensemble_stacking_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblestackingMatrix::add(self : MlensemblestackingMatrix, other : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblestackingMatrix::scale(self : MlensemblestackingMatrix, s : Double) -> MlensemblestackingMatrix {
  let result = ml_ensemble_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblestackingMatrix::multiply(self : MlensemblestackingMatrix, other : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  if self.cols != other.rows { return ml_ensemble_stacking_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_stacking_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlensemblestackingMatrix::trace(self : MlensemblestackingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblestackingMatrix::det(self : MlensemblestackingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblestackingMatrix::norm(self : MlensemblestackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblestackingMatrix::to_string(self : MlensemblestackingMatrix) -> String {
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

pub(all) struct MlensemblestackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_stacking_make_vector(comps : Array[Double]) -> MlensemblestackingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_stacking_vector_zero(dim : Int) -> MlensemblestackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblestackingVector::add(self : MlensemblestackingVector, other : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblestackingVector::sub(self : MlensemblestackingVector, other : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblestackingVector::scale(self : MlensemblestackingVector, s : Double) -> MlensemblestackingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblestackingVector::dot(self : MlensemblestackingVector, other : MlensemblestackingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblestackingVector::norm(self : MlensemblestackingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblestackingVector::normalize(self : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblestackingVector::dist(self : MlensemblestackingVector, other : MlensemblestackingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblestackingVector::to_string(self : MlensemblestackingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblestackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_frame_make(size : Int) -> MlensemblestackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingFrame::len(self : MlensemblestackingFrame) -> Int { self.size }

pub fn MlensemblestackingFrame::get(self : MlensemblestackingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingFrame::set(self : MlensemblestackingFrame, i : Int, v : Double) -> MlensemblestackingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingFrame::sum(self : MlensemblestackingFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingFrame::mean(self : MlensemblestackingFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingFrame::scale(self : MlensemblestackingFrame, f : Double) -> MlensemblestackingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingFrame::add(self : MlensemblestackingFrame, other : MlensemblestackingFrame) -> MlensemblestackingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingFrame::copy(self : MlensemblestackingFrame) -> MlensemblestackingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingFrame::fill(self : MlensemblestackingFrame, v : Double) -> MlensemblestackingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingFrame::min(self : MlensemblestackingFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingFrame::max(self : MlensemblestackingFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingFrame::to_string(self : MlensemblestackingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_table_make(size : Int) -> MlensemblestackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingTable::len(self : MlensemblestackingTable) -> Int { self.size }

pub fn MlensemblestackingTable::get(self : MlensemblestackingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingTable::set(self : MlensemblestackingTable, i : Int, v : Double) -> MlensemblestackingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingTable::sum(self : MlensemblestackingTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingTable::mean(self : MlensemblestackingTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingTable::scale(self : MlensemblestackingTable, f : Double) -> MlensemblestackingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingTable::add(self : MlensemblestackingTable, other : MlensemblestackingTable) -> MlensemblestackingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingTable::copy(self : MlensemblestackingTable) -> MlensemblestackingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingTable::fill(self : MlensemblestackingTable, v : Double) -> MlensemblestackingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingTable::min(self : MlensemblestackingTable) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingTable::max(self : MlensemblestackingTable) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingTable::to_string(self : MlensemblestackingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_graphn_make(size : Int) -> MlensemblestackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingGraphN::len(self : MlensemblestackingGraphN) -> Int { self.size }

pub fn MlensemblestackingGraphN::get(self : MlensemblestackingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingGraphN::set(self : MlensemblestackingGraphN, i : Int, v : Double) -> MlensemblestackingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingGraphN::sum(self : MlensemblestackingGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingGraphN::mean(self : MlensemblestackingGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingGraphN::scale(self : MlensemblestackingGraphN, f : Double) -> MlensemblestackingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingGraphN::add(self : MlensemblestackingGraphN, other : MlensemblestackingGraphN) -> MlensemblestackingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingGraphN::copy(self : MlensemblestackingGraphN) -> MlensemblestackingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingGraphN::fill(self : MlensemblestackingGraphN, v : Double) -> MlensemblestackingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingGraphN::min(self : MlensemblestackingGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingGraphN::max(self : MlensemblestackingGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingGraphN::to_string(self : MlensemblestackingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_node_make(size : Int) -> MlensemblestackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingNode::len(self : MlensemblestackingNode) -> Int { self.size }

pub fn MlensemblestackingNode::get(self : MlensemblestackingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingNode::set(self : MlensemblestackingNode, i : Int, v : Double) -> MlensemblestackingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingNode::sum(self : MlensemblestackingNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingNode::mean(self : MlensemblestackingNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingNode::scale(self : MlensemblestackingNode, f : Double) -> MlensemblestackingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingNode::add(self : MlensemblestackingNode, other : MlensemblestackingNode) -> MlensemblestackingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingNode::copy(self : MlensemblestackingNode) -> MlensemblestackingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingNode::fill(self : MlensemblestackingNode, v : Double) -> MlensemblestackingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingNode::min(self : MlensemblestackingNode) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingNode::max(self : MlensemblestackingNode) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingNode::to_string(self : MlensemblestackingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_edge_make(size : Int) -> MlensemblestackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingEdge::len(self : MlensemblestackingEdge) -> Int { self.size }

pub fn MlensemblestackingEdge::get(self : MlensemblestackingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingEdge::set(self : MlensemblestackingEdge, i : Int, v : Double) -> MlensemblestackingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingEdge::sum(self : MlensemblestackingEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingEdge::mean(self : MlensemblestackingEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingEdge::scale(self : MlensemblestackingEdge, f : Double) -> MlensemblestackingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingEdge::add(self : MlensemblestackingEdge, other : MlensemblestackingEdge) -> MlensemblestackingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingEdge::copy(self : MlensemblestackingEdge) -> MlensemblestackingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingEdge::fill(self : MlensemblestackingEdge, v : Double) -> MlensemblestackingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingEdge::min(self : MlensemblestackingEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingEdge::max(self : MlensemblestackingEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingEdge::to_string(self : MlensemblestackingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_path_make(size : Int) -> MlensemblestackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingPath::len(self : MlensemblestackingPath) -> Int { self.size }

pub fn MlensemblestackingPath::get(self : MlensemblestackingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingPath::set(self : MlensemblestackingPath, i : Int, v : Double) -> MlensemblestackingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingPath::sum(self : MlensemblestackingPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingPath::mean(self : MlensemblestackingPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingPath::scale(self : MlensemblestackingPath, f : Double) -> MlensemblestackingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingPath::add(self : MlensemblestackingPath, other : MlensemblestackingPath) -> MlensemblestackingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingPath::copy(self : MlensemblestackingPath) -> MlensemblestackingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingPath::fill(self : MlensemblestackingPath, v : Double) -> MlensemblestackingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingPath::min(self : MlensemblestackingPath) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingPath::max(self : MlensemblestackingPath) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingPath::to_string(self : MlensemblestackingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_cluster_make(size : Int) -> MlensemblestackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingCluster::len(self : MlensemblestackingCluster) -> Int { self.size }

pub fn MlensemblestackingCluster::get(self : MlensemblestackingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingCluster::set(self : MlensemblestackingCluster, i : Int, v : Double) -> MlensemblestackingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCluster::sum(self : MlensemblestackingCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingCluster::mean(self : MlensemblestackingCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingCluster::scale(self : MlensemblestackingCluster, f : Double) -> MlensemblestackingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCluster::add(self : MlensemblestackingCluster, other : MlensemblestackingCluster) -> MlensemblestackingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingCluster::copy(self : MlensemblestackingCluster) -> MlensemblestackingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCluster::fill(self : MlensemblestackingCluster, v : Double) -> MlensemblestackingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCluster::min(self : MlensemblestackingCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingCluster::max(self : MlensemblestackingCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingCluster::to_string(self : MlensemblestackingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_model_make(size : Int) -> MlensemblestackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingModel::len(self : MlensemblestackingModel) -> Int { self.size }

pub fn MlensemblestackingModel::get(self : MlensemblestackingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingModel::set(self : MlensemblestackingModel, i : Int, v : Double) -> MlensemblestackingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingModel::sum(self : MlensemblestackingModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingModel::mean(self : MlensemblestackingModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingModel::scale(self : MlensemblestackingModel, f : Double) -> MlensemblestackingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingModel::add(self : MlensemblestackingModel, other : MlensemblestackingModel) -> MlensemblestackingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingModel::copy(self : MlensemblestackingModel) -> MlensemblestackingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingModel::fill(self : MlensemblestackingModel, v : Double) -> MlensemblestackingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingModel::min(self : MlensemblestackingModel) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingModel::max(self : MlensemblestackingModel) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingModel::to_string(self : MlensemblestackingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_layer_make(size : Int) -> MlensemblestackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingLayer::len(self : MlensemblestackingLayer) -> Int { self.size }

pub fn MlensemblestackingLayer::get(self : MlensemblestackingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingLayer::set(self : MlensemblestackingLayer, i : Int, v : Double) -> MlensemblestackingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingLayer::sum(self : MlensemblestackingLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingLayer::mean(self : MlensemblestackingLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingLayer::scale(self : MlensemblestackingLayer, f : Double) -> MlensemblestackingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingLayer::add(self : MlensemblestackingLayer, other : MlensemblestackingLayer) -> MlensemblestackingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingLayer::copy(self : MlensemblestackingLayer) -> MlensemblestackingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingLayer::fill(self : MlensemblestackingLayer, v : Double) -> MlensemblestackingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingLayer::min(self : MlensemblestackingLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingLayer::max(self : MlensemblestackingLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingLayer::to_string(self : MlensemblestackingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_buffer_make(size : Int) -> MlensemblestackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingBuffer::len(self : MlensemblestackingBuffer) -> Int { self.size }

pub fn MlensemblestackingBuffer::get(self : MlensemblestackingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingBuffer::set(self : MlensemblestackingBuffer, i : Int, v : Double) -> MlensemblestackingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingBuffer::sum(self : MlensemblestackingBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingBuffer::mean(self : MlensemblestackingBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingBuffer::scale(self : MlensemblestackingBuffer, f : Double) -> MlensemblestackingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingBuffer::add(self : MlensemblestackingBuffer, other : MlensemblestackingBuffer) -> MlensemblestackingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingBuffer::copy(self : MlensemblestackingBuffer) -> MlensemblestackingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingBuffer::fill(self : MlensemblestackingBuffer, v : Double) -> MlensemblestackingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingBuffer::min(self : MlensemblestackingBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingBuffer::max(self : MlensemblestackingBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingBuffer::to_string(self : MlensemblestackingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_cursor_make(size : Int) -> MlensemblestackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingCursor::len(self : MlensemblestackingCursor) -> Int { self.size }

pub fn MlensemblestackingCursor::get(self : MlensemblestackingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingCursor::set(self : MlensemblestackingCursor, i : Int, v : Double) -> MlensemblestackingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCursor::sum(self : MlensemblestackingCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingCursor::mean(self : MlensemblestackingCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingCursor::scale(self : MlensemblestackingCursor, f : Double) -> MlensemblestackingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCursor::add(self : MlensemblestackingCursor, other : MlensemblestackingCursor) -> MlensemblestackingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingCursor::copy(self : MlensemblestackingCursor) -> MlensemblestackingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCursor::fill(self : MlensemblestackingCursor, v : Double) -> MlensemblestackingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingCursor::min(self : MlensemblestackingCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingCursor::max(self : MlensemblestackingCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingCursor::to_string(self : MlensemblestackingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_view_make(size : Int) -> MlensemblestackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingView::len(self : MlensemblestackingView) -> Int { self.size }

pub fn MlensemblestackingView::get(self : MlensemblestackingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingView::set(self : MlensemblestackingView, i : Int, v : Double) -> MlensemblestackingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingView::sum(self : MlensemblestackingView) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingView::mean(self : MlensemblestackingView) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingView::scale(self : MlensemblestackingView, f : Double) -> MlensemblestackingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingView::add(self : MlensemblestackingView, other : MlensemblestackingView) -> MlensemblestackingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingView::copy(self : MlensemblestackingView) -> MlensemblestackingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingView::fill(self : MlensemblestackingView, v : Double) -> MlensemblestackingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingView::min(self : MlensemblestackingView) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingView::max(self : MlensemblestackingView) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingView::to_string(self : MlensemblestackingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_range_make(size : Int) -> MlensemblestackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingRange::len(self : MlensemblestackingRange) -> Int { self.size }

pub fn MlensemblestackingRange::get(self : MlensemblestackingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingRange::set(self : MlensemblestackingRange, i : Int, v : Double) -> MlensemblestackingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingRange::sum(self : MlensemblestackingRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingRange::mean(self : MlensemblestackingRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingRange::scale(self : MlensemblestackingRange, f : Double) -> MlensemblestackingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingRange::add(self : MlensemblestackingRange, other : MlensemblestackingRange) -> MlensemblestackingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingRange::copy(self : MlensemblestackingRange) -> MlensemblestackingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingRange::fill(self : MlensemblestackingRange, v : Double) -> MlensemblestackingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingRange::min(self : MlensemblestackingRange) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingRange::max(self : MlensemblestackingRange) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingRange::to_string(self : MlensemblestackingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_slice_make(size : Int) -> MlensemblestackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblestackingSlice::len(self : MlensemblestackingSlice) -> Int { self.size }

pub fn MlensemblestackingSlice::get(self : MlensemblestackingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblestackingSlice::set(self : MlensemblestackingSlice, i : Int, v : Double) -> MlensemblestackingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblestackingSlice::sum(self : MlensemblestackingSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblestackingSlice::mean(self : MlensemblestackingSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblestackingSlice::scale(self : MlensemblestackingSlice, f : Double) -> MlensemblestackingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingSlice::add(self : MlensemblestackingSlice, other : MlensemblestackingSlice) -> MlensemblestackingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblestackingSlice::copy(self : MlensemblestackingSlice) -> MlensemblestackingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingSlice::fill(self : MlensemblestackingSlice, v : Double) -> MlensemblestackingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblestackingSlice::min(self : MlensemblestackingSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblestackingSlice::max(self : MlensemblestackingSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblestackingSlice::to_string(self : MlensemblestackingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

