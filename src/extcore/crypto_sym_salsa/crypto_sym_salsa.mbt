///===
/// extcore/crypto_sym_salsa

pub(all) struct CryptosymsalsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_salsa_make_point(x : Double, y : Double) -> CryptosymsalsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_salsa_make_point3(x : Double, y : Double, z : Double) -> CryptosymsalsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymsalsaPoint::x(self : CryptosymsalsaPoint) -> Double { self.x }

pub fn CryptosymsalsaPoint::y(self : CryptosymsalsaPoint) -> Double { self.y }

pub fn CryptosymsalsaPoint::z(self : CryptosymsalsaPoint) -> Double { self.z }

pub fn CryptosymsalsaPoint::label(self : CryptosymsalsaPoint) -> Int { self.label }

pub fn CryptosymsalsaPoint::dist(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymsalsaPoint::add(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymsalsaPoint::sub(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymsalsaPoint::scale(self : CryptosymsalsaPoint, s : Double) -> CryptosymsalsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymsalsaPoint::dot(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymsalsaPoint::cross(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymsalsaPoint::norm(self : CryptosymsalsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymsalsaPoint::normalize(self : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymsalsaPoint::negate(self : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymsalsaPoint::mid(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymsalsaPoint::lerp(self : CryptosymsalsaPoint, other : CryptosymsalsaPoint, t : Double) -> CryptosymsalsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymsalsaPoint::to_string(self : CryptosymsalsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymsalsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_salsa_make_series(vals : Array[Double], name : String) -> CryptosymsalsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymsalsaSeries::len(self : CryptosymsalsaSeries) -> Int { self.vals.length() }

pub fn CryptosymsalsaSeries::sum(self : CryptosymsalsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymsalsaSeries::mean(self : CryptosymsalsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymsalsaSeries::min(self : CryptosymsalsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymsalsaSeries::max(self : CryptosymsalsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymsalsaSeries::range(self : CryptosymsalsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymsalsaSeries::variance(self : CryptosymsalsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymsalsaSeries::std(self : CryptosymsalsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymsalsaSeries::median(self : CryptosymsalsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymsalsaSeries::scale(self : CryptosymsalsaSeries, f : Double) -> CryptosymsalsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymsalsaSeries::add(self : CryptosymsalsaSeries, other : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymsalsaSeries::sub(self : CryptosymsalsaSeries, other : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymsalsaSeries::normalize(self : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymsalsaSeries::cumsum(self : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymsalsaSeries::to_string(self : CryptosymsalsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymsalsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_salsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymsalsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_salsa_matrix_identity(n : Int) -> CryptosymsalsaMatrix {
  let m = crypto_sym_salsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymsalsaMatrix::get(self : CryptosymsalsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymsalsaMatrix::transpose(self : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  let result = crypto_sym_salsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymsalsaMatrix::add(self : CryptosymsalsaMatrix, other : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_salsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymsalsaMatrix::scale(self : CryptosymsalsaMatrix, s : Double) -> CryptosymsalsaMatrix {
  let result = crypto_sym_salsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymsalsaMatrix::multiply(self : CryptosymsalsaMatrix, other : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  if self.cols != other.rows { return crypto_sym_salsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_salsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptosymsalsaMatrix::trace(self : CryptosymsalsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymsalsaMatrix::det(self : CryptosymsalsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymsalsaMatrix::norm(self : CryptosymsalsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymsalsaMatrix::to_string(self : CryptosymsalsaMatrix) -> String {
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

pub(all) struct CryptosymsalsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_salsa_make_vector(comps : Array[Double]) -> CryptosymsalsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_salsa_vector_zero(dim : Int) -> CryptosymsalsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymsalsaVector::add(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymsalsaVector::sub(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymsalsaVector::scale(self : CryptosymsalsaVector, s : Double) -> CryptosymsalsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymsalsaVector::dot(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymsalsaVector::norm(self : CryptosymsalsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymsalsaVector::normalize(self : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymsalsaVector::dist(self : CryptosymsalsaVector, other : CryptosymsalsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymsalsaVector::to_string(self : CryptosymsalsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymsalsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_frame_make(size : Int) -> CryptosymsalsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaFrame::len(self : CryptosymsalsaFrame) -> Int { self.size }

pub fn CryptosymsalsaFrame::get(self : CryptosymsalsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaFrame::set(self : CryptosymsalsaFrame, i : Int, v : Double) -> CryptosymsalsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaFrame::sum(self : CryptosymsalsaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaFrame::mean(self : CryptosymsalsaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaFrame::scale(self : CryptosymsalsaFrame, f : Double) -> CryptosymsalsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaFrame::add(self : CryptosymsalsaFrame, other : CryptosymsalsaFrame) -> CryptosymsalsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaFrame::copy(self : CryptosymsalsaFrame) -> CryptosymsalsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaFrame::fill(self : CryptosymsalsaFrame, v : Double) -> CryptosymsalsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaFrame::min(self : CryptosymsalsaFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaFrame::max(self : CryptosymsalsaFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaFrame::to_string(self : CryptosymsalsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_table_make(size : Int) -> CryptosymsalsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaTable::len(self : CryptosymsalsaTable) -> Int { self.size }

pub fn CryptosymsalsaTable::get(self : CryptosymsalsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaTable::set(self : CryptosymsalsaTable, i : Int, v : Double) -> CryptosymsalsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaTable::sum(self : CryptosymsalsaTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaTable::mean(self : CryptosymsalsaTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaTable::scale(self : CryptosymsalsaTable, f : Double) -> CryptosymsalsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaTable::add(self : CryptosymsalsaTable, other : CryptosymsalsaTable) -> CryptosymsalsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaTable::copy(self : CryptosymsalsaTable) -> CryptosymsalsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaTable::fill(self : CryptosymsalsaTable, v : Double) -> CryptosymsalsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaTable::min(self : CryptosymsalsaTable) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaTable::max(self : CryptosymsalsaTable) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaTable::to_string(self : CryptosymsalsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_graphn_make(size : Int) -> CryptosymsalsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaGraphN::len(self : CryptosymsalsaGraphN) -> Int { self.size }

pub fn CryptosymsalsaGraphN::get(self : CryptosymsalsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaGraphN::set(self : CryptosymsalsaGraphN, i : Int, v : Double) -> CryptosymsalsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaGraphN::sum(self : CryptosymsalsaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaGraphN::mean(self : CryptosymsalsaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaGraphN::scale(self : CryptosymsalsaGraphN, f : Double) -> CryptosymsalsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaGraphN::add(self : CryptosymsalsaGraphN, other : CryptosymsalsaGraphN) -> CryptosymsalsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaGraphN::copy(self : CryptosymsalsaGraphN) -> CryptosymsalsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaGraphN::fill(self : CryptosymsalsaGraphN, v : Double) -> CryptosymsalsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaGraphN::min(self : CryptosymsalsaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaGraphN::max(self : CryptosymsalsaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaGraphN::to_string(self : CryptosymsalsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_node_make(size : Int) -> CryptosymsalsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaNode::len(self : CryptosymsalsaNode) -> Int { self.size }

pub fn CryptosymsalsaNode::get(self : CryptosymsalsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaNode::set(self : CryptosymsalsaNode, i : Int, v : Double) -> CryptosymsalsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaNode::sum(self : CryptosymsalsaNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaNode::mean(self : CryptosymsalsaNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaNode::scale(self : CryptosymsalsaNode, f : Double) -> CryptosymsalsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaNode::add(self : CryptosymsalsaNode, other : CryptosymsalsaNode) -> CryptosymsalsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaNode::copy(self : CryptosymsalsaNode) -> CryptosymsalsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaNode::fill(self : CryptosymsalsaNode, v : Double) -> CryptosymsalsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaNode::min(self : CryptosymsalsaNode) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaNode::max(self : CryptosymsalsaNode) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaNode::to_string(self : CryptosymsalsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_edge_make(size : Int) -> CryptosymsalsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaEdge::len(self : CryptosymsalsaEdge) -> Int { self.size }

pub fn CryptosymsalsaEdge::get(self : CryptosymsalsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaEdge::set(self : CryptosymsalsaEdge, i : Int, v : Double) -> CryptosymsalsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaEdge::sum(self : CryptosymsalsaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaEdge::mean(self : CryptosymsalsaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaEdge::scale(self : CryptosymsalsaEdge, f : Double) -> CryptosymsalsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaEdge::add(self : CryptosymsalsaEdge, other : CryptosymsalsaEdge) -> CryptosymsalsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaEdge::copy(self : CryptosymsalsaEdge) -> CryptosymsalsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaEdge::fill(self : CryptosymsalsaEdge, v : Double) -> CryptosymsalsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaEdge::min(self : CryptosymsalsaEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaEdge::max(self : CryptosymsalsaEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaEdge::to_string(self : CryptosymsalsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_path_make(size : Int) -> CryptosymsalsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaPath::len(self : CryptosymsalsaPath) -> Int { self.size }

pub fn CryptosymsalsaPath::get(self : CryptosymsalsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaPath::set(self : CryptosymsalsaPath, i : Int, v : Double) -> CryptosymsalsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaPath::sum(self : CryptosymsalsaPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaPath::mean(self : CryptosymsalsaPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaPath::scale(self : CryptosymsalsaPath, f : Double) -> CryptosymsalsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaPath::add(self : CryptosymsalsaPath, other : CryptosymsalsaPath) -> CryptosymsalsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaPath::copy(self : CryptosymsalsaPath) -> CryptosymsalsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaPath::fill(self : CryptosymsalsaPath, v : Double) -> CryptosymsalsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaPath::min(self : CryptosymsalsaPath) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaPath::max(self : CryptosymsalsaPath) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaPath::to_string(self : CryptosymsalsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_cluster_make(size : Int) -> CryptosymsalsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaCluster::len(self : CryptosymsalsaCluster) -> Int { self.size }

pub fn CryptosymsalsaCluster::get(self : CryptosymsalsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaCluster::set(self : CryptosymsalsaCluster, i : Int, v : Double) -> CryptosymsalsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCluster::sum(self : CryptosymsalsaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaCluster::mean(self : CryptosymsalsaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaCluster::scale(self : CryptosymsalsaCluster, f : Double) -> CryptosymsalsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCluster::add(self : CryptosymsalsaCluster, other : CryptosymsalsaCluster) -> CryptosymsalsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaCluster::copy(self : CryptosymsalsaCluster) -> CryptosymsalsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCluster::fill(self : CryptosymsalsaCluster, v : Double) -> CryptosymsalsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCluster::min(self : CryptosymsalsaCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaCluster::max(self : CryptosymsalsaCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaCluster::to_string(self : CryptosymsalsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_model_make(size : Int) -> CryptosymsalsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaModel::len(self : CryptosymsalsaModel) -> Int { self.size }

pub fn CryptosymsalsaModel::get(self : CryptosymsalsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaModel::set(self : CryptosymsalsaModel, i : Int, v : Double) -> CryptosymsalsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaModel::sum(self : CryptosymsalsaModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaModel::mean(self : CryptosymsalsaModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaModel::scale(self : CryptosymsalsaModel, f : Double) -> CryptosymsalsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaModel::add(self : CryptosymsalsaModel, other : CryptosymsalsaModel) -> CryptosymsalsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaModel::copy(self : CryptosymsalsaModel) -> CryptosymsalsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaModel::fill(self : CryptosymsalsaModel, v : Double) -> CryptosymsalsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaModel::min(self : CryptosymsalsaModel) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaModel::max(self : CryptosymsalsaModel) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaModel::to_string(self : CryptosymsalsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_layer_make(size : Int) -> CryptosymsalsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaLayer::len(self : CryptosymsalsaLayer) -> Int { self.size }

pub fn CryptosymsalsaLayer::get(self : CryptosymsalsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaLayer::set(self : CryptosymsalsaLayer, i : Int, v : Double) -> CryptosymsalsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaLayer::sum(self : CryptosymsalsaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaLayer::mean(self : CryptosymsalsaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaLayer::scale(self : CryptosymsalsaLayer, f : Double) -> CryptosymsalsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaLayer::add(self : CryptosymsalsaLayer, other : CryptosymsalsaLayer) -> CryptosymsalsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaLayer::copy(self : CryptosymsalsaLayer) -> CryptosymsalsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaLayer::fill(self : CryptosymsalsaLayer, v : Double) -> CryptosymsalsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaLayer::min(self : CryptosymsalsaLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaLayer::max(self : CryptosymsalsaLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaLayer::to_string(self : CryptosymsalsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_buffer_make(size : Int) -> CryptosymsalsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaBuffer::len(self : CryptosymsalsaBuffer) -> Int { self.size }

pub fn CryptosymsalsaBuffer::get(self : CryptosymsalsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaBuffer::set(self : CryptosymsalsaBuffer, i : Int, v : Double) -> CryptosymsalsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaBuffer::sum(self : CryptosymsalsaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaBuffer::mean(self : CryptosymsalsaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaBuffer::scale(self : CryptosymsalsaBuffer, f : Double) -> CryptosymsalsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaBuffer::add(self : CryptosymsalsaBuffer, other : CryptosymsalsaBuffer) -> CryptosymsalsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaBuffer::copy(self : CryptosymsalsaBuffer) -> CryptosymsalsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaBuffer::fill(self : CryptosymsalsaBuffer, v : Double) -> CryptosymsalsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaBuffer::min(self : CryptosymsalsaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaBuffer::max(self : CryptosymsalsaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaBuffer::to_string(self : CryptosymsalsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_cursor_make(size : Int) -> CryptosymsalsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaCursor::len(self : CryptosymsalsaCursor) -> Int { self.size }

pub fn CryptosymsalsaCursor::get(self : CryptosymsalsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaCursor::set(self : CryptosymsalsaCursor, i : Int, v : Double) -> CryptosymsalsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCursor::sum(self : CryptosymsalsaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaCursor::mean(self : CryptosymsalsaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaCursor::scale(self : CryptosymsalsaCursor, f : Double) -> CryptosymsalsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCursor::add(self : CryptosymsalsaCursor, other : CryptosymsalsaCursor) -> CryptosymsalsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaCursor::copy(self : CryptosymsalsaCursor) -> CryptosymsalsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCursor::fill(self : CryptosymsalsaCursor, v : Double) -> CryptosymsalsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaCursor::min(self : CryptosymsalsaCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaCursor::max(self : CryptosymsalsaCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaCursor::to_string(self : CryptosymsalsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_view_make(size : Int) -> CryptosymsalsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaView::len(self : CryptosymsalsaView) -> Int { self.size }

pub fn CryptosymsalsaView::get(self : CryptosymsalsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaView::set(self : CryptosymsalsaView, i : Int, v : Double) -> CryptosymsalsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaView::sum(self : CryptosymsalsaView) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaView::mean(self : CryptosymsalsaView) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaView::scale(self : CryptosymsalsaView, f : Double) -> CryptosymsalsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaView::add(self : CryptosymsalsaView, other : CryptosymsalsaView) -> CryptosymsalsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaView::copy(self : CryptosymsalsaView) -> CryptosymsalsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaView::fill(self : CryptosymsalsaView, v : Double) -> CryptosymsalsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaView::min(self : CryptosymsalsaView) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaView::max(self : CryptosymsalsaView) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaView::to_string(self : CryptosymsalsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_range_make(size : Int) -> CryptosymsalsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaRange::len(self : CryptosymsalsaRange) -> Int { self.size }

pub fn CryptosymsalsaRange::get(self : CryptosymsalsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaRange::set(self : CryptosymsalsaRange, i : Int, v : Double) -> CryptosymsalsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaRange::sum(self : CryptosymsalsaRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaRange::mean(self : CryptosymsalsaRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaRange::scale(self : CryptosymsalsaRange, f : Double) -> CryptosymsalsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaRange::add(self : CryptosymsalsaRange, other : CryptosymsalsaRange) -> CryptosymsalsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaRange::copy(self : CryptosymsalsaRange) -> CryptosymsalsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaRange::fill(self : CryptosymsalsaRange, v : Double) -> CryptosymsalsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaRange::min(self : CryptosymsalsaRange) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaRange::max(self : CryptosymsalsaRange) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaRange::to_string(self : CryptosymsalsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_slice_make(size : Int) -> CryptosymsalsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymsalsaSlice::len(self : CryptosymsalsaSlice) -> Int { self.size }

pub fn CryptosymsalsaSlice::get(self : CryptosymsalsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymsalsaSlice::set(self : CryptosymsalsaSlice, i : Int, v : Double) -> CryptosymsalsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaSlice::sum(self : CryptosymsalsaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymsalsaSlice::mean(self : CryptosymsalsaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymsalsaSlice::scale(self : CryptosymsalsaSlice, f : Double) -> CryptosymsalsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaSlice::add(self : CryptosymsalsaSlice, other : CryptosymsalsaSlice) -> CryptosymsalsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymsalsaSlice::copy(self : CryptosymsalsaSlice) -> CryptosymsalsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaSlice::fill(self : CryptosymsalsaSlice, v : Double) -> CryptosymsalsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymsalsaSlice::min(self : CryptosymsalsaSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymsalsaSlice::max(self : CryptosymsalsaSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymsalsaSlice::to_string(self : CryptosymsalsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

