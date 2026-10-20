///===
/// extcore/crypto_asym_ecies

pub(all) struct CryptoasymeciesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecies_make_point(x : Double, y : Double) -> CryptoasymeciesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecies_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeciesPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymeciesPoint::x(self : CryptoasymeciesPoint) -> Double { self.x }

pub fn CryptoasymeciesPoint::y(self : CryptoasymeciesPoint) -> Double { self.y }

pub fn CryptoasymeciesPoint::z(self : CryptoasymeciesPoint) -> Double { self.z }

pub fn CryptoasymeciesPoint::label(self : CryptoasymeciesPoint) -> Int { self.label }

pub fn CryptoasymeciesPoint::dist(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymeciesPoint::add(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymeciesPoint::sub(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymeciesPoint::scale(self : CryptoasymeciesPoint, s : Double) -> CryptoasymeciesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymeciesPoint::dot(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymeciesPoint::cross(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymeciesPoint::norm(self : CryptoasymeciesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymeciesPoint::normalize(self : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeciesPoint::negate(self : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymeciesPoint::mid(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymeciesPoint::lerp(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint, t : Double) -> CryptoasymeciesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymeciesPoint::to_string(self : CryptoasymeciesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymeciesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecies_make_series(vals : Array[Double], name : String) -> CryptoasymeciesSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymeciesSeries::len(self : CryptoasymeciesSeries) -> Int { self.vals.length() }

pub fn CryptoasymeciesSeries::sum(self : CryptoasymeciesSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymeciesSeries::mean(self : CryptoasymeciesSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymeciesSeries::min(self : CryptoasymeciesSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymeciesSeries::max(self : CryptoasymeciesSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymeciesSeries::range(self : CryptoasymeciesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymeciesSeries::variance(self : CryptoasymeciesSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymeciesSeries::std(self : CryptoasymeciesSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymeciesSeries::median(self : CryptoasymeciesSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymeciesSeries::scale(self : CryptoasymeciesSeries, f : Double) -> CryptoasymeciesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymeciesSeries::add(self : CryptoasymeciesSeries, other : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymeciesSeries::sub(self : CryptoasymeciesSeries, other : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymeciesSeries::normalize(self : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymeciesSeries::cumsum(self : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymeciesSeries::to_string(self : CryptoasymeciesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeciesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecies_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeciesMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_asym_ecies_matrix_identity(n : Int) -> CryptoasymeciesMatrix {
  let m = crypto_asym_ecies_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymeciesMatrix::get(self : CryptoasymeciesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymeciesMatrix::transpose(self : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  let result = crypto_asym_ecies_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymeciesMatrix::add(self : CryptoasymeciesMatrix, other : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_ecies_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymeciesMatrix::scale(self : CryptoasymeciesMatrix, s : Double) -> CryptoasymeciesMatrix {
  let result = crypto_asym_ecies_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymeciesMatrix::multiply(self : CryptoasymeciesMatrix, other : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  if self.cols != other.rows { return crypto_asym_ecies_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_ecies_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptoasymeciesMatrix::trace(self : CryptoasymeciesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymeciesMatrix::det(self : CryptoasymeciesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymeciesMatrix::norm(self : CryptoasymeciesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymeciesMatrix::to_string(self : CryptoasymeciesMatrix) -> String {
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

pub(all) struct CryptoasymeciesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecies_make_vector(comps : Array[Double]) -> CryptoasymeciesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecies_vector_zero(dim : Int) -> CryptoasymeciesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymeciesVector::add(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeciesVector::sub(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeciesVector::scale(self : CryptoasymeciesVector, s : Double) -> CryptoasymeciesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymeciesVector::dot(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymeciesVector::norm(self : CryptoasymeciesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymeciesVector::normalize(self : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeciesVector::dist(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymeciesVector::to_string(self : CryptoasymeciesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeciesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_frame_make(size : Int) -> CryptoasymeciesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesFrame::len(self : CryptoasymeciesFrame) -> Int { self.size }

pub fn CryptoasymeciesFrame::get(self : CryptoasymeciesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesFrame::set(self : CryptoasymeciesFrame, i : Int, v : Double) -> CryptoasymeciesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesFrame::sum(self : CryptoasymeciesFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesFrame::mean(self : CryptoasymeciesFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesFrame::scale(self : CryptoasymeciesFrame, f : Double) -> CryptoasymeciesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesFrame::add(self : CryptoasymeciesFrame, other : CryptoasymeciesFrame) -> CryptoasymeciesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesFrame::copy(self : CryptoasymeciesFrame) -> CryptoasymeciesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesFrame::fill(self : CryptoasymeciesFrame, v : Double) -> CryptoasymeciesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesFrame::min(self : CryptoasymeciesFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesFrame::max(self : CryptoasymeciesFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesFrame::to_string(self : CryptoasymeciesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_table_make(size : Int) -> CryptoasymeciesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesTable::len(self : CryptoasymeciesTable) -> Int { self.size }

pub fn CryptoasymeciesTable::get(self : CryptoasymeciesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesTable::set(self : CryptoasymeciesTable, i : Int, v : Double) -> CryptoasymeciesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesTable::sum(self : CryptoasymeciesTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesTable::mean(self : CryptoasymeciesTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesTable::scale(self : CryptoasymeciesTable, f : Double) -> CryptoasymeciesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesTable::add(self : CryptoasymeciesTable, other : CryptoasymeciesTable) -> CryptoasymeciesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesTable::copy(self : CryptoasymeciesTable) -> CryptoasymeciesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesTable::fill(self : CryptoasymeciesTable, v : Double) -> CryptoasymeciesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesTable::min(self : CryptoasymeciesTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesTable::max(self : CryptoasymeciesTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesTable::to_string(self : CryptoasymeciesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_graphn_make(size : Int) -> CryptoasymeciesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesGraphN::len(self : CryptoasymeciesGraphN) -> Int { self.size }

pub fn CryptoasymeciesGraphN::get(self : CryptoasymeciesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesGraphN::set(self : CryptoasymeciesGraphN, i : Int, v : Double) -> CryptoasymeciesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesGraphN::sum(self : CryptoasymeciesGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesGraphN::mean(self : CryptoasymeciesGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesGraphN::scale(self : CryptoasymeciesGraphN, f : Double) -> CryptoasymeciesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesGraphN::add(self : CryptoasymeciesGraphN, other : CryptoasymeciesGraphN) -> CryptoasymeciesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesGraphN::copy(self : CryptoasymeciesGraphN) -> CryptoasymeciesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesGraphN::fill(self : CryptoasymeciesGraphN, v : Double) -> CryptoasymeciesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesGraphN::min(self : CryptoasymeciesGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesGraphN::max(self : CryptoasymeciesGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesGraphN::to_string(self : CryptoasymeciesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_node_make(size : Int) -> CryptoasymeciesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesNode::len(self : CryptoasymeciesNode) -> Int { self.size }

pub fn CryptoasymeciesNode::get(self : CryptoasymeciesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesNode::set(self : CryptoasymeciesNode, i : Int, v : Double) -> CryptoasymeciesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesNode::sum(self : CryptoasymeciesNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesNode::mean(self : CryptoasymeciesNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesNode::scale(self : CryptoasymeciesNode, f : Double) -> CryptoasymeciesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesNode::add(self : CryptoasymeciesNode, other : CryptoasymeciesNode) -> CryptoasymeciesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesNode::copy(self : CryptoasymeciesNode) -> CryptoasymeciesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesNode::fill(self : CryptoasymeciesNode, v : Double) -> CryptoasymeciesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesNode::min(self : CryptoasymeciesNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesNode::max(self : CryptoasymeciesNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesNode::to_string(self : CryptoasymeciesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_edge_make(size : Int) -> CryptoasymeciesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesEdge::len(self : CryptoasymeciesEdge) -> Int { self.size }

pub fn CryptoasymeciesEdge::get(self : CryptoasymeciesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesEdge::set(self : CryptoasymeciesEdge, i : Int, v : Double) -> CryptoasymeciesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesEdge::sum(self : CryptoasymeciesEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesEdge::mean(self : CryptoasymeciesEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesEdge::scale(self : CryptoasymeciesEdge, f : Double) -> CryptoasymeciesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesEdge::add(self : CryptoasymeciesEdge, other : CryptoasymeciesEdge) -> CryptoasymeciesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesEdge::copy(self : CryptoasymeciesEdge) -> CryptoasymeciesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesEdge::fill(self : CryptoasymeciesEdge, v : Double) -> CryptoasymeciesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesEdge::min(self : CryptoasymeciesEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesEdge::max(self : CryptoasymeciesEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesEdge::to_string(self : CryptoasymeciesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_path_make(size : Int) -> CryptoasymeciesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesPath::len(self : CryptoasymeciesPath) -> Int { self.size }

pub fn CryptoasymeciesPath::get(self : CryptoasymeciesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesPath::set(self : CryptoasymeciesPath, i : Int, v : Double) -> CryptoasymeciesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesPath::sum(self : CryptoasymeciesPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesPath::mean(self : CryptoasymeciesPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesPath::scale(self : CryptoasymeciesPath, f : Double) -> CryptoasymeciesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesPath::add(self : CryptoasymeciesPath, other : CryptoasymeciesPath) -> CryptoasymeciesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesPath::copy(self : CryptoasymeciesPath) -> CryptoasymeciesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesPath::fill(self : CryptoasymeciesPath, v : Double) -> CryptoasymeciesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesPath::min(self : CryptoasymeciesPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesPath::max(self : CryptoasymeciesPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesPath::to_string(self : CryptoasymeciesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_cluster_make(size : Int) -> CryptoasymeciesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesCluster::len(self : CryptoasymeciesCluster) -> Int { self.size }

pub fn CryptoasymeciesCluster::get(self : CryptoasymeciesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesCluster::set(self : CryptoasymeciesCluster, i : Int, v : Double) -> CryptoasymeciesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCluster::sum(self : CryptoasymeciesCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesCluster::mean(self : CryptoasymeciesCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesCluster::scale(self : CryptoasymeciesCluster, f : Double) -> CryptoasymeciesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCluster::add(self : CryptoasymeciesCluster, other : CryptoasymeciesCluster) -> CryptoasymeciesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesCluster::copy(self : CryptoasymeciesCluster) -> CryptoasymeciesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCluster::fill(self : CryptoasymeciesCluster, v : Double) -> CryptoasymeciesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCluster::min(self : CryptoasymeciesCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesCluster::max(self : CryptoasymeciesCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesCluster::to_string(self : CryptoasymeciesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_model_make(size : Int) -> CryptoasymeciesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesModel::len(self : CryptoasymeciesModel) -> Int { self.size }

pub fn CryptoasymeciesModel::get(self : CryptoasymeciesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesModel::set(self : CryptoasymeciesModel, i : Int, v : Double) -> CryptoasymeciesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesModel::sum(self : CryptoasymeciesModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesModel::mean(self : CryptoasymeciesModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesModel::scale(self : CryptoasymeciesModel, f : Double) -> CryptoasymeciesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesModel::add(self : CryptoasymeciesModel, other : CryptoasymeciesModel) -> CryptoasymeciesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesModel::copy(self : CryptoasymeciesModel) -> CryptoasymeciesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesModel::fill(self : CryptoasymeciesModel, v : Double) -> CryptoasymeciesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesModel::min(self : CryptoasymeciesModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesModel::max(self : CryptoasymeciesModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesModel::to_string(self : CryptoasymeciesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_layer_make(size : Int) -> CryptoasymeciesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesLayer::len(self : CryptoasymeciesLayer) -> Int { self.size }

pub fn CryptoasymeciesLayer::get(self : CryptoasymeciesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesLayer::set(self : CryptoasymeciesLayer, i : Int, v : Double) -> CryptoasymeciesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesLayer::sum(self : CryptoasymeciesLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesLayer::mean(self : CryptoasymeciesLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesLayer::scale(self : CryptoasymeciesLayer, f : Double) -> CryptoasymeciesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesLayer::add(self : CryptoasymeciesLayer, other : CryptoasymeciesLayer) -> CryptoasymeciesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesLayer::copy(self : CryptoasymeciesLayer) -> CryptoasymeciesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesLayer::fill(self : CryptoasymeciesLayer, v : Double) -> CryptoasymeciesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesLayer::min(self : CryptoasymeciesLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesLayer::max(self : CryptoasymeciesLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesLayer::to_string(self : CryptoasymeciesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_buffer_make(size : Int) -> CryptoasymeciesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesBuffer::len(self : CryptoasymeciesBuffer) -> Int { self.size }

pub fn CryptoasymeciesBuffer::get(self : CryptoasymeciesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesBuffer::set(self : CryptoasymeciesBuffer, i : Int, v : Double) -> CryptoasymeciesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesBuffer::sum(self : CryptoasymeciesBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesBuffer::mean(self : CryptoasymeciesBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesBuffer::scale(self : CryptoasymeciesBuffer, f : Double) -> CryptoasymeciesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesBuffer::add(self : CryptoasymeciesBuffer, other : CryptoasymeciesBuffer) -> CryptoasymeciesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesBuffer::copy(self : CryptoasymeciesBuffer) -> CryptoasymeciesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesBuffer::fill(self : CryptoasymeciesBuffer, v : Double) -> CryptoasymeciesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesBuffer::min(self : CryptoasymeciesBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesBuffer::max(self : CryptoasymeciesBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesBuffer::to_string(self : CryptoasymeciesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_cursor_make(size : Int) -> CryptoasymeciesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesCursor::len(self : CryptoasymeciesCursor) -> Int { self.size }

pub fn CryptoasymeciesCursor::get(self : CryptoasymeciesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesCursor::set(self : CryptoasymeciesCursor, i : Int, v : Double) -> CryptoasymeciesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCursor::sum(self : CryptoasymeciesCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesCursor::mean(self : CryptoasymeciesCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesCursor::scale(self : CryptoasymeciesCursor, f : Double) -> CryptoasymeciesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCursor::add(self : CryptoasymeciesCursor, other : CryptoasymeciesCursor) -> CryptoasymeciesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesCursor::copy(self : CryptoasymeciesCursor) -> CryptoasymeciesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCursor::fill(self : CryptoasymeciesCursor, v : Double) -> CryptoasymeciesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesCursor::min(self : CryptoasymeciesCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesCursor::max(self : CryptoasymeciesCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesCursor::to_string(self : CryptoasymeciesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_view_make(size : Int) -> CryptoasymeciesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesView::len(self : CryptoasymeciesView) -> Int { self.size }

pub fn CryptoasymeciesView::get(self : CryptoasymeciesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesView::set(self : CryptoasymeciesView, i : Int, v : Double) -> CryptoasymeciesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesView::sum(self : CryptoasymeciesView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesView::mean(self : CryptoasymeciesView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesView::scale(self : CryptoasymeciesView, f : Double) -> CryptoasymeciesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesView::add(self : CryptoasymeciesView, other : CryptoasymeciesView) -> CryptoasymeciesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesView::copy(self : CryptoasymeciesView) -> CryptoasymeciesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesView::fill(self : CryptoasymeciesView, v : Double) -> CryptoasymeciesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesView::min(self : CryptoasymeciesView) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesView::max(self : CryptoasymeciesView) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesView::to_string(self : CryptoasymeciesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_range_make(size : Int) -> CryptoasymeciesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesRange::len(self : CryptoasymeciesRange) -> Int { self.size }

pub fn CryptoasymeciesRange::get(self : CryptoasymeciesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesRange::set(self : CryptoasymeciesRange, i : Int, v : Double) -> CryptoasymeciesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesRange::sum(self : CryptoasymeciesRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesRange::mean(self : CryptoasymeciesRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesRange::scale(self : CryptoasymeciesRange, f : Double) -> CryptoasymeciesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesRange::add(self : CryptoasymeciesRange, other : CryptoasymeciesRange) -> CryptoasymeciesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesRange::copy(self : CryptoasymeciesRange) -> CryptoasymeciesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesRange::fill(self : CryptoasymeciesRange, v : Double) -> CryptoasymeciesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesRange::min(self : CryptoasymeciesRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesRange::max(self : CryptoasymeciesRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesRange::to_string(self : CryptoasymeciesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_slice_make(size : Int) -> CryptoasymeciesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeciesSlice::len(self : CryptoasymeciesSlice) -> Int { self.size }

pub fn CryptoasymeciesSlice::get(self : CryptoasymeciesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeciesSlice::set(self : CryptoasymeciesSlice, i : Int, v : Double) -> CryptoasymeciesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesSlice::sum(self : CryptoasymeciesSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeciesSlice::mean(self : CryptoasymeciesSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeciesSlice::scale(self : CryptoasymeciesSlice, f : Double) -> CryptoasymeciesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesSlice::add(self : CryptoasymeciesSlice, other : CryptoasymeciesSlice) -> CryptoasymeciesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeciesSlice::copy(self : CryptoasymeciesSlice) -> CryptoasymeciesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesSlice::fill(self : CryptoasymeciesSlice, v : Double) -> CryptoasymeciesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeciesSlice::min(self : CryptoasymeciesSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymeciesSlice::max(self : CryptoasymeciesSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymeciesSlice::to_string(self : CryptoasymeciesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

