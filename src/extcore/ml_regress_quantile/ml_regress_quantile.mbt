///===
/// extcore/ml_regress_quantile

pub(all) struct MlregressquantilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_quantile_make_point(x : Double, y : Double) -> MlregressquantilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_quantile_make_point3(x : Double, y : Double, z : Double) -> MlregressquantilePoint {
  { x, y, z, label: 0 }
}

pub fn MlregressquantilePoint::x(self : MlregressquantilePoint) -> Double { self.x }

pub fn MlregressquantilePoint::y(self : MlregressquantilePoint) -> Double { self.y }

pub fn MlregressquantilePoint::z(self : MlregressquantilePoint) -> Double { self.z }

pub fn MlregressquantilePoint::label(self : MlregressquantilePoint) -> Int { self.label }

pub fn MlregressquantilePoint::dist(self : MlregressquantilePoint, other : MlregressquantilePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregressquantilePoint::add(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregressquantilePoint::sub(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregressquantilePoint::scale(self : MlregressquantilePoint, s : Double) -> MlregressquantilePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregressquantilePoint::dot(self : MlregressquantilePoint, other : MlregressquantilePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregressquantilePoint::cross(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregressquantilePoint::norm(self : MlregressquantilePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregressquantilePoint::normalize(self : MlregressquantilePoint) -> MlregressquantilePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressquantilePoint::negate(self : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregressquantilePoint::mid(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregressquantilePoint::lerp(self : MlregressquantilePoint, other : MlregressquantilePoint, t : Double) -> MlregressquantilePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregressquantilePoint::to_string(self : MlregressquantilePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregressquantileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_quantile_make_series(vals : Array[Double], name : String) -> MlregressquantileSeries {
  { vals, name, meta: 0 }
}

pub fn MlregressquantileSeries::len(self : MlregressquantileSeries) -> Int { self.vals.length() }

pub fn MlregressquantileSeries::sum(self : MlregressquantileSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregressquantileSeries::mean(self : MlregressquantileSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregressquantileSeries::min(self : MlregressquantileSeries) -> Double { @_common.min(self.vals) }

pub fn MlregressquantileSeries::max(self : MlregressquantileSeries) -> Double { @_common.max(self.vals) }

pub fn MlregressquantileSeries::range(self : MlregressquantileSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregressquantileSeries::variance(self : MlregressquantileSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregressquantileSeries::std(self : MlregressquantileSeries) -> Double { @_common.std(self.vals) }

pub fn MlregressquantileSeries::median(self : MlregressquantileSeries) -> Double { @_common.median(self.vals) }

pub fn MlregressquantileSeries::scale(self : MlregressquantileSeries, f : Double) -> MlregressquantileSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregressquantileSeries::add(self : MlregressquantileSeries, other : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregressquantileSeries::sub(self : MlregressquantileSeries, other : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregressquantileSeries::normalize(self : MlregressquantileSeries) -> MlregressquantileSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregressquantileSeries::cumsum(self : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregressquantileSeries::to_string(self : MlregressquantileSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressquantileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_quantile_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressquantileMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_regress_quantile_matrix_identity(n : Int) -> MlregressquantileMatrix {
  let m = ml_regress_quantile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregressquantileMatrix::get(self : MlregressquantileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregressquantileMatrix::transpose(self : MlregressquantileMatrix) -> MlregressquantileMatrix {
  let result = ml_regress_quantile_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregressquantileMatrix::add(self : MlregressquantileMatrix, other : MlregressquantileMatrix) -> MlregressquantileMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_quantile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregressquantileMatrix::scale(self : MlregressquantileMatrix, s : Double) -> MlregressquantileMatrix {
  let result = ml_regress_quantile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregressquantileMatrix::multiply(self : MlregressquantileMatrix, other : MlregressquantileMatrix) -> MlregressquantileMatrix {
  if self.cols != other.rows { return ml_regress_quantile_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_quantile_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlregressquantileMatrix::trace(self : MlregressquantileMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregressquantileMatrix::det(self : MlregressquantileMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregressquantileMatrix::norm(self : MlregressquantileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregressquantileMatrix::to_string(self : MlregressquantileMatrix) -> String {
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

pub(all) struct MlregressquantileVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_quantile_make_vector(comps : Array[Double]) -> MlregressquantileVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_quantile_vector_zero(dim : Int) -> MlregressquantileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregressquantileVector::add(self : MlregressquantileVector, other : MlregressquantileVector) -> MlregressquantileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressquantileVector::sub(self : MlregressquantileVector, other : MlregressquantileVector) -> MlregressquantileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressquantileVector::scale(self : MlregressquantileVector, s : Double) -> MlregressquantileVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregressquantileVector::dot(self : MlregressquantileVector, other : MlregressquantileVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregressquantileVector::norm(self : MlregressquantileVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregressquantileVector::normalize(self : MlregressquantileVector) -> MlregressquantileVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressquantileVector::dist(self : MlregressquantileVector, other : MlregressquantileVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregressquantileVector::to_string(self : MlregressquantileVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressquantileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_frame_make(size : Int) -> MlregressquantileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileFrame::len(self : MlregressquantileFrame) -> Int { self.size }

pub fn MlregressquantileFrame::get(self : MlregressquantileFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileFrame::set(self : MlregressquantileFrame, i : Int, v : Double) -> MlregressquantileFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileFrame::sum(self : MlregressquantileFrame) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileFrame::mean(self : MlregressquantileFrame) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileFrame::scale(self : MlregressquantileFrame, f : Double) -> MlregressquantileFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileFrame::add(self : MlregressquantileFrame, other : MlregressquantileFrame) -> MlregressquantileFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileFrame::copy(self : MlregressquantileFrame) -> MlregressquantileFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileFrame::fill(self : MlregressquantileFrame, v : Double) -> MlregressquantileFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileFrame::min(self : MlregressquantileFrame) -> Double { @_common.min(self.data) }

pub fn MlregressquantileFrame::max(self : MlregressquantileFrame) -> Double { @_common.max(self.data) }

pub fn MlregressquantileFrame::to_string(self : MlregressquantileFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_table_make(size : Int) -> MlregressquantileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileTable::len(self : MlregressquantileTable) -> Int { self.size }

pub fn MlregressquantileTable::get(self : MlregressquantileTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileTable::set(self : MlregressquantileTable, i : Int, v : Double) -> MlregressquantileTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileTable::sum(self : MlregressquantileTable) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileTable::mean(self : MlregressquantileTable) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileTable::scale(self : MlregressquantileTable, f : Double) -> MlregressquantileTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileTable::add(self : MlregressquantileTable, other : MlregressquantileTable) -> MlregressquantileTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileTable::copy(self : MlregressquantileTable) -> MlregressquantileTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileTable::fill(self : MlregressquantileTable, v : Double) -> MlregressquantileTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileTable::min(self : MlregressquantileTable) -> Double { @_common.min(self.data) }

pub fn MlregressquantileTable::max(self : MlregressquantileTable) -> Double { @_common.max(self.data) }

pub fn MlregressquantileTable::to_string(self : MlregressquantileTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_graphn_make(size : Int) -> MlregressquantileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileGraphN::len(self : MlregressquantileGraphN) -> Int { self.size }

pub fn MlregressquantileGraphN::get(self : MlregressquantileGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileGraphN::set(self : MlregressquantileGraphN, i : Int, v : Double) -> MlregressquantileGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileGraphN::sum(self : MlregressquantileGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileGraphN::mean(self : MlregressquantileGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileGraphN::scale(self : MlregressquantileGraphN, f : Double) -> MlregressquantileGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileGraphN::add(self : MlregressquantileGraphN, other : MlregressquantileGraphN) -> MlregressquantileGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileGraphN::copy(self : MlregressquantileGraphN) -> MlregressquantileGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileGraphN::fill(self : MlregressquantileGraphN, v : Double) -> MlregressquantileGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileGraphN::min(self : MlregressquantileGraphN) -> Double { @_common.min(self.data) }

pub fn MlregressquantileGraphN::max(self : MlregressquantileGraphN) -> Double { @_common.max(self.data) }

pub fn MlregressquantileGraphN::to_string(self : MlregressquantileGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_node_make(size : Int) -> MlregressquantileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileNode::len(self : MlregressquantileNode) -> Int { self.size }

pub fn MlregressquantileNode::get(self : MlregressquantileNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileNode::set(self : MlregressquantileNode, i : Int, v : Double) -> MlregressquantileNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileNode::sum(self : MlregressquantileNode) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileNode::mean(self : MlregressquantileNode) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileNode::scale(self : MlregressquantileNode, f : Double) -> MlregressquantileNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileNode::add(self : MlregressquantileNode, other : MlregressquantileNode) -> MlregressquantileNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileNode::copy(self : MlregressquantileNode) -> MlregressquantileNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileNode::fill(self : MlregressquantileNode, v : Double) -> MlregressquantileNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileNode::min(self : MlregressquantileNode) -> Double { @_common.min(self.data) }

pub fn MlregressquantileNode::max(self : MlregressquantileNode) -> Double { @_common.max(self.data) }

pub fn MlregressquantileNode::to_string(self : MlregressquantileNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_edge_make(size : Int) -> MlregressquantileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileEdge::len(self : MlregressquantileEdge) -> Int { self.size }

pub fn MlregressquantileEdge::get(self : MlregressquantileEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileEdge::set(self : MlregressquantileEdge, i : Int, v : Double) -> MlregressquantileEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileEdge::sum(self : MlregressquantileEdge) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileEdge::mean(self : MlregressquantileEdge) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileEdge::scale(self : MlregressquantileEdge, f : Double) -> MlregressquantileEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileEdge::add(self : MlregressquantileEdge, other : MlregressquantileEdge) -> MlregressquantileEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileEdge::copy(self : MlregressquantileEdge) -> MlregressquantileEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileEdge::fill(self : MlregressquantileEdge, v : Double) -> MlregressquantileEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileEdge::min(self : MlregressquantileEdge) -> Double { @_common.min(self.data) }

pub fn MlregressquantileEdge::max(self : MlregressquantileEdge) -> Double { @_common.max(self.data) }

pub fn MlregressquantileEdge::to_string(self : MlregressquantileEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_path_make(size : Int) -> MlregressquantilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantilePath::len(self : MlregressquantilePath) -> Int { self.size }

pub fn MlregressquantilePath::get(self : MlregressquantilePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantilePath::set(self : MlregressquantilePath, i : Int, v : Double) -> MlregressquantilePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantilePath::sum(self : MlregressquantilePath) -> Double { @_common.sum(self.data) }

pub fn MlregressquantilePath::mean(self : MlregressquantilePath) -> Double { @_common.mean(self.data) }

pub fn MlregressquantilePath::scale(self : MlregressquantilePath, f : Double) -> MlregressquantilePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantilePath::add(self : MlregressquantilePath, other : MlregressquantilePath) -> MlregressquantilePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantilePath::copy(self : MlregressquantilePath) -> MlregressquantilePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantilePath::fill(self : MlregressquantilePath, v : Double) -> MlregressquantilePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantilePath::min(self : MlregressquantilePath) -> Double { @_common.min(self.data) }

pub fn MlregressquantilePath::max(self : MlregressquantilePath) -> Double { @_common.max(self.data) }

pub fn MlregressquantilePath::to_string(self : MlregressquantilePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_cluster_make(size : Int) -> MlregressquantileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileCluster::len(self : MlregressquantileCluster) -> Int { self.size }

pub fn MlregressquantileCluster::get(self : MlregressquantileCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileCluster::set(self : MlregressquantileCluster, i : Int, v : Double) -> MlregressquantileCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileCluster::sum(self : MlregressquantileCluster) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileCluster::mean(self : MlregressquantileCluster) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileCluster::scale(self : MlregressquantileCluster, f : Double) -> MlregressquantileCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileCluster::add(self : MlregressquantileCluster, other : MlregressquantileCluster) -> MlregressquantileCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileCluster::copy(self : MlregressquantileCluster) -> MlregressquantileCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileCluster::fill(self : MlregressquantileCluster, v : Double) -> MlregressquantileCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileCluster::min(self : MlregressquantileCluster) -> Double { @_common.min(self.data) }

pub fn MlregressquantileCluster::max(self : MlregressquantileCluster) -> Double { @_common.max(self.data) }

pub fn MlregressquantileCluster::to_string(self : MlregressquantileCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_model_make(size : Int) -> MlregressquantileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileModel::len(self : MlregressquantileModel) -> Int { self.size }

pub fn MlregressquantileModel::get(self : MlregressquantileModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileModel::set(self : MlregressquantileModel, i : Int, v : Double) -> MlregressquantileModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileModel::sum(self : MlregressquantileModel) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileModel::mean(self : MlregressquantileModel) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileModel::scale(self : MlregressquantileModel, f : Double) -> MlregressquantileModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileModel::add(self : MlregressquantileModel, other : MlregressquantileModel) -> MlregressquantileModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileModel::copy(self : MlregressquantileModel) -> MlregressquantileModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileModel::fill(self : MlregressquantileModel, v : Double) -> MlregressquantileModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileModel::min(self : MlregressquantileModel) -> Double { @_common.min(self.data) }

pub fn MlregressquantileModel::max(self : MlregressquantileModel) -> Double { @_common.max(self.data) }

pub fn MlregressquantileModel::to_string(self : MlregressquantileModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_layer_make(size : Int) -> MlregressquantileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileLayer::len(self : MlregressquantileLayer) -> Int { self.size }

pub fn MlregressquantileLayer::get(self : MlregressquantileLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileLayer::set(self : MlregressquantileLayer, i : Int, v : Double) -> MlregressquantileLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileLayer::sum(self : MlregressquantileLayer) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileLayer::mean(self : MlregressquantileLayer) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileLayer::scale(self : MlregressquantileLayer, f : Double) -> MlregressquantileLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileLayer::add(self : MlregressquantileLayer, other : MlregressquantileLayer) -> MlregressquantileLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileLayer::copy(self : MlregressquantileLayer) -> MlregressquantileLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileLayer::fill(self : MlregressquantileLayer, v : Double) -> MlregressquantileLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileLayer::min(self : MlregressquantileLayer) -> Double { @_common.min(self.data) }

pub fn MlregressquantileLayer::max(self : MlregressquantileLayer) -> Double { @_common.max(self.data) }

pub fn MlregressquantileLayer::to_string(self : MlregressquantileLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_buffer_make(size : Int) -> MlregressquantileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileBuffer::len(self : MlregressquantileBuffer) -> Int { self.size }

pub fn MlregressquantileBuffer::get(self : MlregressquantileBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileBuffer::set(self : MlregressquantileBuffer, i : Int, v : Double) -> MlregressquantileBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileBuffer::sum(self : MlregressquantileBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileBuffer::mean(self : MlregressquantileBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileBuffer::scale(self : MlregressquantileBuffer, f : Double) -> MlregressquantileBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileBuffer::add(self : MlregressquantileBuffer, other : MlregressquantileBuffer) -> MlregressquantileBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileBuffer::copy(self : MlregressquantileBuffer) -> MlregressquantileBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileBuffer::fill(self : MlregressquantileBuffer, v : Double) -> MlregressquantileBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileBuffer::min(self : MlregressquantileBuffer) -> Double { @_common.min(self.data) }

pub fn MlregressquantileBuffer::max(self : MlregressquantileBuffer) -> Double { @_common.max(self.data) }

pub fn MlregressquantileBuffer::to_string(self : MlregressquantileBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_cursor_make(size : Int) -> MlregressquantileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileCursor::len(self : MlregressquantileCursor) -> Int { self.size }

pub fn MlregressquantileCursor::get(self : MlregressquantileCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileCursor::set(self : MlregressquantileCursor, i : Int, v : Double) -> MlregressquantileCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileCursor::sum(self : MlregressquantileCursor) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileCursor::mean(self : MlregressquantileCursor) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileCursor::scale(self : MlregressquantileCursor, f : Double) -> MlregressquantileCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileCursor::add(self : MlregressquantileCursor, other : MlregressquantileCursor) -> MlregressquantileCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileCursor::copy(self : MlregressquantileCursor) -> MlregressquantileCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileCursor::fill(self : MlregressquantileCursor, v : Double) -> MlregressquantileCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileCursor::min(self : MlregressquantileCursor) -> Double { @_common.min(self.data) }

pub fn MlregressquantileCursor::max(self : MlregressquantileCursor) -> Double { @_common.max(self.data) }

pub fn MlregressquantileCursor::to_string(self : MlregressquantileCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_view_make(size : Int) -> MlregressquantileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileView::len(self : MlregressquantileView) -> Int { self.size }

pub fn MlregressquantileView::get(self : MlregressquantileView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileView::set(self : MlregressquantileView, i : Int, v : Double) -> MlregressquantileView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileView::sum(self : MlregressquantileView) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileView::mean(self : MlregressquantileView) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileView::scale(self : MlregressquantileView, f : Double) -> MlregressquantileView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileView::add(self : MlregressquantileView, other : MlregressquantileView) -> MlregressquantileView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileView::copy(self : MlregressquantileView) -> MlregressquantileView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileView::fill(self : MlregressquantileView, v : Double) -> MlregressquantileView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileView::min(self : MlregressquantileView) -> Double { @_common.min(self.data) }

pub fn MlregressquantileView::max(self : MlregressquantileView) -> Double { @_common.max(self.data) }

pub fn MlregressquantileView::to_string(self : MlregressquantileView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_range_make(size : Int) -> MlregressquantileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileRange::len(self : MlregressquantileRange) -> Int { self.size }

pub fn MlregressquantileRange::get(self : MlregressquantileRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileRange::set(self : MlregressquantileRange, i : Int, v : Double) -> MlregressquantileRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileRange::sum(self : MlregressquantileRange) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileRange::mean(self : MlregressquantileRange) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileRange::scale(self : MlregressquantileRange, f : Double) -> MlregressquantileRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileRange::add(self : MlregressquantileRange, other : MlregressquantileRange) -> MlregressquantileRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileRange::copy(self : MlregressquantileRange) -> MlregressquantileRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileRange::fill(self : MlregressquantileRange, v : Double) -> MlregressquantileRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileRange::min(self : MlregressquantileRange) -> Double { @_common.min(self.data) }

pub fn MlregressquantileRange::max(self : MlregressquantileRange) -> Double { @_common.max(self.data) }

pub fn MlregressquantileRange::to_string(self : MlregressquantileRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressquantileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_slice_make(size : Int) -> MlregressquantileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressquantileSlice::len(self : MlregressquantileSlice) -> Int { self.size }

pub fn MlregressquantileSlice::get(self : MlregressquantileSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressquantileSlice::set(self : MlregressquantileSlice, i : Int, v : Double) -> MlregressquantileSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressquantileSlice::sum(self : MlregressquantileSlice) -> Double { @_common.sum(self.data) }

pub fn MlregressquantileSlice::mean(self : MlregressquantileSlice) -> Double { @_common.mean(self.data) }

pub fn MlregressquantileSlice::scale(self : MlregressquantileSlice, f : Double) -> MlregressquantileSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressquantileSlice::add(self : MlregressquantileSlice, other : MlregressquantileSlice) -> MlregressquantileSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressquantileSlice::copy(self : MlregressquantileSlice) -> MlregressquantileSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressquantileSlice::fill(self : MlregressquantileSlice, v : Double) -> MlregressquantileSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressquantileSlice::min(self : MlregressquantileSlice) -> Double { @_common.min(self.data) }

pub fn MlregressquantileSlice::max(self : MlregressquantileSlice) -> Double { @_common.max(self.data) }

pub fn MlregressquantileSlice::to_string(self : MlregressquantileSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

