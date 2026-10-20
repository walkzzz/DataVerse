///===
/// extcore/ml_rl_a3c

pub(all) struct Mlrla3cPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_a3c_make_point(x : Double, y : Double) -> Mlrla3cPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_a3c_make_point3(x : Double, y : Double, z : Double) -> Mlrla3cPoint {
  { x, y, z, label: 0 }
}

pub fn Mlrla3cPoint::x(self : Mlrla3cPoint) -> Double { self.x }

pub fn Mlrla3cPoint::y(self : Mlrla3cPoint) -> Double { self.y }

pub fn Mlrla3cPoint::z(self : Mlrla3cPoint) -> Double { self.z }

pub fn Mlrla3cPoint::label(self : Mlrla3cPoint) -> Int { self.label }

pub fn Mlrla3cPoint::dist(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Mlrla3cPoint::add(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Mlrla3cPoint::sub(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Mlrla3cPoint::scale(self : Mlrla3cPoint, s : Double) -> Mlrla3cPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Mlrla3cPoint::dot(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Mlrla3cPoint::cross(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Mlrla3cPoint::norm(self : Mlrla3cPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Mlrla3cPoint::normalize(self : Mlrla3cPoint) -> Mlrla3cPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Mlrla3cPoint::negate(self : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Mlrla3cPoint::mid(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Mlrla3cPoint::lerp(self : Mlrla3cPoint, other : Mlrla3cPoint, t : Double) -> Mlrla3cPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Mlrla3cPoint::to_string(self : Mlrla3cPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Mlrla3cSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_a3c_make_series(vals : Array[Double], name : String) -> Mlrla3cSeries {
  { vals, name, meta: 0 }
}

pub fn Mlrla3cSeries::len(self : Mlrla3cSeries) -> Int { self.vals.length() }

pub fn Mlrla3cSeries::sum(self : Mlrla3cSeries) -> Double { @_common.sum(self.vals) }

pub fn Mlrla3cSeries::mean(self : Mlrla3cSeries) -> Double { @_common.mean(self.vals) }

pub fn Mlrla3cSeries::min(self : Mlrla3cSeries) -> Double { @_common.min(self.vals) }

pub fn Mlrla3cSeries::max(self : Mlrla3cSeries) -> Double { @_common.max(self.vals) }

pub fn Mlrla3cSeries::range(self : Mlrla3cSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Mlrla3cSeries::variance(self : Mlrla3cSeries) -> Double { @_common.variance(self.vals) }

pub fn Mlrla3cSeries::std(self : Mlrla3cSeries) -> Double { @_common.std(self.vals) }

pub fn Mlrla3cSeries::median(self : Mlrla3cSeries) -> Double { @_common.median(self.vals) }

pub fn Mlrla3cSeries::scale(self : Mlrla3cSeries, f : Double) -> Mlrla3cSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Mlrla3cSeries::add(self : Mlrla3cSeries, other : Mlrla3cSeries) -> Mlrla3cSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Mlrla3cSeries::sub(self : Mlrla3cSeries, other : Mlrla3cSeries) -> Mlrla3cSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Mlrla3cSeries::normalize(self : Mlrla3cSeries) -> Mlrla3cSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Mlrla3cSeries::cumsum(self : Mlrla3cSeries) -> Mlrla3cSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Mlrla3cSeries::to_string(self : Mlrla3cSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Mlrla3cMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_a3c_make_matrix(rows : Int, cols : Int, val : Double) -> Mlrla3cMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_rl_a3c_matrix_identity(n : Int) -> Mlrla3cMatrix {
  let m = ml_rl_a3c_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Mlrla3cMatrix::get(self : Mlrla3cMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Mlrla3cMatrix::transpose(self : Mlrla3cMatrix) -> Mlrla3cMatrix {
  let result = ml_rl_a3c_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Mlrla3cMatrix::add(self : Mlrla3cMatrix, other : Mlrla3cMatrix) -> Mlrla3cMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_a3c_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Mlrla3cMatrix::scale(self : Mlrla3cMatrix, s : Double) -> Mlrla3cMatrix {
  let result = ml_rl_a3c_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Mlrla3cMatrix::multiply(self : Mlrla3cMatrix, other : Mlrla3cMatrix) -> Mlrla3cMatrix {
  if self.cols != other.rows { return ml_rl_a3c_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_a3c_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn Mlrla3cMatrix::trace(self : Mlrla3cMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Mlrla3cMatrix::det(self : Mlrla3cMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Mlrla3cMatrix::norm(self : Mlrla3cMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Mlrla3cMatrix::to_string(self : Mlrla3cMatrix) -> String {
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

pub(all) struct Mlrla3cVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_a3c_make_vector(comps : Array[Double]) -> Mlrla3cVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_a3c_vector_zero(dim : Int) -> Mlrla3cVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Mlrla3cVector::add(self : Mlrla3cVector, other : Mlrla3cVector) -> Mlrla3cVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Mlrla3cVector::sub(self : Mlrla3cVector, other : Mlrla3cVector) -> Mlrla3cVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Mlrla3cVector::scale(self : Mlrla3cVector, s : Double) -> Mlrla3cVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Mlrla3cVector::dot(self : Mlrla3cVector, other : Mlrla3cVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Mlrla3cVector::norm(self : Mlrla3cVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Mlrla3cVector::normalize(self : Mlrla3cVector) -> Mlrla3cVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Mlrla3cVector::dist(self : Mlrla3cVector, other : Mlrla3cVector) -> Double {
  self.sub(other).norm()
}

pub fn Mlrla3cVector::to_string(self : Mlrla3cVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Mlrla3cFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_frame_make(size : Int) -> Mlrla3cFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cFrame::len(self : Mlrla3cFrame) -> Int { self.size }

pub fn Mlrla3cFrame::get(self : Mlrla3cFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cFrame::set(self : Mlrla3cFrame, i : Int, v : Double) -> Mlrla3cFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cFrame::sum(self : Mlrla3cFrame) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cFrame::mean(self : Mlrla3cFrame) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cFrame::scale(self : Mlrla3cFrame, f : Double) -> Mlrla3cFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cFrame::add(self : Mlrla3cFrame, other : Mlrla3cFrame) -> Mlrla3cFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cFrame::copy(self : Mlrla3cFrame) -> Mlrla3cFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cFrame::fill(self : Mlrla3cFrame, v : Double) -> Mlrla3cFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cFrame::min(self : Mlrla3cFrame) -> Double { @_common.min(self.data) }

pub fn Mlrla3cFrame::max(self : Mlrla3cFrame) -> Double { @_common.max(self.data) }

pub fn Mlrla3cFrame::to_string(self : Mlrla3cFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_table_make(size : Int) -> Mlrla3cTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cTable::len(self : Mlrla3cTable) -> Int { self.size }

pub fn Mlrla3cTable::get(self : Mlrla3cTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cTable::set(self : Mlrla3cTable, i : Int, v : Double) -> Mlrla3cTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cTable::sum(self : Mlrla3cTable) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cTable::mean(self : Mlrla3cTable) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cTable::scale(self : Mlrla3cTable, f : Double) -> Mlrla3cTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cTable::add(self : Mlrla3cTable, other : Mlrla3cTable) -> Mlrla3cTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cTable::copy(self : Mlrla3cTable) -> Mlrla3cTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cTable::fill(self : Mlrla3cTable, v : Double) -> Mlrla3cTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cTable::min(self : Mlrla3cTable) -> Double { @_common.min(self.data) }

pub fn Mlrla3cTable::max(self : Mlrla3cTable) -> Double { @_common.max(self.data) }

pub fn Mlrla3cTable::to_string(self : Mlrla3cTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_graphn_make(size : Int) -> Mlrla3cGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cGraphN::len(self : Mlrla3cGraphN) -> Int { self.size }

pub fn Mlrla3cGraphN::get(self : Mlrla3cGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cGraphN::set(self : Mlrla3cGraphN, i : Int, v : Double) -> Mlrla3cGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cGraphN::sum(self : Mlrla3cGraphN) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cGraphN::mean(self : Mlrla3cGraphN) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cGraphN::scale(self : Mlrla3cGraphN, f : Double) -> Mlrla3cGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cGraphN::add(self : Mlrla3cGraphN, other : Mlrla3cGraphN) -> Mlrla3cGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cGraphN::copy(self : Mlrla3cGraphN) -> Mlrla3cGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cGraphN::fill(self : Mlrla3cGraphN, v : Double) -> Mlrla3cGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cGraphN::min(self : Mlrla3cGraphN) -> Double { @_common.min(self.data) }

pub fn Mlrla3cGraphN::max(self : Mlrla3cGraphN) -> Double { @_common.max(self.data) }

pub fn Mlrla3cGraphN::to_string(self : Mlrla3cGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_node_make(size : Int) -> Mlrla3cNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cNode::len(self : Mlrla3cNode) -> Int { self.size }

pub fn Mlrla3cNode::get(self : Mlrla3cNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cNode::set(self : Mlrla3cNode, i : Int, v : Double) -> Mlrla3cNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cNode::sum(self : Mlrla3cNode) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cNode::mean(self : Mlrla3cNode) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cNode::scale(self : Mlrla3cNode, f : Double) -> Mlrla3cNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cNode::add(self : Mlrla3cNode, other : Mlrla3cNode) -> Mlrla3cNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cNode::copy(self : Mlrla3cNode) -> Mlrla3cNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cNode::fill(self : Mlrla3cNode, v : Double) -> Mlrla3cNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cNode::min(self : Mlrla3cNode) -> Double { @_common.min(self.data) }

pub fn Mlrla3cNode::max(self : Mlrla3cNode) -> Double { @_common.max(self.data) }

pub fn Mlrla3cNode::to_string(self : Mlrla3cNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_edge_make(size : Int) -> Mlrla3cEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cEdge::len(self : Mlrla3cEdge) -> Int { self.size }

pub fn Mlrla3cEdge::get(self : Mlrla3cEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cEdge::set(self : Mlrla3cEdge, i : Int, v : Double) -> Mlrla3cEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cEdge::sum(self : Mlrla3cEdge) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cEdge::mean(self : Mlrla3cEdge) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cEdge::scale(self : Mlrla3cEdge, f : Double) -> Mlrla3cEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cEdge::add(self : Mlrla3cEdge, other : Mlrla3cEdge) -> Mlrla3cEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cEdge::copy(self : Mlrla3cEdge) -> Mlrla3cEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cEdge::fill(self : Mlrla3cEdge, v : Double) -> Mlrla3cEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cEdge::min(self : Mlrla3cEdge) -> Double { @_common.min(self.data) }

pub fn Mlrla3cEdge::max(self : Mlrla3cEdge) -> Double { @_common.max(self.data) }

pub fn Mlrla3cEdge::to_string(self : Mlrla3cEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_path_make(size : Int) -> Mlrla3cPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cPath::len(self : Mlrla3cPath) -> Int { self.size }

pub fn Mlrla3cPath::get(self : Mlrla3cPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cPath::set(self : Mlrla3cPath, i : Int, v : Double) -> Mlrla3cPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cPath::sum(self : Mlrla3cPath) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cPath::mean(self : Mlrla3cPath) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cPath::scale(self : Mlrla3cPath, f : Double) -> Mlrla3cPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cPath::add(self : Mlrla3cPath, other : Mlrla3cPath) -> Mlrla3cPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cPath::copy(self : Mlrla3cPath) -> Mlrla3cPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cPath::fill(self : Mlrla3cPath, v : Double) -> Mlrla3cPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cPath::min(self : Mlrla3cPath) -> Double { @_common.min(self.data) }

pub fn Mlrla3cPath::max(self : Mlrla3cPath) -> Double { @_common.max(self.data) }

pub fn Mlrla3cPath::to_string(self : Mlrla3cPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_cluster_make(size : Int) -> Mlrla3cCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cCluster::len(self : Mlrla3cCluster) -> Int { self.size }

pub fn Mlrla3cCluster::get(self : Mlrla3cCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cCluster::set(self : Mlrla3cCluster, i : Int, v : Double) -> Mlrla3cCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cCluster::sum(self : Mlrla3cCluster) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cCluster::mean(self : Mlrla3cCluster) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cCluster::scale(self : Mlrla3cCluster, f : Double) -> Mlrla3cCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cCluster::add(self : Mlrla3cCluster, other : Mlrla3cCluster) -> Mlrla3cCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cCluster::copy(self : Mlrla3cCluster) -> Mlrla3cCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cCluster::fill(self : Mlrla3cCluster, v : Double) -> Mlrla3cCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cCluster::min(self : Mlrla3cCluster) -> Double { @_common.min(self.data) }

pub fn Mlrla3cCluster::max(self : Mlrla3cCluster) -> Double { @_common.max(self.data) }

pub fn Mlrla3cCluster::to_string(self : Mlrla3cCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_model_make(size : Int) -> Mlrla3cModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cModel::len(self : Mlrla3cModel) -> Int { self.size }

pub fn Mlrla3cModel::get(self : Mlrla3cModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cModel::set(self : Mlrla3cModel, i : Int, v : Double) -> Mlrla3cModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cModel::sum(self : Mlrla3cModel) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cModel::mean(self : Mlrla3cModel) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cModel::scale(self : Mlrla3cModel, f : Double) -> Mlrla3cModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cModel::add(self : Mlrla3cModel, other : Mlrla3cModel) -> Mlrla3cModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cModel::copy(self : Mlrla3cModel) -> Mlrla3cModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cModel::fill(self : Mlrla3cModel, v : Double) -> Mlrla3cModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cModel::min(self : Mlrla3cModel) -> Double { @_common.min(self.data) }

pub fn Mlrla3cModel::max(self : Mlrla3cModel) -> Double { @_common.max(self.data) }

pub fn Mlrla3cModel::to_string(self : Mlrla3cModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_layer_make(size : Int) -> Mlrla3cLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cLayer::len(self : Mlrla3cLayer) -> Int { self.size }

pub fn Mlrla3cLayer::get(self : Mlrla3cLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cLayer::set(self : Mlrla3cLayer, i : Int, v : Double) -> Mlrla3cLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cLayer::sum(self : Mlrla3cLayer) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cLayer::mean(self : Mlrla3cLayer) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cLayer::scale(self : Mlrla3cLayer, f : Double) -> Mlrla3cLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cLayer::add(self : Mlrla3cLayer, other : Mlrla3cLayer) -> Mlrla3cLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cLayer::copy(self : Mlrla3cLayer) -> Mlrla3cLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cLayer::fill(self : Mlrla3cLayer, v : Double) -> Mlrla3cLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cLayer::min(self : Mlrla3cLayer) -> Double { @_common.min(self.data) }

pub fn Mlrla3cLayer::max(self : Mlrla3cLayer) -> Double { @_common.max(self.data) }

pub fn Mlrla3cLayer::to_string(self : Mlrla3cLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_buffer_make(size : Int) -> Mlrla3cBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cBuffer::len(self : Mlrla3cBuffer) -> Int { self.size }

pub fn Mlrla3cBuffer::get(self : Mlrla3cBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cBuffer::set(self : Mlrla3cBuffer, i : Int, v : Double) -> Mlrla3cBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cBuffer::sum(self : Mlrla3cBuffer) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cBuffer::mean(self : Mlrla3cBuffer) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cBuffer::scale(self : Mlrla3cBuffer, f : Double) -> Mlrla3cBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cBuffer::add(self : Mlrla3cBuffer, other : Mlrla3cBuffer) -> Mlrla3cBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cBuffer::copy(self : Mlrla3cBuffer) -> Mlrla3cBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cBuffer::fill(self : Mlrla3cBuffer, v : Double) -> Mlrla3cBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cBuffer::min(self : Mlrla3cBuffer) -> Double { @_common.min(self.data) }

pub fn Mlrla3cBuffer::max(self : Mlrla3cBuffer) -> Double { @_common.max(self.data) }

pub fn Mlrla3cBuffer::to_string(self : Mlrla3cBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_cursor_make(size : Int) -> Mlrla3cCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cCursor::len(self : Mlrla3cCursor) -> Int { self.size }

pub fn Mlrla3cCursor::get(self : Mlrla3cCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cCursor::set(self : Mlrla3cCursor, i : Int, v : Double) -> Mlrla3cCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cCursor::sum(self : Mlrla3cCursor) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cCursor::mean(self : Mlrla3cCursor) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cCursor::scale(self : Mlrla3cCursor, f : Double) -> Mlrla3cCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cCursor::add(self : Mlrla3cCursor, other : Mlrla3cCursor) -> Mlrla3cCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cCursor::copy(self : Mlrla3cCursor) -> Mlrla3cCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cCursor::fill(self : Mlrla3cCursor, v : Double) -> Mlrla3cCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cCursor::min(self : Mlrla3cCursor) -> Double { @_common.min(self.data) }

pub fn Mlrla3cCursor::max(self : Mlrla3cCursor) -> Double { @_common.max(self.data) }

pub fn Mlrla3cCursor::to_string(self : Mlrla3cCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_view_make(size : Int) -> Mlrla3cView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cView::len(self : Mlrla3cView) -> Int { self.size }

pub fn Mlrla3cView::get(self : Mlrla3cView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cView::set(self : Mlrla3cView, i : Int, v : Double) -> Mlrla3cView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cView::sum(self : Mlrla3cView) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cView::mean(self : Mlrla3cView) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cView::scale(self : Mlrla3cView, f : Double) -> Mlrla3cView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cView::add(self : Mlrla3cView, other : Mlrla3cView) -> Mlrla3cView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cView::copy(self : Mlrla3cView) -> Mlrla3cView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cView::fill(self : Mlrla3cView, v : Double) -> Mlrla3cView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cView::min(self : Mlrla3cView) -> Double { @_common.min(self.data) }

pub fn Mlrla3cView::max(self : Mlrla3cView) -> Double { @_common.max(self.data) }

pub fn Mlrla3cView::to_string(self : Mlrla3cView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_range_make(size : Int) -> Mlrla3cRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cRange::len(self : Mlrla3cRange) -> Int { self.size }

pub fn Mlrla3cRange::get(self : Mlrla3cRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cRange::set(self : Mlrla3cRange, i : Int, v : Double) -> Mlrla3cRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cRange::sum(self : Mlrla3cRange) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cRange::mean(self : Mlrla3cRange) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cRange::scale(self : Mlrla3cRange, f : Double) -> Mlrla3cRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cRange::add(self : Mlrla3cRange, other : Mlrla3cRange) -> Mlrla3cRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cRange::copy(self : Mlrla3cRange) -> Mlrla3cRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cRange::fill(self : Mlrla3cRange, v : Double) -> Mlrla3cRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cRange::min(self : Mlrla3cRange) -> Double { @_common.min(self.data) }

pub fn Mlrla3cRange::max(self : Mlrla3cRange) -> Double { @_common.max(self.data) }

pub fn Mlrla3cRange::to_string(self : Mlrla3cRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Mlrla3cSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_slice_make(size : Int) -> Mlrla3cSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Mlrla3cSlice::len(self : Mlrla3cSlice) -> Int { self.size }

pub fn Mlrla3cSlice::get(self : Mlrla3cSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Mlrla3cSlice::set(self : Mlrla3cSlice, i : Int, v : Double) -> Mlrla3cSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Mlrla3cSlice::sum(self : Mlrla3cSlice) -> Double { @_common.sum(self.data) }

pub fn Mlrla3cSlice::mean(self : Mlrla3cSlice) -> Double { @_common.mean(self.data) }

pub fn Mlrla3cSlice::scale(self : Mlrla3cSlice, f : Double) -> Mlrla3cSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Mlrla3cSlice::add(self : Mlrla3cSlice, other : Mlrla3cSlice) -> Mlrla3cSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Mlrla3cSlice::copy(self : Mlrla3cSlice) -> Mlrla3cSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Mlrla3cSlice::fill(self : Mlrla3cSlice, v : Double) -> Mlrla3cSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Mlrla3cSlice::min(self : Mlrla3cSlice) -> Double { @_common.min(self.data) }

pub fn Mlrla3cSlice::max(self : Mlrla3cSlice) -> Double { @_common.max(self.data) }

pub fn Mlrla3cSlice::to_string(self : Mlrla3cSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

