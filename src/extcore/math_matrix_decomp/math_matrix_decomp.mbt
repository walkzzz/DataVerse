///===
/// extcore/math_matrix_decomp

pub(all) struct MathmatrixdecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_matrix_decomp_make_point(x : Double, y : Double) -> MathmatrixdecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_matrix_decomp_make_point3(x : Double, y : Double, z : Double) -> MathmatrixdecompPoint {
  { x, y, z, label: 0 }
}

pub fn MathmatrixdecompPoint::x(self : MathmatrixdecompPoint) -> Double { self.x }

pub fn MathmatrixdecompPoint::y(self : MathmatrixdecompPoint) -> Double { self.y }

pub fn MathmatrixdecompPoint::z(self : MathmatrixdecompPoint) -> Double { self.z }

pub fn MathmatrixdecompPoint::label(self : MathmatrixdecompPoint) -> Int { self.label }

pub fn MathmatrixdecompPoint::dist(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathmatrixdecompPoint::add(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathmatrixdecompPoint::sub(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathmatrixdecompPoint::scale(self : MathmatrixdecompPoint, s : Double) -> MathmatrixdecompPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathmatrixdecompPoint::dot(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathmatrixdecompPoint::cross(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathmatrixdecompPoint::norm(self : MathmatrixdecompPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathmatrixdecompPoint::normalize(self : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathmatrixdecompPoint::negate(self : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathmatrixdecompPoint::mid(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathmatrixdecompPoint::lerp(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint, t : Double) -> MathmatrixdecompPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathmatrixdecompPoint::to_string(self : MathmatrixdecompPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathmatrixdecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_matrix_decomp_make_series(vals : Array[Double], name : String) -> MathmatrixdecompSeries {
  { vals, name, meta: 0 }
}

pub fn MathmatrixdecompSeries::len(self : MathmatrixdecompSeries) -> Int { self.vals.length() }

pub fn MathmatrixdecompSeries::sum(self : MathmatrixdecompSeries) -> Double { @_common.sum(self.vals) }

pub fn MathmatrixdecompSeries::mean(self : MathmatrixdecompSeries) -> Double { @_common.mean(self.vals) }

pub fn MathmatrixdecompSeries::min(self : MathmatrixdecompSeries) -> Double { @_common.min(self.vals) }

pub fn MathmatrixdecompSeries::max(self : MathmatrixdecompSeries) -> Double { @_common.max(self.vals) }

pub fn MathmatrixdecompSeries::range(self : MathmatrixdecompSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathmatrixdecompSeries::variance(self : MathmatrixdecompSeries) -> Double { @_common.variance(self.vals) }

pub fn MathmatrixdecompSeries::std(self : MathmatrixdecompSeries) -> Double { @_common.std(self.vals) }

pub fn MathmatrixdecompSeries::median(self : MathmatrixdecompSeries) -> Double { @_common.median(self.vals) }

pub fn MathmatrixdecompSeries::scale(self : MathmatrixdecompSeries, f : Double) -> MathmatrixdecompSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathmatrixdecompSeries::add(self : MathmatrixdecompSeries, other : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathmatrixdecompSeries::sub(self : MathmatrixdecompSeries, other : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathmatrixdecompSeries::normalize(self : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathmatrixdecompSeries::cumsum(self : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathmatrixdecompSeries::to_string(self : MathmatrixdecompSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathmatrixdecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_matrix_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathmatrixdecompMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_matrix_decomp_matrix_identity(n : Int) -> MathmatrixdecompMatrix {
  let m = math_matrix_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathmatrixdecompMatrix::get(self : MathmatrixdecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathmatrixdecompMatrix::transpose(self : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  let result = math_matrix_decomp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathmatrixdecompMatrix::add(self : MathmatrixdecompMatrix, other : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_matrix_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathmatrixdecompMatrix::scale(self : MathmatrixdecompMatrix, s : Double) -> MathmatrixdecompMatrix {
  let result = math_matrix_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathmatrixdecompMatrix::multiply(self : MathmatrixdecompMatrix, other : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  if self.cols != other.rows { return math_matrix_decomp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_matrix_decomp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathmatrixdecompMatrix::trace(self : MathmatrixdecompMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathmatrixdecompMatrix::det(self : MathmatrixdecompMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathmatrixdecompMatrix::norm(self : MathmatrixdecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathmatrixdecompMatrix::to_string(self : MathmatrixdecompMatrix) -> String {
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

pub(all) struct MathmatrixdecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_matrix_decomp_make_vector(comps : Array[Double]) -> MathmatrixdecompVector {
  { comps, dim: comps.length() }
}

pub fn math_matrix_decomp_vector_zero(dim : Int) -> MathmatrixdecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathmatrixdecompVector::add(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathmatrixdecompVector::sub(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathmatrixdecompVector::scale(self : MathmatrixdecompVector, s : Double) -> MathmatrixdecompVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathmatrixdecompVector::dot(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathmatrixdecompVector::norm(self : MathmatrixdecompVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathmatrixdecompVector::normalize(self : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathmatrixdecompVector::dist(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> Double {
  self.sub(other).norm()
}

pub fn MathmatrixdecompVector::to_string(self : MathmatrixdecompVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathmatrixdecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_frame_make(size : Int) -> MathmatrixdecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompFrame::len(self : MathmatrixdecompFrame) -> Int { self.size }

pub fn MathmatrixdecompFrame::get(self : MathmatrixdecompFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompFrame::set(self : MathmatrixdecompFrame, i : Int, v : Double) -> MathmatrixdecompFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompFrame::sum(self : MathmatrixdecompFrame) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompFrame::mean(self : MathmatrixdecompFrame) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompFrame::scale(self : MathmatrixdecompFrame, f : Double) -> MathmatrixdecompFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompFrame::add(self : MathmatrixdecompFrame, other : MathmatrixdecompFrame) -> MathmatrixdecompFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompFrame::copy(self : MathmatrixdecompFrame) -> MathmatrixdecompFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompFrame::fill(self : MathmatrixdecompFrame, v : Double) -> MathmatrixdecompFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompFrame::min(self : MathmatrixdecompFrame) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompFrame::max(self : MathmatrixdecompFrame) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompFrame::to_string(self : MathmatrixdecompFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_table_make(size : Int) -> MathmatrixdecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompTable::len(self : MathmatrixdecompTable) -> Int { self.size }

pub fn MathmatrixdecompTable::get(self : MathmatrixdecompTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompTable::set(self : MathmatrixdecompTable, i : Int, v : Double) -> MathmatrixdecompTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompTable::sum(self : MathmatrixdecompTable) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompTable::mean(self : MathmatrixdecompTable) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompTable::scale(self : MathmatrixdecompTable, f : Double) -> MathmatrixdecompTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompTable::add(self : MathmatrixdecompTable, other : MathmatrixdecompTable) -> MathmatrixdecompTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompTable::copy(self : MathmatrixdecompTable) -> MathmatrixdecompTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompTable::fill(self : MathmatrixdecompTable, v : Double) -> MathmatrixdecompTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompTable::min(self : MathmatrixdecompTable) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompTable::max(self : MathmatrixdecompTable) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompTable::to_string(self : MathmatrixdecompTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_graphn_make(size : Int) -> MathmatrixdecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompGraphN::len(self : MathmatrixdecompGraphN) -> Int { self.size }

pub fn MathmatrixdecompGraphN::get(self : MathmatrixdecompGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompGraphN::set(self : MathmatrixdecompGraphN, i : Int, v : Double) -> MathmatrixdecompGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompGraphN::sum(self : MathmatrixdecompGraphN) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompGraphN::mean(self : MathmatrixdecompGraphN) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompGraphN::scale(self : MathmatrixdecompGraphN, f : Double) -> MathmatrixdecompGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompGraphN::add(self : MathmatrixdecompGraphN, other : MathmatrixdecompGraphN) -> MathmatrixdecompGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompGraphN::copy(self : MathmatrixdecompGraphN) -> MathmatrixdecompGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompGraphN::fill(self : MathmatrixdecompGraphN, v : Double) -> MathmatrixdecompGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompGraphN::min(self : MathmatrixdecompGraphN) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompGraphN::max(self : MathmatrixdecompGraphN) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompGraphN::to_string(self : MathmatrixdecompGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_node_make(size : Int) -> MathmatrixdecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompNode::len(self : MathmatrixdecompNode) -> Int { self.size }

pub fn MathmatrixdecompNode::get(self : MathmatrixdecompNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompNode::set(self : MathmatrixdecompNode, i : Int, v : Double) -> MathmatrixdecompNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompNode::sum(self : MathmatrixdecompNode) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompNode::mean(self : MathmatrixdecompNode) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompNode::scale(self : MathmatrixdecompNode, f : Double) -> MathmatrixdecompNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompNode::add(self : MathmatrixdecompNode, other : MathmatrixdecompNode) -> MathmatrixdecompNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompNode::copy(self : MathmatrixdecompNode) -> MathmatrixdecompNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompNode::fill(self : MathmatrixdecompNode, v : Double) -> MathmatrixdecompNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompNode::min(self : MathmatrixdecompNode) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompNode::max(self : MathmatrixdecompNode) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompNode::to_string(self : MathmatrixdecompNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_edge_make(size : Int) -> MathmatrixdecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompEdge::len(self : MathmatrixdecompEdge) -> Int { self.size }

pub fn MathmatrixdecompEdge::get(self : MathmatrixdecompEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompEdge::set(self : MathmatrixdecompEdge, i : Int, v : Double) -> MathmatrixdecompEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompEdge::sum(self : MathmatrixdecompEdge) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompEdge::mean(self : MathmatrixdecompEdge) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompEdge::scale(self : MathmatrixdecompEdge, f : Double) -> MathmatrixdecompEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompEdge::add(self : MathmatrixdecompEdge, other : MathmatrixdecompEdge) -> MathmatrixdecompEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompEdge::copy(self : MathmatrixdecompEdge) -> MathmatrixdecompEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompEdge::fill(self : MathmatrixdecompEdge, v : Double) -> MathmatrixdecompEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompEdge::min(self : MathmatrixdecompEdge) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompEdge::max(self : MathmatrixdecompEdge) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompEdge::to_string(self : MathmatrixdecompEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_path_make(size : Int) -> MathmatrixdecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompPath::len(self : MathmatrixdecompPath) -> Int { self.size }

pub fn MathmatrixdecompPath::get(self : MathmatrixdecompPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompPath::set(self : MathmatrixdecompPath, i : Int, v : Double) -> MathmatrixdecompPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompPath::sum(self : MathmatrixdecompPath) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompPath::mean(self : MathmatrixdecompPath) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompPath::scale(self : MathmatrixdecompPath, f : Double) -> MathmatrixdecompPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompPath::add(self : MathmatrixdecompPath, other : MathmatrixdecompPath) -> MathmatrixdecompPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompPath::copy(self : MathmatrixdecompPath) -> MathmatrixdecompPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompPath::fill(self : MathmatrixdecompPath, v : Double) -> MathmatrixdecompPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompPath::min(self : MathmatrixdecompPath) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompPath::max(self : MathmatrixdecompPath) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompPath::to_string(self : MathmatrixdecompPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_cluster_make(size : Int) -> MathmatrixdecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompCluster::len(self : MathmatrixdecompCluster) -> Int { self.size }

pub fn MathmatrixdecompCluster::get(self : MathmatrixdecompCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompCluster::set(self : MathmatrixdecompCluster, i : Int, v : Double) -> MathmatrixdecompCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCluster::sum(self : MathmatrixdecompCluster) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompCluster::mean(self : MathmatrixdecompCluster) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompCluster::scale(self : MathmatrixdecompCluster, f : Double) -> MathmatrixdecompCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCluster::add(self : MathmatrixdecompCluster, other : MathmatrixdecompCluster) -> MathmatrixdecompCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompCluster::copy(self : MathmatrixdecompCluster) -> MathmatrixdecompCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCluster::fill(self : MathmatrixdecompCluster, v : Double) -> MathmatrixdecompCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCluster::min(self : MathmatrixdecompCluster) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompCluster::max(self : MathmatrixdecompCluster) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompCluster::to_string(self : MathmatrixdecompCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_model_make(size : Int) -> MathmatrixdecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompModel::len(self : MathmatrixdecompModel) -> Int { self.size }

pub fn MathmatrixdecompModel::get(self : MathmatrixdecompModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompModel::set(self : MathmatrixdecompModel, i : Int, v : Double) -> MathmatrixdecompModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompModel::sum(self : MathmatrixdecompModel) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompModel::mean(self : MathmatrixdecompModel) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompModel::scale(self : MathmatrixdecompModel, f : Double) -> MathmatrixdecompModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompModel::add(self : MathmatrixdecompModel, other : MathmatrixdecompModel) -> MathmatrixdecompModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompModel::copy(self : MathmatrixdecompModel) -> MathmatrixdecompModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompModel::fill(self : MathmatrixdecompModel, v : Double) -> MathmatrixdecompModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompModel::min(self : MathmatrixdecompModel) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompModel::max(self : MathmatrixdecompModel) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompModel::to_string(self : MathmatrixdecompModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_layer_make(size : Int) -> MathmatrixdecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompLayer::len(self : MathmatrixdecompLayer) -> Int { self.size }

pub fn MathmatrixdecompLayer::get(self : MathmatrixdecompLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompLayer::set(self : MathmatrixdecompLayer, i : Int, v : Double) -> MathmatrixdecompLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompLayer::sum(self : MathmatrixdecompLayer) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompLayer::mean(self : MathmatrixdecompLayer) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompLayer::scale(self : MathmatrixdecompLayer, f : Double) -> MathmatrixdecompLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompLayer::add(self : MathmatrixdecompLayer, other : MathmatrixdecompLayer) -> MathmatrixdecompLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompLayer::copy(self : MathmatrixdecompLayer) -> MathmatrixdecompLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompLayer::fill(self : MathmatrixdecompLayer, v : Double) -> MathmatrixdecompLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompLayer::min(self : MathmatrixdecompLayer) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompLayer::max(self : MathmatrixdecompLayer) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompLayer::to_string(self : MathmatrixdecompLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_buffer_make(size : Int) -> MathmatrixdecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompBuffer::len(self : MathmatrixdecompBuffer) -> Int { self.size }

pub fn MathmatrixdecompBuffer::get(self : MathmatrixdecompBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompBuffer::set(self : MathmatrixdecompBuffer, i : Int, v : Double) -> MathmatrixdecompBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompBuffer::sum(self : MathmatrixdecompBuffer) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompBuffer::mean(self : MathmatrixdecompBuffer) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompBuffer::scale(self : MathmatrixdecompBuffer, f : Double) -> MathmatrixdecompBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompBuffer::add(self : MathmatrixdecompBuffer, other : MathmatrixdecompBuffer) -> MathmatrixdecompBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompBuffer::copy(self : MathmatrixdecompBuffer) -> MathmatrixdecompBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompBuffer::fill(self : MathmatrixdecompBuffer, v : Double) -> MathmatrixdecompBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompBuffer::min(self : MathmatrixdecompBuffer) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompBuffer::max(self : MathmatrixdecompBuffer) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompBuffer::to_string(self : MathmatrixdecompBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_cursor_make(size : Int) -> MathmatrixdecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompCursor::len(self : MathmatrixdecompCursor) -> Int { self.size }

pub fn MathmatrixdecompCursor::get(self : MathmatrixdecompCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompCursor::set(self : MathmatrixdecompCursor, i : Int, v : Double) -> MathmatrixdecompCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCursor::sum(self : MathmatrixdecompCursor) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompCursor::mean(self : MathmatrixdecompCursor) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompCursor::scale(self : MathmatrixdecompCursor, f : Double) -> MathmatrixdecompCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCursor::add(self : MathmatrixdecompCursor, other : MathmatrixdecompCursor) -> MathmatrixdecompCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompCursor::copy(self : MathmatrixdecompCursor) -> MathmatrixdecompCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCursor::fill(self : MathmatrixdecompCursor, v : Double) -> MathmatrixdecompCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompCursor::min(self : MathmatrixdecompCursor) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompCursor::max(self : MathmatrixdecompCursor) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompCursor::to_string(self : MathmatrixdecompCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_view_make(size : Int) -> MathmatrixdecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompView::len(self : MathmatrixdecompView) -> Int { self.size }

pub fn MathmatrixdecompView::get(self : MathmatrixdecompView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompView::set(self : MathmatrixdecompView, i : Int, v : Double) -> MathmatrixdecompView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompView::sum(self : MathmatrixdecompView) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompView::mean(self : MathmatrixdecompView) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompView::scale(self : MathmatrixdecompView, f : Double) -> MathmatrixdecompView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompView::add(self : MathmatrixdecompView, other : MathmatrixdecompView) -> MathmatrixdecompView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompView::copy(self : MathmatrixdecompView) -> MathmatrixdecompView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompView::fill(self : MathmatrixdecompView, v : Double) -> MathmatrixdecompView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompView::min(self : MathmatrixdecompView) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompView::max(self : MathmatrixdecompView) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompView::to_string(self : MathmatrixdecompView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_range_make(size : Int) -> MathmatrixdecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompRange::len(self : MathmatrixdecompRange) -> Int { self.size }

pub fn MathmatrixdecompRange::get(self : MathmatrixdecompRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompRange::set(self : MathmatrixdecompRange, i : Int, v : Double) -> MathmatrixdecompRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompRange::sum(self : MathmatrixdecompRange) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompRange::mean(self : MathmatrixdecompRange) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompRange::scale(self : MathmatrixdecompRange, f : Double) -> MathmatrixdecompRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompRange::add(self : MathmatrixdecompRange, other : MathmatrixdecompRange) -> MathmatrixdecompRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompRange::copy(self : MathmatrixdecompRange) -> MathmatrixdecompRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompRange::fill(self : MathmatrixdecompRange, v : Double) -> MathmatrixdecompRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompRange::min(self : MathmatrixdecompRange) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompRange::max(self : MathmatrixdecompRange) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompRange::to_string(self : MathmatrixdecompRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_slice_make(size : Int) -> MathmatrixdecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathmatrixdecompSlice::len(self : MathmatrixdecompSlice) -> Int { self.size }

pub fn MathmatrixdecompSlice::get(self : MathmatrixdecompSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathmatrixdecompSlice::set(self : MathmatrixdecompSlice, i : Int, v : Double) -> MathmatrixdecompSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompSlice::sum(self : MathmatrixdecompSlice) -> Double { @_common.sum(self.data) }

pub fn MathmatrixdecompSlice::mean(self : MathmatrixdecompSlice) -> Double { @_common.mean(self.data) }

pub fn MathmatrixdecompSlice::scale(self : MathmatrixdecompSlice, f : Double) -> MathmatrixdecompSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompSlice::add(self : MathmatrixdecompSlice, other : MathmatrixdecompSlice) -> MathmatrixdecompSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathmatrixdecompSlice::copy(self : MathmatrixdecompSlice) -> MathmatrixdecompSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompSlice::fill(self : MathmatrixdecompSlice, v : Double) -> MathmatrixdecompSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathmatrixdecompSlice::min(self : MathmatrixdecompSlice) -> Double { @_common.min(self.data) }

pub fn MathmatrixdecompSlice::max(self : MathmatrixdecompSlice) -> Double { @_common.max(self.data) }

pub fn MathmatrixdecompSlice::to_string(self : MathmatrixdecompSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

