///===
/// extcore/ml_regress_isotonic

pub(all) struct MlregressisotonicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_isotonic_make_point(x : Double, y : Double) -> MlregressisotonicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_isotonic_make_point3(x : Double, y : Double, z : Double) -> MlregressisotonicPoint {
  { x, y, z, label: 0 }
}

pub fn MlregressisotonicPoint::x(self : MlregressisotonicPoint) -> Double { self.x }

pub fn MlregressisotonicPoint::y(self : MlregressisotonicPoint) -> Double { self.y }

pub fn MlregressisotonicPoint::z(self : MlregressisotonicPoint) -> Double { self.z }

pub fn MlregressisotonicPoint::label(self : MlregressisotonicPoint) -> Int { self.label }

pub fn MlregressisotonicPoint::dist(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregressisotonicPoint::add(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregressisotonicPoint::sub(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregressisotonicPoint::scale(self : MlregressisotonicPoint, s : Double) -> MlregressisotonicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregressisotonicPoint::dot(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregressisotonicPoint::cross(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregressisotonicPoint::norm(self : MlregressisotonicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregressisotonicPoint::normalize(self : MlregressisotonicPoint) -> MlregressisotonicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressisotonicPoint::negate(self : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregressisotonicPoint::mid(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregressisotonicPoint::lerp(self : MlregressisotonicPoint, other : MlregressisotonicPoint, t : Double) -> MlregressisotonicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregressisotonicPoint::to_string(self : MlregressisotonicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregressisotonicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_isotonic_make_series(vals : Array[Double], name : String) -> MlregressisotonicSeries {
  { vals, name, meta: 0 }
}

pub fn MlregressisotonicSeries::len(self : MlregressisotonicSeries) -> Int { self.vals.length() }

pub fn MlregressisotonicSeries::sum(self : MlregressisotonicSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregressisotonicSeries::mean(self : MlregressisotonicSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregressisotonicSeries::min(self : MlregressisotonicSeries) -> Double { @_common.min(self.vals) }

pub fn MlregressisotonicSeries::max(self : MlregressisotonicSeries) -> Double { @_common.max(self.vals) }

pub fn MlregressisotonicSeries::range(self : MlregressisotonicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregressisotonicSeries::variance(self : MlregressisotonicSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregressisotonicSeries::std(self : MlregressisotonicSeries) -> Double { @_common.std(self.vals) }

pub fn MlregressisotonicSeries::median(self : MlregressisotonicSeries) -> Double { @_common.median(self.vals) }

pub fn MlregressisotonicSeries::scale(self : MlregressisotonicSeries, f : Double) -> MlregressisotonicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregressisotonicSeries::add(self : MlregressisotonicSeries, other : MlregressisotonicSeries) -> MlregressisotonicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregressisotonicSeries::sub(self : MlregressisotonicSeries, other : MlregressisotonicSeries) -> MlregressisotonicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregressisotonicSeries::normalize(self : MlregressisotonicSeries) -> MlregressisotonicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregressisotonicSeries::cumsum(self : MlregressisotonicSeries) -> MlregressisotonicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregressisotonicSeries::to_string(self : MlregressisotonicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressisotonicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_isotonic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressisotonicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_isotonic_matrix_identity(n : Int) -> MlregressisotonicMatrix {
  let m = ml_regress_isotonic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregressisotonicMatrix::get(self : MlregressisotonicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregressisotonicMatrix::transpose(self : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  let result = ml_regress_isotonic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregressisotonicMatrix::add(self : MlregressisotonicMatrix, other : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_isotonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregressisotonicMatrix::scale(self : MlregressisotonicMatrix, s : Double) -> MlregressisotonicMatrix {
  let result = ml_regress_isotonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregressisotonicMatrix::multiply(self : MlregressisotonicMatrix, other : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  if self.cols != other.rows { return ml_regress_isotonic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_isotonic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregressisotonicMatrix::trace(self : MlregressisotonicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregressisotonicMatrix::det(self : MlregressisotonicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregressisotonicMatrix::norm(self : MlregressisotonicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregressisotonicMatrix::to_string(self : MlregressisotonicMatrix) -> String {
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

pub(all) struct MlregressisotonicVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_isotonic_make_vector(comps : Array[Double]) -> MlregressisotonicVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_isotonic_vector_zero(dim : Int) -> MlregressisotonicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregressisotonicVector::add(self : MlregressisotonicVector, other : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressisotonicVector::sub(self : MlregressisotonicVector, other : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressisotonicVector::scale(self : MlregressisotonicVector, s : Double) -> MlregressisotonicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregressisotonicVector::dot(self : MlregressisotonicVector, other : MlregressisotonicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregressisotonicVector::norm(self : MlregressisotonicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregressisotonicVector::normalize(self : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressisotonicVector::dist(self : MlregressisotonicVector, other : MlregressisotonicVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregressisotonicVector::to_string(self : MlregressisotonicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressisotonicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_frame_make(size : Int) -> MlregressisotonicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicFrame::len(self : MlregressisotonicFrame) -> Int { self.size }

pub fn MlregressisotonicFrame::get(self : MlregressisotonicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicFrame::set(self : MlregressisotonicFrame, i : Int, v : Double) -> MlregressisotonicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicFrame::sum(self : MlregressisotonicFrame) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicFrame::mean(self : MlregressisotonicFrame) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicFrame::scale(self : MlregressisotonicFrame, f : Double) -> MlregressisotonicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicFrame::add(self : MlregressisotonicFrame, other : MlregressisotonicFrame) -> MlregressisotonicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicFrame::copy(self : MlregressisotonicFrame) -> MlregressisotonicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicFrame::fill(self : MlregressisotonicFrame, v : Double) -> MlregressisotonicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicFrame::min(self : MlregressisotonicFrame) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicFrame::max(self : MlregressisotonicFrame) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicFrame::to_string(self : MlregressisotonicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_table_make(size : Int) -> MlregressisotonicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicTable::len(self : MlregressisotonicTable) -> Int { self.size }

pub fn MlregressisotonicTable::get(self : MlregressisotonicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicTable::set(self : MlregressisotonicTable, i : Int, v : Double) -> MlregressisotonicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicTable::sum(self : MlregressisotonicTable) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicTable::mean(self : MlregressisotonicTable) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicTable::scale(self : MlregressisotonicTable, f : Double) -> MlregressisotonicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicTable::add(self : MlregressisotonicTable, other : MlregressisotonicTable) -> MlregressisotonicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicTable::copy(self : MlregressisotonicTable) -> MlregressisotonicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicTable::fill(self : MlregressisotonicTable, v : Double) -> MlregressisotonicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicTable::min(self : MlregressisotonicTable) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicTable::max(self : MlregressisotonicTable) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicTable::to_string(self : MlregressisotonicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_graphn_make(size : Int) -> MlregressisotonicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicGraphN::len(self : MlregressisotonicGraphN) -> Int { self.size }

pub fn MlregressisotonicGraphN::get(self : MlregressisotonicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicGraphN::set(self : MlregressisotonicGraphN, i : Int, v : Double) -> MlregressisotonicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicGraphN::sum(self : MlregressisotonicGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicGraphN::mean(self : MlregressisotonicGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicGraphN::scale(self : MlregressisotonicGraphN, f : Double) -> MlregressisotonicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicGraphN::add(self : MlregressisotonicGraphN, other : MlregressisotonicGraphN) -> MlregressisotonicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicGraphN::copy(self : MlregressisotonicGraphN) -> MlregressisotonicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicGraphN::fill(self : MlregressisotonicGraphN, v : Double) -> MlregressisotonicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicGraphN::min(self : MlregressisotonicGraphN) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicGraphN::max(self : MlregressisotonicGraphN) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicGraphN::to_string(self : MlregressisotonicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_node_make(size : Int) -> MlregressisotonicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicNode::len(self : MlregressisotonicNode) -> Int { self.size }

pub fn MlregressisotonicNode::get(self : MlregressisotonicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicNode::set(self : MlregressisotonicNode, i : Int, v : Double) -> MlregressisotonicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicNode::sum(self : MlregressisotonicNode) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicNode::mean(self : MlregressisotonicNode) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicNode::scale(self : MlregressisotonicNode, f : Double) -> MlregressisotonicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicNode::add(self : MlregressisotonicNode, other : MlregressisotonicNode) -> MlregressisotonicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicNode::copy(self : MlregressisotonicNode) -> MlregressisotonicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicNode::fill(self : MlregressisotonicNode, v : Double) -> MlregressisotonicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicNode::min(self : MlregressisotonicNode) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicNode::max(self : MlregressisotonicNode) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicNode::to_string(self : MlregressisotonicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_edge_make(size : Int) -> MlregressisotonicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicEdge::len(self : MlregressisotonicEdge) -> Int { self.size }

pub fn MlregressisotonicEdge::get(self : MlregressisotonicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicEdge::set(self : MlregressisotonicEdge, i : Int, v : Double) -> MlregressisotonicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicEdge::sum(self : MlregressisotonicEdge) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicEdge::mean(self : MlregressisotonicEdge) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicEdge::scale(self : MlregressisotonicEdge, f : Double) -> MlregressisotonicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicEdge::add(self : MlregressisotonicEdge, other : MlregressisotonicEdge) -> MlregressisotonicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicEdge::copy(self : MlregressisotonicEdge) -> MlregressisotonicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicEdge::fill(self : MlregressisotonicEdge, v : Double) -> MlregressisotonicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicEdge::min(self : MlregressisotonicEdge) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicEdge::max(self : MlregressisotonicEdge) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicEdge::to_string(self : MlregressisotonicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_path_make(size : Int) -> MlregressisotonicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicPath::len(self : MlregressisotonicPath) -> Int { self.size }

pub fn MlregressisotonicPath::get(self : MlregressisotonicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicPath::set(self : MlregressisotonicPath, i : Int, v : Double) -> MlregressisotonicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicPath::sum(self : MlregressisotonicPath) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicPath::mean(self : MlregressisotonicPath) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicPath::scale(self : MlregressisotonicPath, f : Double) -> MlregressisotonicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicPath::add(self : MlregressisotonicPath, other : MlregressisotonicPath) -> MlregressisotonicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicPath::copy(self : MlregressisotonicPath) -> MlregressisotonicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicPath::fill(self : MlregressisotonicPath, v : Double) -> MlregressisotonicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicPath::min(self : MlregressisotonicPath) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicPath::max(self : MlregressisotonicPath) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicPath::to_string(self : MlregressisotonicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_cluster_make(size : Int) -> MlregressisotonicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicCluster::len(self : MlregressisotonicCluster) -> Int { self.size }

pub fn MlregressisotonicCluster::get(self : MlregressisotonicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicCluster::set(self : MlregressisotonicCluster, i : Int, v : Double) -> MlregressisotonicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCluster::sum(self : MlregressisotonicCluster) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicCluster::mean(self : MlregressisotonicCluster) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicCluster::scale(self : MlregressisotonicCluster, f : Double) -> MlregressisotonicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCluster::add(self : MlregressisotonicCluster, other : MlregressisotonicCluster) -> MlregressisotonicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicCluster::copy(self : MlregressisotonicCluster) -> MlregressisotonicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCluster::fill(self : MlregressisotonicCluster, v : Double) -> MlregressisotonicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCluster::min(self : MlregressisotonicCluster) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicCluster::max(self : MlregressisotonicCluster) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicCluster::to_string(self : MlregressisotonicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_model_make(size : Int) -> MlregressisotonicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicModel::len(self : MlregressisotonicModel) -> Int { self.size }

pub fn MlregressisotonicModel::get(self : MlregressisotonicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicModel::set(self : MlregressisotonicModel, i : Int, v : Double) -> MlregressisotonicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicModel::sum(self : MlregressisotonicModel) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicModel::mean(self : MlregressisotonicModel) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicModel::scale(self : MlregressisotonicModel, f : Double) -> MlregressisotonicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicModel::add(self : MlregressisotonicModel, other : MlregressisotonicModel) -> MlregressisotonicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicModel::copy(self : MlregressisotonicModel) -> MlregressisotonicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicModel::fill(self : MlregressisotonicModel, v : Double) -> MlregressisotonicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicModel::min(self : MlregressisotonicModel) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicModel::max(self : MlregressisotonicModel) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicModel::to_string(self : MlregressisotonicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_layer_make(size : Int) -> MlregressisotonicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicLayer::len(self : MlregressisotonicLayer) -> Int { self.size }

pub fn MlregressisotonicLayer::get(self : MlregressisotonicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicLayer::set(self : MlregressisotonicLayer, i : Int, v : Double) -> MlregressisotonicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicLayer::sum(self : MlregressisotonicLayer) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicLayer::mean(self : MlregressisotonicLayer) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicLayer::scale(self : MlregressisotonicLayer, f : Double) -> MlregressisotonicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicLayer::add(self : MlregressisotonicLayer, other : MlregressisotonicLayer) -> MlregressisotonicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicLayer::copy(self : MlregressisotonicLayer) -> MlregressisotonicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicLayer::fill(self : MlregressisotonicLayer, v : Double) -> MlregressisotonicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicLayer::min(self : MlregressisotonicLayer) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicLayer::max(self : MlregressisotonicLayer) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicLayer::to_string(self : MlregressisotonicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_buffer_make(size : Int) -> MlregressisotonicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicBuffer::len(self : MlregressisotonicBuffer) -> Int { self.size }

pub fn MlregressisotonicBuffer::get(self : MlregressisotonicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicBuffer::set(self : MlregressisotonicBuffer, i : Int, v : Double) -> MlregressisotonicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicBuffer::sum(self : MlregressisotonicBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicBuffer::mean(self : MlregressisotonicBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicBuffer::scale(self : MlregressisotonicBuffer, f : Double) -> MlregressisotonicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicBuffer::add(self : MlregressisotonicBuffer, other : MlregressisotonicBuffer) -> MlregressisotonicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicBuffer::copy(self : MlregressisotonicBuffer) -> MlregressisotonicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicBuffer::fill(self : MlregressisotonicBuffer, v : Double) -> MlregressisotonicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicBuffer::min(self : MlregressisotonicBuffer) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicBuffer::max(self : MlregressisotonicBuffer) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicBuffer::to_string(self : MlregressisotonicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_cursor_make(size : Int) -> MlregressisotonicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicCursor::len(self : MlregressisotonicCursor) -> Int { self.size }

pub fn MlregressisotonicCursor::get(self : MlregressisotonicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicCursor::set(self : MlregressisotonicCursor, i : Int, v : Double) -> MlregressisotonicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCursor::sum(self : MlregressisotonicCursor) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicCursor::mean(self : MlregressisotonicCursor) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicCursor::scale(self : MlregressisotonicCursor, f : Double) -> MlregressisotonicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCursor::add(self : MlregressisotonicCursor, other : MlregressisotonicCursor) -> MlregressisotonicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicCursor::copy(self : MlregressisotonicCursor) -> MlregressisotonicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCursor::fill(self : MlregressisotonicCursor, v : Double) -> MlregressisotonicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicCursor::min(self : MlregressisotonicCursor) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicCursor::max(self : MlregressisotonicCursor) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicCursor::to_string(self : MlregressisotonicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_view_make(size : Int) -> MlregressisotonicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicView::len(self : MlregressisotonicView) -> Int { self.size }

pub fn MlregressisotonicView::get(self : MlregressisotonicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicView::set(self : MlregressisotonicView, i : Int, v : Double) -> MlregressisotonicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicView::sum(self : MlregressisotonicView) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicView::mean(self : MlregressisotonicView) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicView::scale(self : MlregressisotonicView, f : Double) -> MlregressisotonicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicView::add(self : MlregressisotonicView, other : MlregressisotonicView) -> MlregressisotonicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicView::copy(self : MlregressisotonicView) -> MlregressisotonicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicView::fill(self : MlregressisotonicView, v : Double) -> MlregressisotonicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicView::min(self : MlregressisotonicView) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicView::max(self : MlregressisotonicView) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicView::to_string(self : MlregressisotonicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_range_make(size : Int) -> MlregressisotonicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicRange::len(self : MlregressisotonicRange) -> Int { self.size }

pub fn MlregressisotonicRange::get(self : MlregressisotonicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicRange::set(self : MlregressisotonicRange, i : Int, v : Double) -> MlregressisotonicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicRange::sum(self : MlregressisotonicRange) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicRange::mean(self : MlregressisotonicRange) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicRange::scale(self : MlregressisotonicRange, f : Double) -> MlregressisotonicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicRange::add(self : MlregressisotonicRange, other : MlregressisotonicRange) -> MlregressisotonicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicRange::copy(self : MlregressisotonicRange) -> MlregressisotonicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicRange::fill(self : MlregressisotonicRange, v : Double) -> MlregressisotonicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicRange::min(self : MlregressisotonicRange) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicRange::max(self : MlregressisotonicRange) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicRange::to_string(self : MlregressisotonicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_slice_make(size : Int) -> MlregressisotonicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressisotonicSlice::len(self : MlregressisotonicSlice) -> Int { self.size }

pub fn MlregressisotonicSlice::get(self : MlregressisotonicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressisotonicSlice::set(self : MlregressisotonicSlice, i : Int, v : Double) -> MlregressisotonicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressisotonicSlice::sum(self : MlregressisotonicSlice) -> Double { @_common.sum(self.data) }

pub fn MlregressisotonicSlice::mean(self : MlregressisotonicSlice) -> Double { @_common.mean(self.data) }

pub fn MlregressisotonicSlice::scale(self : MlregressisotonicSlice, f : Double) -> MlregressisotonicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicSlice::add(self : MlregressisotonicSlice, other : MlregressisotonicSlice) -> MlregressisotonicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressisotonicSlice::copy(self : MlregressisotonicSlice) -> MlregressisotonicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicSlice::fill(self : MlregressisotonicSlice, v : Double) -> MlregressisotonicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressisotonicSlice::min(self : MlregressisotonicSlice) -> Double { @_common.min(self.data) }

pub fn MlregressisotonicSlice::max(self : MlregressisotonicSlice) -> Double { @_common.max(self.data) }

pub fn MlregressisotonicSlice::to_string(self : MlregressisotonicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

