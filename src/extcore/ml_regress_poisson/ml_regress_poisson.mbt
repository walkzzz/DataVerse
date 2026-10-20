///===
/// extcore/ml_regress_poisson

pub(all) struct MlregresspoissonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_poisson_make_point(x : Double, y : Double) -> MlregresspoissonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_poisson_make_point3(x : Double, y : Double, z : Double) -> MlregresspoissonPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresspoissonPoint::x(self : MlregresspoissonPoint) -> Double { self.x }

pub fn MlregresspoissonPoint::y(self : MlregresspoissonPoint) -> Double { self.y }

pub fn MlregresspoissonPoint::z(self : MlregresspoissonPoint) -> Double { self.z }

pub fn MlregresspoissonPoint::label(self : MlregresspoissonPoint) -> Int { self.label }

pub fn MlregresspoissonPoint::dist(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresspoissonPoint::add(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresspoissonPoint::sub(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresspoissonPoint::scale(self : MlregresspoissonPoint, s : Double) -> MlregresspoissonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresspoissonPoint::dot(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresspoissonPoint::cross(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresspoissonPoint::norm(self : MlregresspoissonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresspoissonPoint::normalize(self : MlregresspoissonPoint) -> MlregresspoissonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspoissonPoint::negate(self : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresspoissonPoint::mid(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresspoissonPoint::lerp(self : MlregresspoissonPoint, other : MlregresspoissonPoint, t : Double) -> MlregresspoissonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresspoissonPoint::to_string(self : MlregresspoissonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresspoissonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_poisson_make_series(vals : Array[Double], name : String) -> MlregresspoissonSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresspoissonSeries::len(self : MlregresspoissonSeries) -> Int { self.vals.length() }

pub fn MlregresspoissonSeries::sum(self : MlregresspoissonSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresspoissonSeries::mean(self : MlregresspoissonSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresspoissonSeries::min(self : MlregresspoissonSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresspoissonSeries::max(self : MlregresspoissonSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresspoissonSeries::range(self : MlregresspoissonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresspoissonSeries::variance(self : MlregresspoissonSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresspoissonSeries::std(self : MlregresspoissonSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresspoissonSeries::median(self : MlregresspoissonSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresspoissonSeries::scale(self : MlregresspoissonSeries, f : Double) -> MlregresspoissonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresspoissonSeries::add(self : MlregresspoissonSeries, other : MlregresspoissonSeries) -> MlregresspoissonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresspoissonSeries::sub(self : MlregresspoissonSeries, other : MlregresspoissonSeries) -> MlregresspoissonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresspoissonSeries::normalize(self : MlregresspoissonSeries) -> MlregresspoissonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresspoissonSeries::cumsum(self : MlregresspoissonSeries) -> MlregresspoissonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresspoissonSeries::to_string(self : MlregresspoissonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspoissonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_poisson_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresspoissonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_poisson_matrix_identity(n : Int) -> MlregresspoissonMatrix {
  let m = ml_regress_poisson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresspoissonMatrix::get(self : MlregresspoissonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresspoissonMatrix::transpose(self : MlregresspoissonMatrix) -> MlregresspoissonMatrix {
  let result = ml_regress_poisson_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresspoissonMatrix::add(self : MlregresspoissonMatrix, other : MlregresspoissonMatrix) -> MlregresspoissonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_poisson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresspoissonMatrix::scale(self : MlregresspoissonMatrix, s : Double) -> MlregresspoissonMatrix {
  let result = ml_regress_poisson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresspoissonMatrix::multiply(self : MlregresspoissonMatrix, other : MlregresspoissonMatrix) -> MlregresspoissonMatrix {
  if self.cols != other.rows { return ml_regress_poisson_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_poisson_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresspoissonMatrix::trace(self : MlregresspoissonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresspoissonMatrix::det(self : MlregresspoissonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresspoissonMatrix::norm(self : MlregresspoissonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresspoissonMatrix::to_string(self : MlregresspoissonMatrix) -> String {
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

pub(all) struct MlregresspoissonVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_poisson_make_vector(comps : Array[Double]) -> MlregresspoissonVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_poisson_vector_zero(dim : Int) -> MlregresspoissonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresspoissonVector::add(self : MlregresspoissonVector, other : MlregresspoissonVector) -> MlregresspoissonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspoissonVector::sub(self : MlregresspoissonVector, other : MlregresspoissonVector) -> MlregresspoissonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspoissonVector::scale(self : MlregresspoissonVector, s : Double) -> MlregresspoissonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresspoissonVector::dot(self : MlregresspoissonVector, other : MlregresspoissonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresspoissonVector::norm(self : MlregresspoissonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresspoissonVector::normalize(self : MlregresspoissonVector) -> MlregresspoissonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspoissonVector::dist(self : MlregresspoissonVector, other : MlregresspoissonVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresspoissonVector::to_string(self : MlregresspoissonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspoissonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_frame_make(size : Int) -> MlregresspoissonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonFrame::len(self : MlregresspoissonFrame) -> Int { self.size }

pub fn MlregresspoissonFrame::get(self : MlregresspoissonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonFrame::set(self : MlregresspoissonFrame, i : Int, v : Double) -> MlregresspoissonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonFrame::sum(self : MlregresspoissonFrame) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonFrame::mean(self : MlregresspoissonFrame) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonFrame::scale(self : MlregresspoissonFrame, f : Double) -> MlregresspoissonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonFrame::add(self : MlregresspoissonFrame, other : MlregresspoissonFrame) -> MlregresspoissonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonFrame::copy(self : MlregresspoissonFrame) -> MlregresspoissonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonFrame::fill(self : MlregresspoissonFrame, v : Double) -> MlregresspoissonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonFrame::min(self : MlregresspoissonFrame) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonFrame::max(self : MlregresspoissonFrame) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonFrame::to_string(self : MlregresspoissonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_table_make(size : Int) -> MlregresspoissonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonTable::len(self : MlregresspoissonTable) -> Int { self.size }

pub fn MlregresspoissonTable::get(self : MlregresspoissonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonTable::set(self : MlregresspoissonTable, i : Int, v : Double) -> MlregresspoissonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonTable::sum(self : MlregresspoissonTable) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonTable::mean(self : MlregresspoissonTable) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonTable::scale(self : MlregresspoissonTable, f : Double) -> MlregresspoissonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonTable::add(self : MlregresspoissonTable, other : MlregresspoissonTable) -> MlregresspoissonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonTable::copy(self : MlregresspoissonTable) -> MlregresspoissonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonTable::fill(self : MlregresspoissonTable, v : Double) -> MlregresspoissonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonTable::min(self : MlregresspoissonTable) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonTable::max(self : MlregresspoissonTable) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonTable::to_string(self : MlregresspoissonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_graphn_make(size : Int) -> MlregresspoissonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonGraphN::len(self : MlregresspoissonGraphN) -> Int { self.size }

pub fn MlregresspoissonGraphN::get(self : MlregresspoissonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonGraphN::set(self : MlregresspoissonGraphN, i : Int, v : Double) -> MlregresspoissonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonGraphN::sum(self : MlregresspoissonGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonGraphN::mean(self : MlregresspoissonGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonGraphN::scale(self : MlregresspoissonGraphN, f : Double) -> MlregresspoissonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonGraphN::add(self : MlregresspoissonGraphN, other : MlregresspoissonGraphN) -> MlregresspoissonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonGraphN::copy(self : MlregresspoissonGraphN) -> MlregresspoissonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonGraphN::fill(self : MlregresspoissonGraphN, v : Double) -> MlregresspoissonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonGraphN::min(self : MlregresspoissonGraphN) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonGraphN::max(self : MlregresspoissonGraphN) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonGraphN::to_string(self : MlregresspoissonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_node_make(size : Int) -> MlregresspoissonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonNode::len(self : MlregresspoissonNode) -> Int { self.size }

pub fn MlregresspoissonNode::get(self : MlregresspoissonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonNode::set(self : MlregresspoissonNode, i : Int, v : Double) -> MlregresspoissonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonNode::sum(self : MlregresspoissonNode) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonNode::mean(self : MlregresspoissonNode) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonNode::scale(self : MlregresspoissonNode, f : Double) -> MlregresspoissonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonNode::add(self : MlregresspoissonNode, other : MlregresspoissonNode) -> MlregresspoissonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonNode::copy(self : MlregresspoissonNode) -> MlregresspoissonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonNode::fill(self : MlregresspoissonNode, v : Double) -> MlregresspoissonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonNode::min(self : MlregresspoissonNode) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonNode::max(self : MlregresspoissonNode) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonNode::to_string(self : MlregresspoissonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_edge_make(size : Int) -> MlregresspoissonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonEdge::len(self : MlregresspoissonEdge) -> Int { self.size }

pub fn MlregresspoissonEdge::get(self : MlregresspoissonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonEdge::set(self : MlregresspoissonEdge, i : Int, v : Double) -> MlregresspoissonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonEdge::sum(self : MlregresspoissonEdge) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonEdge::mean(self : MlregresspoissonEdge) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonEdge::scale(self : MlregresspoissonEdge, f : Double) -> MlregresspoissonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonEdge::add(self : MlregresspoissonEdge, other : MlregresspoissonEdge) -> MlregresspoissonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonEdge::copy(self : MlregresspoissonEdge) -> MlregresspoissonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonEdge::fill(self : MlregresspoissonEdge, v : Double) -> MlregresspoissonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonEdge::min(self : MlregresspoissonEdge) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonEdge::max(self : MlregresspoissonEdge) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonEdge::to_string(self : MlregresspoissonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_path_make(size : Int) -> MlregresspoissonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonPath::len(self : MlregresspoissonPath) -> Int { self.size }

pub fn MlregresspoissonPath::get(self : MlregresspoissonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonPath::set(self : MlregresspoissonPath, i : Int, v : Double) -> MlregresspoissonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonPath::sum(self : MlregresspoissonPath) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonPath::mean(self : MlregresspoissonPath) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonPath::scale(self : MlregresspoissonPath, f : Double) -> MlregresspoissonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonPath::add(self : MlregresspoissonPath, other : MlregresspoissonPath) -> MlregresspoissonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonPath::copy(self : MlregresspoissonPath) -> MlregresspoissonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonPath::fill(self : MlregresspoissonPath, v : Double) -> MlregresspoissonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonPath::min(self : MlregresspoissonPath) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonPath::max(self : MlregresspoissonPath) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonPath::to_string(self : MlregresspoissonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_cluster_make(size : Int) -> MlregresspoissonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonCluster::len(self : MlregresspoissonCluster) -> Int { self.size }

pub fn MlregresspoissonCluster::get(self : MlregresspoissonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonCluster::set(self : MlregresspoissonCluster, i : Int, v : Double) -> MlregresspoissonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCluster::sum(self : MlregresspoissonCluster) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonCluster::mean(self : MlregresspoissonCluster) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonCluster::scale(self : MlregresspoissonCluster, f : Double) -> MlregresspoissonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCluster::add(self : MlregresspoissonCluster, other : MlregresspoissonCluster) -> MlregresspoissonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonCluster::copy(self : MlregresspoissonCluster) -> MlregresspoissonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCluster::fill(self : MlregresspoissonCluster, v : Double) -> MlregresspoissonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCluster::min(self : MlregresspoissonCluster) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonCluster::max(self : MlregresspoissonCluster) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonCluster::to_string(self : MlregresspoissonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_model_make(size : Int) -> MlregresspoissonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonModel::len(self : MlregresspoissonModel) -> Int { self.size }

pub fn MlregresspoissonModel::get(self : MlregresspoissonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonModel::set(self : MlregresspoissonModel, i : Int, v : Double) -> MlregresspoissonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonModel::sum(self : MlregresspoissonModel) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonModel::mean(self : MlregresspoissonModel) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonModel::scale(self : MlregresspoissonModel, f : Double) -> MlregresspoissonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonModel::add(self : MlregresspoissonModel, other : MlregresspoissonModel) -> MlregresspoissonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonModel::copy(self : MlregresspoissonModel) -> MlregresspoissonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonModel::fill(self : MlregresspoissonModel, v : Double) -> MlregresspoissonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonModel::min(self : MlregresspoissonModel) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonModel::max(self : MlregresspoissonModel) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonModel::to_string(self : MlregresspoissonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_layer_make(size : Int) -> MlregresspoissonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonLayer::len(self : MlregresspoissonLayer) -> Int { self.size }

pub fn MlregresspoissonLayer::get(self : MlregresspoissonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonLayer::set(self : MlregresspoissonLayer, i : Int, v : Double) -> MlregresspoissonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonLayer::sum(self : MlregresspoissonLayer) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonLayer::mean(self : MlregresspoissonLayer) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonLayer::scale(self : MlregresspoissonLayer, f : Double) -> MlregresspoissonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonLayer::add(self : MlregresspoissonLayer, other : MlregresspoissonLayer) -> MlregresspoissonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonLayer::copy(self : MlregresspoissonLayer) -> MlregresspoissonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonLayer::fill(self : MlregresspoissonLayer, v : Double) -> MlregresspoissonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonLayer::min(self : MlregresspoissonLayer) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonLayer::max(self : MlregresspoissonLayer) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonLayer::to_string(self : MlregresspoissonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_buffer_make(size : Int) -> MlregresspoissonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonBuffer::len(self : MlregresspoissonBuffer) -> Int { self.size }

pub fn MlregresspoissonBuffer::get(self : MlregresspoissonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonBuffer::set(self : MlregresspoissonBuffer, i : Int, v : Double) -> MlregresspoissonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonBuffer::sum(self : MlregresspoissonBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonBuffer::mean(self : MlregresspoissonBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonBuffer::scale(self : MlregresspoissonBuffer, f : Double) -> MlregresspoissonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonBuffer::add(self : MlregresspoissonBuffer, other : MlregresspoissonBuffer) -> MlregresspoissonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonBuffer::copy(self : MlregresspoissonBuffer) -> MlregresspoissonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonBuffer::fill(self : MlregresspoissonBuffer, v : Double) -> MlregresspoissonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonBuffer::min(self : MlregresspoissonBuffer) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonBuffer::max(self : MlregresspoissonBuffer) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonBuffer::to_string(self : MlregresspoissonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_cursor_make(size : Int) -> MlregresspoissonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonCursor::len(self : MlregresspoissonCursor) -> Int { self.size }

pub fn MlregresspoissonCursor::get(self : MlregresspoissonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonCursor::set(self : MlregresspoissonCursor, i : Int, v : Double) -> MlregresspoissonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCursor::sum(self : MlregresspoissonCursor) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonCursor::mean(self : MlregresspoissonCursor) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonCursor::scale(self : MlregresspoissonCursor, f : Double) -> MlregresspoissonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCursor::add(self : MlregresspoissonCursor, other : MlregresspoissonCursor) -> MlregresspoissonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonCursor::copy(self : MlregresspoissonCursor) -> MlregresspoissonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCursor::fill(self : MlregresspoissonCursor, v : Double) -> MlregresspoissonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonCursor::min(self : MlregresspoissonCursor) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonCursor::max(self : MlregresspoissonCursor) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonCursor::to_string(self : MlregresspoissonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_view_make(size : Int) -> MlregresspoissonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonView::len(self : MlregresspoissonView) -> Int { self.size }

pub fn MlregresspoissonView::get(self : MlregresspoissonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonView::set(self : MlregresspoissonView, i : Int, v : Double) -> MlregresspoissonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonView::sum(self : MlregresspoissonView) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonView::mean(self : MlregresspoissonView) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonView::scale(self : MlregresspoissonView, f : Double) -> MlregresspoissonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonView::add(self : MlregresspoissonView, other : MlregresspoissonView) -> MlregresspoissonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonView::copy(self : MlregresspoissonView) -> MlregresspoissonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonView::fill(self : MlregresspoissonView, v : Double) -> MlregresspoissonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonView::min(self : MlregresspoissonView) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonView::max(self : MlregresspoissonView) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonView::to_string(self : MlregresspoissonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_range_make(size : Int) -> MlregresspoissonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonRange::len(self : MlregresspoissonRange) -> Int { self.size }

pub fn MlregresspoissonRange::get(self : MlregresspoissonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonRange::set(self : MlregresspoissonRange, i : Int, v : Double) -> MlregresspoissonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonRange::sum(self : MlregresspoissonRange) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonRange::mean(self : MlregresspoissonRange) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonRange::scale(self : MlregresspoissonRange, f : Double) -> MlregresspoissonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonRange::add(self : MlregresspoissonRange, other : MlregresspoissonRange) -> MlregresspoissonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonRange::copy(self : MlregresspoissonRange) -> MlregresspoissonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonRange::fill(self : MlregresspoissonRange, v : Double) -> MlregresspoissonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonRange::min(self : MlregresspoissonRange) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonRange::max(self : MlregresspoissonRange) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonRange::to_string(self : MlregresspoissonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_slice_make(size : Int) -> MlregresspoissonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregresspoissonSlice::len(self : MlregresspoissonSlice) -> Int { self.size }

pub fn MlregresspoissonSlice::get(self : MlregresspoissonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregresspoissonSlice::set(self : MlregresspoissonSlice, i : Int, v : Double) -> MlregresspoissonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregresspoissonSlice::sum(self : MlregresspoissonSlice) -> Double { @_common.sum(self.data) }

pub fn MlregresspoissonSlice::mean(self : MlregresspoissonSlice) -> Double { @_common.mean(self.data) }

pub fn MlregresspoissonSlice::scale(self : MlregresspoissonSlice, f : Double) -> MlregresspoissonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonSlice::add(self : MlregresspoissonSlice, other : MlregresspoissonSlice) -> MlregresspoissonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregresspoissonSlice::copy(self : MlregresspoissonSlice) -> MlregresspoissonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonSlice::fill(self : MlregresspoissonSlice, v : Double) -> MlregresspoissonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregresspoissonSlice::min(self : MlregresspoissonSlice) -> Double { @_common.min(self.data) }

pub fn MlregresspoissonSlice::max(self : MlregresspoissonSlice) -> Double { @_common.max(self.data) }

pub fn MlregresspoissonSlice::to_string(self : MlregresspoissonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

