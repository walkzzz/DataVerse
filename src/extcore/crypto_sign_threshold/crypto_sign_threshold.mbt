///===
/// extcore/crypto_sign_threshold

pub(all) struct CryptosignthresholdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_threshold_make_point(x : Double, y : Double) -> CryptosignthresholdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_threshold_make_point3(x : Double, y : Double, z : Double) -> CryptosignthresholdPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignthresholdPoint::x(self : CryptosignthresholdPoint) -> Double { self.x }

pub fn CryptosignthresholdPoint::y(self : CryptosignthresholdPoint) -> Double { self.y }

pub fn CryptosignthresholdPoint::z(self : CryptosignthresholdPoint) -> Double { self.z }

pub fn CryptosignthresholdPoint::label(self : CryptosignthresholdPoint) -> Int { self.label }

pub fn CryptosignthresholdPoint::dist(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignthresholdPoint::add(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignthresholdPoint::sub(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignthresholdPoint::scale(self : CryptosignthresholdPoint, s : Double) -> CryptosignthresholdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignthresholdPoint::dot(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignthresholdPoint::cross(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignthresholdPoint::norm(self : CryptosignthresholdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignthresholdPoint::normalize(self : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignthresholdPoint::negate(self : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignthresholdPoint::mid(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignthresholdPoint::lerp(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint, t : Double) -> CryptosignthresholdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignthresholdPoint::to_string(self : CryptosignthresholdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignthresholdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_threshold_make_series(vals : Array[Double], name : String) -> CryptosignthresholdSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignthresholdSeries::len(self : CryptosignthresholdSeries) -> Int { self.vals.length() }

pub fn CryptosignthresholdSeries::sum(self : CryptosignthresholdSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignthresholdSeries::mean(self : CryptosignthresholdSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignthresholdSeries::min(self : CryptosignthresholdSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignthresholdSeries::max(self : CryptosignthresholdSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignthresholdSeries::range(self : CryptosignthresholdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignthresholdSeries::variance(self : CryptosignthresholdSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignthresholdSeries::std(self : CryptosignthresholdSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignthresholdSeries::median(self : CryptosignthresholdSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignthresholdSeries::scale(self : CryptosignthresholdSeries, f : Double) -> CryptosignthresholdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignthresholdSeries::add(self : CryptosignthresholdSeries, other : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignthresholdSeries::sub(self : CryptosignthresholdSeries, other : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignthresholdSeries::normalize(self : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignthresholdSeries::cumsum(self : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignthresholdSeries::to_string(self : CryptosignthresholdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignthresholdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_threshold_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignthresholdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_threshold_matrix_identity(n : Int) -> CryptosignthresholdMatrix {
  let m = crypto_sign_threshold_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignthresholdMatrix::get(self : CryptosignthresholdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignthresholdMatrix::transpose(self : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  let result = crypto_sign_threshold_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignthresholdMatrix::add(self : CryptosignthresholdMatrix, other : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_threshold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignthresholdMatrix::scale(self : CryptosignthresholdMatrix, s : Double) -> CryptosignthresholdMatrix {
  let result = crypto_sign_threshold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignthresholdMatrix::multiply(self : CryptosignthresholdMatrix, other : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  if self.cols != other.rows { return crypto_sign_threshold_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_threshold_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosignthresholdMatrix::trace(self : CryptosignthresholdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignthresholdMatrix::det(self : CryptosignthresholdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignthresholdMatrix::norm(self : CryptosignthresholdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignthresholdMatrix::to_string(self : CryptosignthresholdMatrix) -> String {
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

pub(all) struct CryptosignthresholdVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_threshold_make_vector(comps : Array[Double]) -> CryptosignthresholdVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_threshold_vector_zero(dim : Int) -> CryptosignthresholdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignthresholdVector::add(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignthresholdVector::sub(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignthresholdVector::scale(self : CryptosignthresholdVector, s : Double) -> CryptosignthresholdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignthresholdVector::dot(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignthresholdVector::norm(self : CryptosignthresholdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignthresholdVector::normalize(self : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignthresholdVector::dist(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignthresholdVector::to_string(self : CryptosignthresholdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignthresholdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_frame_make(size : Int) -> CryptosignthresholdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdFrame::len(self : CryptosignthresholdFrame) -> Int { self.size }

pub fn CryptosignthresholdFrame::get(self : CryptosignthresholdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdFrame::set(self : CryptosignthresholdFrame, i : Int, v : Double) -> CryptosignthresholdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdFrame::sum(self : CryptosignthresholdFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdFrame::mean(self : CryptosignthresholdFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdFrame::scale(self : CryptosignthresholdFrame, f : Double) -> CryptosignthresholdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdFrame::add(self : CryptosignthresholdFrame, other : CryptosignthresholdFrame) -> CryptosignthresholdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdFrame::copy(self : CryptosignthresholdFrame) -> CryptosignthresholdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdFrame::fill(self : CryptosignthresholdFrame, v : Double) -> CryptosignthresholdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdFrame::min(self : CryptosignthresholdFrame) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdFrame::max(self : CryptosignthresholdFrame) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdFrame::to_string(self : CryptosignthresholdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_table_make(size : Int) -> CryptosignthresholdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdTable::len(self : CryptosignthresholdTable) -> Int { self.size }

pub fn CryptosignthresholdTable::get(self : CryptosignthresholdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdTable::set(self : CryptosignthresholdTable, i : Int, v : Double) -> CryptosignthresholdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdTable::sum(self : CryptosignthresholdTable) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdTable::mean(self : CryptosignthresholdTable) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdTable::scale(self : CryptosignthresholdTable, f : Double) -> CryptosignthresholdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdTable::add(self : CryptosignthresholdTable, other : CryptosignthresholdTable) -> CryptosignthresholdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdTable::copy(self : CryptosignthresholdTable) -> CryptosignthresholdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdTable::fill(self : CryptosignthresholdTable, v : Double) -> CryptosignthresholdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdTable::min(self : CryptosignthresholdTable) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdTable::max(self : CryptosignthresholdTable) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdTable::to_string(self : CryptosignthresholdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_graphn_make(size : Int) -> CryptosignthresholdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdGraphN::len(self : CryptosignthresholdGraphN) -> Int { self.size }

pub fn CryptosignthresholdGraphN::get(self : CryptosignthresholdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdGraphN::set(self : CryptosignthresholdGraphN, i : Int, v : Double) -> CryptosignthresholdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdGraphN::sum(self : CryptosignthresholdGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdGraphN::mean(self : CryptosignthresholdGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdGraphN::scale(self : CryptosignthresholdGraphN, f : Double) -> CryptosignthresholdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdGraphN::add(self : CryptosignthresholdGraphN, other : CryptosignthresholdGraphN) -> CryptosignthresholdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdGraphN::copy(self : CryptosignthresholdGraphN) -> CryptosignthresholdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdGraphN::fill(self : CryptosignthresholdGraphN, v : Double) -> CryptosignthresholdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdGraphN::min(self : CryptosignthresholdGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdGraphN::max(self : CryptosignthresholdGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdGraphN::to_string(self : CryptosignthresholdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_node_make(size : Int) -> CryptosignthresholdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdNode::len(self : CryptosignthresholdNode) -> Int { self.size }

pub fn CryptosignthresholdNode::get(self : CryptosignthresholdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdNode::set(self : CryptosignthresholdNode, i : Int, v : Double) -> CryptosignthresholdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdNode::sum(self : CryptosignthresholdNode) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdNode::mean(self : CryptosignthresholdNode) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdNode::scale(self : CryptosignthresholdNode, f : Double) -> CryptosignthresholdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdNode::add(self : CryptosignthresholdNode, other : CryptosignthresholdNode) -> CryptosignthresholdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdNode::copy(self : CryptosignthresholdNode) -> CryptosignthresholdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdNode::fill(self : CryptosignthresholdNode, v : Double) -> CryptosignthresholdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdNode::min(self : CryptosignthresholdNode) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdNode::max(self : CryptosignthresholdNode) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdNode::to_string(self : CryptosignthresholdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_edge_make(size : Int) -> CryptosignthresholdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdEdge::len(self : CryptosignthresholdEdge) -> Int { self.size }

pub fn CryptosignthresholdEdge::get(self : CryptosignthresholdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdEdge::set(self : CryptosignthresholdEdge, i : Int, v : Double) -> CryptosignthresholdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdEdge::sum(self : CryptosignthresholdEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdEdge::mean(self : CryptosignthresholdEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdEdge::scale(self : CryptosignthresholdEdge, f : Double) -> CryptosignthresholdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdEdge::add(self : CryptosignthresholdEdge, other : CryptosignthresholdEdge) -> CryptosignthresholdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdEdge::copy(self : CryptosignthresholdEdge) -> CryptosignthresholdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdEdge::fill(self : CryptosignthresholdEdge, v : Double) -> CryptosignthresholdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdEdge::min(self : CryptosignthresholdEdge) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdEdge::max(self : CryptosignthresholdEdge) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdEdge::to_string(self : CryptosignthresholdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_path_make(size : Int) -> CryptosignthresholdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdPath::len(self : CryptosignthresholdPath) -> Int { self.size }

pub fn CryptosignthresholdPath::get(self : CryptosignthresholdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdPath::set(self : CryptosignthresholdPath, i : Int, v : Double) -> CryptosignthresholdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdPath::sum(self : CryptosignthresholdPath) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdPath::mean(self : CryptosignthresholdPath) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdPath::scale(self : CryptosignthresholdPath, f : Double) -> CryptosignthresholdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdPath::add(self : CryptosignthresholdPath, other : CryptosignthresholdPath) -> CryptosignthresholdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdPath::copy(self : CryptosignthresholdPath) -> CryptosignthresholdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdPath::fill(self : CryptosignthresholdPath, v : Double) -> CryptosignthresholdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdPath::min(self : CryptosignthresholdPath) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdPath::max(self : CryptosignthresholdPath) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdPath::to_string(self : CryptosignthresholdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_cluster_make(size : Int) -> CryptosignthresholdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdCluster::len(self : CryptosignthresholdCluster) -> Int { self.size }

pub fn CryptosignthresholdCluster::get(self : CryptosignthresholdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdCluster::set(self : CryptosignthresholdCluster, i : Int, v : Double) -> CryptosignthresholdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCluster::sum(self : CryptosignthresholdCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdCluster::mean(self : CryptosignthresholdCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdCluster::scale(self : CryptosignthresholdCluster, f : Double) -> CryptosignthresholdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCluster::add(self : CryptosignthresholdCluster, other : CryptosignthresholdCluster) -> CryptosignthresholdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdCluster::copy(self : CryptosignthresholdCluster) -> CryptosignthresholdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCluster::fill(self : CryptosignthresholdCluster, v : Double) -> CryptosignthresholdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCluster::min(self : CryptosignthresholdCluster) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdCluster::max(self : CryptosignthresholdCluster) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdCluster::to_string(self : CryptosignthresholdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_model_make(size : Int) -> CryptosignthresholdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdModel::len(self : CryptosignthresholdModel) -> Int { self.size }

pub fn CryptosignthresholdModel::get(self : CryptosignthresholdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdModel::set(self : CryptosignthresholdModel, i : Int, v : Double) -> CryptosignthresholdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdModel::sum(self : CryptosignthresholdModel) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdModel::mean(self : CryptosignthresholdModel) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdModel::scale(self : CryptosignthresholdModel, f : Double) -> CryptosignthresholdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdModel::add(self : CryptosignthresholdModel, other : CryptosignthresholdModel) -> CryptosignthresholdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdModel::copy(self : CryptosignthresholdModel) -> CryptosignthresholdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdModel::fill(self : CryptosignthresholdModel, v : Double) -> CryptosignthresholdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdModel::min(self : CryptosignthresholdModel) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdModel::max(self : CryptosignthresholdModel) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdModel::to_string(self : CryptosignthresholdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_layer_make(size : Int) -> CryptosignthresholdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdLayer::len(self : CryptosignthresholdLayer) -> Int { self.size }

pub fn CryptosignthresholdLayer::get(self : CryptosignthresholdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdLayer::set(self : CryptosignthresholdLayer, i : Int, v : Double) -> CryptosignthresholdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdLayer::sum(self : CryptosignthresholdLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdLayer::mean(self : CryptosignthresholdLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdLayer::scale(self : CryptosignthresholdLayer, f : Double) -> CryptosignthresholdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdLayer::add(self : CryptosignthresholdLayer, other : CryptosignthresholdLayer) -> CryptosignthresholdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdLayer::copy(self : CryptosignthresholdLayer) -> CryptosignthresholdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdLayer::fill(self : CryptosignthresholdLayer, v : Double) -> CryptosignthresholdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdLayer::min(self : CryptosignthresholdLayer) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdLayer::max(self : CryptosignthresholdLayer) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdLayer::to_string(self : CryptosignthresholdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_buffer_make(size : Int) -> CryptosignthresholdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdBuffer::len(self : CryptosignthresholdBuffer) -> Int { self.size }

pub fn CryptosignthresholdBuffer::get(self : CryptosignthresholdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdBuffer::set(self : CryptosignthresholdBuffer, i : Int, v : Double) -> CryptosignthresholdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdBuffer::sum(self : CryptosignthresholdBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdBuffer::mean(self : CryptosignthresholdBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdBuffer::scale(self : CryptosignthresholdBuffer, f : Double) -> CryptosignthresholdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdBuffer::add(self : CryptosignthresholdBuffer, other : CryptosignthresholdBuffer) -> CryptosignthresholdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdBuffer::copy(self : CryptosignthresholdBuffer) -> CryptosignthresholdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdBuffer::fill(self : CryptosignthresholdBuffer, v : Double) -> CryptosignthresholdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdBuffer::min(self : CryptosignthresholdBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdBuffer::max(self : CryptosignthresholdBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdBuffer::to_string(self : CryptosignthresholdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_cursor_make(size : Int) -> CryptosignthresholdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdCursor::len(self : CryptosignthresholdCursor) -> Int { self.size }

pub fn CryptosignthresholdCursor::get(self : CryptosignthresholdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdCursor::set(self : CryptosignthresholdCursor, i : Int, v : Double) -> CryptosignthresholdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCursor::sum(self : CryptosignthresholdCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdCursor::mean(self : CryptosignthresholdCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdCursor::scale(self : CryptosignthresholdCursor, f : Double) -> CryptosignthresholdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCursor::add(self : CryptosignthresholdCursor, other : CryptosignthresholdCursor) -> CryptosignthresholdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdCursor::copy(self : CryptosignthresholdCursor) -> CryptosignthresholdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCursor::fill(self : CryptosignthresholdCursor, v : Double) -> CryptosignthresholdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdCursor::min(self : CryptosignthresholdCursor) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdCursor::max(self : CryptosignthresholdCursor) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdCursor::to_string(self : CryptosignthresholdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_view_make(size : Int) -> CryptosignthresholdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdView::len(self : CryptosignthresholdView) -> Int { self.size }

pub fn CryptosignthresholdView::get(self : CryptosignthresholdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdView::set(self : CryptosignthresholdView, i : Int, v : Double) -> CryptosignthresholdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdView::sum(self : CryptosignthresholdView) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdView::mean(self : CryptosignthresholdView) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdView::scale(self : CryptosignthresholdView, f : Double) -> CryptosignthresholdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdView::add(self : CryptosignthresholdView, other : CryptosignthresholdView) -> CryptosignthresholdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdView::copy(self : CryptosignthresholdView) -> CryptosignthresholdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdView::fill(self : CryptosignthresholdView, v : Double) -> CryptosignthresholdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdView::min(self : CryptosignthresholdView) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdView::max(self : CryptosignthresholdView) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdView::to_string(self : CryptosignthresholdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_range_make(size : Int) -> CryptosignthresholdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdRange::len(self : CryptosignthresholdRange) -> Int { self.size }

pub fn CryptosignthresholdRange::get(self : CryptosignthresholdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdRange::set(self : CryptosignthresholdRange, i : Int, v : Double) -> CryptosignthresholdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdRange::sum(self : CryptosignthresholdRange) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdRange::mean(self : CryptosignthresholdRange) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdRange::scale(self : CryptosignthresholdRange, f : Double) -> CryptosignthresholdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdRange::add(self : CryptosignthresholdRange, other : CryptosignthresholdRange) -> CryptosignthresholdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdRange::copy(self : CryptosignthresholdRange) -> CryptosignthresholdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdRange::fill(self : CryptosignthresholdRange, v : Double) -> CryptosignthresholdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdRange::min(self : CryptosignthresholdRange) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdRange::max(self : CryptosignthresholdRange) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdRange::to_string(self : CryptosignthresholdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_slice_make(size : Int) -> CryptosignthresholdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignthresholdSlice::len(self : CryptosignthresholdSlice) -> Int { self.size }

pub fn CryptosignthresholdSlice::get(self : CryptosignthresholdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignthresholdSlice::set(self : CryptosignthresholdSlice, i : Int, v : Double) -> CryptosignthresholdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdSlice::sum(self : CryptosignthresholdSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosignthresholdSlice::mean(self : CryptosignthresholdSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosignthresholdSlice::scale(self : CryptosignthresholdSlice, f : Double) -> CryptosignthresholdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdSlice::add(self : CryptosignthresholdSlice, other : CryptosignthresholdSlice) -> CryptosignthresholdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignthresholdSlice::copy(self : CryptosignthresholdSlice) -> CryptosignthresholdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdSlice::fill(self : CryptosignthresholdSlice, v : Double) -> CryptosignthresholdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignthresholdSlice::min(self : CryptosignthresholdSlice) -> Double { @_common.min(self.data) }

pub fn CryptosignthresholdSlice::max(self : CryptosignthresholdSlice) -> Double { @_common.max(self.data) }

pub fn CryptosignthresholdSlice::to_string(self : CryptosignthresholdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

