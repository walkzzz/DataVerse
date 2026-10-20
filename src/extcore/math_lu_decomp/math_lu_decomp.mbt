///===
/// extcore/math_lu_decomp

pub(all) struct MathludecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_lu_decomp_make_point(x : Double, y : Double) -> MathludecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_lu_decomp_make_point3(x : Double, y : Double, z : Double) -> MathludecompPoint {
  { x, y, z, label: 0 }
}

pub fn MathludecompPoint::x(self : MathludecompPoint) -> Double { self.x }

pub fn MathludecompPoint::y(self : MathludecompPoint) -> Double { self.y }

pub fn MathludecompPoint::z(self : MathludecompPoint) -> Double { self.z }

pub fn MathludecompPoint::label(self : MathludecompPoint) -> Int { self.label }

pub fn MathludecompPoint::dist(self : MathludecompPoint, other : MathludecompPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathludecompPoint::add(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathludecompPoint::sub(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathludecompPoint::scale(self : MathludecompPoint, s : Double) -> MathludecompPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathludecompPoint::dot(self : MathludecompPoint, other : MathludecompPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathludecompPoint::cross(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathludecompPoint::norm(self : MathludecompPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathludecompPoint::normalize(self : MathludecompPoint) -> MathludecompPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathludecompPoint::negate(self : MathludecompPoint) -> MathludecompPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathludecompPoint::mid(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathludecompPoint::lerp(self : MathludecompPoint, other : MathludecompPoint, t : Double) -> MathludecompPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathludecompPoint::to_string(self : MathludecompPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathludecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_lu_decomp_make_series(vals : Array[Double], name : String) -> MathludecompSeries {
  { vals, name, meta: 0 }
}

pub fn MathludecompSeries::len(self : MathludecompSeries) -> Int { self.vals.length() }

pub fn MathludecompSeries::sum(self : MathludecompSeries) -> Double { @_common.sum(self.vals) }

pub fn MathludecompSeries::mean(self : MathludecompSeries) -> Double { @_common.mean(self.vals) }

pub fn MathludecompSeries::min(self : MathludecompSeries) -> Double { @_common.min(self.vals) }

pub fn MathludecompSeries::max(self : MathludecompSeries) -> Double { @_common.max(self.vals) }

pub fn MathludecompSeries::range(self : MathludecompSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathludecompSeries::variance(self : MathludecompSeries) -> Double { @_common.variance(self.vals) }

pub fn MathludecompSeries::std(self : MathludecompSeries) -> Double { @_common.std(self.vals) }

pub fn MathludecompSeries::median(self : MathludecompSeries) -> Double { @_common.median(self.vals) }

pub fn MathludecompSeries::scale(self : MathludecompSeries, f : Double) -> MathludecompSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathludecompSeries::add(self : MathludecompSeries, other : MathludecompSeries) -> MathludecompSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathludecompSeries::sub(self : MathludecompSeries, other : MathludecompSeries) -> MathludecompSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathludecompSeries::normalize(self : MathludecompSeries) -> MathludecompSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathludecompSeries::cumsum(self : MathludecompSeries) -> MathludecompSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathludecompSeries::to_string(self : MathludecompSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathludecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_lu_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathludecompMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_lu_decomp_matrix_identity(n : Int) -> MathludecompMatrix {
  let m = math_lu_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathludecompMatrix::get(self : MathludecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathludecompMatrix::transpose(self : MathludecompMatrix) -> MathludecompMatrix {
  let result = math_lu_decomp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathludecompMatrix::add(self : MathludecompMatrix, other : MathludecompMatrix) -> MathludecompMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_lu_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathludecompMatrix::scale(self : MathludecompMatrix, s : Double) -> MathludecompMatrix {
  let result = math_lu_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathludecompMatrix::multiply(self : MathludecompMatrix, other : MathludecompMatrix) -> MathludecompMatrix {
  if self.cols != other.rows { return math_lu_decomp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_lu_decomp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathludecompMatrix::trace(self : MathludecompMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathludecompMatrix::det(self : MathludecompMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathludecompMatrix::norm(self : MathludecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathludecompMatrix::to_string(self : MathludecompMatrix) -> String {
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

pub(all) struct MathludecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_lu_decomp_make_vector(comps : Array[Double]) -> MathludecompVector {
  { comps, dim: comps.length() }
}

pub fn math_lu_decomp_vector_zero(dim : Int) -> MathludecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathludecompVector::add(self : MathludecompVector, other : MathludecompVector) -> MathludecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathludecompVector::sub(self : MathludecompVector, other : MathludecompVector) -> MathludecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathludecompVector::scale(self : MathludecompVector, s : Double) -> MathludecompVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathludecompVector::dot(self : MathludecompVector, other : MathludecompVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathludecompVector::norm(self : MathludecompVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathludecompVector::normalize(self : MathludecompVector) -> MathludecompVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathludecompVector::dist(self : MathludecompVector, other : MathludecompVector) -> Double {
  self.sub(other).norm()
}

pub fn MathludecompVector::to_string(self : MathludecompVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathludecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_frame_make(size : Int) -> MathludecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompFrame::len(self : MathludecompFrame) -> Int { self.size }

pub fn MathludecompFrame::get(self : MathludecompFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompFrame::set(self : MathludecompFrame, i : Int, v : Double) -> MathludecompFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompFrame::sum(self : MathludecompFrame) -> Double { @_common.sum(self.data) }

pub fn MathludecompFrame::mean(self : MathludecompFrame) -> Double { @_common.mean(self.data) }

pub fn MathludecompFrame::scale(self : MathludecompFrame, f : Double) -> MathludecompFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompFrame::add(self : MathludecompFrame, other : MathludecompFrame) -> MathludecompFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompFrame::copy(self : MathludecompFrame) -> MathludecompFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompFrame::fill(self : MathludecompFrame, v : Double) -> MathludecompFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompFrame::min(self : MathludecompFrame) -> Double { @_common.min(self.data) }

pub fn MathludecompFrame::max(self : MathludecompFrame) -> Double { @_common.max(self.data) }

pub fn MathludecompFrame::to_string(self : MathludecompFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_table_make(size : Int) -> MathludecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompTable::len(self : MathludecompTable) -> Int { self.size }

pub fn MathludecompTable::get(self : MathludecompTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompTable::set(self : MathludecompTable, i : Int, v : Double) -> MathludecompTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompTable::sum(self : MathludecompTable) -> Double { @_common.sum(self.data) }

pub fn MathludecompTable::mean(self : MathludecompTable) -> Double { @_common.mean(self.data) }

pub fn MathludecompTable::scale(self : MathludecompTable, f : Double) -> MathludecompTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompTable::add(self : MathludecompTable, other : MathludecompTable) -> MathludecompTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompTable::copy(self : MathludecompTable) -> MathludecompTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompTable::fill(self : MathludecompTable, v : Double) -> MathludecompTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompTable::min(self : MathludecompTable) -> Double { @_common.min(self.data) }

pub fn MathludecompTable::max(self : MathludecompTable) -> Double { @_common.max(self.data) }

pub fn MathludecompTable::to_string(self : MathludecompTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_graphn_make(size : Int) -> MathludecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompGraphN::len(self : MathludecompGraphN) -> Int { self.size }

pub fn MathludecompGraphN::get(self : MathludecompGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompGraphN::set(self : MathludecompGraphN, i : Int, v : Double) -> MathludecompGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompGraphN::sum(self : MathludecompGraphN) -> Double { @_common.sum(self.data) }

pub fn MathludecompGraphN::mean(self : MathludecompGraphN) -> Double { @_common.mean(self.data) }

pub fn MathludecompGraphN::scale(self : MathludecompGraphN, f : Double) -> MathludecompGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompGraphN::add(self : MathludecompGraphN, other : MathludecompGraphN) -> MathludecompGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompGraphN::copy(self : MathludecompGraphN) -> MathludecompGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompGraphN::fill(self : MathludecompGraphN, v : Double) -> MathludecompGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompGraphN::min(self : MathludecompGraphN) -> Double { @_common.min(self.data) }

pub fn MathludecompGraphN::max(self : MathludecompGraphN) -> Double { @_common.max(self.data) }

pub fn MathludecompGraphN::to_string(self : MathludecompGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_node_make(size : Int) -> MathludecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompNode::len(self : MathludecompNode) -> Int { self.size }

pub fn MathludecompNode::get(self : MathludecompNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompNode::set(self : MathludecompNode, i : Int, v : Double) -> MathludecompNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompNode::sum(self : MathludecompNode) -> Double { @_common.sum(self.data) }

pub fn MathludecompNode::mean(self : MathludecompNode) -> Double { @_common.mean(self.data) }

pub fn MathludecompNode::scale(self : MathludecompNode, f : Double) -> MathludecompNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompNode::add(self : MathludecompNode, other : MathludecompNode) -> MathludecompNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompNode::copy(self : MathludecompNode) -> MathludecompNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompNode::fill(self : MathludecompNode, v : Double) -> MathludecompNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompNode::min(self : MathludecompNode) -> Double { @_common.min(self.data) }

pub fn MathludecompNode::max(self : MathludecompNode) -> Double { @_common.max(self.data) }

pub fn MathludecompNode::to_string(self : MathludecompNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_edge_make(size : Int) -> MathludecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompEdge::len(self : MathludecompEdge) -> Int { self.size }

pub fn MathludecompEdge::get(self : MathludecompEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompEdge::set(self : MathludecompEdge, i : Int, v : Double) -> MathludecompEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompEdge::sum(self : MathludecompEdge) -> Double { @_common.sum(self.data) }

pub fn MathludecompEdge::mean(self : MathludecompEdge) -> Double { @_common.mean(self.data) }

pub fn MathludecompEdge::scale(self : MathludecompEdge, f : Double) -> MathludecompEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompEdge::add(self : MathludecompEdge, other : MathludecompEdge) -> MathludecompEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompEdge::copy(self : MathludecompEdge) -> MathludecompEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompEdge::fill(self : MathludecompEdge, v : Double) -> MathludecompEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompEdge::min(self : MathludecompEdge) -> Double { @_common.min(self.data) }

pub fn MathludecompEdge::max(self : MathludecompEdge) -> Double { @_common.max(self.data) }

pub fn MathludecompEdge::to_string(self : MathludecompEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_path_make(size : Int) -> MathludecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompPath::len(self : MathludecompPath) -> Int { self.size }

pub fn MathludecompPath::get(self : MathludecompPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompPath::set(self : MathludecompPath, i : Int, v : Double) -> MathludecompPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompPath::sum(self : MathludecompPath) -> Double { @_common.sum(self.data) }

pub fn MathludecompPath::mean(self : MathludecompPath) -> Double { @_common.mean(self.data) }

pub fn MathludecompPath::scale(self : MathludecompPath, f : Double) -> MathludecompPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompPath::add(self : MathludecompPath, other : MathludecompPath) -> MathludecompPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompPath::copy(self : MathludecompPath) -> MathludecompPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompPath::fill(self : MathludecompPath, v : Double) -> MathludecompPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompPath::min(self : MathludecompPath) -> Double { @_common.min(self.data) }

pub fn MathludecompPath::max(self : MathludecompPath) -> Double { @_common.max(self.data) }

pub fn MathludecompPath::to_string(self : MathludecompPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_cluster_make(size : Int) -> MathludecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompCluster::len(self : MathludecompCluster) -> Int { self.size }

pub fn MathludecompCluster::get(self : MathludecompCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompCluster::set(self : MathludecompCluster, i : Int, v : Double) -> MathludecompCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompCluster::sum(self : MathludecompCluster) -> Double { @_common.sum(self.data) }

pub fn MathludecompCluster::mean(self : MathludecompCluster) -> Double { @_common.mean(self.data) }

pub fn MathludecompCluster::scale(self : MathludecompCluster, f : Double) -> MathludecompCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompCluster::add(self : MathludecompCluster, other : MathludecompCluster) -> MathludecompCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompCluster::copy(self : MathludecompCluster) -> MathludecompCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompCluster::fill(self : MathludecompCluster, v : Double) -> MathludecompCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompCluster::min(self : MathludecompCluster) -> Double { @_common.min(self.data) }

pub fn MathludecompCluster::max(self : MathludecompCluster) -> Double { @_common.max(self.data) }

pub fn MathludecompCluster::to_string(self : MathludecompCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_model_make(size : Int) -> MathludecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompModel::len(self : MathludecompModel) -> Int { self.size }

pub fn MathludecompModel::get(self : MathludecompModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompModel::set(self : MathludecompModel, i : Int, v : Double) -> MathludecompModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompModel::sum(self : MathludecompModel) -> Double { @_common.sum(self.data) }

pub fn MathludecompModel::mean(self : MathludecompModel) -> Double { @_common.mean(self.data) }

pub fn MathludecompModel::scale(self : MathludecompModel, f : Double) -> MathludecompModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompModel::add(self : MathludecompModel, other : MathludecompModel) -> MathludecompModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompModel::copy(self : MathludecompModel) -> MathludecompModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompModel::fill(self : MathludecompModel, v : Double) -> MathludecompModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompModel::min(self : MathludecompModel) -> Double { @_common.min(self.data) }

pub fn MathludecompModel::max(self : MathludecompModel) -> Double { @_common.max(self.data) }

pub fn MathludecompModel::to_string(self : MathludecompModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_layer_make(size : Int) -> MathludecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompLayer::len(self : MathludecompLayer) -> Int { self.size }

pub fn MathludecompLayer::get(self : MathludecompLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompLayer::set(self : MathludecompLayer, i : Int, v : Double) -> MathludecompLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompLayer::sum(self : MathludecompLayer) -> Double { @_common.sum(self.data) }

pub fn MathludecompLayer::mean(self : MathludecompLayer) -> Double { @_common.mean(self.data) }

pub fn MathludecompLayer::scale(self : MathludecompLayer, f : Double) -> MathludecompLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompLayer::add(self : MathludecompLayer, other : MathludecompLayer) -> MathludecompLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompLayer::copy(self : MathludecompLayer) -> MathludecompLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompLayer::fill(self : MathludecompLayer, v : Double) -> MathludecompLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompLayer::min(self : MathludecompLayer) -> Double { @_common.min(self.data) }

pub fn MathludecompLayer::max(self : MathludecompLayer) -> Double { @_common.max(self.data) }

pub fn MathludecompLayer::to_string(self : MathludecompLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_buffer_make(size : Int) -> MathludecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompBuffer::len(self : MathludecompBuffer) -> Int { self.size }

pub fn MathludecompBuffer::get(self : MathludecompBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompBuffer::set(self : MathludecompBuffer, i : Int, v : Double) -> MathludecompBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompBuffer::sum(self : MathludecompBuffer) -> Double { @_common.sum(self.data) }

pub fn MathludecompBuffer::mean(self : MathludecompBuffer) -> Double { @_common.mean(self.data) }

pub fn MathludecompBuffer::scale(self : MathludecompBuffer, f : Double) -> MathludecompBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompBuffer::add(self : MathludecompBuffer, other : MathludecompBuffer) -> MathludecompBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompBuffer::copy(self : MathludecompBuffer) -> MathludecompBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompBuffer::fill(self : MathludecompBuffer, v : Double) -> MathludecompBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompBuffer::min(self : MathludecompBuffer) -> Double { @_common.min(self.data) }

pub fn MathludecompBuffer::max(self : MathludecompBuffer) -> Double { @_common.max(self.data) }

pub fn MathludecompBuffer::to_string(self : MathludecompBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_cursor_make(size : Int) -> MathludecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompCursor::len(self : MathludecompCursor) -> Int { self.size }

pub fn MathludecompCursor::get(self : MathludecompCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompCursor::set(self : MathludecompCursor, i : Int, v : Double) -> MathludecompCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompCursor::sum(self : MathludecompCursor) -> Double { @_common.sum(self.data) }

pub fn MathludecompCursor::mean(self : MathludecompCursor) -> Double { @_common.mean(self.data) }

pub fn MathludecompCursor::scale(self : MathludecompCursor, f : Double) -> MathludecompCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompCursor::add(self : MathludecompCursor, other : MathludecompCursor) -> MathludecompCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompCursor::copy(self : MathludecompCursor) -> MathludecompCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompCursor::fill(self : MathludecompCursor, v : Double) -> MathludecompCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompCursor::min(self : MathludecompCursor) -> Double { @_common.min(self.data) }

pub fn MathludecompCursor::max(self : MathludecompCursor) -> Double { @_common.max(self.data) }

pub fn MathludecompCursor::to_string(self : MathludecompCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_view_make(size : Int) -> MathludecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompView::len(self : MathludecompView) -> Int { self.size }

pub fn MathludecompView::get(self : MathludecompView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompView::set(self : MathludecompView, i : Int, v : Double) -> MathludecompView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompView::sum(self : MathludecompView) -> Double { @_common.sum(self.data) }

pub fn MathludecompView::mean(self : MathludecompView) -> Double { @_common.mean(self.data) }

pub fn MathludecompView::scale(self : MathludecompView, f : Double) -> MathludecompView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompView::add(self : MathludecompView, other : MathludecompView) -> MathludecompView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompView::copy(self : MathludecompView) -> MathludecompView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompView::fill(self : MathludecompView, v : Double) -> MathludecompView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompView::min(self : MathludecompView) -> Double { @_common.min(self.data) }

pub fn MathludecompView::max(self : MathludecompView) -> Double { @_common.max(self.data) }

pub fn MathludecompView::to_string(self : MathludecompView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_range_make(size : Int) -> MathludecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompRange::len(self : MathludecompRange) -> Int { self.size }

pub fn MathludecompRange::get(self : MathludecompRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompRange::set(self : MathludecompRange, i : Int, v : Double) -> MathludecompRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompRange::sum(self : MathludecompRange) -> Double { @_common.sum(self.data) }

pub fn MathludecompRange::mean(self : MathludecompRange) -> Double { @_common.mean(self.data) }

pub fn MathludecompRange::scale(self : MathludecompRange, f : Double) -> MathludecompRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompRange::add(self : MathludecompRange, other : MathludecompRange) -> MathludecompRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompRange::copy(self : MathludecompRange) -> MathludecompRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompRange::fill(self : MathludecompRange, v : Double) -> MathludecompRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompRange::min(self : MathludecompRange) -> Double { @_common.min(self.data) }

pub fn MathludecompRange::max(self : MathludecompRange) -> Double { @_common.max(self.data) }

pub fn MathludecompRange::to_string(self : MathludecompRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathludecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_slice_make(size : Int) -> MathludecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathludecompSlice::len(self : MathludecompSlice) -> Int { self.size }

pub fn MathludecompSlice::get(self : MathludecompSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathludecompSlice::set(self : MathludecompSlice, i : Int, v : Double) -> MathludecompSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathludecompSlice::sum(self : MathludecompSlice) -> Double { @_common.sum(self.data) }

pub fn MathludecompSlice::mean(self : MathludecompSlice) -> Double { @_common.mean(self.data) }

pub fn MathludecompSlice::scale(self : MathludecompSlice, f : Double) -> MathludecompSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathludecompSlice::add(self : MathludecompSlice, other : MathludecompSlice) -> MathludecompSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathludecompSlice::copy(self : MathludecompSlice) -> MathludecompSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathludecompSlice::fill(self : MathludecompSlice, v : Double) -> MathludecompSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathludecompSlice::min(self : MathludecompSlice) -> Double { @_common.min(self.data) }

pub fn MathludecompSlice::max(self : MathludecompSlice) -> Double { @_common.max(self.data) }

pub fn MathludecompSlice::to_string(self : MathludecompSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

