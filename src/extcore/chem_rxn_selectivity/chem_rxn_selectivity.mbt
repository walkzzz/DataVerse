///===
/// extcore/chem_rxn_selectivity

pub(all) struct ChemrxnselectivityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_selectivity_make_point(x : Double, y : Double) -> ChemrxnselectivityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_selectivity_make_point3(x : Double, y : Double, z : Double) -> ChemrxnselectivityPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnselectivityPoint::x(self : ChemrxnselectivityPoint) -> Double { self.x }

pub fn ChemrxnselectivityPoint::y(self : ChemrxnselectivityPoint) -> Double { self.y }

pub fn ChemrxnselectivityPoint::z(self : ChemrxnselectivityPoint) -> Double { self.z }

pub fn ChemrxnselectivityPoint::label(self : ChemrxnselectivityPoint) -> Int { self.label }

pub fn ChemrxnselectivityPoint::dist(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnselectivityPoint::add(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnselectivityPoint::sub(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnselectivityPoint::scale(self : ChemrxnselectivityPoint, s : Double) -> ChemrxnselectivityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnselectivityPoint::dot(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnselectivityPoint::cross(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnselectivityPoint::norm(self : ChemrxnselectivityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnselectivityPoint::normalize(self : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnselectivityPoint::negate(self : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnselectivityPoint::mid(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnselectivityPoint::lerp(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint, t : Double) -> ChemrxnselectivityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnselectivityPoint::to_string(self : ChemrxnselectivityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnselectivitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_selectivity_make_series(vals : Array[Double], name : String) -> ChemrxnselectivitySeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnselectivitySeries::len(self : ChemrxnselectivitySeries) -> Int { self.vals.length() }

pub fn ChemrxnselectivitySeries::sum(self : ChemrxnselectivitySeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnselectivitySeries::mean(self : ChemrxnselectivitySeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnselectivitySeries::min(self : ChemrxnselectivitySeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnselectivitySeries::max(self : ChemrxnselectivitySeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnselectivitySeries::range(self : ChemrxnselectivitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnselectivitySeries::variance(self : ChemrxnselectivitySeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnselectivitySeries::std(self : ChemrxnselectivitySeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnselectivitySeries::median(self : ChemrxnselectivitySeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnselectivitySeries::scale(self : ChemrxnselectivitySeries, f : Double) -> ChemrxnselectivitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnselectivitySeries::add(self : ChemrxnselectivitySeries, other : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnselectivitySeries::sub(self : ChemrxnselectivitySeries, other : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnselectivitySeries::normalize(self : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnselectivitySeries::cumsum(self : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnselectivitySeries::to_string(self : ChemrxnselectivitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnselectivityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_selectivity_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnselectivityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_selectivity_matrix_identity(n : Int) -> ChemrxnselectivityMatrix {
  let m = chem_rxn_selectivity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnselectivityMatrix::get(self : ChemrxnselectivityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnselectivityMatrix::transpose(self : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  let result = chem_rxn_selectivity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnselectivityMatrix::add(self : ChemrxnselectivityMatrix, other : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_selectivity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnselectivityMatrix::scale(self : ChemrxnselectivityMatrix, s : Double) -> ChemrxnselectivityMatrix {
  let result = chem_rxn_selectivity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnselectivityMatrix::multiply(self : ChemrxnselectivityMatrix, other : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  if self.cols != other.rows { return chem_rxn_selectivity_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_selectivity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnselectivityMatrix::trace(self : ChemrxnselectivityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnselectivityMatrix::det(self : ChemrxnselectivityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnselectivityMatrix::norm(self : ChemrxnselectivityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnselectivityMatrix::to_string(self : ChemrxnselectivityMatrix) -> String {
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

pub(all) struct ChemrxnselectivityVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_selectivity_make_vector(comps : Array[Double]) -> ChemrxnselectivityVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_selectivity_vector_zero(dim : Int) -> ChemrxnselectivityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnselectivityVector::add(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnselectivityVector::sub(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnselectivityVector::scale(self : ChemrxnselectivityVector, s : Double) -> ChemrxnselectivityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnselectivityVector::dot(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnselectivityVector::norm(self : ChemrxnselectivityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnselectivityVector::normalize(self : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnselectivityVector::dist(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnselectivityVector::to_string(self : ChemrxnselectivityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnselectivityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_frame_make(size : Int) -> ChemrxnselectivityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityFrame::len(self : ChemrxnselectivityFrame) -> Int { self.size }

pub fn ChemrxnselectivityFrame::get(self : ChemrxnselectivityFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityFrame::set(self : ChemrxnselectivityFrame, i : Int, v : Double) -> ChemrxnselectivityFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityFrame::sum(self : ChemrxnselectivityFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityFrame::mean(self : ChemrxnselectivityFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityFrame::scale(self : ChemrxnselectivityFrame, f : Double) -> ChemrxnselectivityFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityFrame::add(self : ChemrxnselectivityFrame, other : ChemrxnselectivityFrame) -> ChemrxnselectivityFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityFrame::copy(self : ChemrxnselectivityFrame) -> ChemrxnselectivityFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityFrame::fill(self : ChemrxnselectivityFrame, v : Double) -> ChemrxnselectivityFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityFrame::min(self : ChemrxnselectivityFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityFrame::max(self : ChemrxnselectivityFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityFrame::to_string(self : ChemrxnselectivityFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_table_make(size : Int) -> ChemrxnselectivityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityTable::len(self : ChemrxnselectivityTable) -> Int { self.size }

pub fn ChemrxnselectivityTable::get(self : ChemrxnselectivityTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityTable::set(self : ChemrxnselectivityTable, i : Int, v : Double) -> ChemrxnselectivityTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityTable::sum(self : ChemrxnselectivityTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityTable::mean(self : ChemrxnselectivityTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityTable::scale(self : ChemrxnselectivityTable, f : Double) -> ChemrxnselectivityTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityTable::add(self : ChemrxnselectivityTable, other : ChemrxnselectivityTable) -> ChemrxnselectivityTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityTable::copy(self : ChemrxnselectivityTable) -> ChemrxnselectivityTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityTable::fill(self : ChemrxnselectivityTable, v : Double) -> ChemrxnselectivityTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityTable::min(self : ChemrxnselectivityTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityTable::max(self : ChemrxnselectivityTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityTable::to_string(self : ChemrxnselectivityTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_graphn_make(size : Int) -> ChemrxnselectivityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityGraphN::len(self : ChemrxnselectivityGraphN) -> Int { self.size }

pub fn ChemrxnselectivityGraphN::get(self : ChemrxnselectivityGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityGraphN::set(self : ChemrxnselectivityGraphN, i : Int, v : Double) -> ChemrxnselectivityGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityGraphN::sum(self : ChemrxnselectivityGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityGraphN::mean(self : ChemrxnselectivityGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityGraphN::scale(self : ChemrxnselectivityGraphN, f : Double) -> ChemrxnselectivityGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityGraphN::add(self : ChemrxnselectivityGraphN, other : ChemrxnselectivityGraphN) -> ChemrxnselectivityGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityGraphN::copy(self : ChemrxnselectivityGraphN) -> ChemrxnselectivityGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityGraphN::fill(self : ChemrxnselectivityGraphN, v : Double) -> ChemrxnselectivityGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityGraphN::min(self : ChemrxnselectivityGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityGraphN::max(self : ChemrxnselectivityGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityGraphN::to_string(self : ChemrxnselectivityGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_node_make(size : Int) -> ChemrxnselectivityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityNode::len(self : ChemrxnselectivityNode) -> Int { self.size }

pub fn ChemrxnselectivityNode::get(self : ChemrxnselectivityNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityNode::set(self : ChemrxnselectivityNode, i : Int, v : Double) -> ChemrxnselectivityNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityNode::sum(self : ChemrxnselectivityNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityNode::mean(self : ChemrxnselectivityNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityNode::scale(self : ChemrxnselectivityNode, f : Double) -> ChemrxnselectivityNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityNode::add(self : ChemrxnselectivityNode, other : ChemrxnselectivityNode) -> ChemrxnselectivityNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityNode::copy(self : ChemrxnselectivityNode) -> ChemrxnselectivityNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityNode::fill(self : ChemrxnselectivityNode, v : Double) -> ChemrxnselectivityNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityNode::min(self : ChemrxnselectivityNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityNode::max(self : ChemrxnselectivityNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityNode::to_string(self : ChemrxnselectivityNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_edge_make(size : Int) -> ChemrxnselectivityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityEdge::len(self : ChemrxnselectivityEdge) -> Int { self.size }

pub fn ChemrxnselectivityEdge::get(self : ChemrxnselectivityEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityEdge::set(self : ChemrxnselectivityEdge, i : Int, v : Double) -> ChemrxnselectivityEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityEdge::sum(self : ChemrxnselectivityEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityEdge::mean(self : ChemrxnselectivityEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityEdge::scale(self : ChemrxnselectivityEdge, f : Double) -> ChemrxnselectivityEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityEdge::add(self : ChemrxnselectivityEdge, other : ChemrxnselectivityEdge) -> ChemrxnselectivityEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityEdge::copy(self : ChemrxnselectivityEdge) -> ChemrxnselectivityEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityEdge::fill(self : ChemrxnselectivityEdge, v : Double) -> ChemrxnselectivityEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityEdge::min(self : ChemrxnselectivityEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityEdge::max(self : ChemrxnselectivityEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityEdge::to_string(self : ChemrxnselectivityEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_path_make(size : Int) -> ChemrxnselectivityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityPath::len(self : ChemrxnselectivityPath) -> Int { self.size }

pub fn ChemrxnselectivityPath::get(self : ChemrxnselectivityPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityPath::set(self : ChemrxnselectivityPath, i : Int, v : Double) -> ChemrxnselectivityPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityPath::sum(self : ChemrxnselectivityPath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityPath::mean(self : ChemrxnselectivityPath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityPath::scale(self : ChemrxnselectivityPath, f : Double) -> ChemrxnselectivityPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityPath::add(self : ChemrxnselectivityPath, other : ChemrxnselectivityPath) -> ChemrxnselectivityPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityPath::copy(self : ChemrxnselectivityPath) -> ChemrxnselectivityPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityPath::fill(self : ChemrxnselectivityPath, v : Double) -> ChemrxnselectivityPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityPath::min(self : ChemrxnselectivityPath) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityPath::max(self : ChemrxnselectivityPath) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityPath::to_string(self : ChemrxnselectivityPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_cluster_make(size : Int) -> ChemrxnselectivityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityCluster::len(self : ChemrxnselectivityCluster) -> Int { self.size }

pub fn ChemrxnselectivityCluster::get(self : ChemrxnselectivityCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityCluster::set(self : ChemrxnselectivityCluster, i : Int, v : Double) -> ChemrxnselectivityCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCluster::sum(self : ChemrxnselectivityCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityCluster::mean(self : ChemrxnselectivityCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityCluster::scale(self : ChemrxnselectivityCluster, f : Double) -> ChemrxnselectivityCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCluster::add(self : ChemrxnselectivityCluster, other : ChemrxnselectivityCluster) -> ChemrxnselectivityCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityCluster::copy(self : ChemrxnselectivityCluster) -> ChemrxnselectivityCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCluster::fill(self : ChemrxnselectivityCluster, v : Double) -> ChemrxnselectivityCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCluster::min(self : ChemrxnselectivityCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityCluster::max(self : ChemrxnselectivityCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityCluster::to_string(self : ChemrxnselectivityCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_model_make(size : Int) -> ChemrxnselectivityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityModel::len(self : ChemrxnselectivityModel) -> Int { self.size }

pub fn ChemrxnselectivityModel::get(self : ChemrxnselectivityModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityModel::set(self : ChemrxnselectivityModel, i : Int, v : Double) -> ChemrxnselectivityModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityModel::sum(self : ChemrxnselectivityModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityModel::mean(self : ChemrxnselectivityModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityModel::scale(self : ChemrxnselectivityModel, f : Double) -> ChemrxnselectivityModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityModel::add(self : ChemrxnselectivityModel, other : ChemrxnselectivityModel) -> ChemrxnselectivityModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityModel::copy(self : ChemrxnselectivityModel) -> ChemrxnselectivityModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityModel::fill(self : ChemrxnselectivityModel, v : Double) -> ChemrxnselectivityModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityModel::min(self : ChemrxnselectivityModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityModel::max(self : ChemrxnselectivityModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityModel::to_string(self : ChemrxnselectivityModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_layer_make(size : Int) -> ChemrxnselectivityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityLayer::len(self : ChemrxnselectivityLayer) -> Int { self.size }

pub fn ChemrxnselectivityLayer::get(self : ChemrxnselectivityLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityLayer::set(self : ChemrxnselectivityLayer, i : Int, v : Double) -> ChemrxnselectivityLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityLayer::sum(self : ChemrxnselectivityLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityLayer::mean(self : ChemrxnselectivityLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityLayer::scale(self : ChemrxnselectivityLayer, f : Double) -> ChemrxnselectivityLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityLayer::add(self : ChemrxnselectivityLayer, other : ChemrxnselectivityLayer) -> ChemrxnselectivityLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityLayer::copy(self : ChemrxnselectivityLayer) -> ChemrxnselectivityLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityLayer::fill(self : ChemrxnselectivityLayer, v : Double) -> ChemrxnselectivityLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityLayer::min(self : ChemrxnselectivityLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityLayer::max(self : ChemrxnselectivityLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityLayer::to_string(self : ChemrxnselectivityLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_buffer_make(size : Int) -> ChemrxnselectivityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityBuffer::len(self : ChemrxnselectivityBuffer) -> Int { self.size }

pub fn ChemrxnselectivityBuffer::get(self : ChemrxnselectivityBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityBuffer::set(self : ChemrxnselectivityBuffer, i : Int, v : Double) -> ChemrxnselectivityBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityBuffer::sum(self : ChemrxnselectivityBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityBuffer::mean(self : ChemrxnselectivityBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityBuffer::scale(self : ChemrxnselectivityBuffer, f : Double) -> ChemrxnselectivityBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityBuffer::add(self : ChemrxnselectivityBuffer, other : ChemrxnselectivityBuffer) -> ChemrxnselectivityBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityBuffer::copy(self : ChemrxnselectivityBuffer) -> ChemrxnselectivityBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityBuffer::fill(self : ChemrxnselectivityBuffer, v : Double) -> ChemrxnselectivityBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityBuffer::min(self : ChemrxnselectivityBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityBuffer::max(self : ChemrxnselectivityBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityBuffer::to_string(self : ChemrxnselectivityBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_cursor_make(size : Int) -> ChemrxnselectivityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityCursor::len(self : ChemrxnselectivityCursor) -> Int { self.size }

pub fn ChemrxnselectivityCursor::get(self : ChemrxnselectivityCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityCursor::set(self : ChemrxnselectivityCursor, i : Int, v : Double) -> ChemrxnselectivityCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCursor::sum(self : ChemrxnselectivityCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityCursor::mean(self : ChemrxnselectivityCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityCursor::scale(self : ChemrxnselectivityCursor, f : Double) -> ChemrxnselectivityCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCursor::add(self : ChemrxnselectivityCursor, other : ChemrxnselectivityCursor) -> ChemrxnselectivityCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityCursor::copy(self : ChemrxnselectivityCursor) -> ChemrxnselectivityCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCursor::fill(self : ChemrxnselectivityCursor, v : Double) -> ChemrxnselectivityCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityCursor::min(self : ChemrxnselectivityCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityCursor::max(self : ChemrxnselectivityCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityCursor::to_string(self : ChemrxnselectivityCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_view_make(size : Int) -> ChemrxnselectivityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityView::len(self : ChemrxnselectivityView) -> Int { self.size }

pub fn ChemrxnselectivityView::get(self : ChemrxnselectivityView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityView::set(self : ChemrxnselectivityView, i : Int, v : Double) -> ChemrxnselectivityView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityView::sum(self : ChemrxnselectivityView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityView::mean(self : ChemrxnselectivityView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityView::scale(self : ChemrxnselectivityView, f : Double) -> ChemrxnselectivityView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityView::add(self : ChemrxnselectivityView, other : ChemrxnselectivityView) -> ChemrxnselectivityView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityView::copy(self : ChemrxnselectivityView) -> ChemrxnselectivityView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityView::fill(self : ChemrxnselectivityView, v : Double) -> ChemrxnselectivityView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityView::min(self : ChemrxnselectivityView) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityView::max(self : ChemrxnselectivityView) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityView::to_string(self : ChemrxnselectivityView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_range_make(size : Int) -> ChemrxnselectivityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivityRange::len(self : ChemrxnselectivityRange) -> Int { self.size }

pub fn ChemrxnselectivityRange::get(self : ChemrxnselectivityRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivityRange::set(self : ChemrxnselectivityRange, i : Int, v : Double) -> ChemrxnselectivityRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityRange::sum(self : ChemrxnselectivityRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivityRange::mean(self : ChemrxnselectivityRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivityRange::scale(self : ChemrxnselectivityRange, f : Double) -> ChemrxnselectivityRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityRange::add(self : ChemrxnselectivityRange, other : ChemrxnselectivityRange) -> ChemrxnselectivityRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivityRange::copy(self : ChemrxnselectivityRange) -> ChemrxnselectivityRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityRange::fill(self : ChemrxnselectivityRange, v : Double) -> ChemrxnselectivityRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivityRange::min(self : ChemrxnselectivityRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivityRange::max(self : ChemrxnselectivityRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivityRange::to_string(self : ChemrxnselectivityRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_slice_make(size : Int) -> ChemrxnselectivitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnselectivitySlice::len(self : ChemrxnselectivitySlice) -> Int { self.size }

pub fn ChemrxnselectivitySlice::get(self : ChemrxnselectivitySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnselectivitySlice::set(self : ChemrxnselectivitySlice, i : Int, v : Double) -> ChemrxnselectivitySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivitySlice::sum(self : ChemrxnselectivitySlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnselectivitySlice::mean(self : ChemrxnselectivitySlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnselectivitySlice::scale(self : ChemrxnselectivitySlice, f : Double) -> ChemrxnselectivitySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivitySlice::add(self : ChemrxnselectivitySlice, other : ChemrxnselectivitySlice) -> ChemrxnselectivitySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnselectivitySlice::copy(self : ChemrxnselectivitySlice) -> ChemrxnselectivitySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivitySlice::fill(self : ChemrxnselectivitySlice, v : Double) -> ChemrxnselectivitySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnselectivitySlice::min(self : ChemrxnselectivitySlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnselectivitySlice::max(self : ChemrxnselectivitySlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnselectivitySlice::to_string(self : ChemrxnselectivitySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

