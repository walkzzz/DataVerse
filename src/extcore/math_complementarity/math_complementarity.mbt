///===
/// extcore/math_complementarity

pub(all) struct MathcomplementarityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_complementarity_make_point(x : Double, y : Double) -> MathcomplementarityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_complementarity_make_point3(x : Double, y : Double, z : Double) -> MathcomplementarityPoint {
  { x, y, z, label: 0 }
}

pub fn MathcomplementarityPoint::x(self : MathcomplementarityPoint) -> Double { self.x }

pub fn MathcomplementarityPoint::y(self : MathcomplementarityPoint) -> Double { self.y }

pub fn MathcomplementarityPoint::z(self : MathcomplementarityPoint) -> Double { self.z }

pub fn MathcomplementarityPoint::label(self : MathcomplementarityPoint) -> Int { self.label }

pub fn MathcomplementarityPoint::dist(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathcomplementarityPoint::add(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathcomplementarityPoint::sub(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathcomplementarityPoint::scale(self : MathcomplementarityPoint, s : Double) -> MathcomplementarityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathcomplementarityPoint::dot(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathcomplementarityPoint::cross(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathcomplementarityPoint::norm(self : MathcomplementarityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathcomplementarityPoint::normalize(self : MathcomplementarityPoint) -> MathcomplementarityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcomplementarityPoint::negate(self : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathcomplementarityPoint::mid(self : MathcomplementarityPoint, other : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathcomplementarityPoint::lerp(self : MathcomplementarityPoint, other : MathcomplementarityPoint, t : Double) -> MathcomplementarityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathcomplementarityPoint::to_string(self : MathcomplementarityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathcomplementaritySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_complementarity_make_series(vals : Array[Double], name : String) -> MathcomplementaritySeries {
  { vals, name, meta: 0 }
}

pub fn MathcomplementaritySeries::len(self : MathcomplementaritySeries) -> Int { self.vals.length() }

pub fn MathcomplementaritySeries::sum(self : MathcomplementaritySeries) -> Double { @_common.sum(self.vals) }

pub fn MathcomplementaritySeries::mean(self : MathcomplementaritySeries) -> Double { @_common.mean(self.vals) }

pub fn MathcomplementaritySeries::min(self : MathcomplementaritySeries) -> Double { @_common.min(self.vals) }

pub fn MathcomplementaritySeries::max(self : MathcomplementaritySeries) -> Double { @_common.max(self.vals) }

pub fn MathcomplementaritySeries::range(self : MathcomplementaritySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathcomplementaritySeries::variance(self : MathcomplementaritySeries) -> Double { @_common.variance(self.vals) }

pub fn MathcomplementaritySeries::std(self : MathcomplementaritySeries) -> Double { @_common.std(self.vals) }

pub fn MathcomplementaritySeries::median(self : MathcomplementaritySeries) -> Double { @_common.median(self.vals) }

pub fn MathcomplementaritySeries::scale(self : MathcomplementaritySeries, f : Double) -> MathcomplementaritySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathcomplementaritySeries::add(self : MathcomplementaritySeries, other : MathcomplementaritySeries) -> MathcomplementaritySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathcomplementaritySeries::sub(self : MathcomplementaritySeries, other : MathcomplementaritySeries) -> MathcomplementaritySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathcomplementaritySeries::normalize(self : MathcomplementaritySeries) -> MathcomplementaritySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathcomplementaritySeries::cumsum(self : MathcomplementaritySeries) -> MathcomplementaritySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathcomplementaritySeries::to_string(self : MathcomplementaritySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcomplementarityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_complementarity_make_matrix(rows : Int, cols : Int, val : Double) -> MathcomplementarityMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_complementarity_matrix_identity(n : Int) -> MathcomplementarityMatrix {
  let m = math_complementarity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathcomplementarityMatrix::get(self : MathcomplementarityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathcomplementarityMatrix::transpose(self : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  let result = math_complementarity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathcomplementarityMatrix::add(self : MathcomplementarityMatrix, other : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_complementarity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathcomplementarityMatrix::scale(self : MathcomplementarityMatrix, s : Double) -> MathcomplementarityMatrix {
  let result = math_complementarity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathcomplementarityMatrix::multiply(self : MathcomplementarityMatrix, other : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  if self.cols != other.rows { return math_complementarity_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_complementarity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathcomplementarityMatrix::trace(self : MathcomplementarityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathcomplementarityMatrix::det(self : MathcomplementarityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathcomplementarityMatrix::norm(self : MathcomplementarityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathcomplementarityMatrix::to_string(self : MathcomplementarityMatrix) -> String {
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

pub(all) struct MathcomplementarityVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_complementarity_make_vector(comps : Array[Double]) -> MathcomplementarityVector {
  { comps, dim: comps.length() }
}

pub fn math_complementarity_vector_zero(dim : Int) -> MathcomplementarityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathcomplementarityVector::add(self : MathcomplementarityVector, other : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathcomplementarityVector::sub(self : MathcomplementarityVector, other : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathcomplementarityVector::scale(self : MathcomplementarityVector, s : Double) -> MathcomplementarityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathcomplementarityVector::dot(self : MathcomplementarityVector, other : MathcomplementarityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathcomplementarityVector::norm(self : MathcomplementarityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathcomplementarityVector::normalize(self : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcomplementarityVector::dist(self : MathcomplementarityVector, other : MathcomplementarityVector) -> Double {
  self.sub(other).norm()
}

pub fn MathcomplementarityVector::to_string(self : MathcomplementarityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcomplementarityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_frame_make(size : Int) -> MathcomplementarityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityFrame::len(self : MathcomplementarityFrame) -> Int { self.size }

pub fn MathcomplementarityFrame::get(self : MathcomplementarityFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityFrame::set(self : MathcomplementarityFrame, i : Int, v : Double) -> MathcomplementarityFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityFrame::sum(self : MathcomplementarityFrame) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityFrame::mean(self : MathcomplementarityFrame) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityFrame::scale(self : MathcomplementarityFrame, f : Double) -> MathcomplementarityFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityFrame::add(self : MathcomplementarityFrame, other : MathcomplementarityFrame) -> MathcomplementarityFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityFrame::copy(self : MathcomplementarityFrame) -> MathcomplementarityFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityFrame::fill(self : MathcomplementarityFrame, v : Double) -> MathcomplementarityFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityFrame::min(self : MathcomplementarityFrame) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityFrame::max(self : MathcomplementarityFrame) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityFrame::to_string(self : MathcomplementarityFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_table_make(size : Int) -> MathcomplementarityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityTable::len(self : MathcomplementarityTable) -> Int { self.size }

pub fn MathcomplementarityTable::get(self : MathcomplementarityTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityTable::set(self : MathcomplementarityTable, i : Int, v : Double) -> MathcomplementarityTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityTable::sum(self : MathcomplementarityTable) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityTable::mean(self : MathcomplementarityTable) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityTable::scale(self : MathcomplementarityTable, f : Double) -> MathcomplementarityTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityTable::add(self : MathcomplementarityTable, other : MathcomplementarityTable) -> MathcomplementarityTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityTable::copy(self : MathcomplementarityTable) -> MathcomplementarityTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityTable::fill(self : MathcomplementarityTable, v : Double) -> MathcomplementarityTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityTable::min(self : MathcomplementarityTable) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityTable::max(self : MathcomplementarityTable) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityTable::to_string(self : MathcomplementarityTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_graphn_make(size : Int) -> MathcomplementarityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityGraphN::len(self : MathcomplementarityGraphN) -> Int { self.size }

pub fn MathcomplementarityGraphN::get(self : MathcomplementarityGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityGraphN::set(self : MathcomplementarityGraphN, i : Int, v : Double) -> MathcomplementarityGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityGraphN::sum(self : MathcomplementarityGraphN) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityGraphN::mean(self : MathcomplementarityGraphN) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityGraphN::scale(self : MathcomplementarityGraphN, f : Double) -> MathcomplementarityGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityGraphN::add(self : MathcomplementarityGraphN, other : MathcomplementarityGraphN) -> MathcomplementarityGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityGraphN::copy(self : MathcomplementarityGraphN) -> MathcomplementarityGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityGraphN::fill(self : MathcomplementarityGraphN, v : Double) -> MathcomplementarityGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityGraphN::min(self : MathcomplementarityGraphN) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityGraphN::max(self : MathcomplementarityGraphN) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityGraphN::to_string(self : MathcomplementarityGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_node_make(size : Int) -> MathcomplementarityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityNode::len(self : MathcomplementarityNode) -> Int { self.size }

pub fn MathcomplementarityNode::get(self : MathcomplementarityNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityNode::set(self : MathcomplementarityNode, i : Int, v : Double) -> MathcomplementarityNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityNode::sum(self : MathcomplementarityNode) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityNode::mean(self : MathcomplementarityNode) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityNode::scale(self : MathcomplementarityNode, f : Double) -> MathcomplementarityNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityNode::add(self : MathcomplementarityNode, other : MathcomplementarityNode) -> MathcomplementarityNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityNode::copy(self : MathcomplementarityNode) -> MathcomplementarityNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityNode::fill(self : MathcomplementarityNode, v : Double) -> MathcomplementarityNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityNode::min(self : MathcomplementarityNode) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityNode::max(self : MathcomplementarityNode) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityNode::to_string(self : MathcomplementarityNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_edge_make(size : Int) -> MathcomplementarityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityEdge::len(self : MathcomplementarityEdge) -> Int { self.size }

pub fn MathcomplementarityEdge::get(self : MathcomplementarityEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityEdge::set(self : MathcomplementarityEdge, i : Int, v : Double) -> MathcomplementarityEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityEdge::sum(self : MathcomplementarityEdge) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityEdge::mean(self : MathcomplementarityEdge) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityEdge::scale(self : MathcomplementarityEdge, f : Double) -> MathcomplementarityEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityEdge::add(self : MathcomplementarityEdge, other : MathcomplementarityEdge) -> MathcomplementarityEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityEdge::copy(self : MathcomplementarityEdge) -> MathcomplementarityEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityEdge::fill(self : MathcomplementarityEdge, v : Double) -> MathcomplementarityEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityEdge::min(self : MathcomplementarityEdge) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityEdge::max(self : MathcomplementarityEdge) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityEdge::to_string(self : MathcomplementarityEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_path_make(size : Int) -> MathcomplementarityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityPath::len(self : MathcomplementarityPath) -> Int { self.size }

pub fn MathcomplementarityPath::get(self : MathcomplementarityPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityPath::set(self : MathcomplementarityPath, i : Int, v : Double) -> MathcomplementarityPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityPath::sum(self : MathcomplementarityPath) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityPath::mean(self : MathcomplementarityPath) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityPath::scale(self : MathcomplementarityPath, f : Double) -> MathcomplementarityPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityPath::add(self : MathcomplementarityPath, other : MathcomplementarityPath) -> MathcomplementarityPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityPath::copy(self : MathcomplementarityPath) -> MathcomplementarityPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityPath::fill(self : MathcomplementarityPath, v : Double) -> MathcomplementarityPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityPath::min(self : MathcomplementarityPath) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityPath::max(self : MathcomplementarityPath) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityPath::to_string(self : MathcomplementarityPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_cluster_make(size : Int) -> MathcomplementarityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityCluster::len(self : MathcomplementarityCluster) -> Int { self.size }

pub fn MathcomplementarityCluster::get(self : MathcomplementarityCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityCluster::set(self : MathcomplementarityCluster, i : Int, v : Double) -> MathcomplementarityCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCluster::sum(self : MathcomplementarityCluster) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityCluster::mean(self : MathcomplementarityCluster) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityCluster::scale(self : MathcomplementarityCluster, f : Double) -> MathcomplementarityCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCluster::add(self : MathcomplementarityCluster, other : MathcomplementarityCluster) -> MathcomplementarityCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityCluster::copy(self : MathcomplementarityCluster) -> MathcomplementarityCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCluster::fill(self : MathcomplementarityCluster, v : Double) -> MathcomplementarityCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCluster::min(self : MathcomplementarityCluster) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityCluster::max(self : MathcomplementarityCluster) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityCluster::to_string(self : MathcomplementarityCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_model_make(size : Int) -> MathcomplementarityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityModel::len(self : MathcomplementarityModel) -> Int { self.size }

pub fn MathcomplementarityModel::get(self : MathcomplementarityModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityModel::set(self : MathcomplementarityModel, i : Int, v : Double) -> MathcomplementarityModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityModel::sum(self : MathcomplementarityModel) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityModel::mean(self : MathcomplementarityModel) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityModel::scale(self : MathcomplementarityModel, f : Double) -> MathcomplementarityModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityModel::add(self : MathcomplementarityModel, other : MathcomplementarityModel) -> MathcomplementarityModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityModel::copy(self : MathcomplementarityModel) -> MathcomplementarityModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityModel::fill(self : MathcomplementarityModel, v : Double) -> MathcomplementarityModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityModel::min(self : MathcomplementarityModel) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityModel::max(self : MathcomplementarityModel) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityModel::to_string(self : MathcomplementarityModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_layer_make(size : Int) -> MathcomplementarityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityLayer::len(self : MathcomplementarityLayer) -> Int { self.size }

pub fn MathcomplementarityLayer::get(self : MathcomplementarityLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityLayer::set(self : MathcomplementarityLayer, i : Int, v : Double) -> MathcomplementarityLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityLayer::sum(self : MathcomplementarityLayer) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityLayer::mean(self : MathcomplementarityLayer) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityLayer::scale(self : MathcomplementarityLayer, f : Double) -> MathcomplementarityLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityLayer::add(self : MathcomplementarityLayer, other : MathcomplementarityLayer) -> MathcomplementarityLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityLayer::copy(self : MathcomplementarityLayer) -> MathcomplementarityLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityLayer::fill(self : MathcomplementarityLayer, v : Double) -> MathcomplementarityLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityLayer::min(self : MathcomplementarityLayer) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityLayer::max(self : MathcomplementarityLayer) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityLayer::to_string(self : MathcomplementarityLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_buffer_make(size : Int) -> MathcomplementarityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityBuffer::len(self : MathcomplementarityBuffer) -> Int { self.size }

pub fn MathcomplementarityBuffer::get(self : MathcomplementarityBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityBuffer::set(self : MathcomplementarityBuffer, i : Int, v : Double) -> MathcomplementarityBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityBuffer::sum(self : MathcomplementarityBuffer) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityBuffer::mean(self : MathcomplementarityBuffer) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityBuffer::scale(self : MathcomplementarityBuffer, f : Double) -> MathcomplementarityBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityBuffer::add(self : MathcomplementarityBuffer, other : MathcomplementarityBuffer) -> MathcomplementarityBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityBuffer::copy(self : MathcomplementarityBuffer) -> MathcomplementarityBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityBuffer::fill(self : MathcomplementarityBuffer, v : Double) -> MathcomplementarityBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityBuffer::min(self : MathcomplementarityBuffer) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityBuffer::max(self : MathcomplementarityBuffer) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityBuffer::to_string(self : MathcomplementarityBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_cursor_make(size : Int) -> MathcomplementarityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityCursor::len(self : MathcomplementarityCursor) -> Int { self.size }

pub fn MathcomplementarityCursor::get(self : MathcomplementarityCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityCursor::set(self : MathcomplementarityCursor, i : Int, v : Double) -> MathcomplementarityCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCursor::sum(self : MathcomplementarityCursor) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityCursor::mean(self : MathcomplementarityCursor) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityCursor::scale(self : MathcomplementarityCursor, f : Double) -> MathcomplementarityCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCursor::add(self : MathcomplementarityCursor, other : MathcomplementarityCursor) -> MathcomplementarityCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityCursor::copy(self : MathcomplementarityCursor) -> MathcomplementarityCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCursor::fill(self : MathcomplementarityCursor, v : Double) -> MathcomplementarityCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityCursor::min(self : MathcomplementarityCursor) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityCursor::max(self : MathcomplementarityCursor) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityCursor::to_string(self : MathcomplementarityCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_view_make(size : Int) -> MathcomplementarityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityView::len(self : MathcomplementarityView) -> Int { self.size }

pub fn MathcomplementarityView::get(self : MathcomplementarityView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityView::set(self : MathcomplementarityView, i : Int, v : Double) -> MathcomplementarityView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityView::sum(self : MathcomplementarityView) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityView::mean(self : MathcomplementarityView) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityView::scale(self : MathcomplementarityView, f : Double) -> MathcomplementarityView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityView::add(self : MathcomplementarityView, other : MathcomplementarityView) -> MathcomplementarityView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityView::copy(self : MathcomplementarityView) -> MathcomplementarityView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityView::fill(self : MathcomplementarityView, v : Double) -> MathcomplementarityView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityView::min(self : MathcomplementarityView) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityView::max(self : MathcomplementarityView) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityView::to_string(self : MathcomplementarityView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_range_make(size : Int) -> MathcomplementarityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementarityRange::len(self : MathcomplementarityRange) -> Int { self.size }

pub fn MathcomplementarityRange::get(self : MathcomplementarityRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementarityRange::set(self : MathcomplementarityRange, i : Int, v : Double) -> MathcomplementarityRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementarityRange::sum(self : MathcomplementarityRange) -> Double { @_common.sum(self.data) }

pub fn MathcomplementarityRange::mean(self : MathcomplementarityRange) -> Double { @_common.mean(self.data) }

pub fn MathcomplementarityRange::scale(self : MathcomplementarityRange, f : Double) -> MathcomplementarityRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityRange::add(self : MathcomplementarityRange, other : MathcomplementarityRange) -> MathcomplementarityRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementarityRange::copy(self : MathcomplementarityRange) -> MathcomplementarityRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityRange::fill(self : MathcomplementarityRange, v : Double) -> MathcomplementarityRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementarityRange::min(self : MathcomplementarityRange) -> Double { @_common.min(self.data) }

pub fn MathcomplementarityRange::max(self : MathcomplementarityRange) -> Double { @_common.max(self.data) }

pub fn MathcomplementarityRange::to_string(self : MathcomplementarityRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathcomplementaritySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_slice_make(size : Int) -> MathcomplementaritySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathcomplementaritySlice::len(self : MathcomplementaritySlice) -> Int { self.size }

pub fn MathcomplementaritySlice::get(self : MathcomplementaritySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathcomplementaritySlice::set(self : MathcomplementaritySlice, i : Int, v : Double) -> MathcomplementaritySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathcomplementaritySlice::sum(self : MathcomplementaritySlice) -> Double { @_common.sum(self.data) }

pub fn MathcomplementaritySlice::mean(self : MathcomplementaritySlice) -> Double { @_common.mean(self.data) }

pub fn MathcomplementaritySlice::scale(self : MathcomplementaritySlice, f : Double) -> MathcomplementaritySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathcomplementaritySlice::add(self : MathcomplementaritySlice, other : MathcomplementaritySlice) -> MathcomplementaritySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathcomplementaritySlice::copy(self : MathcomplementaritySlice) -> MathcomplementaritySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathcomplementaritySlice::fill(self : MathcomplementaritySlice, v : Double) -> MathcomplementaritySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathcomplementaritySlice::min(self : MathcomplementaritySlice) -> Double { @_common.min(self.data) }

pub fn MathcomplementaritySlice::max(self : MathcomplementaritySlice) -> Double { @_common.max(self.data) }

pub fn MathcomplementaritySlice::to_string(self : MathcomplementaritySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

