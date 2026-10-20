///===
/// extcore/chem_rxn_optimize

pub(all) struct ChemrxnoptimizePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_optimize_make_point(x : Double, y : Double) -> ChemrxnoptimizePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_optimize_make_point3(x : Double, y : Double, z : Double) -> ChemrxnoptimizePoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnoptimizePoint::x(self : ChemrxnoptimizePoint) -> Double { self.x }

pub fn ChemrxnoptimizePoint::y(self : ChemrxnoptimizePoint) -> Double { self.y }

pub fn ChemrxnoptimizePoint::z(self : ChemrxnoptimizePoint) -> Double { self.z }

pub fn ChemrxnoptimizePoint::label(self : ChemrxnoptimizePoint) -> Int { self.label }

pub fn ChemrxnoptimizePoint::dist(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnoptimizePoint::add(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnoptimizePoint::sub(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnoptimizePoint::scale(self : ChemrxnoptimizePoint, s : Double) -> ChemrxnoptimizePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnoptimizePoint::dot(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnoptimizePoint::cross(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnoptimizePoint::norm(self : ChemrxnoptimizePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnoptimizePoint::normalize(self : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnoptimizePoint::negate(self : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnoptimizePoint::mid(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnoptimizePoint::lerp(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint, t : Double) -> ChemrxnoptimizePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnoptimizePoint::to_string(self : ChemrxnoptimizePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_optimize_make_series(vals : Array[Double], name : String) -> ChemrxnoptimizeSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnoptimizeSeries::len(self : ChemrxnoptimizeSeries) -> Int { self.vals.length() }

pub fn ChemrxnoptimizeSeries::sum(self : ChemrxnoptimizeSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnoptimizeSeries::mean(self : ChemrxnoptimizeSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnoptimizeSeries::min(self : ChemrxnoptimizeSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnoptimizeSeries::max(self : ChemrxnoptimizeSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnoptimizeSeries::range(self : ChemrxnoptimizeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnoptimizeSeries::variance(self : ChemrxnoptimizeSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnoptimizeSeries::std(self : ChemrxnoptimizeSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnoptimizeSeries::median(self : ChemrxnoptimizeSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnoptimizeSeries::scale(self : ChemrxnoptimizeSeries, f : Double) -> ChemrxnoptimizeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::add(self : ChemrxnoptimizeSeries, other : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::sub(self : ChemrxnoptimizeSeries, other : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::normalize(self : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnoptimizeSeries::cumsum(self : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::to_string(self : ChemrxnoptimizeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnoptimizeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_optimize_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnoptimizeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_optimize_matrix_identity(n : Int) -> ChemrxnoptimizeMatrix {
  let m = chem_rxn_optimize_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnoptimizeMatrix::get(self : ChemrxnoptimizeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnoptimizeMatrix::transpose(self : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnoptimizeMatrix::add(self : ChemrxnoptimizeMatrix, other : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_optimize_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnoptimizeMatrix::scale(self : ChemrxnoptimizeMatrix, s : Double) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnoptimizeMatrix::multiply(self : ChemrxnoptimizeMatrix, other : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if self.cols != other.rows { return chem_rxn_optimize_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_optimize_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemrxnoptimizeMatrix::trace(self : ChemrxnoptimizeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnoptimizeMatrix::det(self : ChemrxnoptimizeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnoptimizeMatrix::norm(self : ChemrxnoptimizeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnoptimizeMatrix::to_string(self : ChemrxnoptimizeMatrix) -> String {
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

pub(all) struct ChemrxnoptimizeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_optimize_make_vector(comps : Array[Double]) -> ChemrxnoptimizeVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_optimize_vector_zero(dim : Int) -> ChemrxnoptimizeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnoptimizeVector::add(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnoptimizeVector::sub(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnoptimizeVector::scale(self : ChemrxnoptimizeVector, s : Double) -> ChemrxnoptimizeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnoptimizeVector::dot(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnoptimizeVector::norm(self : ChemrxnoptimizeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnoptimizeVector::normalize(self : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnoptimizeVector::dist(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnoptimizeVector::to_string(self : ChemrxnoptimizeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnoptimizeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_frame_make(size : Int) -> ChemrxnoptimizeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeFrame::len(self : ChemrxnoptimizeFrame) -> Int { self.size }

pub fn ChemrxnoptimizeFrame::get(self : ChemrxnoptimizeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeFrame::set(self : ChemrxnoptimizeFrame, i : Int, v : Double) -> ChemrxnoptimizeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeFrame::sum(self : ChemrxnoptimizeFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeFrame::mean(self : ChemrxnoptimizeFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeFrame::scale(self : ChemrxnoptimizeFrame, f : Double) -> ChemrxnoptimizeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeFrame::add(self : ChemrxnoptimizeFrame, other : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeFrame::copy(self : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeFrame::fill(self : ChemrxnoptimizeFrame, v : Double) -> ChemrxnoptimizeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeFrame::min(self : ChemrxnoptimizeFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeFrame::max(self : ChemrxnoptimizeFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeFrame::to_string(self : ChemrxnoptimizeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_table_make(size : Int) -> ChemrxnoptimizeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeTable::len(self : ChemrxnoptimizeTable) -> Int { self.size }

pub fn ChemrxnoptimizeTable::get(self : ChemrxnoptimizeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeTable::set(self : ChemrxnoptimizeTable, i : Int, v : Double) -> ChemrxnoptimizeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeTable::sum(self : ChemrxnoptimizeTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeTable::mean(self : ChemrxnoptimizeTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeTable::scale(self : ChemrxnoptimizeTable, f : Double) -> ChemrxnoptimizeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeTable::add(self : ChemrxnoptimizeTable, other : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeTable::copy(self : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeTable::fill(self : ChemrxnoptimizeTable, v : Double) -> ChemrxnoptimizeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeTable::min(self : ChemrxnoptimizeTable) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeTable::max(self : ChemrxnoptimizeTable) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeTable::to_string(self : ChemrxnoptimizeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_graphn_make(size : Int) -> ChemrxnoptimizeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeGraphN::len(self : ChemrxnoptimizeGraphN) -> Int { self.size }

pub fn ChemrxnoptimizeGraphN::get(self : ChemrxnoptimizeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeGraphN::set(self : ChemrxnoptimizeGraphN, i : Int, v : Double) -> ChemrxnoptimizeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeGraphN::sum(self : ChemrxnoptimizeGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeGraphN::mean(self : ChemrxnoptimizeGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeGraphN::scale(self : ChemrxnoptimizeGraphN, f : Double) -> ChemrxnoptimizeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeGraphN::add(self : ChemrxnoptimizeGraphN, other : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeGraphN::copy(self : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeGraphN::fill(self : ChemrxnoptimizeGraphN, v : Double) -> ChemrxnoptimizeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeGraphN::min(self : ChemrxnoptimizeGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeGraphN::max(self : ChemrxnoptimizeGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeGraphN::to_string(self : ChemrxnoptimizeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_node_make(size : Int) -> ChemrxnoptimizeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeNode::len(self : ChemrxnoptimizeNode) -> Int { self.size }

pub fn ChemrxnoptimizeNode::get(self : ChemrxnoptimizeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeNode::set(self : ChemrxnoptimizeNode, i : Int, v : Double) -> ChemrxnoptimizeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeNode::sum(self : ChemrxnoptimizeNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeNode::mean(self : ChemrxnoptimizeNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeNode::scale(self : ChemrxnoptimizeNode, f : Double) -> ChemrxnoptimizeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeNode::add(self : ChemrxnoptimizeNode, other : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeNode::copy(self : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeNode::fill(self : ChemrxnoptimizeNode, v : Double) -> ChemrxnoptimizeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeNode::min(self : ChemrxnoptimizeNode) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeNode::max(self : ChemrxnoptimizeNode) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeNode::to_string(self : ChemrxnoptimizeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_edge_make(size : Int) -> ChemrxnoptimizeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeEdge::len(self : ChemrxnoptimizeEdge) -> Int { self.size }

pub fn ChemrxnoptimizeEdge::get(self : ChemrxnoptimizeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeEdge::set(self : ChemrxnoptimizeEdge, i : Int, v : Double) -> ChemrxnoptimizeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeEdge::sum(self : ChemrxnoptimizeEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeEdge::mean(self : ChemrxnoptimizeEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeEdge::scale(self : ChemrxnoptimizeEdge, f : Double) -> ChemrxnoptimizeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeEdge::add(self : ChemrxnoptimizeEdge, other : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeEdge::copy(self : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeEdge::fill(self : ChemrxnoptimizeEdge, v : Double) -> ChemrxnoptimizeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeEdge::min(self : ChemrxnoptimizeEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeEdge::max(self : ChemrxnoptimizeEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeEdge::to_string(self : ChemrxnoptimizeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_path_make(size : Int) -> ChemrxnoptimizePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizePath::len(self : ChemrxnoptimizePath) -> Int { self.size }

pub fn ChemrxnoptimizePath::get(self : ChemrxnoptimizePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizePath::set(self : ChemrxnoptimizePath, i : Int, v : Double) -> ChemrxnoptimizePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizePath::sum(self : ChemrxnoptimizePath) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizePath::mean(self : ChemrxnoptimizePath) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizePath::scale(self : ChemrxnoptimizePath, f : Double) -> ChemrxnoptimizePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizePath::add(self : ChemrxnoptimizePath, other : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizePath::copy(self : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizePath::fill(self : ChemrxnoptimizePath, v : Double) -> ChemrxnoptimizePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizePath::min(self : ChemrxnoptimizePath) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizePath::max(self : ChemrxnoptimizePath) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizePath::to_string(self : ChemrxnoptimizePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cluster_make(size : Int) -> ChemrxnoptimizeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeCluster::len(self : ChemrxnoptimizeCluster) -> Int { self.size }

pub fn ChemrxnoptimizeCluster::get(self : ChemrxnoptimizeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeCluster::set(self : ChemrxnoptimizeCluster, i : Int, v : Double) -> ChemrxnoptimizeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCluster::sum(self : ChemrxnoptimizeCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeCluster::mean(self : ChemrxnoptimizeCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeCluster::scale(self : ChemrxnoptimizeCluster, f : Double) -> ChemrxnoptimizeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCluster::add(self : ChemrxnoptimizeCluster, other : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeCluster::copy(self : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCluster::fill(self : ChemrxnoptimizeCluster, v : Double) -> ChemrxnoptimizeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCluster::min(self : ChemrxnoptimizeCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeCluster::max(self : ChemrxnoptimizeCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeCluster::to_string(self : ChemrxnoptimizeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_model_make(size : Int) -> ChemrxnoptimizeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeModel::len(self : ChemrxnoptimizeModel) -> Int { self.size }

pub fn ChemrxnoptimizeModel::get(self : ChemrxnoptimizeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeModel::set(self : ChemrxnoptimizeModel, i : Int, v : Double) -> ChemrxnoptimizeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeModel::sum(self : ChemrxnoptimizeModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeModel::mean(self : ChemrxnoptimizeModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeModel::scale(self : ChemrxnoptimizeModel, f : Double) -> ChemrxnoptimizeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeModel::add(self : ChemrxnoptimizeModel, other : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeModel::copy(self : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeModel::fill(self : ChemrxnoptimizeModel, v : Double) -> ChemrxnoptimizeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeModel::min(self : ChemrxnoptimizeModel) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeModel::max(self : ChemrxnoptimizeModel) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeModel::to_string(self : ChemrxnoptimizeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_layer_make(size : Int) -> ChemrxnoptimizeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeLayer::len(self : ChemrxnoptimizeLayer) -> Int { self.size }

pub fn ChemrxnoptimizeLayer::get(self : ChemrxnoptimizeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeLayer::set(self : ChemrxnoptimizeLayer, i : Int, v : Double) -> ChemrxnoptimizeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeLayer::sum(self : ChemrxnoptimizeLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeLayer::mean(self : ChemrxnoptimizeLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeLayer::scale(self : ChemrxnoptimizeLayer, f : Double) -> ChemrxnoptimizeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeLayer::add(self : ChemrxnoptimizeLayer, other : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeLayer::copy(self : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeLayer::fill(self : ChemrxnoptimizeLayer, v : Double) -> ChemrxnoptimizeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeLayer::min(self : ChemrxnoptimizeLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeLayer::max(self : ChemrxnoptimizeLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeLayer::to_string(self : ChemrxnoptimizeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_buffer_make(size : Int) -> ChemrxnoptimizeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeBuffer::len(self : ChemrxnoptimizeBuffer) -> Int { self.size }

pub fn ChemrxnoptimizeBuffer::get(self : ChemrxnoptimizeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeBuffer::set(self : ChemrxnoptimizeBuffer, i : Int, v : Double) -> ChemrxnoptimizeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeBuffer::sum(self : ChemrxnoptimizeBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeBuffer::mean(self : ChemrxnoptimizeBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeBuffer::scale(self : ChemrxnoptimizeBuffer, f : Double) -> ChemrxnoptimizeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeBuffer::add(self : ChemrxnoptimizeBuffer, other : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeBuffer::copy(self : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeBuffer::fill(self : ChemrxnoptimizeBuffer, v : Double) -> ChemrxnoptimizeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeBuffer::min(self : ChemrxnoptimizeBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeBuffer::max(self : ChemrxnoptimizeBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeBuffer::to_string(self : ChemrxnoptimizeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cursor_make(size : Int) -> ChemrxnoptimizeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeCursor::len(self : ChemrxnoptimizeCursor) -> Int { self.size }

pub fn ChemrxnoptimizeCursor::get(self : ChemrxnoptimizeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeCursor::set(self : ChemrxnoptimizeCursor, i : Int, v : Double) -> ChemrxnoptimizeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCursor::sum(self : ChemrxnoptimizeCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeCursor::mean(self : ChemrxnoptimizeCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeCursor::scale(self : ChemrxnoptimizeCursor, f : Double) -> ChemrxnoptimizeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCursor::add(self : ChemrxnoptimizeCursor, other : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeCursor::copy(self : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCursor::fill(self : ChemrxnoptimizeCursor, v : Double) -> ChemrxnoptimizeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeCursor::min(self : ChemrxnoptimizeCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeCursor::max(self : ChemrxnoptimizeCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeCursor::to_string(self : ChemrxnoptimizeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_view_make(size : Int) -> ChemrxnoptimizeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeView::len(self : ChemrxnoptimizeView) -> Int { self.size }

pub fn ChemrxnoptimizeView::get(self : ChemrxnoptimizeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeView::set(self : ChemrxnoptimizeView, i : Int, v : Double) -> ChemrxnoptimizeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeView::sum(self : ChemrxnoptimizeView) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeView::mean(self : ChemrxnoptimizeView) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeView::scale(self : ChemrxnoptimizeView, f : Double) -> ChemrxnoptimizeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeView::add(self : ChemrxnoptimizeView, other : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeView::copy(self : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeView::fill(self : ChemrxnoptimizeView, v : Double) -> ChemrxnoptimizeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeView::min(self : ChemrxnoptimizeView) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeView::max(self : ChemrxnoptimizeView) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeView::to_string(self : ChemrxnoptimizeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_range_make(size : Int) -> ChemrxnoptimizeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeRange::len(self : ChemrxnoptimizeRange) -> Int { self.size }

pub fn ChemrxnoptimizeRange::get(self : ChemrxnoptimizeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeRange::set(self : ChemrxnoptimizeRange, i : Int, v : Double) -> ChemrxnoptimizeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeRange::sum(self : ChemrxnoptimizeRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeRange::mean(self : ChemrxnoptimizeRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeRange::scale(self : ChemrxnoptimizeRange, f : Double) -> ChemrxnoptimizeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeRange::add(self : ChemrxnoptimizeRange, other : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeRange::copy(self : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeRange::fill(self : ChemrxnoptimizeRange, v : Double) -> ChemrxnoptimizeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeRange::min(self : ChemrxnoptimizeRange) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeRange::max(self : ChemrxnoptimizeRange) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeRange::to_string(self : ChemrxnoptimizeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_slice_make(size : Int) -> ChemrxnoptimizeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxnoptimizeSlice::len(self : ChemrxnoptimizeSlice) -> Int { self.size }

pub fn ChemrxnoptimizeSlice::get(self : ChemrxnoptimizeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxnoptimizeSlice::set(self : ChemrxnoptimizeSlice, i : Int, v : Double) -> ChemrxnoptimizeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeSlice::sum(self : ChemrxnoptimizeSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxnoptimizeSlice::mean(self : ChemrxnoptimizeSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxnoptimizeSlice::scale(self : ChemrxnoptimizeSlice, f : Double) -> ChemrxnoptimizeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeSlice::add(self : ChemrxnoptimizeSlice, other : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxnoptimizeSlice::copy(self : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeSlice::fill(self : ChemrxnoptimizeSlice, v : Double) -> ChemrxnoptimizeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxnoptimizeSlice::min(self : ChemrxnoptimizeSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxnoptimizeSlice::max(self : ChemrxnoptimizeSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxnoptimizeSlice::to_string(self : ChemrxnoptimizeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

