///===
/// extcore/db_tx_acid

pub(all) struct DbtxacidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_acid_make_point(x : Double, y : Double) -> DbtxacidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_acid_make_point3(x : Double, y : Double, z : Double) -> DbtxacidPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxacidPoint::x(self : DbtxacidPoint) -> Double { self.x }

pub fn DbtxacidPoint::y(self : DbtxacidPoint) -> Double { self.y }

pub fn DbtxacidPoint::z(self : DbtxacidPoint) -> Double { self.z }

pub fn DbtxacidPoint::label(self : DbtxacidPoint) -> Int { self.label }

pub fn DbtxacidPoint::dist(self : DbtxacidPoint, other : DbtxacidPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxacidPoint::add(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxacidPoint::sub(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxacidPoint::scale(self : DbtxacidPoint, s : Double) -> DbtxacidPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxacidPoint::dot(self : DbtxacidPoint, other : DbtxacidPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxacidPoint::cross(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxacidPoint::norm(self : DbtxacidPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxacidPoint::normalize(self : DbtxacidPoint) -> DbtxacidPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxacidPoint::negate(self : DbtxacidPoint) -> DbtxacidPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxacidPoint::mid(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxacidPoint::lerp(self : DbtxacidPoint, other : DbtxacidPoint, t : Double) -> DbtxacidPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxacidPoint::to_string(self : DbtxacidPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxacidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_acid_make_series(vals : Array[Double], name : String) -> DbtxacidSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxacidSeries::len(self : DbtxacidSeries) -> Int { self.vals.length() }

pub fn DbtxacidSeries::sum(self : DbtxacidSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxacidSeries::mean(self : DbtxacidSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxacidSeries::min(self : DbtxacidSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxacidSeries::max(self : DbtxacidSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxacidSeries::range(self : DbtxacidSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxacidSeries::variance(self : DbtxacidSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxacidSeries::std(self : DbtxacidSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxacidSeries::median(self : DbtxacidSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxacidSeries::scale(self : DbtxacidSeries, f : Double) -> DbtxacidSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxacidSeries::add(self : DbtxacidSeries, other : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxacidSeries::sub(self : DbtxacidSeries, other : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxacidSeries::normalize(self : DbtxacidSeries) -> DbtxacidSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxacidSeries::cumsum(self : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxacidSeries::to_string(self : DbtxacidSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxacidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_acid_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxacidMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn db_tx_acid_matrix_identity(n : Int) -> DbtxacidMatrix {
  let m = db_tx_acid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxacidMatrix::get(self : DbtxacidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxacidMatrix::transpose(self : DbtxacidMatrix) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxacidMatrix::add(self : DbtxacidMatrix, other : DbtxacidMatrix) -> DbtxacidMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_acid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxacidMatrix::scale(self : DbtxacidMatrix, s : Double) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxacidMatrix::multiply(self : DbtxacidMatrix, other : DbtxacidMatrix) -> DbtxacidMatrix {
  if self.cols != other.rows { return db_tx_acid_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_acid_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbtxacidMatrix::trace(self : DbtxacidMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxacidMatrix::det(self : DbtxacidMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxacidMatrix::norm(self : DbtxacidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxacidMatrix::to_string(self : DbtxacidMatrix) -> String {
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

pub(all) struct DbtxacidVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_acid_make_vector(comps : Array[Double]) -> DbtxacidVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_acid_vector_zero(dim : Int) -> DbtxacidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxacidVector::add(self : DbtxacidVector, other : DbtxacidVector) -> DbtxacidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxacidVector::sub(self : DbtxacidVector, other : DbtxacidVector) -> DbtxacidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxacidVector::scale(self : DbtxacidVector, s : Double) -> DbtxacidVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxacidVector::dot(self : DbtxacidVector, other : DbtxacidVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxacidVector::norm(self : DbtxacidVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxacidVector::normalize(self : DbtxacidVector) -> DbtxacidVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxacidVector::dist(self : DbtxacidVector, other : DbtxacidVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxacidVector::to_string(self : DbtxacidVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxacidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_frame_make(size : Int) -> DbtxacidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidFrame::len(self : DbtxacidFrame) -> Int { self.size }

pub fn DbtxacidFrame::get(self : DbtxacidFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidFrame::set(self : DbtxacidFrame, i : Int, v : Double) -> DbtxacidFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidFrame::sum(self : DbtxacidFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxacidFrame::mean(self : DbtxacidFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxacidFrame::scale(self : DbtxacidFrame, f : Double) -> DbtxacidFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidFrame::add(self : DbtxacidFrame, other : DbtxacidFrame) -> DbtxacidFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidFrame::copy(self : DbtxacidFrame) -> DbtxacidFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidFrame::fill(self : DbtxacidFrame, v : Double) -> DbtxacidFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidFrame::min(self : DbtxacidFrame) -> Double { @_common.min(self.data) }

pub fn DbtxacidFrame::max(self : DbtxacidFrame) -> Double { @_common.max(self.data) }

pub fn DbtxacidFrame::to_string(self : DbtxacidFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_table_make(size : Int) -> DbtxacidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidTable::len(self : DbtxacidTable) -> Int { self.size }

pub fn DbtxacidTable::get(self : DbtxacidTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidTable::set(self : DbtxacidTable, i : Int, v : Double) -> DbtxacidTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidTable::sum(self : DbtxacidTable) -> Double { @_common.sum(self.data) }

pub fn DbtxacidTable::mean(self : DbtxacidTable) -> Double { @_common.mean(self.data) }

pub fn DbtxacidTable::scale(self : DbtxacidTable, f : Double) -> DbtxacidTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidTable::add(self : DbtxacidTable, other : DbtxacidTable) -> DbtxacidTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidTable::copy(self : DbtxacidTable) -> DbtxacidTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidTable::fill(self : DbtxacidTable, v : Double) -> DbtxacidTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidTable::min(self : DbtxacidTable) -> Double { @_common.min(self.data) }

pub fn DbtxacidTable::max(self : DbtxacidTable) -> Double { @_common.max(self.data) }

pub fn DbtxacidTable::to_string(self : DbtxacidTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_graphn_make(size : Int) -> DbtxacidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidGraphN::len(self : DbtxacidGraphN) -> Int { self.size }

pub fn DbtxacidGraphN::get(self : DbtxacidGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidGraphN::set(self : DbtxacidGraphN, i : Int, v : Double) -> DbtxacidGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidGraphN::sum(self : DbtxacidGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxacidGraphN::mean(self : DbtxacidGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxacidGraphN::scale(self : DbtxacidGraphN, f : Double) -> DbtxacidGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidGraphN::add(self : DbtxacidGraphN, other : DbtxacidGraphN) -> DbtxacidGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidGraphN::copy(self : DbtxacidGraphN) -> DbtxacidGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidGraphN::fill(self : DbtxacidGraphN, v : Double) -> DbtxacidGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidGraphN::min(self : DbtxacidGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxacidGraphN::max(self : DbtxacidGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxacidGraphN::to_string(self : DbtxacidGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_node_make(size : Int) -> DbtxacidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidNode::len(self : DbtxacidNode) -> Int { self.size }

pub fn DbtxacidNode::get(self : DbtxacidNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidNode::set(self : DbtxacidNode, i : Int, v : Double) -> DbtxacidNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidNode::sum(self : DbtxacidNode) -> Double { @_common.sum(self.data) }

pub fn DbtxacidNode::mean(self : DbtxacidNode) -> Double { @_common.mean(self.data) }

pub fn DbtxacidNode::scale(self : DbtxacidNode, f : Double) -> DbtxacidNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidNode::add(self : DbtxacidNode, other : DbtxacidNode) -> DbtxacidNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidNode::copy(self : DbtxacidNode) -> DbtxacidNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidNode::fill(self : DbtxacidNode, v : Double) -> DbtxacidNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidNode::min(self : DbtxacidNode) -> Double { @_common.min(self.data) }

pub fn DbtxacidNode::max(self : DbtxacidNode) -> Double { @_common.max(self.data) }

pub fn DbtxacidNode::to_string(self : DbtxacidNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_edge_make(size : Int) -> DbtxacidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidEdge::len(self : DbtxacidEdge) -> Int { self.size }

pub fn DbtxacidEdge::get(self : DbtxacidEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidEdge::set(self : DbtxacidEdge, i : Int, v : Double) -> DbtxacidEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidEdge::sum(self : DbtxacidEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxacidEdge::mean(self : DbtxacidEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxacidEdge::scale(self : DbtxacidEdge, f : Double) -> DbtxacidEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidEdge::add(self : DbtxacidEdge, other : DbtxacidEdge) -> DbtxacidEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidEdge::copy(self : DbtxacidEdge) -> DbtxacidEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidEdge::fill(self : DbtxacidEdge, v : Double) -> DbtxacidEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidEdge::min(self : DbtxacidEdge) -> Double { @_common.min(self.data) }

pub fn DbtxacidEdge::max(self : DbtxacidEdge) -> Double { @_common.max(self.data) }

pub fn DbtxacidEdge::to_string(self : DbtxacidEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_path_make(size : Int) -> DbtxacidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidPath::len(self : DbtxacidPath) -> Int { self.size }

pub fn DbtxacidPath::get(self : DbtxacidPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidPath::set(self : DbtxacidPath, i : Int, v : Double) -> DbtxacidPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidPath::sum(self : DbtxacidPath) -> Double { @_common.sum(self.data) }

pub fn DbtxacidPath::mean(self : DbtxacidPath) -> Double { @_common.mean(self.data) }

pub fn DbtxacidPath::scale(self : DbtxacidPath, f : Double) -> DbtxacidPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidPath::add(self : DbtxacidPath, other : DbtxacidPath) -> DbtxacidPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidPath::copy(self : DbtxacidPath) -> DbtxacidPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidPath::fill(self : DbtxacidPath, v : Double) -> DbtxacidPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidPath::min(self : DbtxacidPath) -> Double { @_common.min(self.data) }

pub fn DbtxacidPath::max(self : DbtxacidPath) -> Double { @_common.max(self.data) }

pub fn DbtxacidPath::to_string(self : DbtxacidPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cluster_make(size : Int) -> DbtxacidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidCluster::len(self : DbtxacidCluster) -> Int { self.size }

pub fn DbtxacidCluster::get(self : DbtxacidCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidCluster::set(self : DbtxacidCluster, i : Int, v : Double) -> DbtxacidCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidCluster::sum(self : DbtxacidCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxacidCluster::mean(self : DbtxacidCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxacidCluster::scale(self : DbtxacidCluster, f : Double) -> DbtxacidCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidCluster::add(self : DbtxacidCluster, other : DbtxacidCluster) -> DbtxacidCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidCluster::copy(self : DbtxacidCluster) -> DbtxacidCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidCluster::fill(self : DbtxacidCluster, v : Double) -> DbtxacidCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidCluster::min(self : DbtxacidCluster) -> Double { @_common.min(self.data) }

pub fn DbtxacidCluster::max(self : DbtxacidCluster) -> Double { @_common.max(self.data) }

pub fn DbtxacidCluster::to_string(self : DbtxacidCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_model_make(size : Int) -> DbtxacidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidModel::len(self : DbtxacidModel) -> Int { self.size }

pub fn DbtxacidModel::get(self : DbtxacidModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidModel::set(self : DbtxacidModel, i : Int, v : Double) -> DbtxacidModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidModel::sum(self : DbtxacidModel) -> Double { @_common.sum(self.data) }

pub fn DbtxacidModel::mean(self : DbtxacidModel) -> Double { @_common.mean(self.data) }

pub fn DbtxacidModel::scale(self : DbtxacidModel, f : Double) -> DbtxacidModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidModel::add(self : DbtxacidModel, other : DbtxacidModel) -> DbtxacidModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidModel::copy(self : DbtxacidModel) -> DbtxacidModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidModel::fill(self : DbtxacidModel, v : Double) -> DbtxacidModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidModel::min(self : DbtxacidModel) -> Double { @_common.min(self.data) }

pub fn DbtxacidModel::max(self : DbtxacidModel) -> Double { @_common.max(self.data) }

pub fn DbtxacidModel::to_string(self : DbtxacidModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_layer_make(size : Int) -> DbtxacidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidLayer::len(self : DbtxacidLayer) -> Int { self.size }

pub fn DbtxacidLayer::get(self : DbtxacidLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidLayer::set(self : DbtxacidLayer, i : Int, v : Double) -> DbtxacidLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidLayer::sum(self : DbtxacidLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxacidLayer::mean(self : DbtxacidLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxacidLayer::scale(self : DbtxacidLayer, f : Double) -> DbtxacidLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidLayer::add(self : DbtxacidLayer, other : DbtxacidLayer) -> DbtxacidLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidLayer::copy(self : DbtxacidLayer) -> DbtxacidLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidLayer::fill(self : DbtxacidLayer, v : Double) -> DbtxacidLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidLayer::min(self : DbtxacidLayer) -> Double { @_common.min(self.data) }

pub fn DbtxacidLayer::max(self : DbtxacidLayer) -> Double { @_common.max(self.data) }

pub fn DbtxacidLayer::to_string(self : DbtxacidLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_buffer_make(size : Int) -> DbtxacidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidBuffer::len(self : DbtxacidBuffer) -> Int { self.size }

pub fn DbtxacidBuffer::get(self : DbtxacidBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidBuffer::set(self : DbtxacidBuffer, i : Int, v : Double) -> DbtxacidBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidBuffer::sum(self : DbtxacidBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxacidBuffer::mean(self : DbtxacidBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxacidBuffer::scale(self : DbtxacidBuffer, f : Double) -> DbtxacidBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidBuffer::add(self : DbtxacidBuffer, other : DbtxacidBuffer) -> DbtxacidBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidBuffer::copy(self : DbtxacidBuffer) -> DbtxacidBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidBuffer::fill(self : DbtxacidBuffer, v : Double) -> DbtxacidBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidBuffer::min(self : DbtxacidBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxacidBuffer::max(self : DbtxacidBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxacidBuffer::to_string(self : DbtxacidBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cursor_make(size : Int) -> DbtxacidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidCursor::len(self : DbtxacidCursor) -> Int { self.size }

pub fn DbtxacidCursor::get(self : DbtxacidCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidCursor::set(self : DbtxacidCursor, i : Int, v : Double) -> DbtxacidCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidCursor::sum(self : DbtxacidCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxacidCursor::mean(self : DbtxacidCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxacidCursor::scale(self : DbtxacidCursor, f : Double) -> DbtxacidCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidCursor::add(self : DbtxacidCursor, other : DbtxacidCursor) -> DbtxacidCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidCursor::copy(self : DbtxacidCursor) -> DbtxacidCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidCursor::fill(self : DbtxacidCursor, v : Double) -> DbtxacidCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidCursor::min(self : DbtxacidCursor) -> Double { @_common.min(self.data) }

pub fn DbtxacidCursor::max(self : DbtxacidCursor) -> Double { @_common.max(self.data) }

pub fn DbtxacidCursor::to_string(self : DbtxacidCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_view_make(size : Int) -> DbtxacidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidView::len(self : DbtxacidView) -> Int { self.size }

pub fn DbtxacidView::get(self : DbtxacidView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidView::set(self : DbtxacidView, i : Int, v : Double) -> DbtxacidView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidView::sum(self : DbtxacidView) -> Double { @_common.sum(self.data) }

pub fn DbtxacidView::mean(self : DbtxacidView) -> Double { @_common.mean(self.data) }

pub fn DbtxacidView::scale(self : DbtxacidView, f : Double) -> DbtxacidView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidView::add(self : DbtxacidView, other : DbtxacidView) -> DbtxacidView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidView::copy(self : DbtxacidView) -> DbtxacidView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidView::fill(self : DbtxacidView, v : Double) -> DbtxacidView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidView::min(self : DbtxacidView) -> Double { @_common.min(self.data) }

pub fn DbtxacidView::max(self : DbtxacidView) -> Double { @_common.max(self.data) }

pub fn DbtxacidView::to_string(self : DbtxacidView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_range_make(size : Int) -> DbtxacidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidRange::len(self : DbtxacidRange) -> Int { self.size }

pub fn DbtxacidRange::get(self : DbtxacidRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidRange::set(self : DbtxacidRange, i : Int, v : Double) -> DbtxacidRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidRange::sum(self : DbtxacidRange) -> Double { @_common.sum(self.data) }

pub fn DbtxacidRange::mean(self : DbtxacidRange) -> Double { @_common.mean(self.data) }

pub fn DbtxacidRange::scale(self : DbtxacidRange, f : Double) -> DbtxacidRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidRange::add(self : DbtxacidRange, other : DbtxacidRange) -> DbtxacidRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidRange::copy(self : DbtxacidRange) -> DbtxacidRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidRange::fill(self : DbtxacidRange, v : Double) -> DbtxacidRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidRange::min(self : DbtxacidRange) -> Double { @_common.min(self.data) }

pub fn DbtxacidRange::max(self : DbtxacidRange) -> Double { @_common.max(self.data) }

pub fn DbtxacidRange::to_string(self : DbtxacidRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxacidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_slice_make(size : Int) -> DbtxacidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxacidSlice::len(self : DbtxacidSlice) -> Int { self.size }

pub fn DbtxacidSlice::get(self : DbtxacidSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxacidSlice::set(self : DbtxacidSlice, i : Int, v : Double) -> DbtxacidSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxacidSlice::sum(self : DbtxacidSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxacidSlice::mean(self : DbtxacidSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxacidSlice::scale(self : DbtxacidSlice, f : Double) -> DbtxacidSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxacidSlice::add(self : DbtxacidSlice, other : DbtxacidSlice) -> DbtxacidSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxacidSlice::copy(self : DbtxacidSlice) -> DbtxacidSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxacidSlice::fill(self : DbtxacidSlice, v : Double) -> DbtxacidSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxacidSlice::min(self : DbtxacidSlice) -> Double { @_common.min(self.data) }

pub fn DbtxacidSlice::max(self : DbtxacidSlice) -> Double { @_common.max(self.data) }

pub fn DbtxacidSlice::to_string(self : DbtxacidSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

