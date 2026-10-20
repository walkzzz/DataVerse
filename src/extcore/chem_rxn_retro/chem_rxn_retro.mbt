///===
/// extcore/chem_rxn_retro

pub(all) struct ChemrxnretroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_retro_make_point(x : Double, y : Double) -> ChemrxnretroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_retro_make_point3(x : Double, y : Double, z : Double) -> ChemrxnretroPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnretroPoint::x(self : ChemrxnretroPoint) -> Double { self.x }

pub fn ChemrxnretroPoint::y(self : ChemrxnretroPoint) -> Double { self.y }

pub fn ChemrxnretroPoint::z(self : ChemrxnretroPoint) -> Double { self.z }

pub fn ChemrxnretroPoint::label(self : ChemrxnretroPoint) -> Int { self.label }

pub fn ChemrxnretroPoint::dist(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnretroPoint::add(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnretroPoint::sub(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnretroPoint::scale(self : ChemrxnretroPoint, s : Double) -> ChemrxnretroPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnretroPoint::dot(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnretroPoint::cross(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnretroPoint::norm(self : ChemrxnretroPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnretroPoint::normalize(self : ChemrxnretroPoint) -> ChemrxnretroPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnretroPoint::negate(self : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnretroPoint::mid(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnretroPoint::lerp(self : ChemrxnretroPoint, other : ChemrxnretroPoint, t : Double) -> ChemrxnretroPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnretroPoint::to_string(self : ChemrxnretroPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnretroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_retro_make_series(vals : Array[Double], name : String) -> ChemrxnretroSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnretroSeries::len(self : ChemrxnretroSeries) -> Int { self.vals.length() }

pub fn ChemrxnretroSeries::sum(self : ChemrxnretroSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnretroSeries::mean(self : ChemrxnretroSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnretroSeries::min(self : ChemrxnretroSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnretroSeries::max(self : ChemrxnretroSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnretroSeries::range(self : ChemrxnretroSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnretroSeries::variance(self : ChemrxnretroSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnretroSeries::std(self : ChemrxnretroSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnretroSeries::median(self : ChemrxnretroSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnretroSeries::scale(self : ChemrxnretroSeries, f : Double) -> ChemrxnretroSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnretroSeries::add(self : ChemrxnretroSeries, other : ChemrxnretroSeries) -> ChemrxnretroSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnretroSeries::sub(self : ChemrxnretroSeries, other : ChemrxnretroSeries) -> ChemrxnretroSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnretroSeries::normalize(self : ChemrxnretroSeries) -> ChemrxnretroSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnretroSeries::cumsum(self : ChemrxnretroSeries) -> ChemrxnretroSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnretroSeries::to_string(self : ChemrxnretroSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnretroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_retro_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnretroMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_rxn_retro_matrix_identity(n : Int) -> ChemrxnretroMatrix {
  let m = chem_rxn_retro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnretroMatrix::get(self : ChemrxnretroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnretroMatrix::transpose(self : ChemrxnretroMatrix) -> ChemrxnretroMatrix {
  let result = chem_rxn_retro_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnretroMatrix::add(self : ChemrxnretroMatrix, other : ChemrxnretroMatrix) -> ChemrxnretroMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_retro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnretroMatrix::scale(self : ChemrxnretroMatrix, s : Double) -> ChemrxnretroMatrix {
  let result = chem_rxn_retro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnretroMatrix::multiply(self : ChemrxnretroMatrix, other : ChemrxnretroMatrix) -> ChemrxnretroMatrix {
  if self.cols != other.rows { return chem_rxn_retro_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_retro_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemrxnretroMatrix::trace(self : ChemrxnretroMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnretroMatrix::det(self : ChemrxnretroMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnretroMatrix::norm(self : ChemrxnretroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnretroMatrix::to_string(self : ChemrxnretroMatrix) -> String {
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

pub(all) struct ChemrxnretroVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_retro_make_vector(comps : Array[Double]) -> ChemrxnretroVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_retro_vector_zero(dim : Int) -> ChemrxnretroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnretroVector::add(self : ChemrxnretroVector, other : ChemrxnretroVector) -> ChemrxnretroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnretroVector::sub(self : ChemrxnretroVector, other : ChemrxnretroVector) -> ChemrxnretroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnretroVector::scale(self : ChemrxnretroVector, s : Double) -> ChemrxnretroVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnretroVector::dot(self : ChemrxnretroVector, other : ChemrxnretroVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnretroVector::norm(self : ChemrxnretroVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnretroVector::normalize(self : ChemrxnretroVector) -> ChemrxnretroVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnretroVector::dist(self : ChemrxnretroVector, other : ChemrxnretroVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnretroVector::to_string(self : ChemrxnretroVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnretroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_frame_make(size : Int) -> ChemrxnretroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroFrame::len(self : ChemrxnretroFrame) -> Int { self.size }

pub fn ChemrxnretroFrame::get(self : ChemrxnretroFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroFrame::set(self : ChemrxnretroFrame, i : Int, v : Double) -> ChemrxnretroFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroFrame::sum(self : ChemrxnretroFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroFrame::mean(self : ChemrxnretroFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroFrame::scale(self : ChemrxnretroFrame, f : Double) -> ChemrxnretroFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroFrame::add(self : ChemrxnretroFrame, other : ChemrxnretroFrame) -> ChemrxnretroFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroFrame::copy(self : ChemrxnretroFrame) -> ChemrxnretroFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroFrame::fill(self : ChemrxnretroFrame, v : Double) -> ChemrxnretroFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroFrame::min(self : ChemrxnretroFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroFrame::max(self : ChemrxnretroFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroFrame::to_string(self : ChemrxnretroFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_table_make(size : Int) -> ChemrxnretroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroTable::len(self : ChemrxnretroTable) -> Int { self.size }

pub fn ChemrxnretroTable::get(self : ChemrxnretroTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroTable::set(self : ChemrxnretroTable, i : Int, v : Double) -> ChemrxnretroTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroTable::sum(self : ChemrxnretroTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroTable::mean(self : ChemrxnretroTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroTable::scale(self : ChemrxnretroTable, f : Double) -> ChemrxnretroTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroTable::add(self : ChemrxnretroTable, other : ChemrxnretroTable) -> ChemrxnretroTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroTable::copy(self : ChemrxnretroTable) -> ChemrxnretroTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroTable::fill(self : ChemrxnretroTable, v : Double) -> ChemrxnretroTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroTable::min(self : ChemrxnretroTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroTable::max(self : ChemrxnretroTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroTable::to_string(self : ChemrxnretroTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_graphn_make(size : Int) -> ChemrxnretroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroGraphN::len(self : ChemrxnretroGraphN) -> Int { self.size }

pub fn ChemrxnretroGraphN::get(self : ChemrxnretroGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroGraphN::set(self : ChemrxnretroGraphN, i : Int, v : Double) -> ChemrxnretroGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroGraphN::sum(self : ChemrxnretroGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroGraphN::mean(self : ChemrxnretroGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroGraphN::scale(self : ChemrxnretroGraphN, f : Double) -> ChemrxnretroGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroGraphN::add(self : ChemrxnretroGraphN, other : ChemrxnretroGraphN) -> ChemrxnretroGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroGraphN::copy(self : ChemrxnretroGraphN) -> ChemrxnretroGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroGraphN::fill(self : ChemrxnretroGraphN, v : Double) -> ChemrxnretroGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroGraphN::min(self : ChemrxnretroGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroGraphN::max(self : ChemrxnretroGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroGraphN::to_string(self : ChemrxnretroGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_node_make(size : Int) -> ChemrxnretroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroNode::len(self : ChemrxnretroNode) -> Int { self.size }

pub fn ChemrxnretroNode::get(self : ChemrxnretroNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroNode::set(self : ChemrxnretroNode, i : Int, v : Double) -> ChemrxnretroNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroNode::sum(self : ChemrxnretroNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroNode::mean(self : ChemrxnretroNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroNode::scale(self : ChemrxnretroNode, f : Double) -> ChemrxnretroNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroNode::add(self : ChemrxnretroNode, other : ChemrxnretroNode) -> ChemrxnretroNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroNode::copy(self : ChemrxnretroNode) -> ChemrxnretroNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroNode::fill(self : ChemrxnretroNode, v : Double) -> ChemrxnretroNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroNode::min(self : ChemrxnretroNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroNode::max(self : ChemrxnretroNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroNode::to_string(self : ChemrxnretroNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_edge_make(size : Int) -> ChemrxnretroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroEdge::len(self : ChemrxnretroEdge) -> Int { self.size }

pub fn ChemrxnretroEdge::get(self : ChemrxnretroEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroEdge::set(self : ChemrxnretroEdge, i : Int, v : Double) -> ChemrxnretroEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroEdge::sum(self : ChemrxnretroEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroEdge::mean(self : ChemrxnretroEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroEdge::scale(self : ChemrxnretroEdge, f : Double) -> ChemrxnretroEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroEdge::add(self : ChemrxnretroEdge, other : ChemrxnretroEdge) -> ChemrxnretroEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroEdge::copy(self : ChemrxnretroEdge) -> ChemrxnretroEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroEdge::fill(self : ChemrxnretroEdge, v : Double) -> ChemrxnretroEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroEdge::min(self : ChemrxnretroEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroEdge::max(self : ChemrxnretroEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroEdge::to_string(self : ChemrxnretroEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_path_make(size : Int) -> ChemrxnretroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroPath::len(self : ChemrxnretroPath) -> Int { self.size }

pub fn ChemrxnretroPath::get(self : ChemrxnretroPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroPath::set(self : ChemrxnretroPath, i : Int, v : Double) -> ChemrxnretroPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroPath::sum(self : ChemrxnretroPath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroPath::mean(self : ChemrxnretroPath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroPath::scale(self : ChemrxnretroPath, f : Double) -> ChemrxnretroPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroPath::add(self : ChemrxnretroPath, other : ChemrxnretroPath) -> ChemrxnretroPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroPath::copy(self : ChemrxnretroPath) -> ChemrxnretroPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroPath::fill(self : ChemrxnretroPath, v : Double) -> ChemrxnretroPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroPath::min(self : ChemrxnretroPath) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroPath::max(self : ChemrxnretroPath) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroPath::to_string(self : ChemrxnretroPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_cluster_make(size : Int) -> ChemrxnretroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroCluster::len(self : ChemrxnretroCluster) -> Int { self.size }

pub fn ChemrxnretroCluster::get(self : ChemrxnretroCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroCluster::set(self : ChemrxnretroCluster, i : Int, v : Double) -> ChemrxnretroCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCluster::sum(self : ChemrxnretroCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroCluster::mean(self : ChemrxnretroCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroCluster::scale(self : ChemrxnretroCluster, f : Double) -> ChemrxnretroCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCluster::add(self : ChemrxnretroCluster, other : ChemrxnretroCluster) -> ChemrxnretroCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroCluster::copy(self : ChemrxnretroCluster) -> ChemrxnretroCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCluster::fill(self : ChemrxnretroCluster, v : Double) -> ChemrxnretroCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCluster::min(self : ChemrxnretroCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroCluster::max(self : ChemrxnretroCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroCluster::to_string(self : ChemrxnretroCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_model_make(size : Int) -> ChemrxnretroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroModel::len(self : ChemrxnretroModel) -> Int { self.size }

pub fn ChemrxnretroModel::get(self : ChemrxnretroModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroModel::set(self : ChemrxnretroModel, i : Int, v : Double) -> ChemrxnretroModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroModel::sum(self : ChemrxnretroModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroModel::mean(self : ChemrxnretroModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroModel::scale(self : ChemrxnretroModel, f : Double) -> ChemrxnretroModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroModel::add(self : ChemrxnretroModel, other : ChemrxnretroModel) -> ChemrxnretroModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroModel::copy(self : ChemrxnretroModel) -> ChemrxnretroModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroModel::fill(self : ChemrxnretroModel, v : Double) -> ChemrxnretroModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroModel::min(self : ChemrxnretroModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroModel::max(self : ChemrxnretroModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroModel::to_string(self : ChemrxnretroModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_layer_make(size : Int) -> ChemrxnretroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroLayer::len(self : ChemrxnretroLayer) -> Int { self.size }

pub fn ChemrxnretroLayer::get(self : ChemrxnretroLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroLayer::set(self : ChemrxnretroLayer, i : Int, v : Double) -> ChemrxnretroLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroLayer::sum(self : ChemrxnretroLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroLayer::mean(self : ChemrxnretroLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroLayer::scale(self : ChemrxnretroLayer, f : Double) -> ChemrxnretroLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroLayer::add(self : ChemrxnretroLayer, other : ChemrxnretroLayer) -> ChemrxnretroLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroLayer::copy(self : ChemrxnretroLayer) -> ChemrxnretroLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroLayer::fill(self : ChemrxnretroLayer, v : Double) -> ChemrxnretroLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroLayer::min(self : ChemrxnretroLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroLayer::max(self : ChemrxnretroLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroLayer::to_string(self : ChemrxnretroLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_buffer_make(size : Int) -> ChemrxnretroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroBuffer::len(self : ChemrxnretroBuffer) -> Int { self.size }

pub fn ChemrxnretroBuffer::get(self : ChemrxnretroBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroBuffer::set(self : ChemrxnretroBuffer, i : Int, v : Double) -> ChemrxnretroBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroBuffer::sum(self : ChemrxnretroBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroBuffer::mean(self : ChemrxnretroBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroBuffer::scale(self : ChemrxnretroBuffer, f : Double) -> ChemrxnretroBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroBuffer::add(self : ChemrxnretroBuffer, other : ChemrxnretroBuffer) -> ChemrxnretroBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroBuffer::copy(self : ChemrxnretroBuffer) -> ChemrxnretroBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroBuffer::fill(self : ChemrxnretroBuffer, v : Double) -> ChemrxnretroBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroBuffer::min(self : ChemrxnretroBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroBuffer::max(self : ChemrxnretroBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroBuffer::to_string(self : ChemrxnretroBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_cursor_make(size : Int) -> ChemrxnretroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroCursor::len(self : ChemrxnretroCursor) -> Int { self.size }

pub fn ChemrxnretroCursor::get(self : ChemrxnretroCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroCursor::set(self : ChemrxnretroCursor, i : Int, v : Double) -> ChemrxnretroCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCursor::sum(self : ChemrxnretroCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroCursor::mean(self : ChemrxnretroCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroCursor::scale(self : ChemrxnretroCursor, f : Double) -> ChemrxnretroCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCursor::add(self : ChemrxnretroCursor, other : ChemrxnretroCursor) -> ChemrxnretroCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroCursor::copy(self : ChemrxnretroCursor) -> ChemrxnretroCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCursor::fill(self : ChemrxnretroCursor, v : Double) -> ChemrxnretroCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroCursor::min(self : ChemrxnretroCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroCursor::max(self : ChemrxnretroCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroCursor::to_string(self : ChemrxnretroCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_view_make(size : Int) -> ChemrxnretroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroView::len(self : ChemrxnretroView) -> Int { self.size }

pub fn ChemrxnretroView::get(self : ChemrxnretroView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroView::set(self : ChemrxnretroView, i : Int, v : Double) -> ChemrxnretroView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroView::sum(self : ChemrxnretroView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroView::mean(self : ChemrxnretroView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroView::scale(self : ChemrxnretroView, f : Double) -> ChemrxnretroView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroView::add(self : ChemrxnretroView, other : ChemrxnretroView) -> ChemrxnretroView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroView::copy(self : ChemrxnretroView) -> ChemrxnretroView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroView::fill(self : ChemrxnretroView, v : Double) -> ChemrxnretroView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroView::min(self : ChemrxnretroView) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroView::max(self : ChemrxnretroView) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroView::to_string(self : ChemrxnretroView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_range_make(size : Int) -> ChemrxnretroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroRange::len(self : ChemrxnretroRange) -> Int { self.size }

pub fn ChemrxnretroRange::get(self : ChemrxnretroRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroRange::set(self : ChemrxnretroRange, i : Int, v : Double) -> ChemrxnretroRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroRange::sum(self : ChemrxnretroRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroRange::mean(self : ChemrxnretroRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroRange::scale(self : ChemrxnretroRange, f : Double) -> ChemrxnretroRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroRange::add(self : ChemrxnretroRange, other : ChemrxnretroRange) -> ChemrxnretroRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroRange::copy(self : ChemrxnretroRange) -> ChemrxnretroRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroRange::fill(self : ChemrxnretroRange, v : Double) -> ChemrxnretroRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroRange::min(self : ChemrxnretroRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroRange::max(self : ChemrxnretroRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroRange::to_string(self : ChemrxnretroRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_slice_make(size : Int) -> ChemrxnretroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnretroSlice::len(self : ChemrxnretroSlice) -> Int { self.size }

pub fn ChemrxnretroSlice::get(self : ChemrxnretroSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnretroSlice::set(self : ChemrxnretroSlice, i : Int, v : Double) -> ChemrxnretroSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnretroSlice::sum(self : ChemrxnretroSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnretroSlice::mean(self : ChemrxnretroSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnretroSlice::scale(self : ChemrxnretroSlice, f : Double) -> ChemrxnretroSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroSlice::add(self : ChemrxnretroSlice, other : ChemrxnretroSlice) -> ChemrxnretroSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnretroSlice::copy(self : ChemrxnretroSlice) -> ChemrxnretroSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroSlice::fill(self : ChemrxnretroSlice, v : Double) -> ChemrxnretroSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnretroSlice::min(self : ChemrxnretroSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnretroSlice::max(self : ChemrxnretroSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnretroSlice::to_string(self : ChemrxnretroSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

