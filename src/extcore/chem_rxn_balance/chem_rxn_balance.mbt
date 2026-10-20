///===
/// extcore/chem_rxn_balance

pub(all) struct ChemrxnbalancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_balance_make_point(x : Double, y : Double) -> ChemrxnbalancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_balance_make_point3(x : Double, y : Double, z : Double) -> ChemrxnbalancePoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnbalancePoint::x(self : ChemrxnbalancePoint) -> Double { self.x }

pub fn ChemrxnbalancePoint::y(self : ChemrxnbalancePoint) -> Double { self.y }

pub fn ChemrxnbalancePoint::z(self : ChemrxnbalancePoint) -> Double { self.z }

pub fn ChemrxnbalancePoint::label(self : ChemrxnbalancePoint) -> Int { self.label }

pub fn ChemrxnbalancePoint::dist(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnbalancePoint::add(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnbalancePoint::sub(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnbalancePoint::scale(self : ChemrxnbalancePoint, s : Double) -> ChemrxnbalancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnbalancePoint::dot(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnbalancePoint::cross(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnbalancePoint::norm(self : ChemrxnbalancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnbalancePoint::normalize(self : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnbalancePoint::negate(self : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnbalancePoint::mid(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnbalancePoint::lerp(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint, t : Double) -> ChemrxnbalancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnbalancePoint::to_string(self : ChemrxnbalancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnbalanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_balance_make_series(vals : Array[Double], name : String) -> ChemrxnbalanceSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnbalanceSeries::len(self : ChemrxnbalanceSeries) -> Int { self.vals.length() }

pub fn ChemrxnbalanceSeries::sum(self : ChemrxnbalanceSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnbalanceSeries::mean(self : ChemrxnbalanceSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnbalanceSeries::min(self : ChemrxnbalanceSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnbalanceSeries::max(self : ChemrxnbalanceSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnbalanceSeries::range(self : ChemrxnbalanceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnbalanceSeries::variance(self : ChemrxnbalanceSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnbalanceSeries::std(self : ChemrxnbalanceSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnbalanceSeries::median(self : ChemrxnbalanceSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnbalanceSeries::scale(self : ChemrxnbalanceSeries, f : Double) -> ChemrxnbalanceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnbalanceSeries::add(self : ChemrxnbalanceSeries, other : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnbalanceSeries::sub(self : ChemrxnbalanceSeries, other : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnbalanceSeries::normalize(self : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnbalanceSeries::cumsum(self : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnbalanceSeries::to_string(self : ChemrxnbalanceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnbalanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_balance_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnbalanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_balance_matrix_identity(n : Int) -> ChemrxnbalanceMatrix {
  let m = chem_rxn_balance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnbalanceMatrix::get(self : ChemrxnbalanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnbalanceMatrix::transpose(self : ChemrxnbalanceMatrix) -> ChemrxnbalanceMatrix {
  let result = chem_rxn_balance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnbalanceMatrix::add(self : ChemrxnbalanceMatrix, other : ChemrxnbalanceMatrix) -> ChemrxnbalanceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_balance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnbalanceMatrix::scale(self : ChemrxnbalanceMatrix, s : Double) -> ChemrxnbalanceMatrix {
  let result = chem_rxn_balance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnbalanceMatrix::multiply(self : ChemrxnbalanceMatrix, other : ChemrxnbalanceMatrix) -> ChemrxnbalanceMatrix {
  if self.cols != other.rows { return chem_rxn_balance_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_balance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemrxnbalanceMatrix::trace(self : ChemrxnbalanceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnbalanceMatrix::det(self : ChemrxnbalanceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnbalanceMatrix::norm(self : ChemrxnbalanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnbalanceMatrix::to_string(self : ChemrxnbalanceMatrix) -> String {
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

pub(all) struct ChemrxnbalanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_balance_make_vector(comps : Array[Double]) -> ChemrxnbalanceVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_balance_vector_zero(dim : Int) -> ChemrxnbalanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnbalanceVector::add(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> ChemrxnbalanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnbalanceVector::sub(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> ChemrxnbalanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnbalanceVector::scale(self : ChemrxnbalanceVector, s : Double) -> ChemrxnbalanceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnbalanceVector::dot(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnbalanceVector::norm(self : ChemrxnbalanceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnbalanceVector::normalize(self : ChemrxnbalanceVector) -> ChemrxnbalanceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnbalanceVector::dist(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnbalanceVector::to_string(self : ChemrxnbalanceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnbalanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_frame_make(size : Int) -> ChemrxnbalanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceFrame::len(self : ChemrxnbalanceFrame) -> Int { self.size }

pub fn ChemrxnbalanceFrame::get(self : ChemrxnbalanceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceFrame::set(self : ChemrxnbalanceFrame, i : Int, v : Double) -> ChemrxnbalanceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceFrame::sum(self : ChemrxnbalanceFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceFrame::mean(self : ChemrxnbalanceFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceFrame::scale(self : ChemrxnbalanceFrame, f : Double) -> ChemrxnbalanceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceFrame::add(self : ChemrxnbalanceFrame, other : ChemrxnbalanceFrame) -> ChemrxnbalanceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceFrame::copy(self : ChemrxnbalanceFrame) -> ChemrxnbalanceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceFrame::fill(self : ChemrxnbalanceFrame, v : Double) -> ChemrxnbalanceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceFrame::min(self : ChemrxnbalanceFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceFrame::max(self : ChemrxnbalanceFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceFrame::to_string(self : ChemrxnbalanceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_table_make(size : Int) -> ChemrxnbalanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceTable::len(self : ChemrxnbalanceTable) -> Int { self.size }

pub fn ChemrxnbalanceTable::get(self : ChemrxnbalanceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceTable::set(self : ChemrxnbalanceTable, i : Int, v : Double) -> ChemrxnbalanceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceTable::sum(self : ChemrxnbalanceTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceTable::mean(self : ChemrxnbalanceTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceTable::scale(self : ChemrxnbalanceTable, f : Double) -> ChemrxnbalanceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceTable::add(self : ChemrxnbalanceTable, other : ChemrxnbalanceTable) -> ChemrxnbalanceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceTable::copy(self : ChemrxnbalanceTable) -> ChemrxnbalanceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceTable::fill(self : ChemrxnbalanceTable, v : Double) -> ChemrxnbalanceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceTable::min(self : ChemrxnbalanceTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceTable::max(self : ChemrxnbalanceTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceTable::to_string(self : ChemrxnbalanceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_graphn_make(size : Int) -> ChemrxnbalanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceGraphN::len(self : ChemrxnbalanceGraphN) -> Int { self.size }

pub fn ChemrxnbalanceGraphN::get(self : ChemrxnbalanceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceGraphN::set(self : ChemrxnbalanceGraphN, i : Int, v : Double) -> ChemrxnbalanceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceGraphN::sum(self : ChemrxnbalanceGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceGraphN::mean(self : ChemrxnbalanceGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceGraphN::scale(self : ChemrxnbalanceGraphN, f : Double) -> ChemrxnbalanceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceGraphN::add(self : ChemrxnbalanceGraphN, other : ChemrxnbalanceGraphN) -> ChemrxnbalanceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceGraphN::copy(self : ChemrxnbalanceGraphN) -> ChemrxnbalanceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceGraphN::fill(self : ChemrxnbalanceGraphN, v : Double) -> ChemrxnbalanceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceGraphN::min(self : ChemrxnbalanceGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceGraphN::max(self : ChemrxnbalanceGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceGraphN::to_string(self : ChemrxnbalanceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_node_make(size : Int) -> ChemrxnbalanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceNode::len(self : ChemrxnbalanceNode) -> Int { self.size }

pub fn ChemrxnbalanceNode::get(self : ChemrxnbalanceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceNode::set(self : ChemrxnbalanceNode, i : Int, v : Double) -> ChemrxnbalanceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceNode::sum(self : ChemrxnbalanceNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceNode::mean(self : ChemrxnbalanceNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceNode::scale(self : ChemrxnbalanceNode, f : Double) -> ChemrxnbalanceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceNode::add(self : ChemrxnbalanceNode, other : ChemrxnbalanceNode) -> ChemrxnbalanceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceNode::copy(self : ChemrxnbalanceNode) -> ChemrxnbalanceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceNode::fill(self : ChemrxnbalanceNode, v : Double) -> ChemrxnbalanceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceNode::min(self : ChemrxnbalanceNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceNode::max(self : ChemrxnbalanceNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceNode::to_string(self : ChemrxnbalanceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_edge_make(size : Int) -> ChemrxnbalanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceEdge::len(self : ChemrxnbalanceEdge) -> Int { self.size }

pub fn ChemrxnbalanceEdge::get(self : ChemrxnbalanceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceEdge::set(self : ChemrxnbalanceEdge, i : Int, v : Double) -> ChemrxnbalanceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceEdge::sum(self : ChemrxnbalanceEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceEdge::mean(self : ChemrxnbalanceEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceEdge::scale(self : ChemrxnbalanceEdge, f : Double) -> ChemrxnbalanceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceEdge::add(self : ChemrxnbalanceEdge, other : ChemrxnbalanceEdge) -> ChemrxnbalanceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceEdge::copy(self : ChemrxnbalanceEdge) -> ChemrxnbalanceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceEdge::fill(self : ChemrxnbalanceEdge, v : Double) -> ChemrxnbalanceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceEdge::min(self : ChemrxnbalanceEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceEdge::max(self : ChemrxnbalanceEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceEdge::to_string(self : ChemrxnbalanceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_path_make(size : Int) -> ChemrxnbalancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalancePath::len(self : ChemrxnbalancePath) -> Int { self.size }

pub fn ChemrxnbalancePath::get(self : ChemrxnbalancePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalancePath::set(self : ChemrxnbalancePath, i : Int, v : Double) -> ChemrxnbalancePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalancePath::sum(self : ChemrxnbalancePath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalancePath::mean(self : ChemrxnbalancePath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalancePath::scale(self : ChemrxnbalancePath, f : Double) -> ChemrxnbalancePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalancePath::add(self : ChemrxnbalancePath, other : ChemrxnbalancePath) -> ChemrxnbalancePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalancePath::copy(self : ChemrxnbalancePath) -> ChemrxnbalancePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalancePath::fill(self : ChemrxnbalancePath, v : Double) -> ChemrxnbalancePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalancePath::min(self : ChemrxnbalancePath) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalancePath::max(self : ChemrxnbalancePath) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalancePath::to_string(self : ChemrxnbalancePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_cluster_make(size : Int) -> ChemrxnbalanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceCluster::len(self : ChemrxnbalanceCluster) -> Int { self.size }

pub fn ChemrxnbalanceCluster::get(self : ChemrxnbalanceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceCluster::set(self : ChemrxnbalanceCluster, i : Int, v : Double) -> ChemrxnbalanceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCluster::sum(self : ChemrxnbalanceCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceCluster::mean(self : ChemrxnbalanceCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceCluster::scale(self : ChemrxnbalanceCluster, f : Double) -> ChemrxnbalanceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCluster::add(self : ChemrxnbalanceCluster, other : ChemrxnbalanceCluster) -> ChemrxnbalanceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceCluster::copy(self : ChemrxnbalanceCluster) -> ChemrxnbalanceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCluster::fill(self : ChemrxnbalanceCluster, v : Double) -> ChemrxnbalanceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCluster::min(self : ChemrxnbalanceCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceCluster::max(self : ChemrxnbalanceCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceCluster::to_string(self : ChemrxnbalanceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_model_make(size : Int) -> ChemrxnbalanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceModel::len(self : ChemrxnbalanceModel) -> Int { self.size }

pub fn ChemrxnbalanceModel::get(self : ChemrxnbalanceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceModel::set(self : ChemrxnbalanceModel, i : Int, v : Double) -> ChemrxnbalanceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceModel::sum(self : ChemrxnbalanceModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceModel::mean(self : ChemrxnbalanceModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceModel::scale(self : ChemrxnbalanceModel, f : Double) -> ChemrxnbalanceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceModel::add(self : ChemrxnbalanceModel, other : ChemrxnbalanceModel) -> ChemrxnbalanceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceModel::copy(self : ChemrxnbalanceModel) -> ChemrxnbalanceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceModel::fill(self : ChemrxnbalanceModel, v : Double) -> ChemrxnbalanceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceModel::min(self : ChemrxnbalanceModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceModel::max(self : ChemrxnbalanceModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceModel::to_string(self : ChemrxnbalanceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_layer_make(size : Int) -> ChemrxnbalanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceLayer::len(self : ChemrxnbalanceLayer) -> Int { self.size }

pub fn ChemrxnbalanceLayer::get(self : ChemrxnbalanceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceLayer::set(self : ChemrxnbalanceLayer, i : Int, v : Double) -> ChemrxnbalanceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceLayer::sum(self : ChemrxnbalanceLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceLayer::mean(self : ChemrxnbalanceLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceLayer::scale(self : ChemrxnbalanceLayer, f : Double) -> ChemrxnbalanceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceLayer::add(self : ChemrxnbalanceLayer, other : ChemrxnbalanceLayer) -> ChemrxnbalanceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceLayer::copy(self : ChemrxnbalanceLayer) -> ChemrxnbalanceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceLayer::fill(self : ChemrxnbalanceLayer, v : Double) -> ChemrxnbalanceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceLayer::min(self : ChemrxnbalanceLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceLayer::max(self : ChemrxnbalanceLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceLayer::to_string(self : ChemrxnbalanceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_buffer_make(size : Int) -> ChemrxnbalanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceBuffer::len(self : ChemrxnbalanceBuffer) -> Int { self.size }

pub fn ChemrxnbalanceBuffer::get(self : ChemrxnbalanceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceBuffer::set(self : ChemrxnbalanceBuffer, i : Int, v : Double) -> ChemrxnbalanceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceBuffer::sum(self : ChemrxnbalanceBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceBuffer::mean(self : ChemrxnbalanceBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceBuffer::scale(self : ChemrxnbalanceBuffer, f : Double) -> ChemrxnbalanceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceBuffer::add(self : ChemrxnbalanceBuffer, other : ChemrxnbalanceBuffer) -> ChemrxnbalanceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceBuffer::copy(self : ChemrxnbalanceBuffer) -> ChemrxnbalanceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceBuffer::fill(self : ChemrxnbalanceBuffer, v : Double) -> ChemrxnbalanceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceBuffer::min(self : ChemrxnbalanceBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceBuffer::max(self : ChemrxnbalanceBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceBuffer::to_string(self : ChemrxnbalanceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_cursor_make(size : Int) -> ChemrxnbalanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceCursor::len(self : ChemrxnbalanceCursor) -> Int { self.size }

pub fn ChemrxnbalanceCursor::get(self : ChemrxnbalanceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceCursor::set(self : ChemrxnbalanceCursor, i : Int, v : Double) -> ChemrxnbalanceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCursor::sum(self : ChemrxnbalanceCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceCursor::mean(self : ChemrxnbalanceCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceCursor::scale(self : ChemrxnbalanceCursor, f : Double) -> ChemrxnbalanceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCursor::add(self : ChemrxnbalanceCursor, other : ChemrxnbalanceCursor) -> ChemrxnbalanceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceCursor::copy(self : ChemrxnbalanceCursor) -> ChemrxnbalanceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCursor::fill(self : ChemrxnbalanceCursor, v : Double) -> ChemrxnbalanceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceCursor::min(self : ChemrxnbalanceCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceCursor::max(self : ChemrxnbalanceCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceCursor::to_string(self : ChemrxnbalanceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_view_make(size : Int) -> ChemrxnbalanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceView::len(self : ChemrxnbalanceView) -> Int { self.size }

pub fn ChemrxnbalanceView::get(self : ChemrxnbalanceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceView::set(self : ChemrxnbalanceView, i : Int, v : Double) -> ChemrxnbalanceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceView::sum(self : ChemrxnbalanceView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceView::mean(self : ChemrxnbalanceView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceView::scale(self : ChemrxnbalanceView, f : Double) -> ChemrxnbalanceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceView::add(self : ChemrxnbalanceView, other : ChemrxnbalanceView) -> ChemrxnbalanceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceView::copy(self : ChemrxnbalanceView) -> ChemrxnbalanceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceView::fill(self : ChemrxnbalanceView, v : Double) -> ChemrxnbalanceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceView::min(self : ChemrxnbalanceView) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceView::max(self : ChemrxnbalanceView) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceView::to_string(self : ChemrxnbalanceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_range_make(size : Int) -> ChemrxnbalanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceRange::len(self : ChemrxnbalanceRange) -> Int { self.size }

pub fn ChemrxnbalanceRange::get(self : ChemrxnbalanceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceRange::set(self : ChemrxnbalanceRange, i : Int, v : Double) -> ChemrxnbalanceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceRange::sum(self : ChemrxnbalanceRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceRange::mean(self : ChemrxnbalanceRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceRange::scale(self : ChemrxnbalanceRange, f : Double) -> ChemrxnbalanceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceRange::add(self : ChemrxnbalanceRange, other : ChemrxnbalanceRange) -> ChemrxnbalanceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceRange::copy(self : ChemrxnbalanceRange) -> ChemrxnbalanceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceRange::fill(self : ChemrxnbalanceRange, v : Double) -> ChemrxnbalanceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceRange::min(self : ChemrxnbalanceRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceRange::max(self : ChemrxnbalanceRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceRange::to_string(self : ChemrxnbalanceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_slice_make(size : Int) -> ChemrxnbalanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnbalanceSlice::len(self : ChemrxnbalanceSlice) -> Int { self.size }

pub fn ChemrxnbalanceSlice::get(self : ChemrxnbalanceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnbalanceSlice::set(self : ChemrxnbalanceSlice, i : Int, v : Double) -> ChemrxnbalanceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceSlice::sum(self : ChemrxnbalanceSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnbalanceSlice::mean(self : ChemrxnbalanceSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnbalanceSlice::scale(self : ChemrxnbalanceSlice, f : Double) -> ChemrxnbalanceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceSlice::add(self : ChemrxnbalanceSlice, other : ChemrxnbalanceSlice) -> ChemrxnbalanceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnbalanceSlice::copy(self : ChemrxnbalanceSlice) -> ChemrxnbalanceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceSlice::fill(self : ChemrxnbalanceSlice, v : Double) -> ChemrxnbalanceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnbalanceSlice::min(self : ChemrxnbalanceSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnbalanceSlice::max(self : ChemrxnbalanceSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnbalanceSlice::to_string(self : ChemrxnbalanceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

