///===
/// extcore/crypto_sign_rsa_pkcs

pub(all) struct CryptosignrsapkcsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_rsa_pkcs_make_point(x : Double, y : Double) -> CryptosignrsapkcsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_rsa_pkcs_make_point3(x : Double, y : Double, z : Double) -> CryptosignrsapkcsPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignrsapkcsPoint::x(self : CryptosignrsapkcsPoint) -> Double { self.x }

pub fn CryptosignrsapkcsPoint::y(self : CryptosignrsapkcsPoint) -> Double { self.y }

pub fn CryptosignrsapkcsPoint::z(self : CryptosignrsapkcsPoint) -> Double { self.z }

pub fn CryptosignrsapkcsPoint::label(self : CryptosignrsapkcsPoint) -> Int { self.label }

pub fn CryptosignrsapkcsPoint::dist(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignrsapkcsPoint::add(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignrsapkcsPoint::sub(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignrsapkcsPoint::scale(self : CryptosignrsapkcsPoint, s : Double) -> CryptosignrsapkcsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignrsapkcsPoint::dot(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignrsapkcsPoint::cross(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignrsapkcsPoint::norm(self : CryptosignrsapkcsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignrsapkcsPoint::normalize(self : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignrsapkcsPoint::negate(self : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignrsapkcsPoint::mid(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignrsapkcsPoint::lerp(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint, t : Double) -> CryptosignrsapkcsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignrsapkcsPoint::to_string(self : CryptosignrsapkcsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_rsa_pkcs_make_series(vals : Array[Double], name : String) -> CryptosignrsapkcsSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignrsapkcsSeries::len(self : CryptosignrsapkcsSeries) -> Int { self.vals.length() }

pub fn CryptosignrsapkcsSeries::sum(self : CryptosignrsapkcsSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignrsapkcsSeries::mean(self : CryptosignrsapkcsSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignrsapkcsSeries::min(self : CryptosignrsapkcsSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignrsapkcsSeries::max(self : CryptosignrsapkcsSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignrsapkcsSeries::range(self : CryptosignrsapkcsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignrsapkcsSeries::variance(self : CryptosignrsapkcsSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignrsapkcsSeries::std(self : CryptosignrsapkcsSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignrsapkcsSeries::median(self : CryptosignrsapkcsSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignrsapkcsSeries::scale(self : CryptosignrsapkcsSeries, f : Double) -> CryptosignrsapkcsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::add(self : CryptosignrsapkcsSeries, other : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::sub(self : CryptosignrsapkcsSeries, other : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::normalize(self : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignrsapkcsSeries::cumsum(self : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::to_string(self : CryptosignrsapkcsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapkcsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_rsa_pkcs_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignrsapkcsMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_sign_rsa_pkcs_matrix_identity(n : Int) -> CryptosignrsapkcsMatrix {
  let m = crypto_sign_rsa_pkcs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignrsapkcsMatrix::get(self : CryptosignrsapkcsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignrsapkcsMatrix::transpose(self : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  let result = crypto_sign_rsa_pkcs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignrsapkcsMatrix::add(self : CryptosignrsapkcsMatrix, other : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_rsa_pkcs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignrsapkcsMatrix::scale(self : CryptosignrsapkcsMatrix, s : Double) -> CryptosignrsapkcsMatrix {
  let result = crypto_sign_rsa_pkcs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignrsapkcsMatrix::multiply(self : CryptosignrsapkcsMatrix, other : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  if self.cols != other.rows { return crypto_sign_rsa_pkcs_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_rsa_pkcs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptosignrsapkcsMatrix::trace(self : CryptosignrsapkcsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignrsapkcsMatrix::det(self : CryptosignrsapkcsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignrsapkcsMatrix::norm(self : CryptosignrsapkcsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignrsapkcsMatrix::to_string(self : CryptosignrsapkcsMatrix) -> String {
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

pub(all) struct CryptosignrsapkcsVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_rsa_pkcs_make_vector(comps : Array[Double]) -> CryptosignrsapkcsVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_rsa_pkcs_vector_zero(dim : Int) -> CryptosignrsapkcsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignrsapkcsVector::add(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignrsapkcsVector::sub(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignrsapkcsVector::scale(self : CryptosignrsapkcsVector, s : Double) -> CryptosignrsapkcsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignrsapkcsVector::dot(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignrsapkcsVector::norm(self : CryptosignrsapkcsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignrsapkcsVector::normalize(self : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignrsapkcsVector::dist(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignrsapkcsVector::to_string(self : CryptosignrsapkcsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapkcsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_frame_make(size : Int) -> CryptosignrsapkcsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsFrame::len(self : CryptosignrsapkcsFrame) -> Int { self.size }

pub fn CryptosignrsapkcsFrame::get(self : CryptosignrsapkcsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsFrame::set(self : CryptosignrsapkcsFrame, i : Int, v : Double) -> CryptosignrsapkcsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsFrame::sum(self : CryptosignrsapkcsFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsFrame::mean(self : CryptosignrsapkcsFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsFrame::scale(self : CryptosignrsapkcsFrame, f : Double) -> CryptosignrsapkcsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsFrame::add(self : CryptosignrsapkcsFrame, other : CryptosignrsapkcsFrame) -> CryptosignrsapkcsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsFrame::copy(self : CryptosignrsapkcsFrame) -> CryptosignrsapkcsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsFrame::fill(self : CryptosignrsapkcsFrame, v : Double) -> CryptosignrsapkcsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsFrame::min(self : CryptosignrsapkcsFrame) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsFrame::max(self : CryptosignrsapkcsFrame) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsFrame::to_string(self : CryptosignrsapkcsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_table_make(size : Int) -> CryptosignrsapkcsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsTable::len(self : CryptosignrsapkcsTable) -> Int { self.size }

pub fn CryptosignrsapkcsTable::get(self : CryptosignrsapkcsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsTable::set(self : CryptosignrsapkcsTable, i : Int, v : Double) -> CryptosignrsapkcsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsTable::sum(self : CryptosignrsapkcsTable) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsTable::mean(self : CryptosignrsapkcsTable) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsTable::scale(self : CryptosignrsapkcsTable, f : Double) -> CryptosignrsapkcsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsTable::add(self : CryptosignrsapkcsTable, other : CryptosignrsapkcsTable) -> CryptosignrsapkcsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsTable::copy(self : CryptosignrsapkcsTable) -> CryptosignrsapkcsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsTable::fill(self : CryptosignrsapkcsTable, v : Double) -> CryptosignrsapkcsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsTable::min(self : CryptosignrsapkcsTable) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsTable::max(self : CryptosignrsapkcsTable) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsTable::to_string(self : CryptosignrsapkcsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_graphn_make(size : Int) -> CryptosignrsapkcsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsGraphN::len(self : CryptosignrsapkcsGraphN) -> Int { self.size }

pub fn CryptosignrsapkcsGraphN::get(self : CryptosignrsapkcsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsGraphN::set(self : CryptosignrsapkcsGraphN, i : Int, v : Double) -> CryptosignrsapkcsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsGraphN::sum(self : CryptosignrsapkcsGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsGraphN::mean(self : CryptosignrsapkcsGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsGraphN::scale(self : CryptosignrsapkcsGraphN, f : Double) -> CryptosignrsapkcsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsGraphN::add(self : CryptosignrsapkcsGraphN, other : CryptosignrsapkcsGraphN) -> CryptosignrsapkcsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsGraphN::copy(self : CryptosignrsapkcsGraphN) -> CryptosignrsapkcsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsGraphN::fill(self : CryptosignrsapkcsGraphN, v : Double) -> CryptosignrsapkcsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsGraphN::min(self : CryptosignrsapkcsGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsGraphN::max(self : CryptosignrsapkcsGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsGraphN::to_string(self : CryptosignrsapkcsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_node_make(size : Int) -> CryptosignrsapkcsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsNode::len(self : CryptosignrsapkcsNode) -> Int { self.size }

pub fn CryptosignrsapkcsNode::get(self : CryptosignrsapkcsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsNode::set(self : CryptosignrsapkcsNode, i : Int, v : Double) -> CryptosignrsapkcsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsNode::sum(self : CryptosignrsapkcsNode) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsNode::mean(self : CryptosignrsapkcsNode) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsNode::scale(self : CryptosignrsapkcsNode, f : Double) -> CryptosignrsapkcsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsNode::add(self : CryptosignrsapkcsNode, other : CryptosignrsapkcsNode) -> CryptosignrsapkcsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsNode::copy(self : CryptosignrsapkcsNode) -> CryptosignrsapkcsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsNode::fill(self : CryptosignrsapkcsNode, v : Double) -> CryptosignrsapkcsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsNode::min(self : CryptosignrsapkcsNode) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsNode::max(self : CryptosignrsapkcsNode) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsNode::to_string(self : CryptosignrsapkcsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_edge_make(size : Int) -> CryptosignrsapkcsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsEdge::len(self : CryptosignrsapkcsEdge) -> Int { self.size }

pub fn CryptosignrsapkcsEdge::get(self : CryptosignrsapkcsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsEdge::set(self : CryptosignrsapkcsEdge, i : Int, v : Double) -> CryptosignrsapkcsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsEdge::sum(self : CryptosignrsapkcsEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsEdge::mean(self : CryptosignrsapkcsEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsEdge::scale(self : CryptosignrsapkcsEdge, f : Double) -> CryptosignrsapkcsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsEdge::add(self : CryptosignrsapkcsEdge, other : CryptosignrsapkcsEdge) -> CryptosignrsapkcsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsEdge::copy(self : CryptosignrsapkcsEdge) -> CryptosignrsapkcsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsEdge::fill(self : CryptosignrsapkcsEdge, v : Double) -> CryptosignrsapkcsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsEdge::min(self : CryptosignrsapkcsEdge) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsEdge::max(self : CryptosignrsapkcsEdge) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsEdge::to_string(self : CryptosignrsapkcsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_path_make(size : Int) -> CryptosignrsapkcsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsPath::len(self : CryptosignrsapkcsPath) -> Int { self.size }

pub fn CryptosignrsapkcsPath::get(self : CryptosignrsapkcsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsPath::set(self : CryptosignrsapkcsPath, i : Int, v : Double) -> CryptosignrsapkcsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsPath::sum(self : CryptosignrsapkcsPath) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsPath::mean(self : CryptosignrsapkcsPath) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsPath::scale(self : CryptosignrsapkcsPath, f : Double) -> CryptosignrsapkcsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsPath::add(self : CryptosignrsapkcsPath, other : CryptosignrsapkcsPath) -> CryptosignrsapkcsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsPath::copy(self : CryptosignrsapkcsPath) -> CryptosignrsapkcsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsPath::fill(self : CryptosignrsapkcsPath, v : Double) -> CryptosignrsapkcsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsPath::min(self : CryptosignrsapkcsPath) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsPath::max(self : CryptosignrsapkcsPath) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsPath::to_string(self : CryptosignrsapkcsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_cluster_make(size : Int) -> CryptosignrsapkcsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsCluster::len(self : CryptosignrsapkcsCluster) -> Int { self.size }

pub fn CryptosignrsapkcsCluster::get(self : CryptosignrsapkcsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsCluster::set(self : CryptosignrsapkcsCluster, i : Int, v : Double) -> CryptosignrsapkcsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCluster::sum(self : CryptosignrsapkcsCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsCluster::mean(self : CryptosignrsapkcsCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsCluster::scale(self : CryptosignrsapkcsCluster, f : Double) -> CryptosignrsapkcsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCluster::add(self : CryptosignrsapkcsCluster, other : CryptosignrsapkcsCluster) -> CryptosignrsapkcsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsCluster::copy(self : CryptosignrsapkcsCluster) -> CryptosignrsapkcsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCluster::fill(self : CryptosignrsapkcsCluster, v : Double) -> CryptosignrsapkcsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCluster::min(self : CryptosignrsapkcsCluster) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsCluster::max(self : CryptosignrsapkcsCluster) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsCluster::to_string(self : CryptosignrsapkcsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_model_make(size : Int) -> CryptosignrsapkcsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsModel::len(self : CryptosignrsapkcsModel) -> Int { self.size }

pub fn CryptosignrsapkcsModel::get(self : CryptosignrsapkcsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsModel::set(self : CryptosignrsapkcsModel, i : Int, v : Double) -> CryptosignrsapkcsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsModel::sum(self : CryptosignrsapkcsModel) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsModel::mean(self : CryptosignrsapkcsModel) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsModel::scale(self : CryptosignrsapkcsModel, f : Double) -> CryptosignrsapkcsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsModel::add(self : CryptosignrsapkcsModel, other : CryptosignrsapkcsModel) -> CryptosignrsapkcsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsModel::copy(self : CryptosignrsapkcsModel) -> CryptosignrsapkcsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsModel::fill(self : CryptosignrsapkcsModel, v : Double) -> CryptosignrsapkcsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsModel::min(self : CryptosignrsapkcsModel) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsModel::max(self : CryptosignrsapkcsModel) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsModel::to_string(self : CryptosignrsapkcsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_layer_make(size : Int) -> CryptosignrsapkcsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsLayer::len(self : CryptosignrsapkcsLayer) -> Int { self.size }

pub fn CryptosignrsapkcsLayer::get(self : CryptosignrsapkcsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsLayer::set(self : CryptosignrsapkcsLayer, i : Int, v : Double) -> CryptosignrsapkcsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsLayer::sum(self : CryptosignrsapkcsLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsLayer::mean(self : CryptosignrsapkcsLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsLayer::scale(self : CryptosignrsapkcsLayer, f : Double) -> CryptosignrsapkcsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsLayer::add(self : CryptosignrsapkcsLayer, other : CryptosignrsapkcsLayer) -> CryptosignrsapkcsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsLayer::copy(self : CryptosignrsapkcsLayer) -> CryptosignrsapkcsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsLayer::fill(self : CryptosignrsapkcsLayer, v : Double) -> CryptosignrsapkcsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsLayer::min(self : CryptosignrsapkcsLayer) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsLayer::max(self : CryptosignrsapkcsLayer) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsLayer::to_string(self : CryptosignrsapkcsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_buffer_make(size : Int) -> CryptosignrsapkcsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsBuffer::len(self : CryptosignrsapkcsBuffer) -> Int { self.size }

pub fn CryptosignrsapkcsBuffer::get(self : CryptosignrsapkcsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsBuffer::set(self : CryptosignrsapkcsBuffer, i : Int, v : Double) -> CryptosignrsapkcsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsBuffer::sum(self : CryptosignrsapkcsBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsBuffer::mean(self : CryptosignrsapkcsBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsBuffer::scale(self : CryptosignrsapkcsBuffer, f : Double) -> CryptosignrsapkcsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsBuffer::add(self : CryptosignrsapkcsBuffer, other : CryptosignrsapkcsBuffer) -> CryptosignrsapkcsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsBuffer::copy(self : CryptosignrsapkcsBuffer) -> CryptosignrsapkcsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsBuffer::fill(self : CryptosignrsapkcsBuffer, v : Double) -> CryptosignrsapkcsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsBuffer::min(self : CryptosignrsapkcsBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsBuffer::max(self : CryptosignrsapkcsBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsBuffer::to_string(self : CryptosignrsapkcsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_cursor_make(size : Int) -> CryptosignrsapkcsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsCursor::len(self : CryptosignrsapkcsCursor) -> Int { self.size }

pub fn CryptosignrsapkcsCursor::get(self : CryptosignrsapkcsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsCursor::set(self : CryptosignrsapkcsCursor, i : Int, v : Double) -> CryptosignrsapkcsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCursor::sum(self : CryptosignrsapkcsCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsCursor::mean(self : CryptosignrsapkcsCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsCursor::scale(self : CryptosignrsapkcsCursor, f : Double) -> CryptosignrsapkcsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCursor::add(self : CryptosignrsapkcsCursor, other : CryptosignrsapkcsCursor) -> CryptosignrsapkcsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsCursor::copy(self : CryptosignrsapkcsCursor) -> CryptosignrsapkcsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCursor::fill(self : CryptosignrsapkcsCursor, v : Double) -> CryptosignrsapkcsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsCursor::min(self : CryptosignrsapkcsCursor) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsCursor::max(self : CryptosignrsapkcsCursor) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsCursor::to_string(self : CryptosignrsapkcsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_view_make(size : Int) -> CryptosignrsapkcsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsView::len(self : CryptosignrsapkcsView) -> Int { self.size }

pub fn CryptosignrsapkcsView::get(self : CryptosignrsapkcsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsView::set(self : CryptosignrsapkcsView, i : Int, v : Double) -> CryptosignrsapkcsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsView::sum(self : CryptosignrsapkcsView) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsView::mean(self : CryptosignrsapkcsView) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsView::scale(self : CryptosignrsapkcsView, f : Double) -> CryptosignrsapkcsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsView::add(self : CryptosignrsapkcsView, other : CryptosignrsapkcsView) -> CryptosignrsapkcsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsView::copy(self : CryptosignrsapkcsView) -> CryptosignrsapkcsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsView::fill(self : CryptosignrsapkcsView, v : Double) -> CryptosignrsapkcsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsView::min(self : CryptosignrsapkcsView) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsView::max(self : CryptosignrsapkcsView) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsView::to_string(self : CryptosignrsapkcsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_range_make(size : Int) -> CryptosignrsapkcsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsRange::len(self : CryptosignrsapkcsRange) -> Int { self.size }

pub fn CryptosignrsapkcsRange::get(self : CryptosignrsapkcsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsRange::set(self : CryptosignrsapkcsRange, i : Int, v : Double) -> CryptosignrsapkcsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsRange::sum(self : CryptosignrsapkcsRange) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsRange::mean(self : CryptosignrsapkcsRange) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsRange::scale(self : CryptosignrsapkcsRange, f : Double) -> CryptosignrsapkcsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsRange::add(self : CryptosignrsapkcsRange, other : CryptosignrsapkcsRange) -> CryptosignrsapkcsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsRange::copy(self : CryptosignrsapkcsRange) -> CryptosignrsapkcsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsRange::fill(self : CryptosignrsapkcsRange, v : Double) -> CryptosignrsapkcsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsRange::min(self : CryptosignrsapkcsRange) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsRange::max(self : CryptosignrsapkcsRange) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsRange::to_string(self : CryptosignrsapkcsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_slice_make(size : Int) -> CryptosignrsapkcsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapkcsSlice::len(self : CryptosignrsapkcsSlice) -> Int { self.size }

pub fn CryptosignrsapkcsSlice::get(self : CryptosignrsapkcsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapkcsSlice::set(self : CryptosignrsapkcsSlice, i : Int, v : Double) -> CryptosignrsapkcsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsSlice::sum(self : CryptosignrsapkcsSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapkcsSlice::mean(self : CryptosignrsapkcsSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapkcsSlice::scale(self : CryptosignrsapkcsSlice, f : Double) -> CryptosignrsapkcsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsSlice::add(self : CryptosignrsapkcsSlice, other : CryptosignrsapkcsSlice) -> CryptosignrsapkcsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapkcsSlice::copy(self : CryptosignrsapkcsSlice) -> CryptosignrsapkcsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsSlice::fill(self : CryptosignrsapkcsSlice, v : Double) -> CryptosignrsapkcsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapkcsSlice::min(self : CryptosignrsapkcsSlice) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapkcsSlice::max(self : CryptosignrsapkcsSlice) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapkcsSlice::to_string(self : CryptosignrsapkcsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

