///===
/// extcore/crypto_asym_dh

pub(all) struct CryptoasymdhPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_dh_make_point(x : Double, y : Double) -> CryptoasymdhPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_dh_make_point3(x : Double, y : Double, z : Double) -> CryptoasymdhPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymdhPoint::x(self : CryptoasymdhPoint) -> Double { self.x }

pub fn CryptoasymdhPoint::y(self : CryptoasymdhPoint) -> Double { self.y }

pub fn CryptoasymdhPoint::z(self : CryptoasymdhPoint) -> Double { self.z }

pub fn CryptoasymdhPoint::label(self : CryptoasymdhPoint) -> Int { self.label }

pub fn CryptoasymdhPoint::dist(self : CryptoasymdhPoint, other : CryptoasymdhPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymdhPoint::add(self : CryptoasymdhPoint, other : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymdhPoint::sub(self : CryptoasymdhPoint, other : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymdhPoint::scale(self : CryptoasymdhPoint, s : Double) -> CryptoasymdhPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymdhPoint::dot(self : CryptoasymdhPoint, other : CryptoasymdhPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymdhPoint::cross(self : CryptoasymdhPoint, other : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymdhPoint::norm(self : CryptoasymdhPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymdhPoint::normalize(self : CryptoasymdhPoint) -> CryptoasymdhPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymdhPoint::negate(self : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymdhPoint::mid(self : CryptoasymdhPoint, other : CryptoasymdhPoint) -> CryptoasymdhPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymdhPoint::lerp(self : CryptoasymdhPoint, other : CryptoasymdhPoint, t : Double) -> CryptoasymdhPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymdhPoint::to_string(self : CryptoasymdhPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymdhSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_dh_make_series(vals : Array[Double], name : String) -> CryptoasymdhSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymdhSeries::len(self : CryptoasymdhSeries) -> Int { self.vals.length() }

pub fn CryptoasymdhSeries::sum(self : CryptoasymdhSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymdhSeries::mean(self : CryptoasymdhSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymdhSeries::min(self : CryptoasymdhSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymdhSeries::max(self : CryptoasymdhSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymdhSeries::range(self : CryptoasymdhSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymdhSeries::variance(self : CryptoasymdhSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymdhSeries::std(self : CryptoasymdhSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymdhSeries::median(self : CryptoasymdhSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymdhSeries::scale(self : CryptoasymdhSeries, f : Double) -> CryptoasymdhSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymdhSeries::add(self : CryptoasymdhSeries, other : CryptoasymdhSeries) -> CryptoasymdhSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymdhSeries::sub(self : CryptoasymdhSeries, other : CryptoasymdhSeries) -> CryptoasymdhSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymdhSeries::normalize(self : CryptoasymdhSeries) -> CryptoasymdhSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymdhSeries::cumsum(self : CryptoasymdhSeries) -> CryptoasymdhSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymdhSeries::to_string(self : CryptoasymdhSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymdhMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_dh_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymdhMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_dh_matrix_identity(n : Int) -> CryptoasymdhMatrix {
  let m = crypto_asym_dh_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymdhMatrix::get(self : CryptoasymdhMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymdhMatrix::transpose(self : CryptoasymdhMatrix) -> CryptoasymdhMatrix {
  let result = crypto_asym_dh_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymdhMatrix::add(self : CryptoasymdhMatrix, other : CryptoasymdhMatrix) -> CryptoasymdhMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_dh_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymdhMatrix::scale(self : CryptoasymdhMatrix, s : Double) -> CryptoasymdhMatrix {
  let result = crypto_asym_dh_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymdhMatrix::multiply(self : CryptoasymdhMatrix, other : CryptoasymdhMatrix) -> CryptoasymdhMatrix {
  if self.cols != other.rows { return crypto_asym_dh_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_dh_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptoasymdhMatrix::trace(self : CryptoasymdhMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymdhMatrix::det(self : CryptoasymdhMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymdhMatrix::norm(self : CryptoasymdhMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymdhMatrix::to_string(self : CryptoasymdhMatrix) -> String {
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

pub(all) struct CryptoasymdhVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_dh_make_vector(comps : Array[Double]) -> CryptoasymdhVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_dh_vector_zero(dim : Int) -> CryptoasymdhVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymdhVector::add(self : CryptoasymdhVector, other : CryptoasymdhVector) -> CryptoasymdhVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymdhVector::sub(self : CryptoasymdhVector, other : CryptoasymdhVector) -> CryptoasymdhVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymdhVector::scale(self : CryptoasymdhVector, s : Double) -> CryptoasymdhVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymdhVector::dot(self : CryptoasymdhVector, other : CryptoasymdhVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymdhVector::norm(self : CryptoasymdhVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymdhVector::normalize(self : CryptoasymdhVector) -> CryptoasymdhVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymdhVector::dist(self : CryptoasymdhVector, other : CryptoasymdhVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymdhVector::to_string(self : CryptoasymdhVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymdhFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_frame_make(size : Int) -> CryptoasymdhFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhFrame::len(self : CryptoasymdhFrame) -> Int { self.size }

pub fn CryptoasymdhFrame::get(self : CryptoasymdhFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhFrame::set(self : CryptoasymdhFrame, i : Int, v : Double) -> CryptoasymdhFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhFrame::sum(self : CryptoasymdhFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhFrame::mean(self : CryptoasymdhFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhFrame::scale(self : CryptoasymdhFrame, f : Double) -> CryptoasymdhFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhFrame::add(self : CryptoasymdhFrame, other : CryptoasymdhFrame) -> CryptoasymdhFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhFrame::copy(self : CryptoasymdhFrame) -> CryptoasymdhFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhFrame::fill(self : CryptoasymdhFrame, v : Double) -> CryptoasymdhFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhFrame::min(self : CryptoasymdhFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhFrame::max(self : CryptoasymdhFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhFrame::to_string(self : CryptoasymdhFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_table_make(size : Int) -> CryptoasymdhTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhTable::len(self : CryptoasymdhTable) -> Int { self.size }

pub fn CryptoasymdhTable::get(self : CryptoasymdhTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhTable::set(self : CryptoasymdhTable, i : Int, v : Double) -> CryptoasymdhTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhTable::sum(self : CryptoasymdhTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhTable::mean(self : CryptoasymdhTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhTable::scale(self : CryptoasymdhTable, f : Double) -> CryptoasymdhTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhTable::add(self : CryptoasymdhTable, other : CryptoasymdhTable) -> CryptoasymdhTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhTable::copy(self : CryptoasymdhTable) -> CryptoasymdhTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhTable::fill(self : CryptoasymdhTable, v : Double) -> CryptoasymdhTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhTable::min(self : CryptoasymdhTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhTable::max(self : CryptoasymdhTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhTable::to_string(self : CryptoasymdhTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_graphn_make(size : Int) -> CryptoasymdhGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhGraphN::len(self : CryptoasymdhGraphN) -> Int { self.size }

pub fn CryptoasymdhGraphN::get(self : CryptoasymdhGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhGraphN::set(self : CryptoasymdhGraphN, i : Int, v : Double) -> CryptoasymdhGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhGraphN::sum(self : CryptoasymdhGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhGraphN::mean(self : CryptoasymdhGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhGraphN::scale(self : CryptoasymdhGraphN, f : Double) -> CryptoasymdhGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhGraphN::add(self : CryptoasymdhGraphN, other : CryptoasymdhGraphN) -> CryptoasymdhGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhGraphN::copy(self : CryptoasymdhGraphN) -> CryptoasymdhGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhGraphN::fill(self : CryptoasymdhGraphN, v : Double) -> CryptoasymdhGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhGraphN::min(self : CryptoasymdhGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhGraphN::max(self : CryptoasymdhGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhGraphN::to_string(self : CryptoasymdhGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_node_make(size : Int) -> CryptoasymdhNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhNode::len(self : CryptoasymdhNode) -> Int { self.size }

pub fn CryptoasymdhNode::get(self : CryptoasymdhNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhNode::set(self : CryptoasymdhNode, i : Int, v : Double) -> CryptoasymdhNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhNode::sum(self : CryptoasymdhNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhNode::mean(self : CryptoasymdhNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhNode::scale(self : CryptoasymdhNode, f : Double) -> CryptoasymdhNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhNode::add(self : CryptoasymdhNode, other : CryptoasymdhNode) -> CryptoasymdhNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhNode::copy(self : CryptoasymdhNode) -> CryptoasymdhNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhNode::fill(self : CryptoasymdhNode, v : Double) -> CryptoasymdhNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhNode::min(self : CryptoasymdhNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhNode::max(self : CryptoasymdhNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhNode::to_string(self : CryptoasymdhNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_edge_make(size : Int) -> CryptoasymdhEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhEdge::len(self : CryptoasymdhEdge) -> Int { self.size }

pub fn CryptoasymdhEdge::get(self : CryptoasymdhEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhEdge::set(self : CryptoasymdhEdge, i : Int, v : Double) -> CryptoasymdhEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhEdge::sum(self : CryptoasymdhEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhEdge::mean(self : CryptoasymdhEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhEdge::scale(self : CryptoasymdhEdge, f : Double) -> CryptoasymdhEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhEdge::add(self : CryptoasymdhEdge, other : CryptoasymdhEdge) -> CryptoasymdhEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhEdge::copy(self : CryptoasymdhEdge) -> CryptoasymdhEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhEdge::fill(self : CryptoasymdhEdge, v : Double) -> CryptoasymdhEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhEdge::min(self : CryptoasymdhEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhEdge::max(self : CryptoasymdhEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhEdge::to_string(self : CryptoasymdhEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_path_make(size : Int) -> CryptoasymdhPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhPath::len(self : CryptoasymdhPath) -> Int { self.size }

pub fn CryptoasymdhPath::get(self : CryptoasymdhPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhPath::set(self : CryptoasymdhPath, i : Int, v : Double) -> CryptoasymdhPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhPath::sum(self : CryptoasymdhPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhPath::mean(self : CryptoasymdhPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhPath::scale(self : CryptoasymdhPath, f : Double) -> CryptoasymdhPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhPath::add(self : CryptoasymdhPath, other : CryptoasymdhPath) -> CryptoasymdhPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhPath::copy(self : CryptoasymdhPath) -> CryptoasymdhPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhPath::fill(self : CryptoasymdhPath, v : Double) -> CryptoasymdhPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhPath::min(self : CryptoasymdhPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhPath::max(self : CryptoasymdhPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhPath::to_string(self : CryptoasymdhPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_cluster_make(size : Int) -> CryptoasymdhCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhCluster::len(self : CryptoasymdhCluster) -> Int { self.size }

pub fn CryptoasymdhCluster::get(self : CryptoasymdhCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhCluster::set(self : CryptoasymdhCluster, i : Int, v : Double) -> CryptoasymdhCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCluster::sum(self : CryptoasymdhCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhCluster::mean(self : CryptoasymdhCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhCluster::scale(self : CryptoasymdhCluster, f : Double) -> CryptoasymdhCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCluster::add(self : CryptoasymdhCluster, other : CryptoasymdhCluster) -> CryptoasymdhCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhCluster::copy(self : CryptoasymdhCluster) -> CryptoasymdhCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCluster::fill(self : CryptoasymdhCluster, v : Double) -> CryptoasymdhCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCluster::min(self : CryptoasymdhCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhCluster::max(self : CryptoasymdhCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhCluster::to_string(self : CryptoasymdhCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_model_make(size : Int) -> CryptoasymdhModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhModel::len(self : CryptoasymdhModel) -> Int { self.size }

pub fn CryptoasymdhModel::get(self : CryptoasymdhModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhModel::set(self : CryptoasymdhModel, i : Int, v : Double) -> CryptoasymdhModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhModel::sum(self : CryptoasymdhModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhModel::mean(self : CryptoasymdhModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhModel::scale(self : CryptoasymdhModel, f : Double) -> CryptoasymdhModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhModel::add(self : CryptoasymdhModel, other : CryptoasymdhModel) -> CryptoasymdhModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhModel::copy(self : CryptoasymdhModel) -> CryptoasymdhModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhModel::fill(self : CryptoasymdhModel, v : Double) -> CryptoasymdhModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhModel::min(self : CryptoasymdhModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhModel::max(self : CryptoasymdhModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhModel::to_string(self : CryptoasymdhModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_layer_make(size : Int) -> CryptoasymdhLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhLayer::len(self : CryptoasymdhLayer) -> Int { self.size }

pub fn CryptoasymdhLayer::get(self : CryptoasymdhLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhLayer::set(self : CryptoasymdhLayer, i : Int, v : Double) -> CryptoasymdhLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhLayer::sum(self : CryptoasymdhLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhLayer::mean(self : CryptoasymdhLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhLayer::scale(self : CryptoasymdhLayer, f : Double) -> CryptoasymdhLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhLayer::add(self : CryptoasymdhLayer, other : CryptoasymdhLayer) -> CryptoasymdhLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhLayer::copy(self : CryptoasymdhLayer) -> CryptoasymdhLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhLayer::fill(self : CryptoasymdhLayer, v : Double) -> CryptoasymdhLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhLayer::min(self : CryptoasymdhLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhLayer::max(self : CryptoasymdhLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhLayer::to_string(self : CryptoasymdhLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_buffer_make(size : Int) -> CryptoasymdhBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhBuffer::len(self : CryptoasymdhBuffer) -> Int { self.size }

pub fn CryptoasymdhBuffer::get(self : CryptoasymdhBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhBuffer::set(self : CryptoasymdhBuffer, i : Int, v : Double) -> CryptoasymdhBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhBuffer::sum(self : CryptoasymdhBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhBuffer::mean(self : CryptoasymdhBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhBuffer::scale(self : CryptoasymdhBuffer, f : Double) -> CryptoasymdhBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhBuffer::add(self : CryptoasymdhBuffer, other : CryptoasymdhBuffer) -> CryptoasymdhBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhBuffer::copy(self : CryptoasymdhBuffer) -> CryptoasymdhBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhBuffer::fill(self : CryptoasymdhBuffer, v : Double) -> CryptoasymdhBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhBuffer::min(self : CryptoasymdhBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhBuffer::max(self : CryptoasymdhBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhBuffer::to_string(self : CryptoasymdhBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_cursor_make(size : Int) -> CryptoasymdhCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhCursor::len(self : CryptoasymdhCursor) -> Int { self.size }

pub fn CryptoasymdhCursor::get(self : CryptoasymdhCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhCursor::set(self : CryptoasymdhCursor, i : Int, v : Double) -> CryptoasymdhCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCursor::sum(self : CryptoasymdhCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhCursor::mean(self : CryptoasymdhCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhCursor::scale(self : CryptoasymdhCursor, f : Double) -> CryptoasymdhCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCursor::add(self : CryptoasymdhCursor, other : CryptoasymdhCursor) -> CryptoasymdhCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhCursor::copy(self : CryptoasymdhCursor) -> CryptoasymdhCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCursor::fill(self : CryptoasymdhCursor, v : Double) -> CryptoasymdhCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhCursor::min(self : CryptoasymdhCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhCursor::max(self : CryptoasymdhCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhCursor::to_string(self : CryptoasymdhCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_view_make(size : Int) -> CryptoasymdhView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhView::len(self : CryptoasymdhView) -> Int { self.size }

pub fn CryptoasymdhView::get(self : CryptoasymdhView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhView::set(self : CryptoasymdhView, i : Int, v : Double) -> CryptoasymdhView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhView::sum(self : CryptoasymdhView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhView::mean(self : CryptoasymdhView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhView::scale(self : CryptoasymdhView, f : Double) -> CryptoasymdhView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhView::add(self : CryptoasymdhView, other : CryptoasymdhView) -> CryptoasymdhView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhView::copy(self : CryptoasymdhView) -> CryptoasymdhView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhView::fill(self : CryptoasymdhView, v : Double) -> CryptoasymdhView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhView::min(self : CryptoasymdhView) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhView::max(self : CryptoasymdhView) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhView::to_string(self : CryptoasymdhView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_range_make(size : Int) -> CryptoasymdhRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhRange::len(self : CryptoasymdhRange) -> Int { self.size }

pub fn CryptoasymdhRange::get(self : CryptoasymdhRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhRange::set(self : CryptoasymdhRange, i : Int, v : Double) -> CryptoasymdhRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhRange::sum(self : CryptoasymdhRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhRange::mean(self : CryptoasymdhRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhRange::scale(self : CryptoasymdhRange, f : Double) -> CryptoasymdhRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhRange::add(self : CryptoasymdhRange, other : CryptoasymdhRange) -> CryptoasymdhRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhRange::copy(self : CryptoasymdhRange) -> CryptoasymdhRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhRange::fill(self : CryptoasymdhRange, v : Double) -> CryptoasymdhRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhRange::min(self : CryptoasymdhRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhRange::max(self : CryptoasymdhRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhRange::to_string(self : CryptoasymdhRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdhSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dh_slice_make(size : Int) -> CryptoasymdhSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdhSlice::len(self : CryptoasymdhSlice) -> Int { self.size }

pub fn CryptoasymdhSlice::get(self : CryptoasymdhSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdhSlice::set(self : CryptoasymdhSlice, i : Int, v : Double) -> CryptoasymdhSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdhSlice::sum(self : CryptoasymdhSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdhSlice::mean(self : CryptoasymdhSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdhSlice::scale(self : CryptoasymdhSlice, f : Double) -> CryptoasymdhSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhSlice::add(self : CryptoasymdhSlice, other : CryptoasymdhSlice) -> CryptoasymdhSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdhSlice::copy(self : CryptoasymdhSlice) -> CryptoasymdhSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhSlice::fill(self : CryptoasymdhSlice, v : Double) -> CryptoasymdhSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdhSlice::min(self : CryptoasymdhSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymdhSlice::max(self : CryptoasymdhSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymdhSlice::to_string(self : CryptoasymdhSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

