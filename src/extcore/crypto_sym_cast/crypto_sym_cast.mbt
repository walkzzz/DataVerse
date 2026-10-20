///===
/// extcore/crypto_sym_cast

pub(all) struct CryptosymcastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_cast_make_point(x : Double, y : Double) -> CryptosymcastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_cast_make_point3(x : Double, y : Double, z : Double) -> CryptosymcastPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymcastPoint::x(self : CryptosymcastPoint) -> Double { self.x }

pub fn CryptosymcastPoint::y(self : CryptosymcastPoint) -> Double { self.y }

pub fn CryptosymcastPoint::z(self : CryptosymcastPoint) -> Double { self.z }

pub fn CryptosymcastPoint::label(self : CryptosymcastPoint) -> Int { self.label }

pub fn CryptosymcastPoint::dist(self : CryptosymcastPoint, other : CryptosymcastPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymcastPoint::add(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymcastPoint::sub(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymcastPoint::scale(self : CryptosymcastPoint, s : Double) -> CryptosymcastPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymcastPoint::dot(self : CryptosymcastPoint, other : CryptosymcastPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymcastPoint::cross(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymcastPoint::norm(self : CryptosymcastPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymcastPoint::normalize(self : CryptosymcastPoint) -> CryptosymcastPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcastPoint::negate(self : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymcastPoint::mid(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymcastPoint::lerp(self : CryptosymcastPoint, other : CryptosymcastPoint, t : Double) -> CryptosymcastPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymcastPoint::to_string(self : CryptosymcastPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymcastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_cast_make_series(vals : Array[Double], name : String) -> CryptosymcastSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymcastSeries::len(self : CryptosymcastSeries) -> Int { self.vals.length() }

pub fn CryptosymcastSeries::sum(self : CryptosymcastSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymcastSeries::mean(self : CryptosymcastSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymcastSeries::min(self : CryptosymcastSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymcastSeries::max(self : CryptosymcastSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymcastSeries::range(self : CryptosymcastSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymcastSeries::variance(self : CryptosymcastSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymcastSeries::std(self : CryptosymcastSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymcastSeries::median(self : CryptosymcastSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymcastSeries::scale(self : CryptosymcastSeries, f : Double) -> CryptosymcastSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymcastSeries::add(self : CryptosymcastSeries, other : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymcastSeries::sub(self : CryptosymcastSeries, other : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymcastSeries::normalize(self : CryptosymcastSeries) -> CryptosymcastSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymcastSeries::cumsum(self : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymcastSeries::to_string(self : CryptosymcastSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_cast_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcastMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_cast_matrix_identity(n : Int) -> CryptosymcastMatrix {
  let m = crypto_sym_cast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymcastMatrix::get(self : CryptosymcastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymcastMatrix::transpose(self : CryptosymcastMatrix) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymcastMatrix::add(self : CryptosymcastMatrix, other : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_cast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymcastMatrix::scale(self : CryptosymcastMatrix, s : Double) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymcastMatrix::multiply(self : CryptosymcastMatrix, other : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if self.cols != other.rows { return crypto_sym_cast_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_cast_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymcastMatrix::trace(self : CryptosymcastMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymcastMatrix::det(self : CryptosymcastMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymcastMatrix::norm(self : CryptosymcastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymcastMatrix::to_string(self : CryptosymcastMatrix) -> String {
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

pub(all) struct CryptosymcastVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_cast_make_vector(comps : Array[Double]) -> CryptosymcastVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_cast_vector_zero(dim : Int) -> CryptosymcastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymcastVector::add(self : CryptosymcastVector, other : CryptosymcastVector) -> CryptosymcastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcastVector::sub(self : CryptosymcastVector, other : CryptosymcastVector) -> CryptosymcastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcastVector::scale(self : CryptosymcastVector, s : Double) -> CryptosymcastVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymcastVector::dot(self : CryptosymcastVector, other : CryptosymcastVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymcastVector::norm(self : CryptosymcastVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymcastVector::normalize(self : CryptosymcastVector) -> CryptosymcastVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcastVector::dist(self : CryptosymcastVector, other : CryptosymcastVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymcastVector::to_string(self : CryptosymcastVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_frame_make(size : Int) -> CryptosymcastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastFrame::len(self : CryptosymcastFrame) -> Int { self.size }

pub fn CryptosymcastFrame::get(self : CryptosymcastFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastFrame::set(self : CryptosymcastFrame, i : Int, v : Double) -> CryptosymcastFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastFrame::sum(self : CryptosymcastFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastFrame::mean(self : CryptosymcastFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastFrame::scale(self : CryptosymcastFrame, f : Double) -> CryptosymcastFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastFrame::add(self : CryptosymcastFrame, other : CryptosymcastFrame) -> CryptosymcastFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastFrame::copy(self : CryptosymcastFrame) -> CryptosymcastFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastFrame::fill(self : CryptosymcastFrame, v : Double) -> CryptosymcastFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastFrame::min(self : CryptosymcastFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymcastFrame::max(self : CryptosymcastFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymcastFrame::to_string(self : CryptosymcastFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_table_make(size : Int) -> CryptosymcastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastTable::len(self : CryptosymcastTable) -> Int { self.size }

pub fn CryptosymcastTable::get(self : CryptosymcastTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastTable::set(self : CryptosymcastTable, i : Int, v : Double) -> CryptosymcastTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastTable::sum(self : CryptosymcastTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastTable::mean(self : CryptosymcastTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastTable::scale(self : CryptosymcastTable, f : Double) -> CryptosymcastTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastTable::add(self : CryptosymcastTable, other : CryptosymcastTable) -> CryptosymcastTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastTable::copy(self : CryptosymcastTable) -> CryptosymcastTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastTable::fill(self : CryptosymcastTable, v : Double) -> CryptosymcastTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastTable::min(self : CryptosymcastTable) -> Double { @_common.min(self.data) }

pub fn CryptosymcastTable::max(self : CryptosymcastTable) -> Double { @_common.max(self.data) }

pub fn CryptosymcastTable::to_string(self : CryptosymcastTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_graphn_make(size : Int) -> CryptosymcastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastGraphN::len(self : CryptosymcastGraphN) -> Int { self.size }

pub fn CryptosymcastGraphN::get(self : CryptosymcastGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastGraphN::set(self : CryptosymcastGraphN, i : Int, v : Double) -> CryptosymcastGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastGraphN::sum(self : CryptosymcastGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastGraphN::mean(self : CryptosymcastGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastGraphN::scale(self : CryptosymcastGraphN, f : Double) -> CryptosymcastGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastGraphN::add(self : CryptosymcastGraphN, other : CryptosymcastGraphN) -> CryptosymcastGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastGraphN::copy(self : CryptosymcastGraphN) -> CryptosymcastGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastGraphN::fill(self : CryptosymcastGraphN, v : Double) -> CryptosymcastGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastGraphN::min(self : CryptosymcastGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymcastGraphN::max(self : CryptosymcastGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymcastGraphN::to_string(self : CryptosymcastGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_node_make(size : Int) -> CryptosymcastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastNode::len(self : CryptosymcastNode) -> Int { self.size }

pub fn CryptosymcastNode::get(self : CryptosymcastNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastNode::set(self : CryptosymcastNode, i : Int, v : Double) -> CryptosymcastNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastNode::sum(self : CryptosymcastNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastNode::mean(self : CryptosymcastNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastNode::scale(self : CryptosymcastNode, f : Double) -> CryptosymcastNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastNode::add(self : CryptosymcastNode, other : CryptosymcastNode) -> CryptosymcastNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastNode::copy(self : CryptosymcastNode) -> CryptosymcastNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastNode::fill(self : CryptosymcastNode, v : Double) -> CryptosymcastNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastNode::min(self : CryptosymcastNode) -> Double { @_common.min(self.data) }

pub fn CryptosymcastNode::max(self : CryptosymcastNode) -> Double { @_common.max(self.data) }

pub fn CryptosymcastNode::to_string(self : CryptosymcastNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_edge_make(size : Int) -> CryptosymcastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastEdge::len(self : CryptosymcastEdge) -> Int { self.size }

pub fn CryptosymcastEdge::get(self : CryptosymcastEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastEdge::set(self : CryptosymcastEdge, i : Int, v : Double) -> CryptosymcastEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastEdge::sum(self : CryptosymcastEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastEdge::mean(self : CryptosymcastEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastEdge::scale(self : CryptosymcastEdge, f : Double) -> CryptosymcastEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastEdge::add(self : CryptosymcastEdge, other : CryptosymcastEdge) -> CryptosymcastEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastEdge::copy(self : CryptosymcastEdge) -> CryptosymcastEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastEdge::fill(self : CryptosymcastEdge, v : Double) -> CryptosymcastEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastEdge::min(self : CryptosymcastEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymcastEdge::max(self : CryptosymcastEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymcastEdge::to_string(self : CryptosymcastEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_path_make(size : Int) -> CryptosymcastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastPath::len(self : CryptosymcastPath) -> Int { self.size }

pub fn CryptosymcastPath::get(self : CryptosymcastPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastPath::set(self : CryptosymcastPath, i : Int, v : Double) -> CryptosymcastPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastPath::sum(self : CryptosymcastPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastPath::mean(self : CryptosymcastPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastPath::scale(self : CryptosymcastPath, f : Double) -> CryptosymcastPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastPath::add(self : CryptosymcastPath, other : CryptosymcastPath) -> CryptosymcastPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastPath::copy(self : CryptosymcastPath) -> CryptosymcastPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastPath::fill(self : CryptosymcastPath, v : Double) -> CryptosymcastPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastPath::min(self : CryptosymcastPath) -> Double { @_common.min(self.data) }

pub fn CryptosymcastPath::max(self : CryptosymcastPath) -> Double { @_common.max(self.data) }

pub fn CryptosymcastPath::to_string(self : CryptosymcastPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cluster_make(size : Int) -> CryptosymcastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastCluster::len(self : CryptosymcastCluster) -> Int { self.size }

pub fn CryptosymcastCluster::get(self : CryptosymcastCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastCluster::set(self : CryptosymcastCluster, i : Int, v : Double) -> CryptosymcastCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastCluster::sum(self : CryptosymcastCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastCluster::mean(self : CryptosymcastCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastCluster::scale(self : CryptosymcastCluster, f : Double) -> CryptosymcastCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastCluster::add(self : CryptosymcastCluster, other : CryptosymcastCluster) -> CryptosymcastCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastCluster::copy(self : CryptosymcastCluster) -> CryptosymcastCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastCluster::fill(self : CryptosymcastCluster, v : Double) -> CryptosymcastCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastCluster::min(self : CryptosymcastCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymcastCluster::max(self : CryptosymcastCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymcastCluster::to_string(self : CryptosymcastCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_model_make(size : Int) -> CryptosymcastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastModel::len(self : CryptosymcastModel) -> Int { self.size }

pub fn CryptosymcastModel::get(self : CryptosymcastModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastModel::set(self : CryptosymcastModel, i : Int, v : Double) -> CryptosymcastModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastModel::sum(self : CryptosymcastModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastModel::mean(self : CryptosymcastModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastModel::scale(self : CryptosymcastModel, f : Double) -> CryptosymcastModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastModel::add(self : CryptosymcastModel, other : CryptosymcastModel) -> CryptosymcastModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastModel::copy(self : CryptosymcastModel) -> CryptosymcastModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastModel::fill(self : CryptosymcastModel, v : Double) -> CryptosymcastModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastModel::min(self : CryptosymcastModel) -> Double { @_common.min(self.data) }

pub fn CryptosymcastModel::max(self : CryptosymcastModel) -> Double { @_common.max(self.data) }

pub fn CryptosymcastModel::to_string(self : CryptosymcastModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_layer_make(size : Int) -> CryptosymcastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastLayer::len(self : CryptosymcastLayer) -> Int { self.size }

pub fn CryptosymcastLayer::get(self : CryptosymcastLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastLayer::set(self : CryptosymcastLayer, i : Int, v : Double) -> CryptosymcastLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastLayer::sum(self : CryptosymcastLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastLayer::mean(self : CryptosymcastLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastLayer::scale(self : CryptosymcastLayer, f : Double) -> CryptosymcastLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastLayer::add(self : CryptosymcastLayer, other : CryptosymcastLayer) -> CryptosymcastLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastLayer::copy(self : CryptosymcastLayer) -> CryptosymcastLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastLayer::fill(self : CryptosymcastLayer, v : Double) -> CryptosymcastLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastLayer::min(self : CryptosymcastLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymcastLayer::max(self : CryptosymcastLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymcastLayer::to_string(self : CryptosymcastLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_buffer_make(size : Int) -> CryptosymcastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastBuffer::len(self : CryptosymcastBuffer) -> Int { self.size }

pub fn CryptosymcastBuffer::get(self : CryptosymcastBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastBuffer::set(self : CryptosymcastBuffer, i : Int, v : Double) -> CryptosymcastBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastBuffer::sum(self : CryptosymcastBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastBuffer::mean(self : CryptosymcastBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastBuffer::scale(self : CryptosymcastBuffer, f : Double) -> CryptosymcastBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastBuffer::add(self : CryptosymcastBuffer, other : CryptosymcastBuffer) -> CryptosymcastBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastBuffer::copy(self : CryptosymcastBuffer) -> CryptosymcastBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastBuffer::fill(self : CryptosymcastBuffer, v : Double) -> CryptosymcastBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastBuffer::min(self : CryptosymcastBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymcastBuffer::max(self : CryptosymcastBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymcastBuffer::to_string(self : CryptosymcastBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cursor_make(size : Int) -> CryptosymcastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastCursor::len(self : CryptosymcastCursor) -> Int { self.size }

pub fn CryptosymcastCursor::get(self : CryptosymcastCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastCursor::set(self : CryptosymcastCursor, i : Int, v : Double) -> CryptosymcastCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastCursor::sum(self : CryptosymcastCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastCursor::mean(self : CryptosymcastCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastCursor::scale(self : CryptosymcastCursor, f : Double) -> CryptosymcastCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastCursor::add(self : CryptosymcastCursor, other : CryptosymcastCursor) -> CryptosymcastCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastCursor::copy(self : CryptosymcastCursor) -> CryptosymcastCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastCursor::fill(self : CryptosymcastCursor, v : Double) -> CryptosymcastCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastCursor::min(self : CryptosymcastCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymcastCursor::max(self : CryptosymcastCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymcastCursor::to_string(self : CryptosymcastCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_view_make(size : Int) -> CryptosymcastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastView::len(self : CryptosymcastView) -> Int { self.size }

pub fn CryptosymcastView::get(self : CryptosymcastView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastView::set(self : CryptosymcastView, i : Int, v : Double) -> CryptosymcastView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastView::sum(self : CryptosymcastView) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastView::mean(self : CryptosymcastView) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastView::scale(self : CryptosymcastView, f : Double) -> CryptosymcastView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastView::add(self : CryptosymcastView, other : CryptosymcastView) -> CryptosymcastView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastView::copy(self : CryptosymcastView) -> CryptosymcastView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastView::fill(self : CryptosymcastView, v : Double) -> CryptosymcastView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastView::min(self : CryptosymcastView) -> Double { @_common.min(self.data) }

pub fn CryptosymcastView::max(self : CryptosymcastView) -> Double { @_common.max(self.data) }

pub fn CryptosymcastView::to_string(self : CryptosymcastView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_range_make(size : Int) -> CryptosymcastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastRange::len(self : CryptosymcastRange) -> Int { self.size }

pub fn CryptosymcastRange::get(self : CryptosymcastRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastRange::set(self : CryptosymcastRange, i : Int, v : Double) -> CryptosymcastRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastRange::sum(self : CryptosymcastRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastRange::mean(self : CryptosymcastRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastRange::scale(self : CryptosymcastRange, f : Double) -> CryptosymcastRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastRange::add(self : CryptosymcastRange, other : CryptosymcastRange) -> CryptosymcastRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastRange::copy(self : CryptosymcastRange) -> CryptosymcastRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastRange::fill(self : CryptosymcastRange, v : Double) -> CryptosymcastRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastRange::min(self : CryptosymcastRange) -> Double { @_common.min(self.data) }

pub fn CryptosymcastRange::max(self : CryptosymcastRange) -> Double { @_common.max(self.data) }

pub fn CryptosymcastRange::to_string(self : CryptosymcastRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_slice_make(size : Int) -> CryptosymcastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcastSlice::len(self : CryptosymcastSlice) -> Int { self.size }

pub fn CryptosymcastSlice::get(self : CryptosymcastSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcastSlice::set(self : CryptosymcastSlice, i : Int, v : Double) -> CryptosymcastSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcastSlice::sum(self : CryptosymcastSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymcastSlice::mean(self : CryptosymcastSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymcastSlice::scale(self : CryptosymcastSlice, f : Double) -> CryptosymcastSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcastSlice::add(self : CryptosymcastSlice, other : CryptosymcastSlice) -> CryptosymcastSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcastSlice::copy(self : CryptosymcastSlice) -> CryptosymcastSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcastSlice::fill(self : CryptosymcastSlice, v : Double) -> CryptosymcastSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcastSlice::min(self : CryptosymcastSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymcastSlice::max(self : CryptosymcastSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymcastSlice::to_string(self : CryptosymcastSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

