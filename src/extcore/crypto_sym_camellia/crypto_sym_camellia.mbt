///===
/// extcore/crypto_sym_camellia

pub(all) struct CryptosymcamelliaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_camellia_make_point(x : Double, y : Double) -> CryptosymcamelliaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_camellia_make_point3(x : Double, y : Double, z : Double) -> CryptosymcamelliaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymcamelliaPoint::x(self : CryptosymcamelliaPoint) -> Double { self.x }

pub fn CryptosymcamelliaPoint::y(self : CryptosymcamelliaPoint) -> Double { self.y }

pub fn CryptosymcamelliaPoint::z(self : CryptosymcamelliaPoint) -> Double { self.z }

pub fn CryptosymcamelliaPoint::label(self : CryptosymcamelliaPoint) -> Int { self.label }

pub fn CryptosymcamelliaPoint::dist(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymcamelliaPoint::add(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymcamelliaPoint::sub(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymcamelliaPoint::scale(self : CryptosymcamelliaPoint, s : Double) -> CryptosymcamelliaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymcamelliaPoint::dot(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymcamelliaPoint::cross(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymcamelliaPoint::norm(self : CryptosymcamelliaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymcamelliaPoint::normalize(self : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcamelliaPoint::negate(self : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymcamelliaPoint::mid(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymcamelliaPoint::lerp(self : CryptosymcamelliaPoint, other : CryptosymcamelliaPoint, t : Double) -> CryptosymcamelliaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymcamelliaPoint::to_string(self : CryptosymcamelliaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymcamelliaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_camellia_make_series(vals : Array[Double], name : String) -> CryptosymcamelliaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymcamelliaSeries::len(self : CryptosymcamelliaSeries) -> Int { self.vals.length() }

pub fn CryptosymcamelliaSeries::sum(self : CryptosymcamelliaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymcamelliaSeries::mean(self : CryptosymcamelliaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymcamelliaSeries::min(self : CryptosymcamelliaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymcamelliaSeries::max(self : CryptosymcamelliaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymcamelliaSeries::range(self : CryptosymcamelliaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymcamelliaSeries::variance(self : CryptosymcamelliaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymcamelliaSeries::std(self : CryptosymcamelliaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymcamelliaSeries::median(self : CryptosymcamelliaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymcamelliaSeries::scale(self : CryptosymcamelliaSeries, f : Double) -> CryptosymcamelliaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymcamelliaSeries::add(self : CryptosymcamelliaSeries, other : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymcamelliaSeries::sub(self : CryptosymcamelliaSeries, other : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymcamelliaSeries::normalize(self : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymcamelliaSeries::cumsum(self : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymcamelliaSeries::to_string(self : CryptosymcamelliaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcamelliaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_camellia_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcamelliaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_camellia_matrix_identity(n : Int) -> CryptosymcamelliaMatrix {
  let m = crypto_sym_camellia_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymcamelliaMatrix::get(self : CryptosymcamelliaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymcamelliaMatrix::transpose(self : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  let result = crypto_sym_camellia_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymcamelliaMatrix::add(self : CryptosymcamelliaMatrix, other : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_camellia_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymcamelliaMatrix::scale(self : CryptosymcamelliaMatrix, s : Double) -> CryptosymcamelliaMatrix {
  let result = crypto_sym_camellia_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymcamelliaMatrix::multiply(self : CryptosymcamelliaMatrix, other : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  if self.cols != other.rows { return crypto_sym_camellia_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_camellia_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymcamelliaMatrix::trace(self : CryptosymcamelliaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymcamelliaMatrix::det(self : CryptosymcamelliaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymcamelliaMatrix::norm(self : CryptosymcamelliaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymcamelliaMatrix::to_string(self : CryptosymcamelliaMatrix) -> String {
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

pub(all) struct CryptosymcamelliaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_camellia_make_vector(comps : Array[Double]) -> CryptosymcamelliaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_camellia_vector_zero(dim : Int) -> CryptosymcamelliaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymcamelliaVector::add(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcamelliaVector::sub(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcamelliaVector::scale(self : CryptosymcamelliaVector, s : Double) -> CryptosymcamelliaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymcamelliaVector::dot(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymcamelliaVector::norm(self : CryptosymcamelliaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymcamelliaVector::normalize(self : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcamelliaVector::dist(self : CryptosymcamelliaVector, other : CryptosymcamelliaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymcamelliaVector::to_string(self : CryptosymcamelliaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcamelliaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_frame_make(size : Int) -> CryptosymcamelliaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaFrame::len(self : CryptosymcamelliaFrame) -> Int { self.size }

pub fn CryptosymcamelliaFrame::get(self : CryptosymcamelliaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaFrame::set(self : CryptosymcamelliaFrame, i : Int, v : Double) -> CryptosymcamelliaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaFrame::sum(self : CryptosymcamelliaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaFrame::mean(self : CryptosymcamelliaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaFrame::scale(self : CryptosymcamelliaFrame, f : Double) -> CryptosymcamelliaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaFrame::add(self : CryptosymcamelliaFrame, other : CryptosymcamelliaFrame) -> CryptosymcamelliaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaFrame::copy(self : CryptosymcamelliaFrame) -> CryptosymcamelliaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaFrame::fill(self : CryptosymcamelliaFrame, v : Double) -> CryptosymcamelliaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaFrame::min(self : CryptosymcamelliaFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaFrame::max(self : CryptosymcamelliaFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaFrame::to_string(self : CryptosymcamelliaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_table_make(size : Int) -> CryptosymcamelliaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaTable::len(self : CryptosymcamelliaTable) -> Int { self.size }

pub fn CryptosymcamelliaTable::get(self : CryptosymcamelliaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaTable::set(self : CryptosymcamelliaTable, i : Int, v : Double) -> CryptosymcamelliaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaTable::sum(self : CryptosymcamelliaTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaTable::mean(self : CryptosymcamelliaTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaTable::scale(self : CryptosymcamelliaTable, f : Double) -> CryptosymcamelliaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaTable::add(self : CryptosymcamelliaTable, other : CryptosymcamelliaTable) -> CryptosymcamelliaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaTable::copy(self : CryptosymcamelliaTable) -> CryptosymcamelliaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaTable::fill(self : CryptosymcamelliaTable, v : Double) -> CryptosymcamelliaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaTable::min(self : CryptosymcamelliaTable) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaTable::max(self : CryptosymcamelliaTable) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaTable::to_string(self : CryptosymcamelliaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_graphn_make(size : Int) -> CryptosymcamelliaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaGraphN::len(self : CryptosymcamelliaGraphN) -> Int { self.size }

pub fn CryptosymcamelliaGraphN::get(self : CryptosymcamelliaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaGraphN::set(self : CryptosymcamelliaGraphN, i : Int, v : Double) -> CryptosymcamelliaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaGraphN::sum(self : CryptosymcamelliaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaGraphN::mean(self : CryptosymcamelliaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaGraphN::scale(self : CryptosymcamelliaGraphN, f : Double) -> CryptosymcamelliaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaGraphN::add(self : CryptosymcamelliaGraphN, other : CryptosymcamelliaGraphN) -> CryptosymcamelliaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaGraphN::copy(self : CryptosymcamelliaGraphN) -> CryptosymcamelliaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaGraphN::fill(self : CryptosymcamelliaGraphN, v : Double) -> CryptosymcamelliaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaGraphN::min(self : CryptosymcamelliaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaGraphN::max(self : CryptosymcamelliaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaGraphN::to_string(self : CryptosymcamelliaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_node_make(size : Int) -> CryptosymcamelliaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaNode::len(self : CryptosymcamelliaNode) -> Int { self.size }

pub fn CryptosymcamelliaNode::get(self : CryptosymcamelliaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaNode::set(self : CryptosymcamelliaNode, i : Int, v : Double) -> CryptosymcamelliaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaNode::sum(self : CryptosymcamelliaNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaNode::mean(self : CryptosymcamelliaNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaNode::scale(self : CryptosymcamelliaNode, f : Double) -> CryptosymcamelliaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaNode::add(self : CryptosymcamelliaNode, other : CryptosymcamelliaNode) -> CryptosymcamelliaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaNode::copy(self : CryptosymcamelliaNode) -> CryptosymcamelliaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaNode::fill(self : CryptosymcamelliaNode, v : Double) -> CryptosymcamelliaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaNode::min(self : CryptosymcamelliaNode) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaNode::max(self : CryptosymcamelliaNode) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaNode::to_string(self : CryptosymcamelliaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_edge_make(size : Int) -> CryptosymcamelliaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaEdge::len(self : CryptosymcamelliaEdge) -> Int { self.size }

pub fn CryptosymcamelliaEdge::get(self : CryptosymcamelliaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaEdge::set(self : CryptosymcamelliaEdge, i : Int, v : Double) -> CryptosymcamelliaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaEdge::sum(self : CryptosymcamelliaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaEdge::mean(self : CryptosymcamelliaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaEdge::scale(self : CryptosymcamelliaEdge, f : Double) -> CryptosymcamelliaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaEdge::add(self : CryptosymcamelliaEdge, other : CryptosymcamelliaEdge) -> CryptosymcamelliaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaEdge::copy(self : CryptosymcamelliaEdge) -> CryptosymcamelliaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaEdge::fill(self : CryptosymcamelliaEdge, v : Double) -> CryptosymcamelliaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaEdge::min(self : CryptosymcamelliaEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaEdge::max(self : CryptosymcamelliaEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaEdge::to_string(self : CryptosymcamelliaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_path_make(size : Int) -> CryptosymcamelliaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaPath::len(self : CryptosymcamelliaPath) -> Int { self.size }

pub fn CryptosymcamelliaPath::get(self : CryptosymcamelliaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaPath::set(self : CryptosymcamelliaPath, i : Int, v : Double) -> CryptosymcamelliaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaPath::sum(self : CryptosymcamelliaPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaPath::mean(self : CryptosymcamelliaPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaPath::scale(self : CryptosymcamelliaPath, f : Double) -> CryptosymcamelliaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaPath::add(self : CryptosymcamelliaPath, other : CryptosymcamelliaPath) -> CryptosymcamelliaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaPath::copy(self : CryptosymcamelliaPath) -> CryptosymcamelliaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaPath::fill(self : CryptosymcamelliaPath, v : Double) -> CryptosymcamelliaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaPath::min(self : CryptosymcamelliaPath) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaPath::max(self : CryptosymcamelliaPath) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaPath::to_string(self : CryptosymcamelliaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_cluster_make(size : Int) -> CryptosymcamelliaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaCluster::len(self : CryptosymcamelliaCluster) -> Int { self.size }

pub fn CryptosymcamelliaCluster::get(self : CryptosymcamelliaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaCluster::set(self : CryptosymcamelliaCluster, i : Int, v : Double) -> CryptosymcamelliaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCluster::sum(self : CryptosymcamelliaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaCluster::mean(self : CryptosymcamelliaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaCluster::scale(self : CryptosymcamelliaCluster, f : Double) -> CryptosymcamelliaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCluster::add(self : CryptosymcamelliaCluster, other : CryptosymcamelliaCluster) -> CryptosymcamelliaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaCluster::copy(self : CryptosymcamelliaCluster) -> CryptosymcamelliaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCluster::fill(self : CryptosymcamelliaCluster, v : Double) -> CryptosymcamelliaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCluster::min(self : CryptosymcamelliaCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaCluster::max(self : CryptosymcamelliaCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaCluster::to_string(self : CryptosymcamelliaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_model_make(size : Int) -> CryptosymcamelliaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaModel::len(self : CryptosymcamelliaModel) -> Int { self.size }

pub fn CryptosymcamelliaModel::get(self : CryptosymcamelliaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaModel::set(self : CryptosymcamelliaModel, i : Int, v : Double) -> CryptosymcamelliaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaModel::sum(self : CryptosymcamelliaModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaModel::mean(self : CryptosymcamelliaModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaModel::scale(self : CryptosymcamelliaModel, f : Double) -> CryptosymcamelliaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaModel::add(self : CryptosymcamelliaModel, other : CryptosymcamelliaModel) -> CryptosymcamelliaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaModel::copy(self : CryptosymcamelliaModel) -> CryptosymcamelliaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaModel::fill(self : CryptosymcamelliaModel, v : Double) -> CryptosymcamelliaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaModel::min(self : CryptosymcamelliaModel) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaModel::max(self : CryptosymcamelliaModel) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaModel::to_string(self : CryptosymcamelliaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_layer_make(size : Int) -> CryptosymcamelliaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaLayer::len(self : CryptosymcamelliaLayer) -> Int { self.size }

pub fn CryptosymcamelliaLayer::get(self : CryptosymcamelliaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaLayer::set(self : CryptosymcamelliaLayer, i : Int, v : Double) -> CryptosymcamelliaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaLayer::sum(self : CryptosymcamelliaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaLayer::mean(self : CryptosymcamelliaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaLayer::scale(self : CryptosymcamelliaLayer, f : Double) -> CryptosymcamelliaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaLayer::add(self : CryptosymcamelliaLayer, other : CryptosymcamelliaLayer) -> CryptosymcamelliaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaLayer::copy(self : CryptosymcamelliaLayer) -> CryptosymcamelliaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaLayer::fill(self : CryptosymcamelliaLayer, v : Double) -> CryptosymcamelliaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaLayer::min(self : CryptosymcamelliaLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaLayer::max(self : CryptosymcamelliaLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaLayer::to_string(self : CryptosymcamelliaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_buffer_make(size : Int) -> CryptosymcamelliaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaBuffer::len(self : CryptosymcamelliaBuffer) -> Int { self.size }

pub fn CryptosymcamelliaBuffer::get(self : CryptosymcamelliaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaBuffer::set(self : CryptosymcamelliaBuffer, i : Int, v : Double) -> CryptosymcamelliaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaBuffer::sum(self : CryptosymcamelliaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaBuffer::mean(self : CryptosymcamelliaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaBuffer::scale(self : CryptosymcamelliaBuffer, f : Double) -> CryptosymcamelliaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaBuffer::add(self : CryptosymcamelliaBuffer, other : CryptosymcamelliaBuffer) -> CryptosymcamelliaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaBuffer::copy(self : CryptosymcamelliaBuffer) -> CryptosymcamelliaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaBuffer::fill(self : CryptosymcamelliaBuffer, v : Double) -> CryptosymcamelliaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaBuffer::min(self : CryptosymcamelliaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaBuffer::max(self : CryptosymcamelliaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaBuffer::to_string(self : CryptosymcamelliaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_cursor_make(size : Int) -> CryptosymcamelliaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaCursor::len(self : CryptosymcamelliaCursor) -> Int { self.size }

pub fn CryptosymcamelliaCursor::get(self : CryptosymcamelliaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaCursor::set(self : CryptosymcamelliaCursor, i : Int, v : Double) -> CryptosymcamelliaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCursor::sum(self : CryptosymcamelliaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaCursor::mean(self : CryptosymcamelliaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaCursor::scale(self : CryptosymcamelliaCursor, f : Double) -> CryptosymcamelliaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCursor::add(self : CryptosymcamelliaCursor, other : CryptosymcamelliaCursor) -> CryptosymcamelliaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaCursor::copy(self : CryptosymcamelliaCursor) -> CryptosymcamelliaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCursor::fill(self : CryptosymcamelliaCursor, v : Double) -> CryptosymcamelliaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaCursor::min(self : CryptosymcamelliaCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaCursor::max(self : CryptosymcamelliaCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaCursor::to_string(self : CryptosymcamelliaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_view_make(size : Int) -> CryptosymcamelliaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaView::len(self : CryptosymcamelliaView) -> Int { self.size }

pub fn CryptosymcamelliaView::get(self : CryptosymcamelliaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaView::set(self : CryptosymcamelliaView, i : Int, v : Double) -> CryptosymcamelliaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaView::sum(self : CryptosymcamelliaView) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaView::mean(self : CryptosymcamelliaView) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaView::scale(self : CryptosymcamelliaView, f : Double) -> CryptosymcamelliaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaView::add(self : CryptosymcamelliaView, other : CryptosymcamelliaView) -> CryptosymcamelliaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaView::copy(self : CryptosymcamelliaView) -> CryptosymcamelliaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaView::fill(self : CryptosymcamelliaView, v : Double) -> CryptosymcamelliaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaView::min(self : CryptosymcamelliaView) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaView::max(self : CryptosymcamelliaView) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaView::to_string(self : CryptosymcamelliaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_range_make(size : Int) -> CryptosymcamelliaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaRange::len(self : CryptosymcamelliaRange) -> Int { self.size }

pub fn CryptosymcamelliaRange::get(self : CryptosymcamelliaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaRange::set(self : CryptosymcamelliaRange, i : Int, v : Double) -> CryptosymcamelliaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaRange::sum(self : CryptosymcamelliaRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaRange::mean(self : CryptosymcamelliaRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaRange::scale(self : CryptosymcamelliaRange, f : Double) -> CryptosymcamelliaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaRange::add(self : CryptosymcamelliaRange, other : CryptosymcamelliaRange) -> CryptosymcamelliaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaRange::copy(self : CryptosymcamelliaRange) -> CryptosymcamelliaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaRange::fill(self : CryptosymcamelliaRange, v : Double) -> CryptosymcamelliaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaRange::min(self : CryptosymcamelliaRange) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaRange::max(self : CryptosymcamelliaRange) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaRange::to_string(self : CryptosymcamelliaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_slice_make(size : Int) -> CryptosymcamelliaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymcamelliaSlice::len(self : CryptosymcamelliaSlice) -> Int { self.size }

pub fn CryptosymcamelliaSlice::get(self : CryptosymcamelliaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymcamelliaSlice::set(self : CryptosymcamelliaSlice, i : Int, v : Double) -> CryptosymcamelliaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaSlice::sum(self : CryptosymcamelliaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymcamelliaSlice::mean(self : CryptosymcamelliaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymcamelliaSlice::scale(self : CryptosymcamelliaSlice, f : Double) -> CryptosymcamelliaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaSlice::add(self : CryptosymcamelliaSlice, other : CryptosymcamelliaSlice) -> CryptosymcamelliaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymcamelliaSlice::copy(self : CryptosymcamelliaSlice) -> CryptosymcamelliaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaSlice::fill(self : CryptosymcamelliaSlice, v : Double) -> CryptosymcamelliaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymcamelliaSlice::min(self : CryptosymcamelliaSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymcamelliaSlice::max(self : CryptosymcamelliaSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymcamelliaSlice::to_string(self : CryptosymcamelliaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

