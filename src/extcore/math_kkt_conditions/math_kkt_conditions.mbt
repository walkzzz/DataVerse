///===
/// extcore/math_kkt_conditions

pub(all) struct MathkktconditionsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_kkt_conditions_make_point(x : Double, y : Double) -> MathkktconditionsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_kkt_conditions_make_point3(x : Double, y : Double, z : Double) -> MathkktconditionsPoint {
  { x, y, z, label: 0 }
}

pub fn MathkktconditionsPoint::x(self : MathkktconditionsPoint) -> Double { self.x }

pub fn MathkktconditionsPoint::y(self : MathkktconditionsPoint) -> Double { self.y }

pub fn MathkktconditionsPoint::z(self : MathkktconditionsPoint) -> Double { self.z }

pub fn MathkktconditionsPoint::label(self : MathkktconditionsPoint) -> Int { self.label }

pub fn MathkktconditionsPoint::dist(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathkktconditionsPoint::add(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathkktconditionsPoint::sub(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathkktconditionsPoint::scale(self : MathkktconditionsPoint, s : Double) -> MathkktconditionsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathkktconditionsPoint::dot(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathkktconditionsPoint::cross(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathkktconditionsPoint::norm(self : MathkktconditionsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathkktconditionsPoint::normalize(self : MathkktconditionsPoint) -> MathkktconditionsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathkktconditionsPoint::negate(self : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathkktconditionsPoint::mid(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathkktconditionsPoint::lerp(self : MathkktconditionsPoint, other : MathkktconditionsPoint, t : Double) -> MathkktconditionsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathkktconditionsPoint::to_string(self : MathkktconditionsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathkktconditionsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_kkt_conditions_make_series(vals : Array[Double], name : String) -> MathkktconditionsSeries {
  { vals, name, meta: 0 }
}

pub fn MathkktconditionsSeries::len(self : MathkktconditionsSeries) -> Int { self.vals.length() }

pub fn MathkktconditionsSeries::sum(self : MathkktconditionsSeries) -> Double { @_common.sum(self.vals) }

pub fn MathkktconditionsSeries::mean(self : MathkktconditionsSeries) -> Double { @_common.mean(self.vals) }

pub fn MathkktconditionsSeries::min(self : MathkktconditionsSeries) -> Double { @_common.min(self.vals) }

pub fn MathkktconditionsSeries::max(self : MathkktconditionsSeries) -> Double { @_common.max(self.vals) }

pub fn MathkktconditionsSeries::range(self : MathkktconditionsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathkktconditionsSeries::variance(self : MathkktconditionsSeries) -> Double { @_common.variance(self.vals) }

pub fn MathkktconditionsSeries::std(self : MathkktconditionsSeries) -> Double { @_common.std(self.vals) }

pub fn MathkktconditionsSeries::median(self : MathkktconditionsSeries) -> Double { @_common.median(self.vals) }

pub fn MathkktconditionsSeries::scale(self : MathkktconditionsSeries, f : Double) -> MathkktconditionsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathkktconditionsSeries::add(self : MathkktconditionsSeries, other : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathkktconditionsSeries::sub(self : MathkktconditionsSeries, other : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathkktconditionsSeries::normalize(self : MathkktconditionsSeries) -> MathkktconditionsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathkktconditionsSeries::cumsum(self : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathkktconditionsSeries::to_string(self : MathkktconditionsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathkktconditionsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_kkt_conditions_make_matrix(rows : Int, cols : Int, val : Double) -> MathkktconditionsMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_kkt_conditions_matrix_identity(n : Int) -> MathkktconditionsMatrix {
  let m = math_kkt_conditions_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathkktconditionsMatrix::get(self : MathkktconditionsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathkktconditionsMatrix::transpose(self : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  let result = math_kkt_conditions_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathkktconditionsMatrix::add(self : MathkktconditionsMatrix, other : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_kkt_conditions_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathkktconditionsMatrix::scale(self : MathkktconditionsMatrix, s : Double) -> MathkktconditionsMatrix {
  let result = math_kkt_conditions_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathkktconditionsMatrix::multiply(self : MathkktconditionsMatrix, other : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  if self.cols != other.rows { return math_kkt_conditions_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_kkt_conditions_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathkktconditionsMatrix::trace(self : MathkktconditionsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathkktconditionsMatrix::det(self : MathkktconditionsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathkktconditionsMatrix::norm(self : MathkktconditionsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathkktconditionsMatrix::to_string(self : MathkktconditionsMatrix) -> String {
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

pub(all) struct MathkktconditionsVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_kkt_conditions_make_vector(comps : Array[Double]) -> MathkktconditionsVector {
  { comps, dim: comps.length() }
}

pub fn math_kkt_conditions_vector_zero(dim : Int) -> MathkktconditionsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathkktconditionsVector::add(self : MathkktconditionsVector, other : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathkktconditionsVector::sub(self : MathkktconditionsVector, other : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathkktconditionsVector::scale(self : MathkktconditionsVector, s : Double) -> MathkktconditionsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathkktconditionsVector::dot(self : MathkktconditionsVector, other : MathkktconditionsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathkktconditionsVector::norm(self : MathkktconditionsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathkktconditionsVector::normalize(self : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathkktconditionsVector::dist(self : MathkktconditionsVector, other : MathkktconditionsVector) -> Double {
  self.sub(other).norm()
}

pub fn MathkktconditionsVector::to_string(self : MathkktconditionsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathkktconditionsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_frame_make(size : Int) -> MathkktconditionsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsFrame::len(self : MathkktconditionsFrame) -> Int { self.size }

pub fn MathkktconditionsFrame::get(self : MathkktconditionsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsFrame::set(self : MathkktconditionsFrame, i : Int, v : Double) -> MathkktconditionsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsFrame::sum(self : MathkktconditionsFrame) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsFrame::mean(self : MathkktconditionsFrame) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsFrame::scale(self : MathkktconditionsFrame, f : Double) -> MathkktconditionsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsFrame::add(self : MathkktconditionsFrame, other : MathkktconditionsFrame) -> MathkktconditionsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsFrame::copy(self : MathkktconditionsFrame) -> MathkktconditionsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsFrame::fill(self : MathkktconditionsFrame, v : Double) -> MathkktconditionsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsFrame::min(self : MathkktconditionsFrame) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsFrame::max(self : MathkktconditionsFrame) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsFrame::to_string(self : MathkktconditionsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_table_make(size : Int) -> MathkktconditionsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsTable::len(self : MathkktconditionsTable) -> Int { self.size }

pub fn MathkktconditionsTable::get(self : MathkktconditionsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsTable::set(self : MathkktconditionsTable, i : Int, v : Double) -> MathkktconditionsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsTable::sum(self : MathkktconditionsTable) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsTable::mean(self : MathkktconditionsTable) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsTable::scale(self : MathkktconditionsTable, f : Double) -> MathkktconditionsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsTable::add(self : MathkktconditionsTable, other : MathkktconditionsTable) -> MathkktconditionsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsTable::copy(self : MathkktconditionsTable) -> MathkktconditionsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsTable::fill(self : MathkktconditionsTable, v : Double) -> MathkktconditionsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsTable::min(self : MathkktconditionsTable) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsTable::max(self : MathkktconditionsTable) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsTable::to_string(self : MathkktconditionsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_graphn_make(size : Int) -> MathkktconditionsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsGraphN::len(self : MathkktconditionsGraphN) -> Int { self.size }

pub fn MathkktconditionsGraphN::get(self : MathkktconditionsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsGraphN::set(self : MathkktconditionsGraphN, i : Int, v : Double) -> MathkktconditionsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsGraphN::sum(self : MathkktconditionsGraphN) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsGraphN::mean(self : MathkktconditionsGraphN) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsGraphN::scale(self : MathkktconditionsGraphN, f : Double) -> MathkktconditionsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsGraphN::add(self : MathkktconditionsGraphN, other : MathkktconditionsGraphN) -> MathkktconditionsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsGraphN::copy(self : MathkktconditionsGraphN) -> MathkktconditionsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsGraphN::fill(self : MathkktconditionsGraphN, v : Double) -> MathkktconditionsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsGraphN::min(self : MathkktconditionsGraphN) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsGraphN::max(self : MathkktconditionsGraphN) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsGraphN::to_string(self : MathkktconditionsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_node_make(size : Int) -> MathkktconditionsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsNode::len(self : MathkktconditionsNode) -> Int { self.size }

pub fn MathkktconditionsNode::get(self : MathkktconditionsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsNode::set(self : MathkktconditionsNode, i : Int, v : Double) -> MathkktconditionsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsNode::sum(self : MathkktconditionsNode) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsNode::mean(self : MathkktconditionsNode) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsNode::scale(self : MathkktconditionsNode, f : Double) -> MathkktconditionsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsNode::add(self : MathkktconditionsNode, other : MathkktconditionsNode) -> MathkktconditionsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsNode::copy(self : MathkktconditionsNode) -> MathkktconditionsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsNode::fill(self : MathkktconditionsNode, v : Double) -> MathkktconditionsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsNode::min(self : MathkktconditionsNode) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsNode::max(self : MathkktconditionsNode) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsNode::to_string(self : MathkktconditionsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_edge_make(size : Int) -> MathkktconditionsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsEdge::len(self : MathkktconditionsEdge) -> Int { self.size }

pub fn MathkktconditionsEdge::get(self : MathkktconditionsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsEdge::set(self : MathkktconditionsEdge, i : Int, v : Double) -> MathkktconditionsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsEdge::sum(self : MathkktconditionsEdge) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsEdge::mean(self : MathkktconditionsEdge) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsEdge::scale(self : MathkktconditionsEdge, f : Double) -> MathkktconditionsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsEdge::add(self : MathkktconditionsEdge, other : MathkktconditionsEdge) -> MathkktconditionsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsEdge::copy(self : MathkktconditionsEdge) -> MathkktconditionsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsEdge::fill(self : MathkktconditionsEdge, v : Double) -> MathkktconditionsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsEdge::min(self : MathkktconditionsEdge) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsEdge::max(self : MathkktconditionsEdge) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsEdge::to_string(self : MathkktconditionsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_path_make(size : Int) -> MathkktconditionsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsPath::len(self : MathkktconditionsPath) -> Int { self.size }

pub fn MathkktconditionsPath::get(self : MathkktconditionsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsPath::set(self : MathkktconditionsPath, i : Int, v : Double) -> MathkktconditionsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsPath::sum(self : MathkktconditionsPath) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsPath::mean(self : MathkktconditionsPath) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsPath::scale(self : MathkktconditionsPath, f : Double) -> MathkktconditionsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsPath::add(self : MathkktconditionsPath, other : MathkktconditionsPath) -> MathkktconditionsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsPath::copy(self : MathkktconditionsPath) -> MathkktconditionsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsPath::fill(self : MathkktconditionsPath, v : Double) -> MathkktconditionsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsPath::min(self : MathkktconditionsPath) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsPath::max(self : MathkktconditionsPath) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsPath::to_string(self : MathkktconditionsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_cluster_make(size : Int) -> MathkktconditionsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsCluster::len(self : MathkktconditionsCluster) -> Int { self.size }

pub fn MathkktconditionsCluster::get(self : MathkktconditionsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsCluster::set(self : MathkktconditionsCluster, i : Int, v : Double) -> MathkktconditionsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCluster::sum(self : MathkktconditionsCluster) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsCluster::mean(self : MathkktconditionsCluster) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsCluster::scale(self : MathkktconditionsCluster, f : Double) -> MathkktconditionsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCluster::add(self : MathkktconditionsCluster, other : MathkktconditionsCluster) -> MathkktconditionsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsCluster::copy(self : MathkktconditionsCluster) -> MathkktconditionsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCluster::fill(self : MathkktconditionsCluster, v : Double) -> MathkktconditionsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCluster::min(self : MathkktconditionsCluster) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsCluster::max(self : MathkktconditionsCluster) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsCluster::to_string(self : MathkktconditionsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_model_make(size : Int) -> MathkktconditionsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsModel::len(self : MathkktconditionsModel) -> Int { self.size }

pub fn MathkktconditionsModel::get(self : MathkktconditionsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsModel::set(self : MathkktconditionsModel, i : Int, v : Double) -> MathkktconditionsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsModel::sum(self : MathkktconditionsModel) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsModel::mean(self : MathkktconditionsModel) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsModel::scale(self : MathkktconditionsModel, f : Double) -> MathkktconditionsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsModel::add(self : MathkktconditionsModel, other : MathkktconditionsModel) -> MathkktconditionsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsModel::copy(self : MathkktconditionsModel) -> MathkktconditionsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsModel::fill(self : MathkktconditionsModel, v : Double) -> MathkktconditionsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsModel::min(self : MathkktconditionsModel) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsModel::max(self : MathkktconditionsModel) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsModel::to_string(self : MathkktconditionsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_layer_make(size : Int) -> MathkktconditionsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsLayer::len(self : MathkktconditionsLayer) -> Int { self.size }

pub fn MathkktconditionsLayer::get(self : MathkktconditionsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsLayer::set(self : MathkktconditionsLayer, i : Int, v : Double) -> MathkktconditionsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsLayer::sum(self : MathkktconditionsLayer) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsLayer::mean(self : MathkktconditionsLayer) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsLayer::scale(self : MathkktconditionsLayer, f : Double) -> MathkktconditionsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsLayer::add(self : MathkktconditionsLayer, other : MathkktconditionsLayer) -> MathkktconditionsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsLayer::copy(self : MathkktconditionsLayer) -> MathkktconditionsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsLayer::fill(self : MathkktconditionsLayer, v : Double) -> MathkktconditionsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsLayer::min(self : MathkktconditionsLayer) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsLayer::max(self : MathkktconditionsLayer) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsLayer::to_string(self : MathkktconditionsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_buffer_make(size : Int) -> MathkktconditionsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsBuffer::len(self : MathkktconditionsBuffer) -> Int { self.size }

pub fn MathkktconditionsBuffer::get(self : MathkktconditionsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsBuffer::set(self : MathkktconditionsBuffer, i : Int, v : Double) -> MathkktconditionsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsBuffer::sum(self : MathkktconditionsBuffer) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsBuffer::mean(self : MathkktconditionsBuffer) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsBuffer::scale(self : MathkktconditionsBuffer, f : Double) -> MathkktconditionsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsBuffer::add(self : MathkktconditionsBuffer, other : MathkktconditionsBuffer) -> MathkktconditionsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsBuffer::copy(self : MathkktconditionsBuffer) -> MathkktconditionsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsBuffer::fill(self : MathkktconditionsBuffer, v : Double) -> MathkktconditionsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsBuffer::min(self : MathkktconditionsBuffer) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsBuffer::max(self : MathkktconditionsBuffer) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsBuffer::to_string(self : MathkktconditionsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_cursor_make(size : Int) -> MathkktconditionsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsCursor::len(self : MathkktconditionsCursor) -> Int { self.size }

pub fn MathkktconditionsCursor::get(self : MathkktconditionsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsCursor::set(self : MathkktconditionsCursor, i : Int, v : Double) -> MathkktconditionsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCursor::sum(self : MathkktconditionsCursor) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsCursor::mean(self : MathkktconditionsCursor) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsCursor::scale(self : MathkktconditionsCursor, f : Double) -> MathkktconditionsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCursor::add(self : MathkktconditionsCursor, other : MathkktconditionsCursor) -> MathkktconditionsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsCursor::copy(self : MathkktconditionsCursor) -> MathkktconditionsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCursor::fill(self : MathkktconditionsCursor, v : Double) -> MathkktconditionsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsCursor::min(self : MathkktconditionsCursor) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsCursor::max(self : MathkktconditionsCursor) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsCursor::to_string(self : MathkktconditionsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_view_make(size : Int) -> MathkktconditionsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsView::len(self : MathkktconditionsView) -> Int { self.size }

pub fn MathkktconditionsView::get(self : MathkktconditionsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsView::set(self : MathkktconditionsView, i : Int, v : Double) -> MathkktconditionsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsView::sum(self : MathkktconditionsView) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsView::mean(self : MathkktconditionsView) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsView::scale(self : MathkktconditionsView, f : Double) -> MathkktconditionsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsView::add(self : MathkktconditionsView, other : MathkktconditionsView) -> MathkktconditionsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsView::copy(self : MathkktconditionsView) -> MathkktconditionsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsView::fill(self : MathkktconditionsView, v : Double) -> MathkktconditionsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsView::min(self : MathkktconditionsView) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsView::max(self : MathkktconditionsView) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsView::to_string(self : MathkktconditionsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_range_make(size : Int) -> MathkktconditionsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsRange::len(self : MathkktconditionsRange) -> Int { self.size }

pub fn MathkktconditionsRange::get(self : MathkktconditionsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsRange::set(self : MathkktconditionsRange, i : Int, v : Double) -> MathkktconditionsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsRange::sum(self : MathkktconditionsRange) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsRange::mean(self : MathkktconditionsRange) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsRange::scale(self : MathkktconditionsRange, f : Double) -> MathkktconditionsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsRange::add(self : MathkktconditionsRange, other : MathkktconditionsRange) -> MathkktconditionsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsRange::copy(self : MathkktconditionsRange) -> MathkktconditionsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsRange::fill(self : MathkktconditionsRange, v : Double) -> MathkktconditionsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsRange::min(self : MathkktconditionsRange) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsRange::max(self : MathkktconditionsRange) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsRange::to_string(self : MathkktconditionsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_slice_make(size : Int) -> MathkktconditionsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathkktconditionsSlice::len(self : MathkktconditionsSlice) -> Int { self.size }

pub fn MathkktconditionsSlice::get(self : MathkktconditionsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathkktconditionsSlice::set(self : MathkktconditionsSlice, i : Int, v : Double) -> MathkktconditionsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathkktconditionsSlice::sum(self : MathkktconditionsSlice) -> Double { @_common.sum(self.data) }

pub fn MathkktconditionsSlice::mean(self : MathkktconditionsSlice) -> Double { @_common.mean(self.data) }

pub fn MathkktconditionsSlice::scale(self : MathkktconditionsSlice, f : Double) -> MathkktconditionsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsSlice::add(self : MathkktconditionsSlice, other : MathkktconditionsSlice) -> MathkktconditionsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathkktconditionsSlice::copy(self : MathkktconditionsSlice) -> MathkktconditionsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsSlice::fill(self : MathkktconditionsSlice, v : Double) -> MathkktconditionsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathkktconditionsSlice::min(self : MathkktconditionsSlice) -> Double { @_common.min(self.data) }

pub fn MathkktconditionsSlice::max(self : MathkktconditionsSlice) -> Double { @_common.max(self.data) }

pub fn MathkktconditionsSlice::to_string(self : MathkktconditionsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

