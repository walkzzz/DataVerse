///===
/// extcore/chem_rxn_yield

pub(all) struct ChemrxnyieldPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_yield_make_point(x : Double, y : Double) -> ChemrxnyieldPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_yield_make_point3(x : Double, y : Double, z : Double) -> ChemrxnyieldPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnyieldPoint::x(self : ChemrxnyieldPoint) -> Double { self.x }

pub fn ChemrxnyieldPoint::y(self : ChemrxnyieldPoint) -> Double { self.y }

pub fn ChemrxnyieldPoint::z(self : ChemrxnyieldPoint) -> Double { self.z }

pub fn ChemrxnyieldPoint::label(self : ChemrxnyieldPoint) -> Int { self.label }

pub fn ChemrxnyieldPoint::dist(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnyieldPoint::add(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnyieldPoint::sub(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnyieldPoint::scale(self : ChemrxnyieldPoint, s : Double) -> ChemrxnyieldPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnyieldPoint::dot(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnyieldPoint::cross(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnyieldPoint::norm(self : ChemrxnyieldPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnyieldPoint::normalize(self : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnyieldPoint::negate(self : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnyieldPoint::mid(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint) -> ChemrxnyieldPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnyieldPoint::lerp(self : ChemrxnyieldPoint, other : ChemrxnyieldPoint, t : Double) -> ChemrxnyieldPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnyieldPoint::to_string(self : ChemrxnyieldPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnyieldSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_yield_make_series(vals : Array[Double], name : String) -> ChemrxnyieldSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnyieldSeries::len(self : ChemrxnyieldSeries) -> Int { self.vals.length() }

pub fn ChemrxnyieldSeries::sum(self : ChemrxnyieldSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnyieldSeries::mean(self : ChemrxnyieldSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnyieldSeries::min(self : ChemrxnyieldSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnyieldSeries::max(self : ChemrxnyieldSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnyieldSeries::range(self : ChemrxnyieldSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnyieldSeries::variance(self : ChemrxnyieldSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnyieldSeries::std(self : ChemrxnyieldSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnyieldSeries::median(self : ChemrxnyieldSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnyieldSeries::scale(self : ChemrxnyieldSeries, f : Double) -> ChemrxnyieldSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnyieldSeries::add(self : ChemrxnyieldSeries, other : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnyieldSeries::sub(self : ChemrxnyieldSeries, other : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnyieldSeries::normalize(self : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnyieldSeries::cumsum(self : ChemrxnyieldSeries) -> ChemrxnyieldSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnyieldSeries::to_string(self : ChemrxnyieldSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnyieldMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_yield_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnyieldMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_yield_matrix_identity(n : Int) -> ChemrxnyieldMatrix {
  let m = chem_rxn_yield_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnyieldMatrix::get(self : ChemrxnyieldMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnyieldMatrix::transpose(self : ChemrxnyieldMatrix) -> ChemrxnyieldMatrix {
  let result = chem_rxn_yield_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnyieldMatrix::add(self : ChemrxnyieldMatrix, other : ChemrxnyieldMatrix) -> ChemrxnyieldMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_yield_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnyieldMatrix::scale(self : ChemrxnyieldMatrix, s : Double) -> ChemrxnyieldMatrix {
  let result = chem_rxn_yield_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnyieldMatrix::multiply(self : ChemrxnyieldMatrix, other : ChemrxnyieldMatrix) -> ChemrxnyieldMatrix {
  if self.cols != other.rows { return chem_rxn_yield_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_yield_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemrxnyieldMatrix::trace(self : ChemrxnyieldMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnyieldMatrix::det(self : ChemrxnyieldMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnyieldMatrix::norm(self : ChemrxnyieldMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnyieldMatrix::to_string(self : ChemrxnyieldMatrix) -> String {
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

pub(all) struct ChemrxnyieldVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_yield_make_vector(comps : Array[Double]) -> ChemrxnyieldVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_yield_vector_zero(dim : Int) -> ChemrxnyieldVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnyieldVector::add(self : ChemrxnyieldVector, other : ChemrxnyieldVector) -> ChemrxnyieldVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnyieldVector::sub(self : ChemrxnyieldVector, other : ChemrxnyieldVector) -> ChemrxnyieldVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnyieldVector::scale(self : ChemrxnyieldVector, s : Double) -> ChemrxnyieldVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnyieldVector::dot(self : ChemrxnyieldVector, other : ChemrxnyieldVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnyieldVector::norm(self : ChemrxnyieldVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnyieldVector::normalize(self : ChemrxnyieldVector) -> ChemrxnyieldVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnyieldVector::dist(self : ChemrxnyieldVector, other : ChemrxnyieldVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnyieldVector::to_string(self : ChemrxnyieldVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnyieldFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_frame_make(size : Int) -> ChemrxnyieldFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldFrame::len(self : ChemrxnyieldFrame) -> Int { self.size }

pub fn ChemrxnyieldFrame::get(self : ChemrxnyieldFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldFrame::set(self : ChemrxnyieldFrame, i : Int, v : Double) -> ChemrxnyieldFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldFrame::sum(self : ChemrxnyieldFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldFrame::mean(self : ChemrxnyieldFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldFrame::scale(self : ChemrxnyieldFrame, f : Double) -> ChemrxnyieldFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldFrame::add(self : ChemrxnyieldFrame, other : ChemrxnyieldFrame) -> ChemrxnyieldFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldFrame::copy(self : ChemrxnyieldFrame) -> ChemrxnyieldFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldFrame::fill(self : ChemrxnyieldFrame, v : Double) -> ChemrxnyieldFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldFrame::min(self : ChemrxnyieldFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldFrame::max(self : ChemrxnyieldFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldFrame::to_string(self : ChemrxnyieldFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_table_make(size : Int) -> ChemrxnyieldTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldTable::len(self : ChemrxnyieldTable) -> Int { self.size }

pub fn ChemrxnyieldTable::get(self : ChemrxnyieldTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldTable::set(self : ChemrxnyieldTable, i : Int, v : Double) -> ChemrxnyieldTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldTable::sum(self : ChemrxnyieldTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldTable::mean(self : ChemrxnyieldTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldTable::scale(self : ChemrxnyieldTable, f : Double) -> ChemrxnyieldTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldTable::add(self : ChemrxnyieldTable, other : ChemrxnyieldTable) -> ChemrxnyieldTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldTable::copy(self : ChemrxnyieldTable) -> ChemrxnyieldTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldTable::fill(self : ChemrxnyieldTable, v : Double) -> ChemrxnyieldTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldTable::min(self : ChemrxnyieldTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldTable::max(self : ChemrxnyieldTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldTable::to_string(self : ChemrxnyieldTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_graphn_make(size : Int) -> ChemrxnyieldGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldGraphN::len(self : ChemrxnyieldGraphN) -> Int { self.size }

pub fn ChemrxnyieldGraphN::get(self : ChemrxnyieldGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldGraphN::set(self : ChemrxnyieldGraphN, i : Int, v : Double) -> ChemrxnyieldGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldGraphN::sum(self : ChemrxnyieldGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldGraphN::mean(self : ChemrxnyieldGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldGraphN::scale(self : ChemrxnyieldGraphN, f : Double) -> ChemrxnyieldGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldGraphN::add(self : ChemrxnyieldGraphN, other : ChemrxnyieldGraphN) -> ChemrxnyieldGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldGraphN::copy(self : ChemrxnyieldGraphN) -> ChemrxnyieldGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldGraphN::fill(self : ChemrxnyieldGraphN, v : Double) -> ChemrxnyieldGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldGraphN::min(self : ChemrxnyieldGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldGraphN::max(self : ChemrxnyieldGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldGraphN::to_string(self : ChemrxnyieldGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_node_make(size : Int) -> ChemrxnyieldNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldNode::len(self : ChemrxnyieldNode) -> Int { self.size }

pub fn ChemrxnyieldNode::get(self : ChemrxnyieldNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldNode::set(self : ChemrxnyieldNode, i : Int, v : Double) -> ChemrxnyieldNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldNode::sum(self : ChemrxnyieldNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldNode::mean(self : ChemrxnyieldNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldNode::scale(self : ChemrxnyieldNode, f : Double) -> ChemrxnyieldNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldNode::add(self : ChemrxnyieldNode, other : ChemrxnyieldNode) -> ChemrxnyieldNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldNode::copy(self : ChemrxnyieldNode) -> ChemrxnyieldNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldNode::fill(self : ChemrxnyieldNode, v : Double) -> ChemrxnyieldNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldNode::min(self : ChemrxnyieldNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldNode::max(self : ChemrxnyieldNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldNode::to_string(self : ChemrxnyieldNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_edge_make(size : Int) -> ChemrxnyieldEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldEdge::len(self : ChemrxnyieldEdge) -> Int { self.size }

pub fn ChemrxnyieldEdge::get(self : ChemrxnyieldEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldEdge::set(self : ChemrxnyieldEdge, i : Int, v : Double) -> ChemrxnyieldEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldEdge::sum(self : ChemrxnyieldEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldEdge::mean(self : ChemrxnyieldEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldEdge::scale(self : ChemrxnyieldEdge, f : Double) -> ChemrxnyieldEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldEdge::add(self : ChemrxnyieldEdge, other : ChemrxnyieldEdge) -> ChemrxnyieldEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldEdge::copy(self : ChemrxnyieldEdge) -> ChemrxnyieldEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldEdge::fill(self : ChemrxnyieldEdge, v : Double) -> ChemrxnyieldEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldEdge::min(self : ChemrxnyieldEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldEdge::max(self : ChemrxnyieldEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldEdge::to_string(self : ChemrxnyieldEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_path_make(size : Int) -> ChemrxnyieldPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldPath::len(self : ChemrxnyieldPath) -> Int { self.size }

pub fn ChemrxnyieldPath::get(self : ChemrxnyieldPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldPath::set(self : ChemrxnyieldPath, i : Int, v : Double) -> ChemrxnyieldPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldPath::sum(self : ChemrxnyieldPath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldPath::mean(self : ChemrxnyieldPath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldPath::scale(self : ChemrxnyieldPath, f : Double) -> ChemrxnyieldPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldPath::add(self : ChemrxnyieldPath, other : ChemrxnyieldPath) -> ChemrxnyieldPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldPath::copy(self : ChemrxnyieldPath) -> ChemrxnyieldPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldPath::fill(self : ChemrxnyieldPath, v : Double) -> ChemrxnyieldPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldPath::min(self : ChemrxnyieldPath) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldPath::max(self : ChemrxnyieldPath) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldPath::to_string(self : ChemrxnyieldPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_cluster_make(size : Int) -> ChemrxnyieldCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldCluster::len(self : ChemrxnyieldCluster) -> Int { self.size }

pub fn ChemrxnyieldCluster::get(self : ChemrxnyieldCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldCluster::set(self : ChemrxnyieldCluster, i : Int, v : Double) -> ChemrxnyieldCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCluster::sum(self : ChemrxnyieldCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldCluster::mean(self : ChemrxnyieldCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldCluster::scale(self : ChemrxnyieldCluster, f : Double) -> ChemrxnyieldCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCluster::add(self : ChemrxnyieldCluster, other : ChemrxnyieldCluster) -> ChemrxnyieldCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldCluster::copy(self : ChemrxnyieldCluster) -> ChemrxnyieldCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCluster::fill(self : ChemrxnyieldCluster, v : Double) -> ChemrxnyieldCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCluster::min(self : ChemrxnyieldCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldCluster::max(self : ChemrxnyieldCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldCluster::to_string(self : ChemrxnyieldCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_model_make(size : Int) -> ChemrxnyieldModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldModel::len(self : ChemrxnyieldModel) -> Int { self.size }

pub fn ChemrxnyieldModel::get(self : ChemrxnyieldModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldModel::set(self : ChemrxnyieldModel, i : Int, v : Double) -> ChemrxnyieldModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldModel::sum(self : ChemrxnyieldModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldModel::mean(self : ChemrxnyieldModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldModel::scale(self : ChemrxnyieldModel, f : Double) -> ChemrxnyieldModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldModel::add(self : ChemrxnyieldModel, other : ChemrxnyieldModel) -> ChemrxnyieldModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldModel::copy(self : ChemrxnyieldModel) -> ChemrxnyieldModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldModel::fill(self : ChemrxnyieldModel, v : Double) -> ChemrxnyieldModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldModel::min(self : ChemrxnyieldModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldModel::max(self : ChemrxnyieldModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldModel::to_string(self : ChemrxnyieldModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_layer_make(size : Int) -> ChemrxnyieldLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldLayer::len(self : ChemrxnyieldLayer) -> Int { self.size }

pub fn ChemrxnyieldLayer::get(self : ChemrxnyieldLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldLayer::set(self : ChemrxnyieldLayer, i : Int, v : Double) -> ChemrxnyieldLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldLayer::sum(self : ChemrxnyieldLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldLayer::mean(self : ChemrxnyieldLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldLayer::scale(self : ChemrxnyieldLayer, f : Double) -> ChemrxnyieldLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldLayer::add(self : ChemrxnyieldLayer, other : ChemrxnyieldLayer) -> ChemrxnyieldLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldLayer::copy(self : ChemrxnyieldLayer) -> ChemrxnyieldLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldLayer::fill(self : ChemrxnyieldLayer, v : Double) -> ChemrxnyieldLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldLayer::min(self : ChemrxnyieldLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldLayer::max(self : ChemrxnyieldLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldLayer::to_string(self : ChemrxnyieldLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_buffer_make(size : Int) -> ChemrxnyieldBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldBuffer::len(self : ChemrxnyieldBuffer) -> Int { self.size }

pub fn ChemrxnyieldBuffer::get(self : ChemrxnyieldBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldBuffer::set(self : ChemrxnyieldBuffer, i : Int, v : Double) -> ChemrxnyieldBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldBuffer::sum(self : ChemrxnyieldBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldBuffer::mean(self : ChemrxnyieldBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldBuffer::scale(self : ChemrxnyieldBuffer, f : Double) -> ChemrxnyieldBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldBuffer::add(self : ChemrxnyieldBuffer, other : ChemrxnyieldBuffer) -> ChemrxnyieldBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldBuffer::copy(self : ChemrxnyieldBuffer) -> ChemrxnyieldBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldBuffer::fill(self : ChemrxnyieldBuffer, v : Double) -> ChemrxnyieldBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldBuffer::min(self : ChemrxnyieldBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldBuffer::max(self : ChemrxnyieldBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldBuffer::to_string(self : ChemrxnyieldBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_cursor_make(size : Int) -> ChemrxnyieldCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldCursor::len(self : ChemrxnyieldCursor) -> Int { self.size }

pub fn ChemrxnyieldCursor::get(self : ChemrxnyieldCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldCursor::set(self : ChemrxnyieldCursor, i : Int, v : Double) -> ChemrxnyieldCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCursor::sum(self : ChemrxnyieldCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldCursor::mean(self : ChemrxnyieldCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldCursor::scale(self : ChemrxnyieldCursor, f : Double) -> ChemrxnyieldCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCursor::add(self : ChemrxnyieldCursor, other : ChemrxnyieldCursor) -> ChemrxnyieldCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldCursor::copy(self : ChemrxnyieldCursor) -> ChemrxnyieldCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCursor::fill(self : ChemrxnyieldCursor, v : Double) -> ChemrxnyieldCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldCursor::min(self : ChemrxnyieldCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldCursor::max(self : ChemrxnyieldCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldCursor::to_string(self : ChemrxnyieldCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_view_make(size : Int) -> ChemrxnyieldView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldView::len(self : ChemrxnyieldView) -> Int { self.size }

pub fn ChemrxnyieldView::get(self : ChemrxnyieldView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldView::set(self : ChemrxnyieldView, i : Int, v : Double) -> ChemrxnyieldView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldView::sum(self : ChemrxnyieldView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldView::mean(self : ChemrxnyieldView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldView::scale(self : ChemrxnyieldView, f : Double) -> ChemrxnyieldView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldView::add(self : ChemrxnyieldView, other : ChemrxnyieldView) -> ChemrxnyieldView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldView::copy(self : ChemrxnyieldView) -> ChemrxnyieldView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldView::fill(self : ChemrxnyieldView, v : Double) -> ChemrxnyieldView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldView::min(self : ChemrxnyieldView) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldView::max(self : ChemrxnyieldView) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldView::to_string(self : ChemrxnyieldView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_range_make(size : Int) -> ChemrxnyieldRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldRange::len(self : ChemrxnyieldRange) -> Int { self.size }

pub fn ChemrxnyieldRange::get(self : ChemrxnyieldRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldRange::set(self : ChemrxnyieldRange, i : Int, v : Double) -> ChemrxnyieldRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldRange::sum(self : ChemrxnyieldRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldRange::mean(self : ChemrxnyieldRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldRange::scale(self : ChemrxnyieldRange, f : Double) -> ChemrxnyieldRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldRange::add(self : ChemrxnyieldRange, other : ChemrxnyieldRange) -> ChemrxnyieldRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldRange::copy(self : ChemrxnyieldRange) -> ChemrxnyieldRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldRange::fill(self : ChemrxnyieldRange, v : Double) -> ChemrxnyieldRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldRange::min(self : ChemrxnyieldRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldRange::max(self : ChemrxnyieldRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldRange::to_string(self : ChemrxnyieldRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnyieldSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_yield_slice_make(size : Int) -> ChemrxnyieldSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnyieldSlice::len(self : ChemrxnyieldSlice) -> Int { self.size }

pub fn ChemrxnyieldSlice::get(self : ChemrxnyieldSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnyieldSlice::set(self : ChemrxnyieldSlice, i : Int, v : Double) -> ChemrxnyieldSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldSlice::sum(self : ChemrxnyieldSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnyieldSlice::mean(self : ChemrxnyieldSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnyieldSlice::scale(self : ChemrxnyieldSlice, f : Double) -> ChemrxnyieldSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldSlice::add(self : ChemrxnyieldSlice, other : ChemrxnyieldSlice) -> ChemrxnyieldSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnyieldSlice::copy(self : ChemrxnyieldSlice) -> ChemrxnyieldSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldSlice::fill(self : ChemrxnyieldSlice, v : Double) -> ChemrxnyieldSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnyieldSlice::min(self : ChemrxnyieldSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnyieldSlice::max(self : ChemrxnyieldSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnyieldSlice::to_string(self : ChemrxnyieldSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

